package LSP::Utils;

use strict;
use warnings;
use utf8;
use LSP::LSP;

our %ne_connectors = (
			        'de' => '1',
			        'da' => '1',
			        'das' => '1',
			        'do' => '1',
			        'dos' => '1',
			        'e' => '1'
			        );

our %black_list = (
			        'Ministério' => '1',
			        'Público' => '1',
			        'Air' => '1',
			        'France' => '1',
			        'Albufeira' => '1',
			        'Alfa' => '1',
			        'Pendular' => '1',
			        'Amnistia' => '1',
			        'Internacional' => '1',			 
			        'Assembleia' => '1',
			        'Municipal' => '1',
			        'Associação' => '1',
			        'Bombardier' => '1',
			        'Aerospace' => '1',
			        'Chefe' => '1',
			        'Estado' => '1',
			        'Maior' => '1',
			        'Comissão' => '1',
			        'Europeia' => '1',
			        'Dados' => '1',
			        'Direcção' => '1',
			        'Geral' => '1',
			        'Saúde' => '1',
			        'Director' => '1',
			        'Desportivo' => '1',
			        'Em' => '1',
			        'Entidade' => '1',
			        'Reguladora' => '1',
			        'Fonta' => '1',
			        'Transportadora' => '1',
			        'Aérea' => '1',
			        'Vila' => '1',
			        'Junta' => '1',
			        'Freguesia' => '1',
			        'Câmara' => '1',
			        'Municipal' => '1',
			        'Ministério' => '1',
			        'Os' => '1',
			        'Verdes' => '1',
			        'Pioneer' => '1',
			        'Technology' => '1',
			        'Prémio' => '1',
			        'Nóbel' => '1',
			        'Procurador' => '1',
			        'Geral' => '1',
			        'República' => '1',
			        'Red' => '1',
			        'Bull' => '1',
			        'Supremo' => '1',
			        'Tribunal' => '1',
			        'Constitucional' => '1',
			        'Comité' => '1',
			        'Viana' => '1',
			        'Guimarães' => '1',
			        'Setúbal' => '1',
			        'União' => '1',
			        'Universidade' => '1',
			        'Hospital' => '1',
			        'Santo' => '1',
			        'Santa' => '1',
			        'África' => '1',
			        'Técnica' => '1',
			        'Transportes' => '1',
			        'Trabalho' => '1',
			        'Turismo' => '1',
			        'Tratado' => '1',
			        'Tecnologia' => '1',
			        'Teatro' => '1',
			        'Museu' => '1',
			        'Taça' => '1',
			        'Sul' => '1',
			        'Sociedade' => '1',
			        'Sindicato' => '1',
			        'Serviço' => '1',
			        'Segurança' => '1',
			        'Provedor' => '1',
			        'Partido' => '1',
			        'Parlamento' => '1',
			        'Organização' => '1',
			        'Lusa' => '1',
			        'Liga' => '1',
			        'Agência' => '1',
			        'Instituto' => '1',
			        'Governo' => '1',
			        'Regional' => '1',
			        'Fundação' => '1',
			        'Forças' => '1',
			        'Armadas' => '1',
			        'Federação' => '1',
			        'Executivo' => '1',
			        'Cooperação' => '1',
			        'Conselho' => '1',
			        'Confederação' => '1',
			       	'Congresso' => '1',
			       	'Centro' => '1',
			       	'Bloco' => '1',
			       	'Partido' => '1',
			       	'Banco' => '1',
			       	'Autoridade' => '1',
			       	'Páginas' => '1',
			       	'Amarelas' => '1',
			       	'Já' => '1',
			       	'Previsão' => '1',
			       	'Eurosondagem' => '1',
			       	'Por' => '1',
			       	'Redacção' => '1',
			       	'Também' => '1',
			       	'Sporting' => '1',
			       	'Benfica' => '1',
			       	'Porto' => '1',
			       	'Prémio' => '1',
			       	'Nobel' => '1',
			       	'Por' => '1',
			       	'Na' => '1',
			       	'Última' => '1',
			       	'Arguido' => '1',
			       	'Frente' => '1',
			       	'Comum' => '1',
			       	'Dia' => '1',
			       	'Mundial' => '1',
			       	'Sida' => '1',
			       	'Portal' => '1',
			       	'Têxtil' => '1',
			       	'Vestuário' => '1',
			       	'Casa' => '1',
			       	'Pia' => '1',
			       	'Estados' => '1',
			       	'Unidos' => '1',
			       	'Sindicato' => '1',
			       	'Pescas' => '1',
			       	'Jogadores' => '1',
			       	'Feira' => '1',
			       	'Manchester' => '1',
			       	'United' => '1',
			       	'New' => '1',
			       	'York' => '1',
			       	'Times' => '1',
			       	'Confederações' => '1',
			       	'China' => '1',
			       	'Japão' => '1',
			       	'Protecção' => '1',
			       	'Civil' => '1',
			       	'Tribunal' => '1',
			       	'Relação' => '1',
			       	'Cruz' => '1',
			       	'Vermelha' => '1',
			       	'Grupo' => '1',
			       	'Moradores' => '1',
			       	'Colégio' => '1',
			       	'Imprensa' => '1',
			       	'Fundadores' => '1',
			       	'Reino' => '1',
			       	'Legislativas' => '1',
			       	'Candidatura' => '1',
			       	'Justiça' => '1',
			       	'Eurodeputada' => '1',
			       	'Brasil' => '1',
			       	'Portugal' => '1',
			       	'Munícipes' => '1',
			       	'Wall' => '1',
			       	'Street' => '1',
			       	'Futebol' => '1',
			       	'Boavista' => '1',
			       	'Fundador' => '1',
			       	'Bayer' => '1',
			       	'Festival' => '1',
			       	'Central' => '1',
			       	'Jornal' => '1',
			       	'Angola' => '1',
			       	'Mercado' => '1',
			       	'Partidos' => '1',
			       	'Heróis' => '1',
			       	'País' => '1',
			       	'Packard' => '1',
			       	'Editorial' => '1',
			       	'Media' => '1',
			       	'Clube' => '1',
			       	'Galp' => '1',
			       	'Independente' => '1',
			       	'Sindicatos' => '1',
			       	'Março' => '1',
			       	
			       	
							## Áreas / Domínios	
							'Educação' => '1',
							'Ambiente' => '1',
							'Medicina' => '1',					
							'Finanças' => '1',		
							'Economia' => '1',
							
							## Preposições
							'Enquanto' => '1',
							'Entre' => '1',
							'No' => '1',
							'Para' => '1',
							'Quando' => '1',
							'Quanto' => '1',
							'Segundo' => '1',
							
							## 
							'Circo' => '1',
							'Concelho' => '1',
							'Concorrente' => '1',
							'Concurso' => '1',
							'Conferência' => '1',
							'Consórcio' => '1',
							'Contabilista' => '1',
							'Coordenação' => '1',
							'Credores' => '1',
							'Credor' => '1',
							'Empresa' => '1',
							'Empresas' => '1',
							'Plano' => '1',
							'Leitura' => '1',
							'Sem-abrigo' => '1',
							'Emancipação' => '1',
							
							## Cargos
							'Guarda-redes' => '1',
							'Jogador' => '1',
							'Seleccionador' => '1',
							'Perfeito' => '1',
							'Patrão' => '1',
							'Ditador' => '1',
							
							
							## 
							'Capital' => '1',
							'Distrital' => '1',
							'Comando' => '1',
							
							## Empresas
							'Airways' => '1',
							'Locomotive' => '1',
							'Nokia' => '1',
							'Siemens' => '1',
							'American' => '1',
							'Airlines' => '1',
							'Reuters' => '1',
							
							## Locais
							'Iorque' => '1',
							
							## Misc
							'Blog' => '1',		      
							'Oposição' => '1',
							'Cidadãos' => '1',
							'Auto-mobilizados' => '1',
							'Falando' => '1',
							'Oculta' => '1',
							'Twitter' => '1',
							'Fã' => '1',
							'Multicultural' => '1',
							'Energia' => '1',
							'Fedorento' => '1',
							'Selecção' => '1',
							'Nacional' => '1',
							'Média' => '1',
							'Media' => '1',
							'Nações' => '1',
							'Unidas' => '1',
							'Zelândia' => '1',
							'Reunião' => '1',
							'Resultados' => '1',
							'Rival' => '1',
							'Sector' => '1',
							'Loto' => '1',
							'Sport' => '1',
							'TV' => '1',
							'Subida' => '1',
							'Street' => '1',
							'Buenos' => '1',
							'Continental' => '1',
							'Fábrica' => '1',
							'Pneus' => '1',
							'Solar' => '1',
							'Hello' => '1',
							'Inquérito' => '1',
							'Inspecção-Geral' => '1',
							'Human' => '1',
							'Rights' => '1',
							'Watch' => '1',
							'Pensões' => '1',
							'Património' => '1',
							'Siderúrgica' => '1',
							'Janeira' => '1',
							'Social' => '1',
							'Último' => '1',
							'Promoção' => '1',
							'Inter' => '1',
							'Fórmula' => '1',
							'Fundo' => '1',
							'Film' => '1',
							'Estoril' => '1',
							'Escola' => '1',
							'Secundária' => '1',
							'Deutsche' => '1',
							'Bank' => '1',
							'Corrida' => '1',
							'Comunidades' => '1',
							'Comunidade' => '1',
							'Colégio' => '1',
							'Colégios' => '1',
							'Cidade' => '1',
							'Causa' => '1',
							'Canonização' => '1',
							'Cavalo' => '1',
							'Financial' => '1',
							'à' => '1',
							'World' => '1',
							'Auto-Estrada' => '1',
							'é' => '1',
							'Mas' => '1',
							'Se' => '1',
							'Também' => '1',
							'Depois' => '1',
							
							
							## Marcas
							'Sony' => '1',
							'Western' => '1',
							'Union' => '1',
							
							## Nacionalidades
							'Croata' => '1',
							'Inglaterra' => '1',
							'Purtuguês' => '1',
							'Milão' => '1',
							'Hungría' => '1',
							
							
							## Obras
							'Fotobiografia' => '1',
							
							## Ergo
							'Penalista' => '1',
							'Seleccionardor' => '1',
							
							## Desporto
							'Futsal' => '1', 
							 	
							## Relações familiares
							'Irmão' => '1',
							'Filho' => '1',
							'Filha' => '1',							
							'Irmã' => '1',
							'Pai' => '1' 	
							 	
			        );

