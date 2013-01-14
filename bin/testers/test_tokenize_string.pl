#!/usr/bin/perl
use strict;
use warnings;
use LSP::Utils;	

my $lsp_utils = new LSP::Utils();

my $test_string = shift;

my $tokenized_string = $lsp_utils->TokenizeString($test_string);
warn("\n" . $tokenized_string);

my @list_instantiations = $lsp_utils->GetInstantiationList();
warn("\n\nInstantiation List:\n");
for(@list_instantiations) {
	warn("'$_'\n");
}
