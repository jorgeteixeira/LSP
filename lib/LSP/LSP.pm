package LSP::LSP;

use 5.006;
use strict;
use warnings;
use LSP::LSPDB;

our $VERSION = '0.01';

sub new {
	shift;
  my $this = {};
	$this->{get_analysis_counter} = 0;
	$this->{get_radical_info_by_id_counter} = 0;
	$this->{get_semantic_info_by_tag_id_counter} = 0;
	    
  bless $this;
  return $this;
}

sub SetVerbose() {
	my $this = shift;
  $this->{verbose} = shift || 0;
}

sub IsKnownForm() {
	my $this = shift;
  my $form_lc = $this->LC(shift);
  return (defined($LSPDB::index_hash{$form_lc}));
}

sub GetAnalysis {
	# This method has one input, the word. This method will retrieve an array 
	# which contains the %form_analysis_hash. 
	# This hash uses the information avaiable at the LSPDB database. 

	my $this = shift;
	my $form = shift; # input
	my @analysis_list = (); # output
	$this->{get_analysis_counter}++;
	
	my $form_lc = $this->LC($form);
		
	## Let's check if the $form is defined in the index_hash (in LSPDB module)
	if (defined($LSPDB::index_hash{$form_lc})) {
		# the string $forms_analysis_string contains the entire analysis for the 
	 	# $form
	 	
		my $forms_analysis_string = $LSPDB::index_hash{$form_lc};
		  
		# one single $form may have more than one analyse, so each analysis is 
		# separated by '+'. The array @forms_analysis_list will contain a list
		# of analysis for a single $form
		my @forms_analysis_list = split('\+', $forms_analysis_string);
		
		## For all possible forms' analyisis, let's build an hash
		for(@forms_analysis_list) {
			my %form_analysis_hash = ();
							
			# The analysis parameters are separated by '\t'. The @form_info array
			# will contain all the avaiable parameters (to be defined as keys of the
			# %form_analysis_hash hash) for each analysis of the $form being 
			# analysed.
		  my @form_info = split('\t', $_);

			# Accordingly to the information retrieved by the index_hash in the
			# LSPDB module, we build the %form_analysis_hash with respective keys 
			# and values, as following. 
	    my $form_category = $form_info[1];
      $form_analysis_hash{form} = $form;
 	    $form_analysis_hash{radical_id} = $form_info[0];
   	  $form_analysis_hash{category} = $form_category;
     	$form_analysis_hash{radical_category} = $form_info[2];
  	  $form_analysis_hash{gender} = $form_info[3];
 			$form_analysis_hash{number} = $form_info[4];

 			# If $form is an cardinal, the degree parameter is unique to this 
 			# category and needs to be defined separately.
 			if ($form_category eq "card") {
 			  $form_analysis_hash{number} = $form_info[3];
 			  $form_analysis_hash{gender} = "";
 			}
        			
 			# If $form is an adjective, the degree parameter is unique to this 
 			# category and needs to be defined separately.
 			if ($form_category eq "adj") {
 			  $form_analysis_hash{degree} = $form_info[5];
 			}
 			
 			# If $form is a verb, the tense and person parameters are unique to this 
 			# category and need to be defined separately.
 			if ($form_category eq "v") {
 			  $form_analysis_hash{tense} = $form_info[3];
 			  $form_analysis_hash{person} = $form_info[5];
 			  $form_analysis_hash{gender} = "";
 			}
 			
 			# If $form is an adverb, the flags parameter is unique to this 
 			# category and needs to be defined separately.  			
 			if ($form_category eq "adv") {
 			  $form_analysis_hash{flags} = $form_info[5];
 			}

 			# If $form is a pronoun, the person and c parameters are unique to this 
 			# category and need to be defined separately.  
 			if ($form_category eq "prn") {
 			  $form_analysis_hash{person} = $form_info[5];
 			  $form_analysis_hash{c} = $form_info[6];
 			}
	
			# In order to get some information only avaiable in the db_radicals list
			# of the LSPDB module, we need to use the GetRadicalInfoByID method.
 			my %radical_info_hash = $this->GetRadicalInfoByID($form_info[0]);

 			$form_analysis_hash{radical} = $radical_info_hash{radical};
 			
 			# example: subcategory of the adverb form 'abaixo' is 'lugar' 			
 			$form_analysis_hash{subcategory} = $radical_info_hash{subcategory}; 	
 			
 			# example: adverb form 'vagamente' has 'vago' as a radical, which its 
 			# category is a common_noun
 			$form_analysis_hash{radical_category} = $radical_info_hash{category};
 						
 			$form_analysis_hash{radical_subcategory} = $radical_info_hash{subcategory};
 			
 			$form_analysis_hash{prep} = $radical_info_hash{prep};
 			$form_analysis_hash{art} = $radical_info_hash{art};
 			$form_analysis_hash{ppes} = $radical_info_hash{ppes};
 			$form_analysis_hash{adverb} = $radical_info_hash{adverb};
 			
 			# valency information (ex: 'bonito' has valency 1)
 			$form_analysis_hash{valency} = $radical_info_hash{valency};
  		
  		my @semantic_tags = ();
			for (@{$radical_info_hash{semantic_tags_id}}) {
				my $tag_id = $_;
				my %semantic_tag_hash = $this->GetSemanticInfoByTagID($tag_id);
				push (@semantic_tags, \%semantic_tag_hash);
			}
	
			@{$form_analysis_hash{semantic_tags}} = @semantic_tags;

 			push (@analysis_list, \%form_analysis_hash); 			
	  } 
	} else{
		return $this->ProcessSpecialCases($form); 
	}
	return @analysis_list;	
}

