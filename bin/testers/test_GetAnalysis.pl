#!/usr/bin/perl
## Authors: Luis Sarmento and Jorge Teixeira
##
## Creation data: 28/08/2008
##
##  The main purpose of this script is to list all the avaiable morphological
##	and semantic information of a given word in the LSPDB module. 
##
## How to use it:
##
##	perl LSP_tester.pl word_to_search
##
## How does it works:
##
##	This script uses the information avaiable at LSPDB module, specifically the
##	GetAnalysis() method from LSP module, which return a list of objects, 
##	each one containing a parameter of the morphological and semantic analysis,
##	is avaiable.
##	The output - $output - is a string containing all the defined paramenters
##	for the searched word.
##
## Example:
##
##	perl LSP_manager.pl engenheiro
##
##	 Word="engenheiro"
##      Radical: engenheiro
##      Category: nc
##      Gender: m
##      Number: s
##      Radical category: nc
##      Semantic tag: ERGO
##      Semantic tag: CARGO
##      ---
##

use strict;
use warnings;
use LSP::LSP;

# Initializations
my $LSP = new LSP::LSP();
$LSP->SetVerbose(2);

my $word = shift || die("Please choose a word to search"); # input
my $output = "Word=\"$word\"\n"; # output

# Lets use the GetAnalysis() method from LSP module to get the morphological
# and semantic analysis (is avaiable) for $word
my @analysis_list = $LSP->GetAnalysis($word);
for (@analysis_list) {
	my $index_list_ref = $_;
  my %index_list = %{$index_list_ref};
    
	# Set the radical parameter
	if(defined($index_list{radical})) { 
		my $radical = $index_list{radical};
		$output .= "\tLemma: $radical\n";
	}
	
	# Set the category parameter
	if(defined($index_list{category})) { 
		my $category = $index_list{category};
		$output .= "\tCategory: $category\n";
	}
		
	# Set the gender parameter
	if(defined($index_list{gender}) && ($index_list{gender} ne "")) {
		my $gender = $index_list{gender};
		$output .= "\tGender: $gender\n";
	}
		
	# Set the number parameter
	if(defined($index_list{number})) {
		my $number = $index_list{number};
		$output .= "\tNumber: $number\n";
	}
		
	# Set the tense parameter
	if(defined($index_list{tense})) {
		my $tense = $index_list{tense};
		$output .= "\tTense: $tense\n";
	}
		
	# Set the radical parameter
	if(defined($index_list{person})) {
		my $person = $index_list{person};
		$output .= "\tPerson: $person\n";
	}	
		
	# Set the degree parameter			
	if(defined($index_list{degree})) {
		my $degree = $index_list{degree};
		$output .= "\tDegree: $degree\n";
	}
		
	# Set the subcategory parameter		
	if(defined($index_list{subcategory}) && ($index_list{subcategory} ne "")) {
		my $subcategory = $index_list{subcategory};
		$output .= "\tSub-category: $subcategory\n";
	}
		
	# Set the c parameter
	if(defined($index_list{c})) {
		my $c = $index_list{c};
		$output .= "\tC: $c\n";
	}
		
	# Set the flags parameter	
	if(defined($index_list{flags})) {
		my $flags = $index_list{flags};
		$output .= "\tFlags: $flags\n";
	}
		
	# Set the radical_category parameter	
	if(defined($index_list{radical_category})) {
		my $radical_cat = $index_list{radical_category};
		$output .= "\tRadical category: $radical_cat\n";
	}
			
	# Set the radical_preposition parameter	
	if(defined($index_list{prep}) && ($index_list{prep} ne "")) {
		my $radical_preposition = $index_list{prep};
		$output .= "\tRadical preposition: $radical_preposition\n";
	}

	# Set the radical_article parameter	
	if(defined($index_list{art}) && ($index_list{art} ne "")) {
		my $radical_article = $index_list{art};
		$output .= "\tRadical article: $radical_article\n";
	}

	# Set the radical_personal_preposition parameter	
	if(defined($index_list{ppes}) && ($index_list{ppes} ne "")) {
		my $radical_personal_preposition = $index_list{ppes};
		$output .= "\tRadical Personal Preposition: $radical_personal_preposition\n";
	}

	# Set the radical_adverb parameter	
	if(defined($index_list{adverb}) && ($index_list{adverb} ne "")) {
		my $radical_adverb = $index_list{adverb};
		$output .= "\tRadical adverb: $radical_adverb\n";
	}

	# Set the semantic tags
	if(scalar(@{$index_list{semantic_tags}}) != 0) {
		my $tag_name= "";
		my $tag_cat = "";
		my $tag_sub_cat = "";
		my @semantic_tags = @{$index_list{semantic_tags}};
		for (@semantic_tags) {
			my $ref = $_;
  		my %semantic_list_hash = %{$ref};
  		$tag_name = $semantic_list_hash{name};
			$tag_cat = $semantic_list_hash{tag_cat};
			if(defined($semantic_list_hash{tag_sub_cat})){
				$tag_sub_cat = $semantic_list_hash{tag_sub_cat};
			}			
			
			$output .= "\tSemantic tag name: $tag_name\n\tSemantic tag category: $tag_cat\n\tSemantic tag sub-category: $tag_sub_cat\n";
		}
	}
	# Set the reflexive parameter	
	if(defined($index_list{reflex})) {
		my $reflex_flag = $index_list{reflex};
		$output .= "\tReflexive verb form\n";
	}
	
	# Valency	
	if(defined($index_list{valency})) {
		$output .= "\tValency: '$index_list{valency}'\n";
	}
		
	$output .= "\t---\n";
	
	
	
}

print $output;