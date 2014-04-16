package Test::Proc;
use 5.008005;
use strict;
use warnings;
use parent 'Exporter';

use Test::Proc::Object;

our $VERSION = "0.01";
our @EXPORT = qw/ test_proc /;

sub test_proc (&) {
    my $code = shift;
    Test::Proc::Object->new($code);
}

1;
__END__

=encoding utf-8

=head1 NAME

Test::Proc - Helper tool for testing multi process program.

=head1 SYNOPSIS

    use Test::More;
    use Test::Proc;
    
    my $proc = test_proc {
        print 'test';
        warn 'dummy';
        sleep 50;
    };
    
    ok $proc->poll;
    
    like $proc->stdout, qr/\Atest/;
    like $proc->stderr, qr/\Adummy/;
    
    $proc->kill('KILL');
    my $status = $proc->wait;
    is $status, 255;

=head1 DESCRIPTION

Test::Proc is a helper tool for testing multi process product.

=head1 LICENSE

Copyright (C) ytnobody.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=cut

