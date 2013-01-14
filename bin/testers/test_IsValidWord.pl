#!/usr/bin/perl
use strict;
use warnings;
use LSP::Utils;

my $lsp_utils = new LSP::Utils ();
$lsp_utils->SetVerbose(2);

my $word = shift || "unico";

my $result = $lsp_utils->IsValidWord($word);

warn("RESULT: $result");
