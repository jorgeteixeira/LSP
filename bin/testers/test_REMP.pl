#!/usr/bin/perl

# Case 1) José Sócrates	
# Case 2) Manuela Ferreira Leita
# Case 3) Manuela Ferreira Leita Xxxx
# Case 4) Pinto da Costa
# Case 5) Ricardo Viegas de Abreu
# Case 6) Maria de Lurdes Rodrigues
# Case 7) Luiz xx Inácio Lula Silva
# Case 8) Luiz Inácio xx Lula Silva	
# Case 9) Luiz Inácio Lula xx Silva

use strict;
use warnings;
use LSP::Utils;

my $lsp_utils = new LSP::Utils ();
$lsp_utils->SetVerbose(2);


my $counter = 0;
my %ne_hash = ();

my $input_string = shift || "Lewis Hamilton ( McLaren-Mercedes )";
my @output = $lsp_utils->REMP($input_string);
for(@output) {
	my $ne = $_;
	$ne =~ s/^NE\_//;
	$ne =~ s/\_/ /g;
	$ne_hash{$ne}++;
	$counter++;	
}

for(sort keys %ne_hash) {
	print($_ . "\n");
}	
	
print("'$counter' NE recognized\n");
