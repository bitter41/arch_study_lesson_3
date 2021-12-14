use Data::Dumper;
use Test::Spec;
use Test::Spec::Mocks;
use lib qw( ./lib ../lib );


describe 'Calc::Expression::SimpleNotation::_parse() int: ' => sub {

    it 'should include module Calc::Expression successfuly' => sub {
        use_ok('Calc::Expression::SimpleNotation');
    };

    describe '[SUCCESS] ' => sub {
        my $expr;

        before each => sub {
            $expr = mock();
        };

        describe 'should fill _expression field with 3 lexemes and call LexemeFactory 3 times for expression: 2 + 3 --> ' => sub {
            before each => sub {
                Calc::Expression::SimpleNotation::_parse($expr, '2 + 3');
            };

            it 'check lexemes count' => sub {
                is scalar @{$expr->{_expression}}, 3;
            };

            it 'check lexeme 1 ref' => sub {
                is ref $expr->{_expression}[0], 'Calc::Lexeme::Number';
            };
            it 'check lexeme 1 value' => sub {
                is $expr->{_expression}[0]->get_value(), 2;
            };
            it 'check lexeme 1 type' => sub {
                is $expr->{_expression}[0]->get_type(), 'number';
            };
            it 'check lexeme 1 valid' => sub {
                is $expr->{_expression}[0]->is_valid(), 1;
            };

            it 'check lexeme 2 ref' => sub {
                is ref $expr->{_expression}[1], 'Calc::Lexeme::Operator::Addition';
            };
            it 'check lexeme 2 value' => sub {
                is $expr->{_expression}[1]->get_value(), '+';
            };
            it 'check lexeme 2 type' => sub {
                is $expr->{_expression}[1]->get_type(), 'operator';
            };
            it 'check lexeme 2 valid' => sub {
                is $expr->{_expression}[1]->is_valid(), 1;
            };

            it 'check lexeme 3 ref' => sub {
                is ref $expr->{_expression}[2], 'Calc::Lexeme::Number';
            };
            it 'check lexeme 3 value' => sub {
                is $expr->{_expression}[2]->get_value(), 3;
            };
            it 'check lexeme 3 type' => sub {
                is $expr->{_expression}[2]->get_type(), 'number';
            };
            it 'check lexeme 3 valid' => sub {
                is $expr->{_expression}[2]->is_valid(), 1;
            };
        };

        describe 'should fill _expression field with 3 lexemes and call LexemeFactory 3 times for expression with wrong lexeme: 2 + X' => sub {
            before each => sub {
                Calc::Expression::SimpleNotation::_parse($expr, '2 + X');
            };

            it 'check lexemes count' => sub {
                is scalar @{$expr->{_expression}}, 3;
            };

            it 'check lexeme 1 ref' => sub {
                is ref $expr->{_expression}[0], 'Calc::Lexeme::Number';
            };
            it 'check lexeme 1 value' => sub {
                is $expr->{_expression}[0]->get_value(), 2;
            };
            it 'check lexeme 1 type' => sub {
                is $expr->{_expression}[0]->get_type(), 'number';
            };
            it 'check lexeme 1 valid' => sub {
                is $expr->{_expression}[0]->is_valid(), 1;
            };

            it 'check lexeme 2 ref' => sub {
                is ref $expr->{_expression}[1], 'Calc::Lexeme::Operator::Addition';
            };
            it 'check lexeme 2 value' => sub {
                is $expr->{_expression}[1]->get_value(), '+';
            };
            it 'check lexeme 2 type' => sub {
                is $expr->{_expression}[1]->get_type(), 'operator';
            };
            it 'check lexeme 2 valid' => sub {
                is $expr->{_expression}[1]->is_valid(), 1;
            };

            it 'check lexeme 3 ref' => sub {
                is ref $expr->{_expression}[2], 'Calc::Lexeme::Unknown';
            };
            it 'check lexeme 3 value' => sub {
                is $expr->{_expression}[2]->get_value(), 'X';
            };
            it 'check lexeme 3 type' => sub {
                is $expr->{_expression}[2]->get_type(), 'unknown';
            };
            it 'check lexeme 3 valid' => sub {
                is $expr->{_expression}[2]->is_valid(), 0;
            };

        };

        describe 'should fill _expression field with 11 lexemes and call LexemeFactory 11 times for expression with all known lexemes: (2 + 3) * 4 / 2 - 1' => sub {
            before each => sub {
                Calc::Expression::SimpleNotation::_parse($expr, '(2 + 3) * 4 / 2 - 1');
            };

            it 'check lexemes count' => sub {
                is scalar @{$expr->{_expression}}, 11;
            };

            it 'check lexeme 1 ref' => sub {
                is ref $expr->{_expression}[0], 'Calc::Lexeme::Bracket::Left';
            };
            it 'check lexeme 1 value' => sub {
                is $expr->{_expression}[0]->get_value(), '(';
            };
            it 'check lexeme 1 type' => sub {
                is $expr->{_expression}[0]->get_type(), 'bracket_left';
            };
            it 'check lexeme 1 valid' => sub {
                is $expr->{_expression}[0]->is_valid(), 1;
            };

            it 'check lexeme 2 ref' => sub {
                is ref $expr->{_expression}[1], 'Calc::Lexeme::Number';
            };
            it 'check lexeme 2 value' => sub {
                is $expr->{_expression}[1]->get_value(), 2;
            };
            it 'check lexeme 2 type' => sub {
                is $expr->{_expression}[1]->get_type(), 'number';
            };
            it 'check lexeme 2 valid' => sub {
                is $expr->{_expression}[1]->is_valid(), 1;
            };

            it 'check lexeme 3 ref' => sub {
                is ref $expr->{_expression}[2], 'Calc::Lexeme::Operator::Addition';
            };
            it 'check lexeme 3 value' => sub {
                is $expr->{_expression}[2]->get_value(), '+';
            };
            it 'check lexeme 3 type' => sub {
                is $expr->{_expression}[2]->get_type(), 'operator';
            };
            it 'check lexeme 3 valid' => sub {
                is $expr->{_expression}[2]->is_valid(), 1;
            };
            it 'check lexeme 3 priority' => sub {
                is $expr->{_expression}[2]->get_priority(), 0;
            };

            it 'check lexeme 4 ref' => sub {
                is ref $expr->{_expression}[3], 'Calc::Lexeme::Number';
            };
            it 'check lexeme 4 value' => sub {
                is $expr->{_expression}[3]->get_value(), '3';
            };
            it 'check lexeme 4 type' => sub {
                is $expr->{_expression}[3]->get_type(), 'number';
            };
            it 'check lexeme 4 valid' => sub {
                is $expr->{_expression}[3]->is_valid(), 1;
            };

            it 'check lexeme 5 ref' => sub {
                is ref $expr->{_expression}[4], 'Calc::Lexeme::Bracket::Right';
            };
            it 'check lexeme 5 value' => sub {
                is $expr->{_expression}[4]->get_value(), ')';
            };
            it 'check lexeme 5 type' => sub {
                is $expr->{_expression}[4]->get_type(), 'bracket_right';
            };
            it 'check lexeme 5 valid' => sub {
                is $expr->{_expression}[4]->is_valid(), 1;
            };

            it 'check lexeme 6 ref' => sub {
                is ref $expr->{_expression}[5], 'Calc::Lexeme::Operator::Multiplication';
            };
            it 'check lexeme 6 value' => sub {
                is $expr->{_expression}[5]->get_value(), '*';
            };
            it 'check lexeme 6 type' => sub {
                is $expr->{_expression}[5]->get_type(), 'operator';
            };
            it 'check lexeme 6 valid' => sub {
                is $expr->{_expression}[5]->is_valid(), 1;
            };
            it 'check lexeme 6 priority' => sub {
                is $expr->{_expression}[5]->get_priority(), 1;
            };

            it 'check lexeme 7 ref' => sub {
                is ref $expr->{_expression}[6], 'Calc::Lexeme::Number';
            };
            it 'check lexeme 7 value' => sub {
                is $expr->{_expression}[6]->get_value(), '4';
            };
            it 'check lexeme 7 type' => sub {
                is $expr->{_expression}[6]->get_type(), 'number';
            };
            it 'check lexeme 7 valid' => sub {
                is $expr->{_expression}[6]->is_valid(), 1;
            };

            it 'check lexeme 8 ref' => sub {
                is ref $expr->{_expression}[7], 'Calc::Lexeme::Operator::Division';
            };
            it 'check lexeme 8 value' => sub {
                is $expr->{_expression}[7]->get_value(), '/';
            };
            it 'check lexeme 8 type' => sub {
                is $expr->{_expression}[7]->get_type(), 'operator';
            };
            it 'check lexeme 8 valid' => sub {
                is $expr->{_expression}[7]->is_valid(), 1;
            };
            it 'check lexeme 8 priority' => sub {
                is $expr->{_expression}[7]->get_priority(), 1;
            };

            it 'check lexeme 9 ref' => sub {
                is ref $expr->{_expression}[8], 'Calc::Lexeme::Number';
            };
            it 'check lexeme 9 value' => sub {
                is $expr->{_expression}[8]->get_value(), '2';
            };
            it 'check lexeme 9 type' => sub {
                is $expr->{_expression}[8]->get_type(), 'number';
            };
            it 'check lexeme 9 valid' => sub {
                is $expr->{_expression}[8]->is_valid(), 1;
            };

            it 'check lexeme 10 ref' => sub {
                is ref $expr->{_expression}[9], 'Calc::Lexeme::Operator::Subtraction';
            };
            it 'check lexeme 10 value' => sub {
                is $expr->{_expression}[9]->get_value(), '-';
            };
            it 'check lexeme 10 type' => sub {
                is $expr->{_expression}[9]->get_type(), 'operator';
            };
            it 'check lexeme 10 valid' => sub {
                is $expr->{_expression}[9]->is_valid(), 1;
            };
            it 'check lexeme 10 priority' => sub {
                is $expr->{_expression}[9]->get_priority(), 0;
            };

            it 'check lexeme 11 ref' => sub {
                is ref $expr->{_expression}[10], 'Calc::Lexeme::Number';
            };
            it 'check lexeme 11 value' => sub {
                is $expr->{_expression}[10]->get_value(), '1';
            };
            it 'check lexeme 11 type' => sub {
                is $expr->{_expression}[10]->get_type(), 'number';
            };
            it 'check lexeme 11 valid' => sub {
                is $expr->{_expression}[10]->is_valid(), 1;
            };
        };

    };
};

runtests();