##	These special cases includes verb forms like 'torna-se' which were not
##	included in the LSPDB module to avoid an excessive increase of LSPDB size.
sub ProcessSpecialCases() {
	my $this = shift;
	my $word = shift;
	my @analysis_list = "";
	my %analysis_hash = ();
	my @new_analysis_list = ();
	my %new_analysis_hash = ();
	
	if(!defined($word)) {
		return @new_analysis_list;
	}
	
	if($word =~ /(\w+)\-te$/ || $word =~ /(\w+)\-se$/) {
		@analysis_list = $this->GetAnalysis($1);
		for(@analysis_list) {
			my $index_list_ref = $_;
		  my %index_list = %{$index_list_ref};	
		  if ($index_list{category} eq "v") {
 			  $index_list{reflex} = "1";	
 			  push (@new_analysis_list, \%index_list);  	
		  }		
		}
	}
		
	return @new_analysis_list;
}

##  Given a radical_id, this method returns its radical (string) by consulting 
##	the list of radicals @db_radicals
## Some specific parameters as the radical of the form, the subcategory of the 
## form and the radical category and subcategory are not avaiable trough the 
## %index_hash, so we need to get this information from the db_radicals list at 
## the LSPDB module, by using the following method. 
sub GetRadicalInfoByID()  {
	my $this = shift;
	my $radical_id = shift; # input
	my %radical_info_hash = (); # output
	$this->{get_radical_info_by_id_counter}++;
	
	# Let's check if the $radical_id is defined in the db_radicals list in LSPDB 
	# module) 
	if (defined($LSPDB::db_radicals[$radical_id])) {

		my $radical_string = $LSPDB::db_radicals[$radical_id];
		
		# @radical_info_list contains a list of parameters that will be used as 
		# values for the %radical_info_hash hash with its respective keys.
    my @radical_info_list = split('\t', $radical_string);
    @{$radical_info_hash{semantic_tags_id}} = ();
    $radical_info_hash{radical} = $radical_info_list[0]; 
    $radical_info_hash{category} = $radical_info_list[1]; 	
    $radical_info_hash{subcategory} = $radical_info_list[2];
    
    
    if($radical_info_hash{category} eq "nc" or
    		$radical_info_hash{category} eq "a_nc" or
    		$radical_info_hash{category} eq "adj" or
    		$radical_info_hash{category} eq "adv" or
    		$radical_info_hash{category} eq "prn") {
    
    	$radical_info_hash{gender} = $radical_info_list[3]; 			
    	$radical_info_hash{number} = $radical_info_list[4];
    	$radical_info_hash{variant} = $radical_info_list[5];
    	$radical_info_hash{source} = $radical_info_list[6];
    	$radical_info_hash{valency} = $radical_info_list[7];
    	if(defined($radical_info_list[8])) {
    		@{$radical_info_hash{semantic_tags_id}} = split('\*',$radical_info_list[8]);
    	}    				
    }
    
    if($radical_info_hash{category} eq "v") {
    	$radical_info_hash{trans} = $radical_info_list[3];
    	$radical_info_hash{variant} = $radical_info_list[4];
    	$radical_info_hash{source} = $radical_info_list[5];   
    	$radical_info_hash{valency} = $radical_info_list[6];
    	if(defined($radical_info_list[7])) {
    		@{$radical_info_hash{semantic_tags_id}} = split('\*',$radical_info_list[7]);
    	}        	
    }    
    
    if($radical_info_hash{category} eq "prep"
    		or $radical_info_hash{category} eq "con") {
    	$radical_info_hash{variant} = $radical_info_list[3];
    	$radical_info_hash{source} = $radical_info_list[4];
    	if(defined($radical_info_list[5])) {
    		@{$radical_info_hash{semantic_tags_id}} = split('\*',$radical_info_list[5]);	
    	}
    }  
    
    if($radical_info_hash{category} eq "art"
    		or $radical_info_hash{category} eq "card"
    		or $radical_info_hash{category} eq "nord") {
    	$radical_info_hash{gender} = $radical_info_list[3];
    	$radical_info_hash{number} = $radical_info_list[4];
    	$radical_info_hash{variant} = $radical_info_list[5];   
    	$radical_info_hash{source} = $radical_info_list[6];
    	if(defined($radical_info_list[7])) {
    		@{$radical_info_hash{semantic_tags_id}} = split('\*',$radical_info_list[7]);
    	}    	
    } 

    if ($radical_info_hash{category} eq "cp") {
     	$radical_info_hash{gender} = $radical_info_list[3];
    	$radical_info_hash{number} = $radical_info_list[4];   	
      $radical_info_hash{prep} = $radical_info_list[5];
      $radical_info_hash{art} = $radical_info_list[6];
      $radical_info_hash{ppes} = $radical_info_list[7];
      $radical_info_hash{adverb} = $radical_info_list[8];
      $radical_info_hash{variant} = $radical_info_list[9]; 			
    	$radical_info_hash{source} = $radical_info_list[10];
    	if (defined($radical_info_list[11])) {
    		@{$radical_info_hash{semantic_tags_id}} = split('\*',$radical_info_list[11]);
    	} 			
    }       
	} 
  return %radical_info_hash;
}  

