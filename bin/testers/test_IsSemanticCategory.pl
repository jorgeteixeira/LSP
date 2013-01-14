#!/usr/bin/perl
## Authors: Jorge Teixeira
##
## Creation data: 01/04/2008
##
##	This script test a method from LSP::LSP which verifies is a given word 
##	belongs to the semantic category (and) sub-category mentioned by the user.
##
## How to use it:
##
##	perl test_IsSemanticCategory.pl "word" "semantic_cat" "semantic_sub_cat"
##
use strict;
use warnings;
use LSP::LSP;

my $word = shift || die ("Please choose the word to test");
my $category = shift || die ("Please choose the semantic category to test");
my $sub_category = shift || "";


my $LSP_object = new LSP::LSP();

my $status = $LSP_object->IsSemanticCategory($word,$category,$sub_category);

if($status == 1) {
	print "True \n";
} else {
	print "False \n";
}