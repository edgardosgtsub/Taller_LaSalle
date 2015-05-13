#!/usr/bin/perl

use warnings;
use strict;
use Getopt::Long;
use Term::ANSIColor qw(:constants);

#################################################################
###########Global Variables#############
my @languages_list;
my @ocrs_list;
my @formats_list;
my @imagenes_list;
####### Read input arguments   #####
my $opt_help = undef;
my $input_dir = undef;
my $ocrs = undef;
my $output_dir = undef;
my $formats = undef;
my @args = @ARGV;
GetOptions('help'=> \$opt_help,
            'input_dir=s'=> \$input_dir,
            'ocrs=s'=>\$ocrs,
            'output_dir=s'=>\$output_dir,
            'formats=s' => \$formats,
        );
#################################################################
          ##########        main        ##########
&process_args();
&convert();

##################      sub routines    ########################
sub process_args(){
#Ayuda
	&print_help() if (defined $opt_help);
#Si no hay carpeta qué procesar, salir con error.
	die("Se necesita una carpeta con imágenes para usar el programa") if(!defined $input_dir);
#Se pueden usar más de un convertidor
	$ocrs = "t" if(!defined $ocrs);
	@ocrs_list = split(/\,/,$ocrs);
#Asignar la carpeta de salida en base a la de entrada si no se define
	($output_dir = $input_dir) =~ s/(.*)/$1_converted/ if (!defined $output_dir);
#Para elformato se pueden ahora escoger varios y se creará una carpeta con cada uno de ellos.
	$formats = "txt" if(!defined $formats);
	@formats_list = split(/\,/,$formats);

	@imagenes_list = `ls $input_dir`;
	foreach my $imagen (@imagenes_list){
		$imagen =~ s/ /\\ /g; chomp $imagen;
	}
}

sub convert(){
	my $imagen; my $conversion; my $command;
	my $current_dir; my $formato2; my $ocr;
	foreach my $formato (@formats_list){
		$formato2 = "TXT" if($formato eq "txt");
		$formato2 = "PDF" if($formato eq "pdf");
    print("\nConvirtiendo a $formato\n");
		foreach $ocr (@ocrs_list){
			$ocr = "Tesseract" if($ocr eq "t");
			$ocr = "GOCR" if($ocr eq "g");
			$ocr = "Ocrad" if($ocr eq "o");
			$current_dir = "$output_dir/$formato/$ocr";
			print("\nUsando OCR: $ocr\n");
			print("Creando directorio: $current_dir\n");
			`mkdir -p $current_dir`;
			foreach $imagen (@imagenes_list){
				($conversion = $imagen ) =~ s/.jpg/.$formato/;
				print("Convirtiendo $imagen a $conversion en $current_dir\n");
				$command = "ocrfeeder-cli --image $input_dir/$imagen -f $formato2 -o $current_dir/$conversion -e $ocr -l es";
				print("Usando commando:\n>$command\n");
#  `$command`;
			}
		}
	}

	print("Imágenes convertidas!\nEn la carpeta $output_dir puede encontrar los archivos finales.\n");
}

sub print_help(){
    print("\nEste script convierte imagenes de texto a documentos pdf o txt. Use --input_dir <path a la carpeta con imagenes>. Por default convertirá a txt y usará la máquina de conversión Tesseract. Si quiere convertir a más formatos y/o usar otras máquinas de conversión (Ocrad o GOCR) use: --formats \"txt,pdf,<otros formatos>\"\n y/o --ocrs \"t,o,g\".\n");
    exit 0;
}
