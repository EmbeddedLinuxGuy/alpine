package Prufrock;

use strict;
use warnings;

BEGIN {}

sub Prufrock::title { 'The Love Song of J.\ Alfred Prufrock' }
$Prufrock::title_text = 'The Love Song of J. Alfred Prufrock';
sub Prufrock::author { 'T S Eliot' }
$Prufrock::work_name = 'Prufrock and Other Observations, by T. S. Eliot';

sub Prufrock::output {
    my $txt = '';
    my $blanks = 0;
    while (<STDIN>) {
	chomp;
	s/(\r|\s)*$//;
	if ($_ =~ /^\s*$/) {
	    ++$blanks;
	    if ($blanks == 4) {
		return $txt;
	    }
	    $txt .= "\n";
	} else {
	    $blanks = 0;
	    $txt .= "$_\\\\\n";
	}
    }
}

END {}

return 1;
