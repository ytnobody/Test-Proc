package Test::Proc;
use 5.008005;
use strict;
use warnings;
use parent 'Exporter';

use Test::Proc::Object;

our $VERSION = "0.01";
our @EXPORT = qw/ test_proc /;

sub test_proc ($&) {
    my ($name, $code) = @_;
    Test::Proc::Object->new($name, $code);
}

1;
__END__

=encoding utf-8

=head1 NAME

Test::Proc - Helper tool for testing multi process program.

=head1 SYNOPSIS

    use Test::More;
    use Test::Proc;
    
    my $proc = test_proc 'my_task' => sub {
        print 'test';
        warn 'dummy';
        sleep 20;
    };
    
    $proc->is_work;
    
    $proc->stdout_like( qr/\Atest/ );
    $proc->stderr_like( qr/\Adummy/ );
    
    $proc->exit_ok;


=head1 DESCRIPTION

Test::Proc is a helper tool for testing multi process product.

=head1 EXPORTS

=head2 test_proc

    my $proc = test_proc $coderef;

Returns a L<Test::Proc::Object> instance.

=head1 LICENSE

Copyright (C) ytnobody.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=head1 SEE ALSO

L<Test::Proc::Object>

=cut

