#!/usr/bin/perl -w
use strict;
use LWP::UserAgent;
use IO::Socket;
use JSON;

my @qry_str = split '&', $ENV{QUERY_STRING};
if(@qry_str < 2) {
    die 'you have to type at least two parameters';
}

my $host;
my @request;
for my $par (@qry_str) {
    my ($name, $value) = split '=', $par;
    if($name eq 'host') {
        $host = $value;
    }
    if($name eq 'req') {
        push @request, $value;
    }
}

# check if host is right
if($host !~ qr|^(?:https?://)?(?:www\.)?(.*\..*)|i) {
    die 'wrong host name format';
}
$host = $1;

# get proxy servers list to circumvent Yandex blocking
my @proxies = fetch_proxies(qw(br ca ch cn cz de hk fr gb in it jp kr mx nl ru tw ua us za));

my $json;
my $content;
for my $r (@request) {
    my ($pgnum, $pos, $cur_pos) = (0, 0, 0 );
    
    while(fetch_next($r, $pgnum)) {    
        my $tmp = fetch_pos();
        $cur_pos += $tmp->{pos};
        if($tmp->{found}) {
            $pos = $cur_pos;
            last;
        }
        ++$pgnum;
    }
    $json->{$r} = $pos;
}
print "Content-Type: application/json\r\n\r\n";
print encode_json $json;

sub fetch_proxies {     # get proxies by country abbrevations
    my @proxies = ();
    my $ua = LWP::UserAgent->new();
    for my $country (@_) {
        my $resp = $ua->get(
            "https://www.proxynova.com/proxy-server-list/country-$country/"
            );
        foreach ($resp->content =~ /<tr>(.*?)<\/tr>/gs) {    
            $_ =~ s/\s//g;
            $_ =~ s/<span.*?>//g;
            $_ =~ s/<\/span>//g;
            $_ =~ s/<a.*?>//g;
            $_ =~ s/<\/a>//g;
    
            my @cols = $_ =~ /<td.*?>(.*?)<\/td>/g;
            if(
                $cols[6] eq 'Elite'
                && $cols[0] =~ /^\d+\.\d+\.\d+\.\d+$/
                && $cols[1] =~ /^\d+$/
                )
            {
                push @proxies, {ip => $cols[0], port => $cols[1]};
            }
        }
    }
    return @proxies;
}

sub proxy_available {   # check proxy host and port
    my ($ip, $port) = @_;    
    my $socket = IO::Socket::INET->new(
        Proto => 'tcp',
        PeerAddr => $ip,
        PeerPort => $port,
        Timeout => 0.1
        );
    return $socket ? 1 : 0;
}

sub fetch_next {        # fetch next page and search for query
    my ($qry, $pgnum) = @_;
    
    return 0 if $pgnum > 2;
    
    my $ua = LWP::UserAgent->new();
    for my $proxy (@proxies) {

        next if !proxy_available($proxy->{ip}, $proxy->{port});

        $ua->proxy(['http','ftp'], "http://$proxy->{ip}:$proxy->{port}");

        my $resp = $ua->get(
            "http://yandex.ru/search/?lr=213&text=$qry&p=$pgnum"
            );
        if(
            $resp->is_success
            && $resp->content =~ /<div class="serp-header__wrapper">/
            )
        {
            $content = $resp->content;
            return 1;
        }
    }
    return 0;
}

sub fetch_pos {
    my $pos = 0;
    foreach($content =~ /<div class="path organic__path".*?>(.*?)<\/div>/gs) {
        if($_ =~ /<a class="link link_outer_yes path__item".*?>(.*?)<\/a>/) {
            my $link = $1;
            $link =~ s/<b>//g;
            $link =~ s/<\/b>//g;

            ++$pos;
            
            if($link =~ /$host/i) {
                return {found => 1, pos => $pos};
            }
        }
    }
    return {found => 0, pos => $pos};
}
