use Data::Dumper;
use Test::Spec;
use Test::Spec::Mocks;
use lib qw( ./lib ../lib );


describe 'Calc::Calculator::ReversePolish int: ' => sub {
    
    it 'should include module Calc::Calculator::ReversePolish successfuly' => sub {
        use_ok('Calc::Calculator::ReversePolish');
    };

    describe '[WRONG] ' => sub {
        describe 'check calculator state for right expression: 2 0 / -->' => sub {
            my $calculator;
            
            before each => sub {
                $calculator = Calc::Calculator::ReversePolish->new('2 0 /');
            };

            it '_src_expression_string filled right' => sub {
                is $calculator->{_src_expression_string}, '2 0 /';
            };

            it '_stack is empty' => sub {
                cmp_deeply $calculator->{_stack}, [];
            };

            it '&has_errors' => sub {
                cmp_deeply $calculator->has_errors(), 1;
            };

            it '&get_errors not empty' => sub {
                cmp_deeply $calculator->get_errors(), [
                    'Something wrong while doing operation \'/\' with operands: \'2\' and \'0\'',
                ] or diag Dumper($calculator->get_errors());
            };

            it '_get_src_expression() is ReversePolishNotation' => sub {
                is ref $calculator->_get_src_expression(), 'Calc::Expression::ReversePolishNotation';
            };

            it '_get_src_expression() check for &get_as_string' => sub {
                is $calculator->_get_src_expression()->get_as_string(), '2 0 /';
            };

            it 'get_result() returns right value: undef' => sub {
                is $calculator->get_result(), undef;
            };

        };

        describe 'check calculator state for right expression: 2 + -->' => sub {
            my $calculator;
            
            before each => sub {
                $calculator = Calc::Calculator::ReversePolish->new('2 +');
            };

            it '_src_expression_string filled right' => sub {
                is $calculator->{_src_expression_string}, '2 +';
            };

            it '_stack is empty' => sub {
                cmp_deeply $calculator->{_stack}, [];
            };

            it '&has_errors' => sub {
                cmp_deeply $calculator->has_errors(), 1;
            };

            it '&get_errors not empty' => sub {
                cmp_deeply $calculator->get_errors(), [
                    'Not found second operand while doing operation \'+\' with operand \'2\'',
                ] or diag Dumper($calculator->get_errors());
            };

            it '_get_src_expression() is ReversePolishNotation' => sub {
                is ref $calculator->_get_src_expression(), 'Calc::Expression::ReversePolishNotation';
            };

            it '_get_src_expression() check for &get_as_string' => sub {
                is $calculator->_get_src_expression()->get_as_string(), '2 +';
            };

            it 'get_result() returns right value: undef' => sub {
                is $calculator->get_result(), undef;
            };

        };

    };


    describe '[SUCCESS] ' => sub {

        describe 'check calculator state for right expression: 1 0 + 0 * -->' => sub {
            my $calculator;
            
            before each => sub {
                $calculator = Calc::Calculator::ReversePolish->new('1 0 + 0 *');
            };

            it '_src_expression_string filled right' => sub {
                is $calculator->{_src_expression_string}, '1 0 + 0 *';
            };

            it '_stack is empty' => sub {
                cmp_deeply $calculator->{_stack}, [];
            };

            it '&has_errors' => sub {
                cmp_deeply $calculator->has_errors(), 0 or diag(Dumper($calculator->get_errors()));
            };

            it '_get_src_expression() is ReversePolishNotation' => sub {
                is ref $calculator->_get_src_expression(), 'Calc::Expression::ReversePolishNotation';
            };

            it '_get_src_expression() check for &get_as_string' => sub {
                is $calculator->_get_src_expression()->get_as_string(), '1 0 + 0 *';
            };

            it 'get_result() returns right value: 0' => sub {
                is $calculator->get_result(), 0;
            };

        };


        describe 'check calculator state for right expression: 1 0 + 0 + 7 - -->' => sub {
            my $calculator;
            
            before each => sub {
                $calculator = Calc::Calculator::ReversePolish->new('1 0 + 0 + 7 -');
            };

            it '_src_expression_string filled right' => sub {
                is $calculator->{_src_expression_string}, '1 0 + 0 + 7 -';
            };

            it '_stack is empty' => sub {
                cmp_deeply $calculator->{_stack}, [];
            };

            it '&has_errors' => sub {
                cmp_deeply $calculator->has_errors(), 0;
            };

            it '_get_src_expression() is ReversePolishNotation' => sub {
                is ref $calculator->_get_src_expression(), 'Calc::Expression::ReversePolishNotation';
            };

            it '_get_src_expression() check for &get_as_string' => sub {
                is $calculator->_get_src_expression()->get_as_string(), '1 0 + 0 + 7 -';
            };

            it 'get_result() returns right value: -6' => sub {
                is $calculator->get_result(), -6;
            };

        };


        describe 'check calculator state for right expression: 2 3 + -->' => sub {
            my $calculator;
            
            before each => sub {
                $calculator = Calc::Calculator::ReversePolish->new('2 3 +');
            };

            it '_src_expression_string filled right' => sub {
                is $calculator->{_src_expression_string}, '2 3 +';
            };

            it '_stack is empty' => sub {
                cmp_deeply $calculator->{_stack}, [];
            };

            it '&has_errors' => sub {
                cmp_deeply $calculator->has_errors(), 0;
            };

            it '_get_src_expression() is ReversePolishNotation' => sub {
                is ref $calculator->_get_src_expression(), 'Calc::Expression::ReversePolishNotation';
            };

            it '_get_src_expression() check for &get_as_string' => sub {
                is $calculator->_get_src_expression()->get_as_string(), '2 3 +';
            };

            it 'get_result() returns right value: 5' => sub {
                is $calculator->get_result(), 5;
            };

        };


        describe 'check calculator state for right expression: 1 2 + 4 * 3 + -->' => sub {
            my $calculator;
            
            before each => sub {
                $calculator = Calc::Calculator::ReversePolish->new('1 2 + 4 * 3 +');
            };

            it '_src_expression_string filled right' => sub {
                is $calculator->{_src_expression_string}, '1 2 + 4 * 3 +';
            };

            it '_stack is empty' => sub {
                cmp_deeply $calculator->{_stack}, [];
            };

            it '&has_errors' => sub {
                cmp_deeply $calculator->has_errors(), 0;
            };

            it '_get_src_expression() is ReversePolishNotation' => sub {
                is ref $calculator->_get_src_expression(), 'Calc::Expression::ReversePolishNotation';
            };

            it '_get_src_expression() check for &get_as_string' => sub {
                is $calculator->_get_src_expression()->get_as_string(), '1 2 + 4 * 3 +';
            };

            it 'get_result() returns right value: 15' => sub {
                is $calculator->get_result(), 15;
            };

        };


        describe 'check calculator state for right expression: 1 2 4 * + 3 - -->' => sub {
            my $calculator;
            
            before each => sub {
                $calculator = Calc::Calculator::ReversePolish->new('1 2 4 * + 3 -');
            };

            it '_src_expression_string filled right' => sub {
                is $calculator->{_src_expression_string}, '1 2 4 * + 3 -';
            };

            it '_stack is empty' => sub {
                cmp_deeply $calculator->{_stack}, [];
            };

            it '&has_errors' => sub {
                cmp_deeply $calculator->has_errors(), 0;
            };

            it '_get_src_expression() is ReversePolishNotation' => sub {
                is ref $calculator->_get_src_expression(), 'Calc::Expression::ReversePolishNotation';
            };

            it '_get_src_expression() check for &get_as_string' => sub {
                is $calculator->_get_src_expression()->get_as_string(), '1 2 4 * + 3 -';
            };

            it 'get_result() returns right value: 6' => sub {
                is $calculator->get_result(), 6;
            };

        };


        describe 'check calculator state for right expression: 1 2 + 4 * 6 + 3 / -->' => sub {
            my $calculator;
            
            before each => sub {
                $calculator = Calc::Calculator::ReversePolish->new('1 2 + 4 * 6 + 3 /');
            };

            it '_src_expression_string filled right' => sub {
                is $calculator->{_src_expression_string}, '1 2 + 4 * 6 + 3 /';
            };

            it '_stack is empty' => sub {
                cmp_deeply $calculator->{_stack}, [];
            };

            it '&has_errors' => sub {
                cmp_deeply $calculator->has_errors(), 0;
            };

            it '_get_src_expression() is ReversePolishNotation' => sub {
                is ref $calculator->_get_src_expression(), 'Calc::Expression::ReversePolishNotation';
            };

            it '_get_src_expression() check for &get_as_string' => sub {
                is $calculator->_get_src_expression()->get_as_string(), '1 2 + 4 * 6 + 3 /';
            };

            it 'get_result() returns right value: 6' => sub {
                is $calculator->get_result(), 6;
            };

        };


        describe 'check calculator state for right expression: 1 2 + 14 * 6 / 2 3 2 + * + -->' => sub {
            my $calculator;
            
            before each => sub {
                $calculator = Calc::Calculator::ReversePolish->new('1 2 + 14 * 6 / 2 3 2 + * +');
            };

            it '_src_expression_string filled right' => sub {
                is $calculator->{_src_expression_string}, '1 2 + 14 * 6 / 2 3 2 + * +';
            };

            it '_stack is empty' => sub {
                cmp_deeply $calculator->{_stack}, [];
            };

            it '&has_errors' => sub {
                cmp_deeply $calculator->has_errors(), 0;
            };

            it '_get_src_expression() is ReversePolishNotation' => sub {
                is ref $calculator->_get_src_expression(), 'Calc::Expression::ReversePolishNotation';
            };

            it '_get_src_expression() check for &get_as_string' => sub {
                is $calculator->_get_src_expression()->get_as_string(), '1 2 + 14 * 6 / 2 3 2 + * +';
            };

            it 'get_result() returns right value: 17' => sub {
                is $calculator->get_result(), 17;
            };

        };

    };

};

runtests();
