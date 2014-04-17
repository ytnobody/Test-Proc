# NAME

Test::Proc - Helper tool for testing multi process program.

# SYNOPSIS

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



# DESCRIPTION

Test::Proc is a helper tool for testing multi process product.

# EXPORTS

## test\_proc

    my $proc = test_proc $coderef;

Returns a [Test::Proc::Object](http://search.cpan.org/perldoc?Test::Proc::Object) instance.

# LICENSE

Copyright (C) ytnobody.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

ytnobody <ytnobody@gmail.com>

# SEE ALSO

[Test::Proc::Object](http://search.cpan.org/perldoc?Test::Proc::Object)