sub GetSemanticInfoByTagID() {
	my $this = shift;
	my $tag_id = shift; # input (new tag id)
	my %semantic_tag_info_hash = (); # output
	$this->{get_semantic_info_by_tag_id_counter}++;
	
	if (defined($LSPDB::db_semantic_groups[$tag_id])) {	
		my $semantic_tag_string = $LSPDB::db_semantic_groups[$tag_id];
		
		my @semantic_tag_info_list = split('\t', $semantic_tag_string);
    @{$semantic_tag_info_hash{semantic_tags_id}} = ();
    
    $semantic_tag_info_hash{tag_id} = $semantic_tag_info_list[0];
    $semantic_tag_info_hash{tag_cat} = $semantic_tag_info_list[2];
        
    if($semantic_tag_info_list[3] ne "") {
    	$semantic_tag_info_hash{tag_sub_cat} = $semantic_tag_info_list[3];
    }
    if($semantic_tag_info_list[4] ne "") {
    	$semantic_tag_info_hash{name} = $semantic_tag_info_list[4];
    } 
    if($semantic_tag_info_list[5] ne "") {
    	$semantic_tag_info_hash{description} = $semantic_tag_info_list[5];
    }
		if($semantic_tag_info_list[6] ne "") {
			$semantic_tag_info_hash{source} = $semantic_tag_info_list[6];
		}		
	}	
	return %semantic_tag_info_hash;
}

