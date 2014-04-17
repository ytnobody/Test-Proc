use strict;
use Test::More;
use Test::Proc;
use Test::Time;

my $proc = test_proc 'my_work' => sub {
    my $begin = time();
    sleep 3; 
    my $end = time();

    printf "%d sec. elapsed", $end - $begin;
};

$proc->is_work;
$proc->exit_ok;
$proc->isnt_work;

$proc->stdout_like(qr/\A3 sec\. elapsed\z/);
$proc->stderr_like(qr/\A\z/);

done_testing;
