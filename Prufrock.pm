package Prufrock;

use strict;
use warnings;

BEGIN {}

# Arial width table
# http://p2p.wrox.com/access/32197-calculate-character-widths.html

%Prufrock::widths = (' ' => 200, '!' => 254, '"' => 444, '#' => 644,
'$' => 536, '%' => 719, '&' => 796, '\'' => 235, '(' => 304, ')' =>
304, '*' => 416, '+' => 533, ',' => 217, '-' => 294, '.' => 216, '/'
=> 273, '0' => 533, '1' => 533, '2' => 533, '3' => 533, '4' => 533,
'5' => 533, '6' => 533, '7' => 533, '8' => 533, '9' => 533, ':' =>
216, ';' => 217, '<' => 533, '=' => 533, '>' => 533, '?' => 361, '@'
=> 757, 'A' => 724, 'B' => 598, 'C' => 640, 'D' => 750, 'E' => 549,
'F' => 484, 'G' => 720, 'H' => 742, 'I' => 326, 'J' => 315, 'K' =>
678, 'L' => 522, 'M' => 835, 'N' => 699, 'O' => 779, 'P' => 532, 'Q'
=> 779, 'R' => 675, 'S' => 536, 'T' => 596, 'U' => 722, 'V' => 661,
'W' => 975, 'X' => 641, 'Y' => 641, 'Z' => 684, '[' => 342, '\\' =>
273, ']' => 342, '^' => 247, '_' => 475, '`' => 247, 'a' => 441, 'b'
=> 540, 'c' => 448, 'd' => 542, 'e' => 466, 'f' => 321, 'g' => 479,
'h' => 551, 'i' => 278, 'j' => 268, 'k' => 530, 'l' => 269, 'm' =>
833, 'n' => 560, 'o' => 554, 'p' => 549, 'q' => 534, 'r' => 398, 's'
=> 397, 't' => 340, 'u' => 542, 'v' => 535, 'w' => 818, 'x' => 527,
'y' => 535, 'z' => 503, '{' => 380, '|' => 265, '}' => 380, '~' =>
533, '€' => 533, '‚' => 235, '„' => 444, '…' => 950, '†' => 536, '‡'
=> 536, '‰' => 1096, '‹' => 256, 'Ś' => 964, 'Ź' => 536, '‘' => 235,
'’' => 235, '“' => 444, '”' => 444, '•' => 536, '–' => 475, '—' =>
950, '›' => 256, 'ś' => 813, 'ź' => 641, 'Ł' => 536, 'Ą' => 536, '§'
=> 536, '«' => 399, '¬' => 521, '­' => 294, 'Ż' => 533, '°' => 294,
'±' => 533, 'ł' => 380, '´' => 247, 'µ' => 524, 'ą' => 380, '»' =>
399, '˝' => 760, 'ż' => 361, 'Ć' => 941, 'Ę' => 549, 'Ń' => 699, 'Ó'
=> 779, 'ć' => 703, 'ę' => 466, 'ń' => 560, 'ó' => 554, '÷' => 533);

sub Prufrock::title { 'The Love Song of J.\ Alfred Prufrock' }
sub Prufrock::author { 'T.\ S.\ Eliot' }
$Prufrock::work_name = 'Prufrock and Other Observations, by T. S. Eliot';
sub Prufrock::extra_packages { "\n\\usepackage{parskip}" }
sub Prufrock::long_line {
    my $l = shift;
    my $count = 0;
    for my $i (0..length($l)-1) {
	$count += $Prufrock::widths{substr($l, $i, 1)};
    }

# 22740  Shall I say, I have gone at dusk through narrow streets
# <break threshold>
# 22949  Among the porcelain, among some talk of you and me,

    return ($count > 22800);
}

#Custom line-break algorithm for poems.
# break after comma, if there is one
# break after right-paren ) if there is one
# break before "that" or "which"
# break before the word "and"
# break before "the"
# if a line begins with 5 spaces, join with previous line


sub Prufrock::break_up {
    my $l = shift;

    if ($l =~ /^(.*),(.+?)$/) {
#	print STDERR "C $l\n";
	$l = "$1,\\\\\n\\hspace*{.5em}$2";
    } elsif ($l=~ /^(.*)\)(.+?)$/) {
#	print STDERR "P $l\n";
	$l = "$1)\\\\\n\\hspace*{.5em}$2";
    } elsif ($l=~ /^(.*) which (.+?)$/) {
#	print STDERR "W $l\n";
	$l = "$1 which \\\\\n\\hspace*{.5em}$2";
    } elsif ($l=~ /^(.*) and (.+?)$/) {
#	print STDERR "A $l\n";
	$l = "$1\\\\\n\\hspace*{.5em}and $2";
    } elsif ($l=~ /^(.*) the (.+?)$/) {
#	print STDERR "T $l\n";
	$l = "$1\\\\\n\\hspace*{.5em}the $2";
    } else {
#	print STDERR "N $l\n";
    }
    return $l;
}

sub Prufrock::output {
    my $txt = '';
    my $blanks = 0;
    my $l = <STDIN>;
    my $n = <STDIN>;
    my $indented = 0;

    do {
	chomp $l;
	$l =~ s/(\r|\s)*$//;

	if ($n =~ /^     /) {
	    $n =~ s/^     / /;
	    $l .= $n;
	    $l =~ s/(\r|\s)*$//;
	    $n = <STDIN>;
	}

	if ($l =~ /^\s*$/) {
	    ++$blanks;
	    if ($blanks == 4) {
		$txt =~ s/"(.*?)"/``$1"/gs;
		return $txt;
	    }
	} else {
	    if ($blanks == 3) {
		$txt = "\\vspace{.25in}\\begin{center}\\begin{tabular}{\@{\\itshape}l\@{\\itshape}}
                $txt
                \\end{tabular}\\end{center}\\vspace{.25in}\n";
	    } elsif ($blanks > 0) {
		$txt .= "\n";
		$indented = 0;
	    }
	    $blanks = 0;

	    if ($l =~ /^   /) {
		$l =~ s/^   //;
		$txt .= "\\hspace*{2em}";
		$indented = 1;
	    } else {
#if the previous line was indented and this line is not, start a new paragraph
#this is a "bug" in the Gutenberg text where we fail to start a new paragraph
#after "So how should I presume?"
		if ($indented) {
		    $txt .= "\n";
		}
		$indented = 0;
	    }

	    if (Prufrock::long_line($l)) {
		$l = Prufrock::break_up($l);
	    }

	    $txt .= "$l\\\\\n";
	}
	$l = $n;
    } while ($n = <STDIN>);
    print STDERR "Did not find end-of-poem separator\n";
}

END {}

return 1;
