#!/bin/env perl

use strict;
use warnings;
use v5.24;

my $battery = 0;
my $batteryInfo = `acpi -b | grep "Battery $battery"`;
my $batteryState = `echo "$batteryInfo" | grep -wo "Full\|Charging\|Discharging"`;
my $batteryPower = `echo "$batteryInfo" | grep -o '[0-9]\+%' | tr -d '%'`;
my $batteryPowerRemaining = `acpi -b | awk '{print\$5}'`;
my $urgentValue = 10;

say "$batteryPower% $batteryPowerRemaining";
