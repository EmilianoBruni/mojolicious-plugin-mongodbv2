use Test::More tests => 1;

BEGIN {
    use_ok( 'Mojolicious::Plugin::Mongodbv2' ) || print "OH OH!\n";
}

diag( "Testing Mojolicious::Plugin::Mongodbv2 $Mojolicious::Plugin::Mongodbv2::VERSION, Perl $], $^X" );
