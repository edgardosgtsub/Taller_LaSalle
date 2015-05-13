#!/usr/bin/perl

use warnings;
use strict;


print("");
#################################################################
###########Global Variables#############
my $input_dir = $ARGV[0];
my $ocr = $ARGV[1];
my $format = $ARGV[2];
my $output_dir = "Converted";
#################################################################

my $format2 = $format;
$format2 = "TXT" if($format eq "txt");
$format2 = "PDF" if($format eq "pdf");
print("Formato escogido: $format2\n");

$ocr = "Tesseract" if($ocr eq "t");
$ocr = "GOCR" if($ocr eq "g");
$ocr = "Ocrad" if($ocr eq "o");
print("Convertidor escogido: $ocr\n");

my @imagenes = `ls $input_dir`;
my $imagen; my $conversion; my $command;
`mkdir $output_dir`;
foreach my $imagen (@imagenes){
  $imagen =~ s/ /\\ /g; chomp $imagen;
  ($conversion = $imagen ) =~ s/.jpg/.$format/;
  print("Convirtiendo $imagen to $conversion\n");
  $command = "ocrfeeder-cli --image $input_dir/$imagen -f $format2 -o $output_dir/$conversion -e $ocr -l es";
  print("Usando commando:\n>$command\n");
#  `$command`;
}
print("Imágenes convertidas!\nEn la carpeta $output_dir puede encontrar los archivos finales.\n");
