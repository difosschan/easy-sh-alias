#!/usr/bin/perl -w
# 由于时区产生零点错误，此脚本停用（或以后修复）
# 由 deal_time.py 脚本替代
use Class::Date qw(date localdate);
use strict;

my $timestamp;
if (scalar @ARGV >= 1) {
  $timestamp = $ARGV[0];
} else {
  $timestamp = time;
}
printf("%s\n", $timestamp);

my($sec, $min, $hour, $day, $mon, $year, $wday, $yday, $isdst) = localtime $timestamp;
printf("timestr: %04d-%02d-%02d %02d:%02d:%02d\n", $year+1900, $mon+1, $day, $hour, $min, $sec);

my $zero_str = sprintf("%04d-%02d-%02d",$year+1900, $mon+1, $day, 0, 0, 0);
my $zero_sec = date($zero_str)->epoch;
printf("zero clock (second): %d\n", $zero_sec);
