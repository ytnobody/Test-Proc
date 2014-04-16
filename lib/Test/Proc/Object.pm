package Test::Proc::Object;
use strict;
use warnings;
use parent 'Proc::Simple';
use File::Temp 'tempdir';
use File::Spec;
use File::Slurp 'read_file';

sub new {
    my ($class, $code) = @_;
    my $self = $class->SUPER::new;

    $self->{tempdir} = tempdir(CLEANUP => 1);
    $self->{stdout} = File::Spec->catfile($self->{tempdir}, 'stdout');
    $self->{stderr} = File::Spec->catfile($self->{tempdir}, 'stderr');

    $self->redirect_output($self->{stdout}, $self->{stderr});

    $self->kill_on_destroy(1);
    $self->signal_on_destroy('KILL');

    $self->start($code);

    return $self;
}

sub stdout { read_file(shift->{stdout}) }

sub stderr { read_file(shift->{stderr}) }

1;
__END__

=encoding utf-8

=head1 NAME

Test::Proc::Object - Process Class for Test::Proc

=head1 SYNOPSIS

    use Test::Proc::Object;
    
    my $proc = Test::Proc::Object->new('/path/to/script', 'option');

=head1 DESCRIPTION

Test::Proc::Object is a Process Class for testing multi process product.

=head1 LICENSE

Copyright (C) ytnobody.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=cut

