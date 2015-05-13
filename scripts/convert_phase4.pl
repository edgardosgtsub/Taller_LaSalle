#!/usr/bin/perl

use Getopt::Long;
use File::Basename;
use warnings;
use strict;
use Term::ANSIColor qw(:constants);


#################################################################
###########Global Variables#############
my @languages_list;

####### Read input arguments   #####
my $opt_help = undef;
my $input_dir = undef;
my $languages = undef;
my $opt_useall = undef;
my $ocrs = undef;
my $output_dir = undef;
my $formats = undef;
my $merge = undef;
my $opt_compare = undef;
my @args = @ARGV;
GetOptions('help'=> \$opt_help,
            'input_dir=s'=> \$input_dir,
            'l=s'=> \$languages,
            'useall'=>\$opt_useall,
            'ocrs=s'=>\$ocrs,
            'output_dir=s'=>\$output_dir,
            'formats=s' => \$format,
            'merge' => \$opt_merge,
            'compare' => \$opt_compare,
            'debug' => \$opt_debug,
        );
#################################################################

sub process_args(){
#Ayuda
	&get_help() if (defined $opt_help);
#Si no hay carpeta qué procesar, salir con error.
  die("Se necesita una carpeta con imágenes para usar el programa") if(!defined $input_dir);
#Asignar lenguajes
	@languages_list = split(/\,/,$languages) if (defined languages);
  
#Asignar la carpeta de salida en base a la de entrada si no se define
  ($output_dir = $input_dir) =~ s/(.*)/$1_converted/ if (!defined $output_dir);
#
}
