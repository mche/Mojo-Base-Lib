#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Mojo::Base::Lib' ) || print "Bail out!\n";
}

diag( "Testing Mojo::Base::Lib $Mojo::Base::Lib::VERSION, Perl $], $^X" );
