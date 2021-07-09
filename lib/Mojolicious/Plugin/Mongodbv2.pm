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

has 'conf' => sub { {host => 'mongodb://localhost/mongodbv2' } };
has '_client';

sub init {
    my $s = shift;
    $s->_client(MongoDB::MongoClient->new($s->conf));
}

1;
__END__

# ABSTRACT: MongoDB v2 driver in Mojolicious

=pod

=encoding UTF-8

=begin html

BUILD STATUS: <a href="https://travis-ci.com/EmilianoBruni/mojolicious-plugin-mongodbv2"><img src="https://travis-ci.com/EmilianoBruni/mojolicious-plugin-mongodbv2.svg?branch=main"></a>

=end html

=head1 SYNOPSIS

Provides helper to easy use MongoDB v2 drivers in Mojolicious application.

    plugin 'mongodbv2', {
        host => 'mongodb://localhost/mongodbv2',
        helper => 'db',
    }

=head1 CONFIGURATION OPTIONS

    host                (optional)  MongoDB URI Connection
                                    (default: 'mongodb://localhost/mongodbv2')
    helper              (optional)  The name to give to the easy-access helper
                                    (default: 'db')
All other options passed to the plugin are used to connect to MongoDB.

=head1 HELPERS/ATTRIBUTES

=head2 mongodb_connection

This plugin helper will return the MongoDB::MongoClient object

=head2 db

This is the name of the default easy-access helper.

=head1 BUGS/CONTRIBUTING

Please report any bugs through the web interface at L<https://github.com/EmilianoBruni/mojolicious-plugin-mongodbv2/issues>
If you want to contribute changes or otherwise involve yourself in development, feel free to fork the Git repository from
L<https://github.com/EmilianoBruni/mojolicious-plugin-mongodbv2/>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.
    perldoc Mojolicious::Plugin::Mongodbv2

=head1 AUTHOR

Emiliano Bruni <info AT ebruni.it>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2021 by Emiliano Bruni.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

1;
