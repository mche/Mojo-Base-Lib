use Mojo::Base::Lib -strict;
use Test::More;

#~ use FindBin;
#~ use lib "$FindBin::Bin/lib";

package Test;
use Mojo::Base::Lib 'Test2', -lib => 'lib2';

package main;

my $object2 = Test->new;

isa_ok($object2, 'Test', 'class ok');
isa_ok($object2, 'Test2', 'class ok');

done_testing();
