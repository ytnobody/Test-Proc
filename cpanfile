requires 'perl', '5.008001';
requires 'Proc::Simple', '0';
requires 'Exporter', '0';
requires 'File::Spec', '0';
requires 'File::Temp', '0';
requires 'File::Slurp', '0';

on 'test' => sub {
    requires 'Test::More', '0.98';
    requires 'Test::Time', '0';
};

