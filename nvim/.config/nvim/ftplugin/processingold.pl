use 5.24.0;
use warnings;
use strict;

# change your types of expenses here:
my %categories = (
);

# get date. If not on Linux, this won't work
my $month = `date +%B`;
chomp($month);
my $totalMoney = 0;

while(<>){
    print if !/Total/;  # echo back out each row
    if (/Total/) {next;}  # ignore total row since recalculated

    # get all types -> $1
    if (my ($testing) = $_=~/.*\|.*\|\s(.*)\s\|/){
        # check to make sure the type isn't a title
        unless ($1 =~ /Type/ or $1 =~ /---/){
            my $type = $1;
            unless (defined $categories{$type}) {
                $categories{${type}} = 0;
                # print $type;
            }
        }
    }

    # add money
    if(/\$([0-9]+)/){
        $totalMoney += $1;
        my $currentMoney = $1;
        foreach my $categoryName (keys %categories){
            if(/\|\s$categoryName/i){
                $categories{$categoryName} += $currentMoney;
            }
        }
    }
}

my $percentages = "";
my $allCategories = "";
my $index = 0; # bad hack but it works -- no comma and pipe on last in list

foreach my $categoryName (keys %categories){
    $index++;
    if ($index != keys %categories){
        $percentages .= (($categories{$categoryName} / $totalMoney) . ",");
        $allCategories .= $categoryName . ":" . $categories{$categoryName} . "|";
    } else {
        $percentages .= $categories{$categoryName} / $totalMoney;
        $allCategories .= $categoryName . ":" . $categories{$categoryName};
    }
}

# uses Google API. If you don't want google, comment out the next two lines
my @getPicture = qq#curl -o ${month}.png "http://chart.apis.google.com/chart?cht=p&chd=t:$percentages&chs=600x300&chl=$allCategories" > /dev/null 2>&1#;
system(@getPicture);

print "Total | \$$totalMoney | - | -";
