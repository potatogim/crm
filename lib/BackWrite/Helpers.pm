package BackWrite::Helpers;
use Mojo::Base -strict;

use BackWrite::Model;

sub register {
    my ( $class, %params ) = @_;

    my $app = $params{context} || undef;

    $app->helper(
        'schema' => sub {
            return BackWrite::Model->init_db;
        }
    );

    # TODO pack into plugin
    $app->helper(
        'lang' => sub {
            shift->session( lang => $_[0] || 'eng' ),;
        }
    );

    # TODO pack into plugin
    $app->helper(
        'l' => sub {
            my $l = BackWrite::I18N->load( shift->session('lang') || 'eng' );
            return $l->key( $_[0] ) || '';
        }
    );

    # TODO pack into plugin
    $app->helper(
        'r' => sub {
            my $l = BackWrite::I18N->load( shift->session('lang') || 'eng' );
            return $l->key('replace_for')->{ $_[0] } || '';
        }
    );

    use BackWrite::App::DateTime;
    $app->helper(
        'datetime' => sub {
            return BackWrite::App::DateTime->parse( $_[1] ) || undef;
        }
    );

    $app;
}

1;
