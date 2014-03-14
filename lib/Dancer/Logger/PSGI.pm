package Dancer::Logger::PSGI;

use v5.10;
use strict;
use warnings;
use Dancer::SharedData;
use parent qw(Dancer::Logger::Abstract);

# VERSION
# ABSTRACT: PSGI Log handler for Dancer

sub init { }

sub _log {
    my ($self, $level, $message) = @_;
    my $full_message = $self->format_message($level => $message);
    chomp $full_message;

    my $request = Dancer::SharedData->request;
    if ( $request->{env}{'psgix.logger'} ) {
        $request->{env}{'psgix.logger'}->(
            {   level   => $level,
                message => $full_message,
            }
        );
    }
    return;
}

1;
