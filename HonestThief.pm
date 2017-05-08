package HonestThief;

use strict;
use warnings;

BEGIN {}

sub HonestThief::title { 'An Honest Thief' }
sub HonestThief::author { 'Fyodor Dostoevsky' }
$HonestThief::work_name = 'Short Stories, by Fiodor Dostoievski';

sub HonestThief::output {
    my $txt = '';
    my $found = 0;
    while (<STDIN>) {
	if (/^AN HONEST THIEF\s*$/) { $found = 1; last; }
    }
    if (! $found) { return "story not found"; }
    while (<STDIN>) {
	if (/^A NOVEL IN NINE LETTERS\s*$/) { last; }
	$txt .= $_;
    }
    my $output = $txt;

    # double quotes
    #    $output =~ s/"([a-zA-Z ,]+)"/`$1'/gs;
    $output =~ s/'([a-z]+)'/`$1'/gs;
    $output =~ s/"([a-zA-Z ,]+)"/``$1"/gs;
    $output =~ s/^(\s*)"/$1``/gm;
    $output =~ s/"([A-Za-z].*?)"/``$1"/gs;
    $output =~ s/ê/\\^e/g;
    $output =~ s/à/\`a/g;

    while ($output =~ /"(.*?)"/g) {
	
    }
#    my $lq = "``";
#    my $rq = '"';
#    $output =~ s/"(.*?)"/if($1&&($1 =~ m!vspace!)){$1}else{$1}/egs;
    $output =~ s/^_(.*?)_([^[:print:]*])$/\\emph{$1}\n\n/mg;
    $output =~ s/_(.*?)_/\\emph{$1}/gs;

    $output = qq|\\hyphenation{Ag-ra-fe-na  Em-el-yan-oush-ka As-ta-fy Ivan-o-vitch}
    |.$output;

    return $output;
}

END {}

return 1;
