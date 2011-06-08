#!/usr/bin/env perl
use strict;
use warnings;
use LWP::Simple;
my $url;
my $content;
$url = "http://svtget.se/";

$content = get($url);
$content =~ s/\t//g;
$content =~ s/<!--.*?--\s*>//gs;
$content =~ s|<.+?>||g;

print $content;
