#!/usr/bin/perl

use strict;
use warnings;
use 5.10.0;

use Mustache::Simple;

my $data = {
    a =>  { one =>  1 },
    b =>  { two =>  2 },
    c =>  { three =>  3 },
    d =>  { four =>  4 },
    e =>  { five =>  5 },
};

my $template = <<EOT;
{{#a}}
{{one}}
{{#b}}
{{one}}{{two}}{{one}}
{{#c}}
{{one}}{{two}}{{three}}{{two}}{{one}}
{{#d}}
{{one}}{{two}}{{three}}{{four}}{{three}}{{two}}{{one}}
{{#e}}
{{one}}{{two}}{{three}}{{four}}{{five}}{{four}}{{three}}{{two}}{{one}}
{{/e}}
{{one}}{{two}}{{three}}{{four}}{{three}}{{two}}{{one}}
{{/d}}
{{one}}{{two}}{{three}}{{two}}{{one}}
{{/c}}
{{one}}{{two}}{{one}}
{{/b}}
{{one}}
{{/a}}
EOT

my $mus = new Mustache::Simple;
print $mus->render($template, $data);
