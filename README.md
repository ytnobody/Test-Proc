# NAME

Test::Proc - Helper tool for testing multi process program.

# SYNOPSIS

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

# DESCRIPTION

Test::Proc is a helper tool for testing multi process product.

# LICENSE

Copyright (C) ytnobody.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

ytnobody <ytnobody@gmail.com>
