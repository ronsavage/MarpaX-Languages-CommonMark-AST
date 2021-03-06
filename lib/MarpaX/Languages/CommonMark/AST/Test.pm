package MarpaX::Languages::CommonMark::AST::Test;
use Test::Base -Base;
 
use MarpaX::Languages::CommonMark::AST;
 
package MarpaX::Languages::CommonMark::AST::Test::Filter;
use Test::Base::Filter -base;
use 5.010; 
my $p = MarpaX::Languages::CommonMark::AST->new;

sub filter {
    my $input = shift;

#    warn "filter: $input";
    # turn tabs are embedded in test file to real tabs to test preprocessing
    $input =~ s/\\t/\t/g;
    # handle quoted text
    if ($input =~ m/q{(.+?)}/){
        $input =~ s/(^|\n)q{/$1/gs;
        $input =~ s/}\n/\n/gs;
    }
#    warn "filter: $input";

    # get ast and conver to html
    my $ast = $p->parse($input);
    return $p->html($ast);
}
