use strict;
use Test::More;
use Test::Proc;
use Test::Time;

my $proc = test_proc {
    my $begin = time();
    sleep 3; 
    my $end = time();

    printf "%d sec. elapsed", $end - $begin;
};

is $proc->poll, 1;
is $proc->wait, 0;

is $proc->stdout, '3 sec. elapsed';
is $proc->stderr, '';
is $proc->poll, 0;

done_testing;
