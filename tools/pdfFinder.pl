#!/bin/env perl
use v5.24;
use strict;
use warnings;

my $pdflist = `find ~ -name "*.pdf"`;
my @pdfs= split(/\n/, $pdflist);
my @pdfNames = $pdflist =~ m#([^\/]*pdf)#g;
$pdflist = join("\n", @pdfNames);
my $file = `echo "$pdflist" | rofi -dmenu run -lines 4 -bw 20 -eh 2 -width 600 -padding 40 -i -p "pdf> "`;
chomp($file);

my ($output) = grep(/\Q$file\E/, @pdfs);
# say $output;
`zathura "$output"`;
