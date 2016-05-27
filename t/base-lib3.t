use Mojo::Base -strict;
use Test::More;

#~ use FindBin;
#~ use lib "$FindBin::Bin/lib";

package Mojo::BaseTestTest;
use Mojo::Base 'Mojo::BaseTest::Base3', -lib => 'lib';

package main;

my $object2 = Mojo::BaseTestTest->new;

isa_ok($object2, 'Mojo::BaseTestTest', 'class ok');
isa_ok($object2, 'Mojo::BaseTest::Base3', 'class ok');
isa_ok($object2, 'Mojo::BaseTest::Base1', 'class ok');
isa_ok($object2, 'Mojo::Base', 'class ok');



done_testing();
