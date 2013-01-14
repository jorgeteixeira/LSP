#!/usr/bin/perl
## Authors: Jorge Teixeira
##
## Creation data: 01/04/2008
##
##	This script test a method from LSP::LSP which verifies is a given word 
##	is included in the LSPDB database. Returns True(1) or False(0).
##
## How to use it:
##
##	perl test_IsKnownForm.pl
##
use strict;
use warnings;
use LSP::LSP;

my $LSP_object = new LSP::LSP();

my $word = shift || "teste";

my $status = $LSP_object->IsKnownForm($word);

if($status == 1 ) {
	print "True\n";
} else {
	print "False\n";
}
