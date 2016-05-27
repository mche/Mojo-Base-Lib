package Mojo::Base::Lib;
use base 'Mojo::Base';

#~ use strict;
#~ use warnings;
#~ use utf8;
#~ use feature ();

our $VERSION = '0.001';

sub import {
  my $class = shift;
  #~ return unless my $flag = shift;
  
  my ($flag, $findbin,);
  my @flags = ();
  my @libs = ();

  # parse flags
  while ((my $it = shift) || @_) {
    unshift @_, @$it
      and next
      if ref $it eq 'ARRAY';
    
    next 
      unless defined($it) && $it =~ m'/|\w';# /  root lib? lets
    
    # controll flag
    if ($it =~ s'^(-\w+)'') {
      
      $flag = $1;
      push @flags, $flag
        and next
        unless $flag eq '-lib';
      
      unshift @_, split m'[:;]+', $it # -lib:foo;bar
        if $it;
      
      next;
      
    } else { # non controll
      
      push @flags, $it
        and next
        unless $flag && $flag eq '-lib';# non lib items
      
    }
    
    # abs lib
    push @libs, $it
      and next
      if $it =~ m'^/';
    
    # relative lib
    $findbin ||= do {
      require FindBin;
      $FindBin::Bin;
    };
    push @libs, $findbin.'/'.$it;
  }
  
  if ( @libs && (my @ok_libs = grep{ my $lib = $_; not scalar grep($lib eq $_, @INC) } @libs) ) {
    require lib;
    lib->import(@ok_libs);
  }
  
  $flag = shift @flags
    or return;

  # Base
  if ($flag eq '-base') { $flag = $class }

  # Strict
  elsif ($flag eq '-strict') { $flag = undef }

  # Module
  elsif ((my $file = $flag) && !$flag->can('new')) {
    $file =~ s!::|'!/!g;
    require "$file.pm";
  }

  # ISA
  if ($flag) {
    my $caller = caller;
    no strict 'refs';
    push @{"${caller}::ISA"}, $flag;
    _monkey_patch $caller, 'has', sub { attr($caller, @_) };
  }

  # Mojo modules are strict!
  $_->import for qw(strict warnings utf8);
  feature->import(':5.10');
}

1;

=pod

=encoding utf8

Доброго всем

=head1 Mojo::Base::Lib

¡ ¡ ¡ ALL GLORY TO GLORIA ! ! !

=head1 VERSION

0.001

=head1 NAME

Mojo::Base::Lib - use Mojo::Base::Lib -lib, qw(rel/path/lib /abs/path/lib);

=head1 SYNOPSIS

Also there is a fourth extended form for add extra lib directories to perl's search path. See <lib>

  use Mojo::Base -lib, qw(rel/path/lib /abs/path/lib);
  use Mojo::Base -lib, ['lib1', 'lib2'];
  use Mojo::Base '-lib:lib1:lib2;lib3';
  use Mojo::Base -strict, qw(-lib lib1 lib2);
  use Mojo::Base qw(-base -lib lib1 lib2);
  use Mojo::Base 'SomeBaseClass', qw(-lib lib1 lib2);
  use Mojo::Base qw(-lib lib1 lib2), 'SomeBaseClass'; # same above, different order allow

For relative lib path will use L<FindBin> module and C<$FindBin::Bin> is prepends to that lib.
Libs always applied first even its last on flags list.

=head1 SEE ALSO

L<Mojo::Base>

=head1 AUTHOR

Михаил Че (Mikhail Che), C<< <mche[-at-]cpan.org> >>

=head1 BUGS / CONTRIBUTING

Please report any bugs or feature requests at L<https://github.com/mche/Mojolicious-Plugin-RoutesAuthDBI/issues>. Pull requests also welcome.

=head1 COPYRIGHT

Copyright 2016 Mikhail Che.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