sub LC() {
	my $this = shift;
	my $in_string = shift;

  ## Lower case with perl's lc + additional utf chars mappings	
	my $string = lc($in_string);	
	$string =~ s/Á/á/g;
	$string =~ s/À/à/g;
	$string =~ s/Â/â/g;
	$string =~ s/É/é/g;
	$string =~ s/È/È/g;
	$string =~ s/Ê/ê/g;
	$string =~ s/Í/í/g;
	$string =~ s/Ì/ì/g;
	$string =~ s/Î/î/g;
	$string =~ s/Ó/ó/g;
	$string =~ s/Ò/ò/g;
	$string =~ s/Ô/ô/g;
	$string =~ s/Ú/ú/g;
	$string =~ s/Ù/ù/g;
	$string =~ s/Û/û/g;
	$string =~ s/Ç/ç/g;
	return $string;
 
}

sub IsCategory() {
	my $this = shift;
	my $word = shift;	
	my $input_category = shift;
	
	my @analysis_list = $this->GetAnalysis($word);	
	for(@analysis_list) {
  	my %index_list = %{$_};
		if($input_category eq $index_list{category}) {
			return 1;
		}
		next; 
	}
	return 0;	
}

sub IsSemanticCategory() {
	my $this = shift;
	my $word = shift;
	my $input_sem_category = shift;
	my $input_sem_sub_category = shift || "";
	
	my @analysis_list = $this->GetAnalysis($word);
	for(@analysis_list) {
  	my %analysis = %{$_};	
		for(@{$analysis{semantic_tags}}) {
	  	my %semantic_analysis = %{$_};	
			if(defined($semantic_analysis{tag_cat}) && $semantic_analysis{tag_cat} eq $input_sem_category && $input_sem_sub_category eq "") {
				return 1;
			}
			elsif(defined($semantic_analysis{tag_cat}) && $semantic_analysis{tag_cat} eq $input_sem_category && $input_sem_sub_category eq $semantic_analysis{tag_sub_cat}) {
				return 1;
			} 
		}
	}
	return 0;
}
 
sub IsErgo() {
	my $this = shift;
	my $word = shift;
	
	my @analysis_list = $this->GetAnalysis($word);
	for(@analysis_list) {
  	my %analysis = %{$_};	
		for(@{$analysis{semantic_tags}}) {
	  	my %semantic_analysis = %{$_};	
			if(defined($semantic_analysis{tag_cat}) && defined($semantic_analysis{tag_sub_cat})) {
				if($semantic_analysis{tag_cat} eq "HMN" && ($semantic_analysis{tag_sub_cat} eq "ERGO" || $semantic_analysis{tag_sub_cat} eq "CARGO")) {
					return 1;
				}
			}
		}
	}
	return 0;
}

 sub ContainsErgo() {
	my $this = shift;
	my $string = shift;
	
	warn("DEPERCATED - see IsErgoPhrase() in LSP::Utils");
	exit;
}

sub ContainsNE() {
	my $this = shift;
	my $string = shift;
	my @list_words = split(/ /,$string);
	my $ne_value = 0;
	
	for(@list_words) {
		my $word = $_;	
		
		# ex: 'Algarve,Açores e Madeira'
		if($word =~ /(\,)/) {
			#warn("Case 1: [$word] -> , .");
			return 0;
		}
		
		# ex: 'Prémio Nobel da Literatura em 1997'
		elsif($word =~ /(^em$|^com$|^no$|^na$|^nos$|^nas$|^por$|^para$|^os$)/i) {
			#warn("Case 2: [$word] -> em com no na nos nas por para ");
			return 0;
		}
		
		# ex: 'Viseu e Guarda continuam com vias intransitáveis'
		elsif($this->IsCategory($word,"v") eq 1 && $word !~ /[A-Z]/) {
			#warn("Case 3: [$word] -> is a verb");
			return 0;
		}
		
		# ex: 'EDP'
		elsif($word =~ /^[A-Z]{1,n}$/) {
			warn("Case 4: [$word] -> is a symbol");
			return 0;
		}		
		
		elsif($word =~ /^[A-Z]/ && $word !~ /\d{1,n}/) {
			$ne_value = 1;
		}
	}
	if($ne_value eq 1) {
		return 1;
	}
	return 0;
}

 sub IsNationality() {
	my $this = shift;
	my $word = shift;
	
	my @analysis_list = $this->GetAnalysis($word);
	for(@analysis_list) {
  	my %analysis = %{$_};	
		for(@{$analysis{semantic_tags}}) {
	  	my %semantic_analysis = %{$_};	
			if(defined($semantic_analysis{tag_cat}) && defined($semantic_analysis{tag_sub_cat})) {
				if($semantic_analysis{tag_cat} eq "HMN" && $semantic_analysis{tag_sub_cat} eq "NAC") {
					return 1;
				}
			}
		}
	}
	return 0;
}
 
