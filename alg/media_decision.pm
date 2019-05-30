# You have several entities, so called "creatives", each of them has:
#   * advertiser;
#   * country to serve (optional);
#   * price.

# Implement a function auction, receiving:
#   * number of winners;
#   * country name (optional);
#   * array of creatives.

# The function should return winner creatives, obeying the following rules:
#   * all winners must have unique advertiser id;
#   * if third argument (country) is provided, then only creatives without
# country or creatives with the same country can be among winners;
#   * any preference shouldn't be given to any of equal by price creatives, but
# should return such creatives equiprobable.

# The solution should be covered with tests. Consider a case with several input
# creatives equal by price and several function calls with same input, output
# results may be different
package media_decision;

sub make_decision {
    my ($win_cnt, $dest, @creatives) = @_;
    my %adv = ();
    return @{[
        map {!$adv{$_->{advertiser}}++ ? $_ : ()}
        sort {$b->{price} <=> $a->{price}}
        grep {!$dest || !$_->{country} || $_->{country} eq $dest} @creatives
    ]} [0..$win_cnt - 1];
}

1;