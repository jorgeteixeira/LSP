#!/usr/bin/perl
## Authors: Jorge Teixeira
##
## Creation data: 01/04/2008
##
##	This script test a method from LSP::LSP which verifies is a the radical 
##	of the word given by the user matches any of the radicals listed by the 
##	user 
##	
##
## How to use it:
##
##	perl test_IsRadicalInList.pl "word" "radical1,radical2,radical3"
##
use strict;
use warnings;
use LSP::LSP;

my $word = shift || "felizmente";
my @categories = ("v","nc");


my $LSP_object = new LSP::LSP();

my $status = $LSP_object->IsCategoryInList($word,\@categories);

if($status == 1) {
	print "True \n";
} else {
	print "False \n";
}