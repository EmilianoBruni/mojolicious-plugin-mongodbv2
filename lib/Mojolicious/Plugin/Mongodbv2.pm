# ABSTRACT: MongoDB v2 driver in Mojolicious
use strict;
use warnings;
package Mojolicious::Plugin::Mongodbv2;

use Mojo::Base 'Mojolicious::Plugin';
use MongoDB;

sub register {
    my ($self, $app, $conf) = @_;
    $conf = $conf || {};

    $conf->{helper} ||= 'db';

    $app->attr('mongodb_connection' => sub {
        my $m = Mojolicious::Plugin::Mongodbv2::Client->new(conf => $conf);
        $m->init();
        return $m->_client;
    });

    $app->helper($conf->{helper} => sub {
        my $s = shift;
        my $m = $s->app->mongodb_connection;
        return $m->db($m->db_name);
    });
}

package Mojolicious::Plugin::Mongodbv2::Client;
use Mojo::Base -base;

has 'conf' => sub { {host => 'mongodb://localhost:27017/mongodbv2' } };
has '_client';

sub init {
    my $s = shift;
    $s->_client(MongoDB::MongoClient->new($s->conf));
}

1;
__END__

1;
