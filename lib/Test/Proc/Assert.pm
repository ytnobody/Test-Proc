package Test::Proc::Assert;
use strict;
use warnings;
use parent 'Test::Builder::Module';

sub ok {
    my $class = shift;
    my $tb = $class->builder;
    return $tb->ok(@_);
}

1;
