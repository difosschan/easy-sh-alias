#!/usr/bin/perl
use strict;
#use Data::Dumper::Simple;
my $ARGC = scalar @ARGV;

if ($ARGC < 1) {
    print "input argument:\n" .
          "1. Symbol in low-level.\n";
    exit;
}

my $argvs = "";
foreach my $argv (@ARGV) {
    $argvs .= " $argv";
}

my @all_files = glob "*.so";
push @all_files, glob "*.o";
push @all_files, glob "*.a";
my $cnt = 0;
foreach (@all_files) {
    # run 'nm' first time. (without '-C' parameter), and grep symbol.
    my $nm_cmd = "nm -A $_|cat -n|grep $argvs";
    my $nm_result = `$nm_cmd`;
    
    # ignore result which wasn't contains symbol.
    next if ($nm_result == "");
    
    # get line number( which specified by 'cat -n') and so file name. 
    my ($line_number, $so_file);
    my $i = 0;
    my @result = split /\s+/, "$nm_result";
    foreach (@result) {
        next if /^\s*$/;
        if (0 == $i) {
            $line_number = $_;
            ++ $i;
        } elsif (1 == $i) {
            $so_file = (split ':', $_)[0];
            last;
        }
    }
    # run 'nm' again (use '-C' parameter).
    $nm_cmd = "nm -C -A $so_file|cat -n|grep -E \"^[[:space:]]*" . $line_number. "[[:space:]]+\"";
    $nm_result = `$nm_cmd`;
    
    ++$cnt;
    print "\033[1;33m". "[$cnt]" . "\033[0m" . "  ";
    print $nm_result;
}