sub IsRadicalInList() {
  my $this = shift;
	my $word = shift;
	my $valid_radicals_list_ref = shift;

	## De-ref
	my @valid_radicals_list = @{$valid_radicals_list_ref};

	my @analysis_list = $this->GetAnalysis($word);
	for(@analysis_list) {
  	my %analysis = %{$_};
		for(@valid_radicals_list) {
      if($_ eq $analysis{radical}) {
				return 1;
      }
  	}
	}
	return 0;
} 

sub IsCategoryInList() {
	my $this = shift;
	my $word = shift;
	my $valid_categories_list_ref = shift;

	## De-ref
	my @valid_categories_list = @{$valid_categories_list_ref};
	  		
	my @analysis_list = $this->GetAnalysis($word);
	
	for(@analysis_list) {
  	my %analysis = %{$_};
		for(@valid_categories_list) {
			if($_ eq $analysis{category}) {
				return 1;
			}
 		}
	}
	return 0;
} 


sub IsTenseInList() {
	my $this = shift;
	my $verb = shift;
	my $valid_tense_list_ref = shift;

	## De-ref
	my @valid_tense_list = @{$valid_tense_list_ref};
	  		
	my @analysis_list = $this->GetAnalysis($verb);
	
	for(@analysis_list) {
  	my %analysis = %{$_};
  	if ($analysis{category} ne "v") {
  	  next;
  	}
		for(@valid_tense_list) {
			if($_ eq $analysis{tense}) {
				return 1;
			}
 		}
	}
	return 0;
} 


sub IsSingular() {
	my $this = shift;
	my $word = shift;
	  		
	my @analysis_list = $this->GetAnalysis($word);	
	for(@analysis_list) {
  	my %analysis = %{$_};
  	if (defined($analysis{number}) && $analysis{number} eq "s") {
  	  return 1;
  	}
	}
	return 0;
} 
 
sub GetAnalysisCounter () {
	my $this = shift;
	return $this->{get_analysis_counter};
}

sub GetRadicalInfoByTagIDCounter () {
	my $this = shift;
	return $this->{get_radical_info_by_id_counter};
}

sub GetSemInfoByTagIDCounter () {
	my $this = shift;
	return $this->{get_semantic_info_by_tag_id_counter};
}

sub Warn() {
  my $this = shift;
  my $message = shift;
  my $min_verbose = shift || 1;

  if ($this->{verbose} < $min_verbose) {
    return;
  }
  ## Caller Info
  my ($package, $filename, $line, $subroutine, 
      $hasargs, $wantarray, $evaltext, $is_require) = caller(1);
  
  ## Time Info
  my ($sec, $min, $hour, $mday, $mon, 
      $year, $wday, $yday, $isdst) = localtime(time());
  if ($sec < 10) {
    $sec = "0" . $sec;
  }
  if ($min < 10) {
    $min = "0" . $min;
  }
  
  warn($hour . ":" . $min . ":" . $sec . " $subroutine($line) - $message\n");
}

1;

__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

	LSP - "Lexico Semantico Portugues" is a module for retireval of portuguese 
	morphological and semantic information of words.

=head1 SYNOPSIS

	use LSP;

=head1 DESCRIPTION

	This module is directly connected to the LSPDB module, as it uses the 
	information avaiable at the LSPDB to retrieve a complete morphological and
	semantic analysis.

=head1 METHODS

=head2 new()

	This is a initialization method, with no input parameters.

=head2 SetVerbose ()

	Method used to define the level of warnings.
	
