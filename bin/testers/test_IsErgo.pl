#!/usr/bin/perl
## Authors: Jorge Teixeira
##
## Creation data: 25/06/2009
##
##	This script test a method from LSP::LSP which verifies is a given word 
##	belongs to the semantic category 'HMN' sub-category 'ERGO'.
##
## How to use it:
##
##	perl test_IsErgo.pl "word"
##
use strict;
use warnings;
use LSP::LSP;

my $word = shift || die ("Please choose the word to test");

my $LSP_object = new LSP::LSP();

my $status = $LSP_object->IsErgo($word);

if($status == 1) {
	print "True \n";
} else {
	print "False \n";
}