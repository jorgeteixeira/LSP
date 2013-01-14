#!/usr/bin/perl
## Authors: Jorge Teixeira
##
## Creation data: 01/04/2008
##
##	This script test a method from LSP::Utils that splits the input string into
##	sentences, whethever is possible
##
## How to use it:
##
##	perl test_SplitSentences.pl
##
use strict;
use warnings;
use LSP::Utils;

my $string = shift || die("Missing test sentence...");


#warn("\n$string\n\n");

my $lsp_utils = new LSP::Utils;
$lsp_utils->SetVerbose(1);


my @content = $lsp_utils->SplitSentences($string);
for (@content) {
	warn("\n==>$_\n");
}