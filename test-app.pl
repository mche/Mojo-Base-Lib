#!/usr/bin/env perl
# find ~/perl5/lib/ -type f -exec grep -Hni 'is not a controller' {} \;

package TestApp;

#~ use FindBin;
#~ use lib "$FindBin::Bin/lib";

use Mojo::Base 'Mojolicious::Che';

sub startup {# 
  my $app = shift;
  $app->plugin(Config =>{file => 'Config.pm'});
  $app->поехали();
}

__PACKAGE__->new()->start();