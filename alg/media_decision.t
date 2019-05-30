#!/usr/bin/perl -w
use strict;
use media_decision;
use Test::Simple tests => 10;
use Data::Dumper;

my @creatives = (
    {advertiser => 'Mercedes', country => 'Russia', price => 120},
    {advertiser => 'Audi', country => 'Other', price => 120},
    {advertiser => 'Citroen', country => 'Germany', price => 105},
    {advertiser => 'BMW', country => 'Russia', price => 120},
    {advertiser => 'Audi', country => 'Russia', price => 115},
    {advertiser => 'Mercedes', country => 'Russia', price => 110},
    {advertiser => 'BMW', country => 'Russia', price => 70},
    {advertiser => 'Mercedes', country => 'Russia', price => 120},
    {advertiser => 'Audi', country => 'Russia', price => 120},
    {advertiser => 'BMW', country => 'Germany', price => 107},
    {advertiser => 'Audi', country => 'Russia', price => 100},
    {advertiser => 'Mercedes', country => 'Other', price => 100},
    {advertiser => 'Audi', country => 'Other', price => 20},
    {advertiser => 'Mercedes', country => 'Other', price => 90},
    {advertiser => 'Audi', country => 'Other', price => 40},
    {advertiser => 'BMW', country => 'Germany', price => 65},
    {advertiser => 'Audi', country => 'Italy', price => 86},
    {advertiser => 'BMW', country => 'Germany', price => 95},
    {advertiser => 'Mercedes', country => 'Other', price => 120},
    {advertiser => 'BMW', country => 'Germany', price => 120},
    {advertiser => 'Audi', country => 'Germany', price => 120},
    {advertiser => 'Citroen', country => 'Germany', price => 120},
    {advertiser => 'Audi', country => 'Germany', price => 75},
    {advertiser => 'BMW', country => 'Russia', price => 50},
    {advertiser => 'Audi', country => 'Germany', price => 55},
    {advertiser => 'Citroen', country => 'Germany', price => 88}
);

for my $t (
    {win_cnt => 3, name => 'all creatives w 3 winners'},
    {
        win_cnt => 3,
        dest => 'Germany',
        name => 'all creatives w 3 winners for Germany'
    },
    {
        win_cnt => 3,
        dest => 'Russia',
        name => 'all creatives w 3 winner for Russia'
    },
    {win_cnt => 3, end => 10, name => 'first 10 creatives w 3 winners'},
    {
        win_cnt => 3,
        start => 10,
        end => 20,
        name => 'creatives from 10 to 20 w 3 winners'
    },
    {win_cnt => 3, start => 20, name => 'creatives from 20 w 3 winners'},
    {win_cnt => 4, start => 10, name => 'creatives from 10 w 4 winners'},
    {
        win_cnt => 4,
        start => 10,
        name => 'creatives from 10 w 4 winners for Russia'
    },
    {
        win_cnt => 1,
        dest => 'Germany',
        name => 'all creatives w 1 winner for Germany'
    },
    {
        win_cnt => 1,
        dest => 'Italy',
        name => 'all creatives w 1 winner for Italy'
    }
    )
{
    my $start = $t->{start} // 0;
    my $end = $t->{end} // $#creatives;
    ok(
        test_helper(
            $t->{win_cnt},
            $t->{dest},
            @creatives[$start..$end]
            ),
        $t->{name}
        );
}

sub test_helper {
    my($win_cnt, $dest, @creatives) = @_;
    
    my @res = media_decision::make_decision($win_cnt, $dest, @creatives);
    if(@res > $win_cnt || !$res[$win_cnt - 1]) {
        return 0;
    }
  
    my %digest = ();
    for my $cr (@res) {
        my ($adv, $country) = ($cr->{advertiser}, $cr->{country});
        if(
            ++$digest{$adv} > 1
            || ($dest && !($country ne $dest xor $country ne 'Other'))
            )
        {
            return 0;
        }
    }

    return 1;
}
