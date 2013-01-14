#!/usr/bin/perl
## Authors: Jorge Teixeira
##
## Creation data: 01/04/2008
##
##	This script test a method from LSP::LSP which verifies if a given word 
##	(a verb form) is from the first or the third person
##
## How to use it:
##
##	perl test_IsFirstThirdPersonVerb.pl "word"
##
use strict;
use warnings;
use LSP::LSP;

my $word = shift || die ("Please choose the word to test");

my $LSP_object = new LSP::LSP();

my $status = $LSP_object->IsFirstThirdPersonVerb($word);

if($status == 1) {
	print "True \n";
} else {
	print "False \n";
}