sub new {
	shift;
  my $this = {};
  
	$this->{lsp} = new LSP::LSP();
	$this->{lsp}->SetVerbose(2);  
	    
  bless $this;
  return $this;
}

sub SetVerbose() {
	my $this = shift;
  $this->{verbose} = shift || 0;
}


sub IsValidWord() {
	my $this = shift;
	my $word = shift || "";
	
	if($word eq "") {
		return 0;
	}
	
	# Avoid words that are ergos
	if($this->{lsp}->IsErgo($word) eq 1) {
		return 0;
	}
	
	# Avoid words with non-characters and symbols (EDP);
	if($word =~ /\W{1,n}/ || $word =~ /(\<|\>|\(|\)|\;|:|,|\/|\\|\")/ || 
		 $word =~ /^[A-Z]([A-Z]+)/ || 
		 $word =~ /^ex\-/i ) {
		$this->Warn("$word is not ok (I)",2);
		return 0;
	}
	
	if($word =~ /\(|\)/ ) {
		$this->Warn("$word is not ok (III) - parêntesis",2);
		return 0;
	}
	
	# Valid if is capitalized and is not in the black list
	elsif($word =~ /^[A-ZÃÁÉÍÓÚ]([a-zãéíóúà]+)/ && !defined($black_list{$word})) {
		#$this->Warn("$word is ok",2);
		return 1;
	}

	# Avoid words like 'E' or 'S' or 'D'
	elsif($word =~ /^[A-ZÃÁÉÍÓÚ]$/) {
		$this->Warn("$word is not ok (I)",2);
		return 0;
	}
	
	# Valid if is a connector
	elsif(defined($ne_connectors{$word})) {
		#$this->Warn("$word is ok (connector)",2);
		return 1;
	}	 
	
	else {
		$this->Warn("$word is not ok (II)",2);
		return 0;
	}
}


## DEPERCATED. User NER::BasicNER instead
sub REMP() {
	my $this = shift;
	my $input_string = shift;
	my @list_ne = ();
		
	# add an extra word to the string... this avoid problems in while() 	
	$input_string .= " palavra";	
	
	my @list_words = split(/\s|,|\./,$input_string);
	my $number_words = scalar(@list_words);
	if($number_words eq 0) {
		$this->Warn("EXCLUDED: empty input...",2);
		return 0;
	}

	# Case 1) José Sócrates	
	# Case 2) Manuela Ferreira Leita
	# Case 3) Manuela Ferreira Leita Xxxx

	# Case 4) Pinto da Costa
		
	# Case 5) Ricardo Viegas de Abreu
	# Case 6) Maria de Lurdes Rodrigues
	
	# Case 7) Luiz xx Inácio Lula Silva
	# Case 8) Luiz Inácio xx Lula Silva	
	# Case 9) Luiz Inácio Lula xx Silva	
	
	my $ne_candidate = "NE_";
	while(defined($list_words[0])) {
		my $word = $list_words[0];
		
		# The last element cannot be a connector
		# E.g: "José Sócrates e então ..."
		if($this->IsValidWord($word) eq 1 && defined($ne_connectors{$word}) && $this->IsValidWord($list_words[1]) eq 0) {
			#
			$this->Warn("'$word' is OK but is not valid -> the last word cannot be a connector",2);
		}			
		
		# If its not the first element of the NE string			
		elsif($this->IsValidWord($word) eq 1 && $ne_candidate ne "NE_") {
			$ne_candidate .= $word . "_";
			$this->Warn("'$word' is OK",2);
		}				
		
		# Avoid validating the connector if is the first element of the NE
		# E.g: "e José Sócrates ..."		
		elsif($this->IsValidWord($word) eq 1 && $ne_candidate eq "NE_" && defined($ne_connectors{$word})) {
			$ne_candidate = "NE_";
			$this->Warn("'$word' non valid for the first element",2);
		}
		
		# If its the first element and is a regular NE element
		elsif($this->IsValidWord($word) eq 1 && $ne_candidate eq "NE_" && !defined($ne_connectors{$word})) {
			$ne_candidate .= $word . "_";
			$this->Warn("'$word' is OK",2);
		}

							
		else {
			
			# The candidate string must have at least 2 names
			# Avoid cases like "José disse ..."
			if($ne_candidate =~ /NE\_(.+?)\_(.+?)/) {				 				
				$ne_candidate =~ s/\_$//;	
				
				# casos estranhos de encoding em que o NE termina com uma destas palavras
				$ne_candidate =~ s/ (e|é|á|ás|à|às)$//;
				
				# casos estranhos de encoding em que o NE começa com uma destas palavras
				if($ne_candidate =~ /^(e|é|á|ás|à|às) /) {
					next;
				}
				
				
				push(@list_ne,$ne_candidate);
				$ne_candidate = "NE_";
			}
			
			else {
				$ne_candidate = "NE_";
			}
		}
		
		
		shift(@list_words);
	}
	
	return @list_ne;		
}



sub SplitSentences() {
	my $this = shift;
	my $paragraph = shift || "";
	my %splited_sentences = ();

	$paragraph =~ s/  / /g;
	$paragraph =~ s/\s{2,}/ /gs;
	$paragraph =~ s/\t{1,}/ /gs;
	$paragraph =~ s/<br>/ /gs;
	
	my %siglas = ("dr" => 1, "dra" => 1, "d" => 1, "s" => 1, "prof" => 1, "sp" => 1);
	## Vamos corrigir alguns erros dos próprios autores
	for (keys %siglas) {
		$paragraph =~ s/\s($_) \./$1\./ig;
	}
	
	
	## E.g. '...melhor treinador do mundo. Durante o dia de ontem...'
	my $flag_1 = 0;
	while ($paragraph =~ /\s(\w+)(\s{0,1})(\.|\.\.\.|\!|\?)(\s{0,1}[A-ZÁÉÍÓÚÃĨÕŨÂÊÎÔÛÇ])/ && $flag_1 eq 0) {
		my $p = $1;
		if(defined($p) && !defined($siglas{lc($p)}) && length($p) > 1) {		
			$paragraph =~ s/\s(\w+)(\s{0,1})(\.|\.\.\.|\!|\?)(\s{0,1}[A-ZÁÉÍÓÚÃĨÕŨÂÊÎÔÛÇ])/ $1$2$3\n$4/;
		} else {
			$flag_1 = 1;
		}
	}	
	

	## E.g. '...melhor treinador do Mundo ” . “ Sou o fã número um de Mourinho...'
	my $flag_2 = 0;
	while ($paragraph =~ /\s(\w+)(\s{0,1})(”|»|")(\s{0,1}\.)(\s{0,1})(“|«|")(\s{0,1}[A-ZÁÉÍÓÚÃĨÕŨÂÊÎÔÛÇ])/ && $flag_2 eq 0) {
		my $p = $1;
		if(defined($p) && !defined($siglas{lc($p)}) && length($p) > 1) {		
			$paragraph =~ s/\s(\w+)(\s{0,1})(”|»|")(\s{0,1}\.)(\s{0,1})(“|«|")(\s{0,1}[A-ZÁÉÍÓÚÃĨÕŨÂÊÎÔÛÇ])/ $1$2$3$4\n$5$6$7/;
		} else {
			$flag_2 = 1;
		}
	}			

	## E.g. '...a mesma candidatura. “ Sou candidato por vontade própria...'
	my $flag_3 = 0;
	while ($paragraph =~ / (.+?)( {0,1}\.)( {0,1})(“|«|")( {0,1}[A-ZÁÉÍÓÚÃĨÕŨÂÊÎÔÛÇ])/ && $flag_3 eq 0) {
		my $p = $1;
		if(defined($p) && !defined($siglas{lc($p)}) && length($p) > 1) {		
			$paragraph =~ s/ (.+?)( {0,1}\.)( {0,1})(“|«|")( {0,1}[A-ZÁÉÍÓÚÃĨÕŨÂÊÎÔÛÇ])/ $1$2\n$3$4$5/;
		} else {
			$flag_3 = 1;
		}
	}			
	
	## E.g. '...dignidade das pessoas ” . Para...'
	while ($paragraph =~ s/( {0,1})(”|»|")( {0,1}\.)( {0,1}[A-ZÁÉÍÓÚÃĨÕŨÂÊÎÔÛÇ])/$1$2$3\n$4/) {;}	
	
	
	## E.g. 'Moutinho é melhor jogador do que ele próprio foi. - Negociações por Coentrão aceleram'
	while ($paragraph =~ s/ (.+?)( {0,1}\.)( {0,1}\-\s{0,1}[A-ZÁÉÍÓÚÃĨÕŨÂÊÎÔÛÇ])/$1$2\n$3/) {;}	
	
		
	## mais algumas limpezas
	$paragraph =~ s/  / /g;
	
	my @sentences = split('\n', $paragraph);	
	
	return @sentences;
}


sub TokenizeString() {
	my $this = shift;
	my $string = shift;
	@{$this->{instantiation_list}} = ();
	
	# substitues '(' or '\' or ... by ' ( ' or ' \ ' or ..
	if ($string =~ s/(\,|\)|\;|\:)\s/ $1 /g) {
		push(@{$this->{instantiation_list}}, 1);
	}
	
	# If the '.' is preceeded at least by 2 characters, than '.' can be separated;
	# example: "...e assim ficou." -> Can be separeted
	# "... o João A. Santos ..." -> Cannot be separated
	if ($string =~ s/([a-zA-Z]{2,})\.\s/$1 \. /g) {
		push(@{$this->{instantiation_list}}, 2);
	}
	
	# If after thw '.' is a space followed by capital letter, than is a new
	# sentence and can be splitted.
	#if ($string =~ s/\. ([A-Z])+/ \. $1/g) {
	#	push(@{$this->{instantiation_list}}, 3);
	#}
	
	# If there is '(' or '[' together with a word, it can be splited.
	if ($string =~ s/(\(|\)|\[|\])/ $1 /g) {
		push(@{$this->{instantiation_list}}, 4);
	}
	
	# This is used at the end of sentences when there is a '.' '?' '!' ';' or ':' 
	# followed by a number of spaces or '\n' (can be zero). 
	if ($string =~ s/(\.|\?|\!|\;|\:)\s*($|\n)/ $1$2/g) {
		push(@{$this->{instantiation_list}}, 5);
	}
	
	# characters like ' " ? or ! can be separated and considerer single tokens
	if ($string =~ s/(\"|\'\'|\?|\!|\”)/ $1 /g) {
		push(@{$this->{instantiation_list}}, 6);
	}
	
	# If there are double spaces, the extra one is removed
	if ($string =~ s/  / /g) {
		push(@{$this->{instantiation_list}}, 7);
	}	

	# example: 'test' -> ' test '
	if ($string =~ s/(^| )('|")(\w+)('|")( |$)/ $1$2 $3 $4$5 /g) {
		push(@{$this->{instantiation_list}}, 8);	
	}

	# example: ``test -> ` ` test
	if ($string =~ s/(`|-)(`|-)(\w+)/$1 $2 $3/g) {
		push(@{$this->{instantiation_list}}, 9);	
	}

	# example: `test -> ` test
	if ($string =~ s/(^`)(\w+)/ $1 $2 /g) {
		push(@{$this->{instantiation_list}}, 11);	
	}

	# example: test`test -> test ` test
	if ($string =~ s/(\w+)(`)(\w+)/ $1 $2 $3 /g) {
		push(@{$this->{instantiation_list}}, 10);	
	}

	# example: _test -> _ test
	if ($string =~ s/(^_|^\[|^\\\|^\/|^\/\/)(\w+)/ $1 $2 /g) {
		push(@{$this->{instantiation_list}}, 12);	
	}

	# example: test_ -> test _
	if ($string =~ s/(\w+)(_$|\\\$|\/$|\/\/$|\]$)/ $1 $2 /g) {
		push(@{$this->{instantiation_list}}, 13);	
	}

	# example: '"Quarenta....' “
	if ($string =~ s/(\`\`|\“|")(.+?)(\'\'|\“|")/$1 $2 $3/g) {
		push(@{$this->{instantiation_list}}, 14);
	}
	
	# example: '<<disponível>>'
	if ($string =~ s/(\<\<|\«)(.+?)(\<\<|»)/$1 $2 $3/g) {
		push(@{$this->{instantiation_list}}, 15);
	}
	
	# dr. sr. sra. ...
	if ($string =~ s/(\s|.|,|:)(dr|sr|sra|dra|prof|exmo|exma)\s{0,}\.(.+?)/$1 $2\. $3/gi) {
		push(@{$this->{instantiation_list}}, 16);
	}	
		
	$string =~ s/ {2,}/ /gs;	
		
	return $string;
}


sub GetInstantiationList() {
	my $this = shift;
	return @{$this->{instantiation_list}};
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

	Utils do Léxico Semântico do Português

=head1 SYNOPSIS

	use LSP::Utils;

=head1 DESCRIPTION


=head1 GLOBAL VARIABLES

=head2 ne_connectors

	This hash contains the valid connector for Named Entities of People for the
	Portuguese common names.
	E.g.: "José da Silva"
	
=head2 black_list

	This hash contains the words that are not considered as part of the Named 
	Entities of people names, avoinding wrong NE as "Ministério da Educação"	

=head1 METHODS

=head2 new()

	This is a initialization method, with no input parameters.

=head2 SetVerbose ()

	Method used to define the level of warnings.
	
=head2 IsValidWord ()

	This method analysis the validity of a given word. This word is part of a 
	Named Entitie (for people) cancidate, so that the method has some restrictions
	as capitalized words and connectors order. 
	This method returns 1 if the word is valid, and 0 if it's not.
	
=head2 REMP ()

	REMP (Reconhecinhecimento de Entidades Mencionadas para Pessoas) is a Named
	Entities method specificly design for people names.
	Its input is a string and the output is a list of NE strings, identified as 
	follows:
	e.g.: "NE_José_Sócrates"
	
=head2 REMP2()

	This method is not implemented yet...
	Is a second version of REMP() method in the sense that it uses additional
	knowledge of the propor nouns to build the NE for people.	
		
	
=head2 SplitSentences ()

	Based on and input string, this method returns a list with all the sentences
	splited from the input string.
	It uses a list of rules for this procedure.

=head2 TokenizeString ()

	Given a input string, this method tokenize this string based on a set of rules 
	and considering the ponctuationg.
	The output is a string with all the tokens separeted by the space character.

=head2 GetInstantiationList()	
	
	blabla
	
=head2 Warn ()

	This method is used to release warning during the program execution accordingly
	to the verbose level previously defined.

=head1 SEE ALSO

	LSP::LSP - Léxico Semântico do Português

=head1 AUTHOR

Jorge Teixeira, E<lt>jft@fe.up.ptE<gt>
Luis Sarmento, E<lt>las@fe.up.ptE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 by  Jorge Teixeira and Luis Sarmento

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.6 or,
at your option, any later version of Perl 5 you may have available.


=cut
