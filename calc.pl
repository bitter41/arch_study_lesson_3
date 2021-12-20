#!/usr/bin/env perl

use lib './lib';
use strict;
use warnings;

use Data::Dumper;
use Calc::ExpressionConvertor::SimpleToReversePolish;
use Calc::Calculator::ReversePolish;

use constant DEBUG_STATUS_FOR_TOGGLE_DICT => {
    0 => 'Enable',
    1 => 'Disable',
};

my $debug_mode = 0;

while (1) {
    my $debug_status_for_tiggle = DEBUG_STATUS_FOR_TOGGLE_DICT->{$debug_mode};
    print <<THEEND;
\n\n###################################
Commands:
    /debug: $debug_status_for_tiggle debug mode
    /exit
-----------------------------------

THEEND
    print "Enter expression or command: ";
    my $expression = <STDIN>;
    chomp $expression;

    last if $expression eq '/exit';
    if ($expression eq '/debug') {
        $debug_mode = $debug_mode ^ 1; # xor / toggle
        next;
    }

    my $convertor = Calc::ExpressionConvertor::SimpleToReversePolish->new($expression);
    if ($convertor->has_errors()) {
        foreach my $error (@{ $convertor->get_errors() }) {
            print "$error\n";
        }
        next;
    }
    my $expression_in_rpn_string = $convertor->get_dst_expression()->get_as_string();
    print "Expression in rpn: $expression_in_rpn_string\n";

    my $calculator = Calc::Calculator::ReversePolish->new( $expression_in_rpn_string, { debug_mode => $debug_mode } );
    if ($calculator->has_errors()) {
        foreach my $error (@{ $calculator->get_errors() }) {
            print "$error\n";
        }
        next;
    }
    my $result = $calculator->get_result();

    print "Result of expression: $result\n";

}
