
=pod
Главный Конфиг сервиса
=cut


{
  'Проект'=>'Тест',
  mojo_mode=> 'development',
  mojo_log_level => 'debug',#$ENV{PLACK_ENV} ? 'error' : 'debug', 
  mojo_plugins=>[ 
      [charset => { charset => 'UTF-8' }, ],
  ],
  mojo_session => {cookie_name => 'ELK'},
  mojo_secrets => ['true 123 test-app',],
  namespaces => [],
  'маршруты' => [
  [
    route=>'/callback',
    to=>sub {shift->render(format=>'txt', text=>'You have access!')},
    name=>'foo',#'install#manual', namespace000=>'Mojolicious::Plugin::RoutesAuthDBI',
  ],[
    route=>'/check-auth',
    to=>{cb=>sub {my $c =shift; $c->render(format=>'txt', text=>"Hi @{[$c->auth_user->{login}]}! You have access!");}},
  ],[
    route=>'/routes',
    to=>{cb=>sub {my $c =shift; $c->render(format=>'txt', text=>$c->dumper($c->match->endpoint));}},
    name=>'app routes',
  ],
  ],
};


