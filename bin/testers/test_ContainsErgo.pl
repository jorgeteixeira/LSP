#!/usr/bin/perl
## Authors: Jorge Teixeira
##
## Creation data: 25/06/2009
##
##	This script test a method from LSP::LSP which verifies is a given string 
##	contains at least one word that belongs to the semantic category 'HMN' 
##	and sub-category 'ERGO'.
##
## How to use it:
##
##	perl test_IsErgo.pl "string of words"
##
use strict;
use warnings;
use LSP::LSP;

my $string = shift || die ("Please choose the string to test");

my $LSP_object = new LSP::LSP();

my $status = $LSP_object->ContainsErgo($string);

if($status == 1) {
	print "True \n";
} else {
	print "False \n";
}