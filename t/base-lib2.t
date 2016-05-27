use Mojo::Base -strict;
use Test::More;

use FindBin;
my $lib1 = "$FindBin::Bin/lib1";
my $lib2 = "/abs/path2";

is scalar grep($lib1 eq $_, @INC), 0, 'ok not lib1';
is scalar grep($lib2 eq $_, @INC), 0, 'ok not lib2';

eval <<EVAL;
use Mojo::Base -lib, qw($lib2 lib1);
EVAL

is scalar grep($lib1 eq $_, @INC), 1, 'ok lib1';
is scalar grep($lib2 eq $_, @INC), 1, 'ok lib2';

done_testing();
