package Test::Proc::Object;
use strict;
use warnings;
use parent 'Proc::Simple';
use File::Temp 'tempdir';
use File::Spec;
use File::Slurp 'read_file';
use Test::Proc::Assert;

sub new {
    my ($class, $name, $code) = @_;
    my $self = $class->SUPER::new;

    $self->{name} = $name;
    $self->{tempdir} = tempdir(CLEANUP => 1);
    $self->{stdout} = File::Spec->catfile($self->{tempdir}, 'stdout');
    $self->{stderr} = File::Spec->catfile($self->{tempdir}, 'stderr');

    $self->redirect_output($self->{stdout}, $self->{stderr});

    $self->kill_on_destroy(1);
    $self->signal_on_destroy('KILL');

    $self->start($code);

    return $self;
}

sub wait {
    my $self = shift;
    my $status = $self->SUPER::wait;
    $self->{exit_status} = $status;
    $status;
}

sub stdout { read_file(shift->{stdout}, @_) }

sub stderr { read_file(shift->{stderr}, @_) }

sub is_work {
    my $self = shift;
    my $test_name = sprintf('process %s is work', $self->{name});
    Test::Proc::Assert->ok($self->poll, $test_name);
}

sub isnt_work {
    my $self = shift;
    my $test_name = sprintf('process %s is not work', $self->{name});
    Test::Proc::Assert->ok(! $self->poll, $test_name);
}

sub exit_ok {
    my $self = shift;
    $self->exit_code_is(0);
}

sub exit_code_is {
    my ($self, $exit_code) = @_;
    my $test_name = sprintf('process %s exit code is %d', $self->{name}, $exit_code);
    $self->wait;
    Test::Proc::Assert->ok($self->{exit_status} == $exit_code, $test_name);
}

sub stdout_like {
    my ($self, $regex) = @_;
    my $test_name = sprintf('process %s STDOUT like %s', $self->{name}, $regex);
    my $str = $self->stdout;
    Test::Proc::Assert->ok($str =~ $regex, $test_name);
}

sub stderr_like {
    my ($self, $regex) = @_;
    my $test_name = sprintf('process %s STDERR like %s', $self->{name}, $regex);
    my $str = $self->stderr;
    Test::Proc::Assert->ok($str =~ $regex, $test_name);
}

1;
__END__

=encoding utf-8

=head1 NAME

Test::Proc::Object - Process Class for Test::Proc

=head1 SYNOPSIS

    use Test::Proc::Object;
    
    my $proc = Test::Proc::Object->new('task_name' => sub { ... });
    $proc->is_work;
    $proc->wait;
    $proc->exit_ok;
    $proc->isnt_work;

=head1 DESCRIPTION

Test::Proc::Object is a Process Class for testing multi process scenario.

This class inherits L<Proc::Simple>. 

=head1 METHODS

=head2 new

    my $proc = Test::Proc::Object->new($proc_name, $coderef);

Return a Test::Proc::Object.

=head2 wait

    my $exit_code = $proc->wait;

Wait to exit process, store an exit code into self, and return an exit code.

=head2 stdout, stderr

    my $text = $self->stdout;
    my $raw_text = $self->stdout({binmode => ':raw'});
    my @lines = $self->stderr;

Return STDOUT/STDERR like read_file of L<File::Slurp>.

=head2 is_work, isnt_work

    $proc->is_work;

To test that the process is running.

=head2 exit_ok

    $proc->exit_ok;

To test that process was exit successfully (exit code = 0).

This method calls wait method internally.

=head2 exit_code_is

    $proc->exit_code_is(1);

To test that process was exit with specified exit code.

This method calls wait method internally.

=head2 stdout_like, stderr_like

    $proc->stderr_like(qr/^expected things/);

To test that STDOUT/STDERR matches to specified regex-ref.

=head1 LICENSE

Copyright (C) ytnobody.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=cut

