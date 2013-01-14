#!/usr/bin/perl
## Authors: Jorge Teixeira
##
## Creation data: 01/04/2008
##
##	This script test a method from LSP::LSP which verifies is a given word 
##	belongs to the category mentioned by the user.
##
## How to use it:
##
##	perl test_IsCategory.pl "word" "morphological_cat"
##
use strict;
use warnings;
use LSP::LSP;

my $word = shift || die ("Please choose the word to test");
my $category = shift || die ("Please choose the category to test");

my $LSP_object = new LSP::LSP();

my $status = $LSP_object->IsCategory($word,$category);

if($status == 1) {
	print "True \n";
} else {
	print "False \n";
}