=head2 IsKnownForm()

	This method verifies if the given word is present in the LSPDB database.	
	e.g: IsKnwonForm(andar) ("andar" means "to walk")
	     Returns '1' (true)

=head2 GetAnalysis ()

	This method has one input provided by the user, which is the form/word that
	the user wants to analyse.
	The output of this method depends on the category and avaiable morphological
	information for the specific word queried.
	Considering the case of a form with complete morphological information, and
	deppending on the category, the output will be similar to:
	
	-> Generic case (avaiable to all categories except verbs):
		* form: the word queried for analysis
		* radical_id: the identification number of the radical of the word queried
		* category
		* radical_category: the category of the radical of the word queried
		* gender
		* number
		* radical: the radical word
		* subcategory
		* radical category
		* radical sub category
		
	-> Adjective
		* degree
		
	-> Verbe
		* tense
		* person
		
	-> Adverb
		* flags
		
	-> Pronoun
		* person
		* c
		
	e.g: GetAnalysis(andar)	("andar" means "to walk")
	     Returns a lists of objects (hashs), one for each analysis.
		 
=head2 ProcessSpecialCases()

	These special cases includes verb forms like 'torna-se' which were not
	included in the LSPDB module to avoid an excessive increase of LSPDB size.		 
		 
=head2 GetRadicalInfoByID ()

	This method is not called directly by the user since it is used by the 
	GetAnalysis () previously described.
	Some specific parameters as the radical of the form, the subcategory of the 
	form and the radical category and subcategory are not avaiable directly trough
	the GetAnalysis () (because they are located in a different part of the LSPDB
	module, the db_radicals list), so we need to get this information from the 
	correct location, and send it to the GetAnalysis (). So this process is 
	complety transparent for the user.
	e.g: GetRadicalInfoById(1234) (where 1234 is the radical of the radical)
	     Returns an hash with all the radical parameters available.

=head2 GetSemanticInfoByTagID ()

	This method returns the avaiable information in the LSPDB module for a given
	ID of a semantic tag.
	e.g: GetSemanticInfoByTagID(12) (where 12 is the id of the semantic tag)
	     Returns an hash with the semantic tag information.
			
=head2 LC()

	This method receives a word and returns the word in lowe-case. Is usefull due
	to some errors concerning the codification.
	e.g: LC(CASA)
	     Returns 'casa' for this example

=head2 IsCategory()

	This method tests the input word based on the LSPDB information and return 
	true(1) if its morphological category is equal to the category given by the 
	user or false(0) if its not.
	e.g: IsCategory("andar","v")
	     Returns true for this example;

=head2 IsSemanticCategory()

	Like the previous method, this tests the input word using the LSPDB 
	information and returns true(1) is the semantic information retrieved by the
	LSPDB is equal to the  one given by the user, or false(0) if not.
	e.g: IsSemanticCategory("engenheiro","HMN","ERGO") 
	     Returns true for this example;	
	
=head2 IsRadicalInList()

	This method tests the word given by the user and compare its radical (use the
	LSPDB information to get the radical) with the list of radicals given by the
	user. If at least one matches, it returns true (1), otherwise returns false 
	(0).
	e.g: IsRadicalInList("estive",\@radicals_list) 
	      where @radicals_list = "estar","andar","ser"
	     Returns true for this example;

=head2 IsCategoryInList()

	This method tests the category of the words given by the user and compare them
	with the category specified by the user.
	If at least one of the words' category matches the defined category, it 
	returns true (1), otherwise returns false (0).
	e.g: IsRadicalInList("v",\@radicals_list) 
	      where @radicals_list = "estar","andar","ser"
	     Returns true for this example;
	
=head2 Warn ()

	This method is used to release warning during the program execution accordingly
	to the verbose level previously defined.

=head1 SEE ALSO

	LSPDB.pm -> the LSP database module, which contain all the avaiable forms with
	its analysis and its radicals.

=head1 AUTHOR

Jorge Teixeira, E<lt>jft@fe.up.ptE<gt>
Luis Sarmento, E<lt>las@fe.up.ptE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 by  Jorge Teixeira and Luis Sarmento

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.6 or,
at your option, any later version of Perl 5 you may have available.


=cut
