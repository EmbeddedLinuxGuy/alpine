package Prufrock;

use strict;
use warnings;

BEGIN {}

sub Prufrock::title { 'The Love Song of J.\ Alfred Prufrock' }
sub Prufrock::author { 'T.\ S.\ Eliot' }
$Prufrock::work_name = 'Prufrock and Other Observations, by T. S. Eliot';
sub Prufrock::extra_packages { "\n\\usepackage{parskip}" }
sub Prufrock::output {
    my $txt = '';
    my $blanks = 0;
    my $l = <STDIN>;
    my $n = <STDIN>;
    
    do {
	if ($n =~ /^     /) {
	    $l .= $n;
	    $n = <STDIN>;
	}

	chomp $l;
	$l =~ s/(\r|\s)*$//;
	if ($l =~ /^\s*$/) {
	    ++$blanks;
	    if ($blanks == 4) {
		$txt =~ s/"(.*?)"/``$1"/gs;
		return $txt;
	    } else {
		$txt .= "\n";
	    }
	} else {
	    $blanks = 0;
	    if ($l =~ /^   /) {
		$l =~ s/^   //;
		$txt .= "\\hspace*{2em}";
	    }
	    $txt .= "$l\\newline\n";
	}
	$l = $n;
    } while ($n = <STDIN>);
    print STDERR "Did not find end-of-poem separator\n";
}

END {}

return 1;
