#!/usr/bin/perl

use strict;
use warnings;
use LWP::Simple;
use Data::Dumper::Simple;
use Cwd;

my $RetryUpperLimit = 5;
my @pics_list_files;
my $cwd = getcwd;

# 处理输入参数
if (scalar(@ARGV) == 0) {
    # 不带参数时，默认以本目录的所有txt文件为下载列表
    @pics_list_files = glob q(*.txt);
} else {
    # 带参数时，以参数中制定的文件为下载列表
    foreach my $pics_list_file(@ARGV) {
        push @pics_list_files, $pics_list_file;
    }
}
my $i_file = 0;
foreach my $file_or_url (@pics_list_files) {
    if (-e $file_or_url) {
        print "Analyze resource in <$file_or_url>:\n";
        get_res_from_file($file_or_url, ++$i_file);
    } else {
        print "Download URL <$file_or_url> directly:\n";
        get_res_from_url($file_or_url);
    }
}

# 返回值：成功 1；失败 0
sub get_res_from_url {
    my $url = shift;
    my $ret = 0;
    my $local = '';

    # 以"#"开头的为注释，需要跳过
    if ($url =~ /^#.+$/) {
        return 1;
    }

    # 防止URL使用斜杠结尾
    my @sp = split(/\//, $url);
    $local = @sp[scalar(@sp) - 1];
    # 对带问号的URL实行截断
    @sp = split(/\?/, $local);
    $local = $sp[0];

    if (-e $local) {
        print "[IGNORE] File <$local> is already exist.\n";
        return 1;
    }

    my $tmp_file = $local . ".tmp";
    if (-e $tmp_file) {
        # 临时文件存在，则删除之
        unlink $tmp_file;
    }
    # 下载文件并命名为临时文件名
    my $HTTP_response_code = LWP::Simple::getstore($url, $tmp_file);
    print "[DOWNLOADING...] $url ==> $local\n";
    print "getstore() return $HTTP_response_code\n";
    if ($HTTP_response_code == 200) {
        # 把临时文件改名成正式文件名
        rename $tmp_file, $local;
        print "\tSucceed!\n";
        $ret = 1;
    } else {
        print "\tFail.\n";
    }
    unlink $tmp_file; # 删除临时文件
    return $ret;
}

sub get_res_from_file {
    my $res_list_filename = shift;
    my $pre = shift;

    open "RES_LIST_FN", "<", $res_list_filename || &Abort ("Resource list file <$res_list_filename> could not be opened.");

    my @picture_array = <RES_LIST_FN>;
    close RES_LIST_FN;
    my $i = 1; # 自增序号（暂时没用）

    my @picture_array_need = @picture_array;
    my @picture_array_failed;
    my $remain_cnt = 0;
    my $retry = 0;
    do {
        foreach my $a_pic_url (@picture_array_need) {
            chomp ($a_pic_url);
            next if ($a_pic_url eq '');

            if (! get_res_from_url($a_pic_url)) {
                push @picture_array_failed, $a_pic_url;
            }
        }
        # 没下载成功的重试
        @picture_array_need = @picture_array_failed;
        if ( ($remain_cnt = scalar(@picture_array_need)) != 0) {
            printf("download retry, %u files remaining.\n", $remain_cnt);
        }
        ++$retry;
    } while (($remain_cnt != 0) && ($retry < $RetryUpperLimit));

}

