use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'Mojo::Base::Lib',
    AUTHOR           => q{Mikhail Che <mche@cpan.org>},
    VERSION_FROM     => 'lib/Mojo/Base/Lib.pm',
    ABSTRACT_FROM    => 'lib/Mojo/Base/Lib.pm',
    LICENSE          => 'Perl',
    PL_FILES         => {},
    MIN_PERL_VERSION => 5.006,
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
    },
    BUILD_REQUIRES => {
        'Test::More' => 0,
    },
    PREREQ_PM => {
        'Mojolicious'              => 6,
        #'Foo::Bar::Module' => 5.0401,
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    ##clean => { FILES => 'Mojo-Base-Lib-*' },
);
