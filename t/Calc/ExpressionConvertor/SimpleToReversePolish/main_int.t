use Data::Dumper;
use Test::Spec;
use Test::Spec::Mocks;
use lib qw( ./lib ../lib );


describe 'Calc::ExpressionConvertor::SimpleToReversePolish int: ' => sub {
    
    it 'should include module Calc::ExpressionConvertor::SimpleToReversePolish successfuly' => sub {
        use_ok('Calc::ExpressionConvertor::SimpleToReversePolish');
    };

    describe '[WRONG] ' => sub {


        describe 'check convertor state for wrong expression: 2 + 3 X 45 / 2 % -->' => sub {
            my $convertor;
            
            before each => sub {
                Calc::ExpressionConvertor::SimpleToReversePolish->expects('_convert')->never;

                $convertor = Calc::ExpressionConvertor::SimpleToReversePolish->new('2 + 3 X 45 / 2 %');
            };

            it '_src_expression_string filled right' => sub {
                is $convertor->{_src_expression_string}, '2 + 3 X 45 / 2 %';
            };

            it '_stack is empty' => sub {
                cmp_deeply $convertor->{_stack}, [];
            };

            it '&has_errors' => sub {
                cmp_deeply $convertor->has_errors(), 1;
            };

            it '&get_errors not empty' => sub {
                cmp_deeply $convertor->get_errors(), [
                    'Found wrong lexeme in expression: X',
                    'Found wrong lexeme in expression: %'
                ] or diag Dumper($convertor->get_errors());
            };

            it '_src_expression is SimplehNotation' => sub {
                is ref $convertor->_get_src_expression(), 'Calc::Expression::SimpleNotation';
            };

            it '_src_expression check for &get_as_string' => sub {
                is $convertor->_get_src_expression()->get_as_string(), '2+3X45/2%';
            };

            it '_dst_expression is ReversePolishNotation' => sub {
                is ref $convertor->_get_dst_expression(), 'Calc::Expression::ReversePolishNotation';
            };

            it '_dst_expression has right value' => sub {
                is $convertor->_get_dst_expression()->get_as_string(), '';
            };
        };


        describe 'check convertor state for wrong expression: (1 + 2 * 4 + 3 -->' => sub {
            my $convertor;
            
            before each => sub {
                $convertor = Calc::ExpressionConvertor::SimpleToReversePolish->new('(1 + 2 * 4 + 3');
            };

            it '_src_expression_string filled right' => sub {
                is $convertor->{_src_expression_string}, '(1 + 2 * 4 + 3';
            };

            it '_stack is empty' => sub {
                cmp_deeply $convertor->{_stack}, [];
            };

            it '&has_errors' => sub {
                cmp_deeply $convertor->has_errors(), 1;
            };

            it '&get_errors not empty' => sub {
                cmp_deeply $convertor->get_errors(), [
                    'Seems you missed close bracket lexeme in dst expression, because found lexeme: (',
                ];
            };

            it '_src_expression is SimplehNotation' => sub {
                is ref $convertor->_get_src_expression(), 'Calc::Expression::SimpleNotation';
            };

            it '_src_expression check for &get_as_string' => sub {
                is $convertor->_get_src_expression()->get_as_string(), '(1+2*4+3';
            };

            it '_dst_expression is ReversePolishNotation' => sub {
                is ref $convertor->_get_dst_expression(), 'Calc::Expression::ReversePolishNotation';
            };

            it '_dst_expression has right value' => sub {
                is $convertor->_get_dst_expression()->get_as_string(), '';
            };

        };


        describe 'check convertor state for wrong expression: ((1 + 2) * 4 + 3 -->' => sub {
            my $convertor;
            
            before each => sub {
                $convertor = Calc::ExpressionConvertor::SimpleToReversePolish->new('((1 + 2) * 4 + 3');
            };

            it '_src_expression_string filled right' => sub {
                is $convertor->{_src_expression_string}, '((1 + 2) * 4 + 3';
            };

            it '_stack is empty' => sub {
                cmp_deeply $convertor->{_stack}, [];
            };

            it '&has_errors' => sub {
                cmp_deeply $convertor->has_errors(), 1;
            };

            it '&get_errors not empty' => sub {
                cmp_deeply $convertor->get_errors(), [
                    'Seems you missed close bracket lexeme in dst expression, because found lexeme: (',
                ];
            };

            it '_src_expression is SimplehNotation' => sub {
                is ref $convertor->_get_src_expression(), 'Calc::Expression::SimpleNotation';
            };

            it '_src_expression check for &get_as_string' => sub {
                is $convertor->_get_src_expression()->get_as_string(), '((1+2)*4+3';
            };

            it '_dst_expression is ReversePolishNotation' => sub {
                is ref $convertor->_get_dst_expression(), 'Calc::Expression::ReversePolishNotation';
            };

            it '_dst_expression has right value' => sub {
                is $convertor->_get_dst_expression()->get_as_string(), '';
            };

        };


        describe 'check convertor state for wrong expression: (1 (+ 2() * 4 + 3 -->' => sub {
            my $convertor;
            
            before each => sub {
                $convertor = Calc::ExpressionConvertor::SimpleToReversePolish->new('(1 (+ 2() * 4 + 3');
            };

            it '_src_expression_string filled right' => sub {
                is $convertor->{_src_expression_string}, '(1 (+ 2() * 4 + 3';
            };

            it '_stack is empty' => sub {
                cmp_deeply $convertor->{_stack}, [];
            };

            it '&has_errors' => sub {
                cmp_deeply $convertor->has_errors(), 1;
            };

            it '&get_errors not empty' => sub {
                cmp_deeply $convertor->get_errors(), [
                    'Seems you missed close bracket lexeme in dst expression, because found lexeme: (',
                    'Seems you missed close bracket lexeme in dst expression, because found lexeme: ('
                ];
            };

            it '_src_expression is SimplehNotation' => sub {
                is ref $convertor->_get_src_expression(), 'Calc::Expression::SimpleNotation';
            };

            it '_src_expression check for &get_as_string' => sub {
                is $convertor->_get_src_expression()->get_as_string(), '(1(+2()*4+3';
            };

            it '_dst_expression is ReversePolishNotation' => sub {
                is ref $convertor->_get_dst_expression(), 'Calc::Expression::ReversePolishNotation';
            };

            it '_dst_expression has right value' => sub {
                is $convertor->_get_dst_expression()->get_as_string(), '';
            };

        };


        describe 'check convertor state for wrong expression: (1 + 2) * )4 + 3( -->' => sub {
            my $convertor;
            
            before each => sub {
                $convertor = Calc::ExpressionConvertor::SimpleToReversePolish->new('(1 + 2) * )4 + 3(');
            };

            it '_src_expression_string filled right' => sub {
                is $convertor->{_src_expression_string}, '(1 + 2) * )4 + 3(';
            };

            it '_stack is empty' => sub {
                cmp_deeply $convertor->{_stack}, [];
            };

            it '&has_errors' => sub {
                cmp_deeply $convertor->has_errors(), 1;
            };

            it '&get_errors not empty' => sub {
                cmp_deeply $convertor->get_errors(), [
                    'Seems you missed lexeme of type bracket_left',
                    'Seems you missed close bracket lexeme in dst expression, because found lexeme: ('
                ];
            };

            it '_src_expression is SimplehNotation' => sub {
                is ref $convertor->_get_src_expression(), 'Calc::Expression::SimpleNotation';
            };

            it '_src_expression check for &get_as_string' => sub {
                is $convertor->_get_src_expression()->get_as_string(), '(1+2)*)4+3(';
            };

            it '_dst_expression is ReversePolishNotation' => sub {
                is ref $convertor->_get_dst_expression(), 'Calc::Expression::ReversePolishNotation';
            };

            it '_dst_expression has right value' => sub {
                is $convertor->_get_dst_expression()->get_as_string(), '';
            };

        };


        describe 'check convertor state for wrong expression: (1 + 2) * )4 + 3 -->' => sub {
            my $convertor;
            
            before each => sub {
                $convertor = Calc::ExpressionConvertor::SimpleToReversePolish->new('(1 + 2) * )4 + 3');
            };

            it '_src_expression_string filled right' => sub {
                is $convertor->{_src_expression_string}, '(1 + 2) * )4 + 3';
            };

            it '_stack is empty' => sub {
                cmp_deeply $convertor->{_stack}, [];
            };

            it '&has_errors' => sub {
                cmp_deeply $convertor->has_errors(), 1;
            };

            it '&get_errors not empty' => sub {
                cmp_deeply $convertor->get_errors(), [
                    'Seems you missed lexeme of type bracket_left',
                ];
            };

            it '_src_expression is SimplehNotation' => sub {
                is ref $convertor->_get_src_expression(), 'Calc::Expression::SimpleNotation';
            };

            it '_src_expression check for &get_as_string' => sub {
                is $convertor->_get_src_expression()->get_as_string(), '(1+2)*)4+3';
            };

            it '_dst_expression is ReversePolishNotation' => sub {
                is ref $convertor->_get_dst_expression(), 'Calc::Expression::ReversePolishNotation';
            };

            it '_dst_expression has right value' => sub {
                is $convertor->_get_dst_expression()->get_as_string(), '';
            };

        };
    };


    describe '[SUCCESS] ' => sub {
        describe 'check convertor state for right expression: 2 + 3 -->' => sub {
            my $convertor;
            
            before each => sub {
                $convertor = Calc::ExpressionConvertor::SimpleToReversePolish->new('2 + 3');
            };

            it '_src_expression_string filled right' => sub {
                is $convertor->{_src_expression_string}, '2 + 3';
            };

            it '_stack is empty' => sub {
                cmp_deeply $convertor->{_stack}, [];
            };

            it '&has_errors' => sub {
                cmp_deeply $convertor->has_errors(), 0;
            };

            it '_src_expression is SimplehNotation' => sub {
                is ref $convertor->_get_src_expression(), 'Calc::Expression::SimpleNotation';
            };

            it '_src_expression check for &get_as_string' => sub {
                is $convertor->_get_src_expression()->get_as_string(), '2+3';
            };

            it '_dst_expression is ReversePolishNotation' => sub {
                is ref $convertor->_get_dst_expression(), 'Calc::Expression::ReversePolishNotation';
            };

            it '_dst_expression has right value' => sub {
                is $convertor->_get_dst_expression()->get_as_string(), '23+';
            };

        };


        describe 'check convertor state for right expression: (1 + 2) * 4 + 3 -->' => sub {
            my $convertor;
            
            before each => sub {
                $convertor = Calc::ExpressionConvertor::SimpleToReversePolish->new('(1 + 2) * 4 + 3');
            };

            it '_src_expression_string filled right' => sub {
                is $convertor->{_src_expression_string}, '(1 + 2) * 4 + 3';
            };

            it '_stack is empty' => sub {
                cmp_deeply $convertor->{_stack}, [];
            };

            it '&has_errors' => sub {
                cmp_deeply $convertor->has_errors(), 0;
            };

            it '_src_expression is SimplehNotation' => sub {
                is ref $convertor->_get_src_expression(), 'Calc::Expression::SimpleNotation';
            };

            it '_src_expression check for &get_as_string' => sub {
                is $convertor->_get_src_expression()->get_as_string(), '(1+2)*4+3';
            };

            it '_dst_expression is ReversePolishNotation' => sub {
                is ref $convertor->_get_dst_expression(), 'Calc::Expression::ReversePolishNotation';
            };

            it '_dst_expression has right value' => sub {
                is $convertor->_get_dst_expression()->get_as_string(), '12+4*3+';
            };

        };


        describe 'check convertor state for right expression: 1 + 2 * 4 - 3 -->' => sub {
            my $convertor;
            
            before each => sub {
                $convertor = Calc::ExpressionConvertor::SimpleToReversePolish->new('1 + 2 * 4 - 3');
            };

            it '_src_expression_string filled right' => sub {
                is $convertor->{_src_expression_string}, '1 + 2 * 4 - 3';
            };

            it '_stack is empty' => sub {
                cmp_deeply $convertor->{_stack}, [];
            };

            it '&has_errors' => sub {
                cmp_deeply $convertor->has_errors(), 0;
            };

            it '_src_expression is SimplehNotation' => sub {
                is ref $convertor->_get_src_expression(), 'Calc::Expression::SimpleNotation';
            };

            it '_src_expression check for &get_as_string' => sub {
                is $convertor->_get_src_expression()->get_as_string(), '1+2*4-3';
            };

            it '_dst_expression is ReversePolishNotation' => sub {
                is ref $convertor->_get_dst_expression(), 'Calc::Expression::ReversePolishNotation';
            };

            it '_dst_expression has right value' => sub {
                is $convertor->_get_dst_expression()->get_as_string(), '124*+3-';
            };

        };


        describe 'check convertor state for right expression: ((1 + 2) * 4 + 6) / 3 -->' => sub {
            my $convertor;
            
            before each => sub {
                $convertor = Calc::ExpressionConvertor::SimpleToReversePolish->new('((1 + 2) * 4 + 6) / 3');
            };

            it '_src_expression_string filled right' => sub {
                is $convertor->{_src_expression_string}, '((1 + 2) * 4 + 6) / 3';
            };

            it '_stack is empty' => sub {
                cmp_deeply $convertor->{_stack}, [];
            };

            it '&has_errors' => sub {
                cmp_deeply $convertor->has_errors(), 0;
            };

            it '_src_expression is SimplehNotation' => sub {
                is ref $convertor->_get_src_expression(), 'Calc::Expression::SimpleNotation';
            };

            it '_src_expression check for &get_as_string' => sub {
                is $convertor->_get_src_expression()->get_as_string(), '((1+2)*4+6)/3';
            };

            it '_dst_expression is ReversePolishNotation' => sub {
                is ref $convertor->_get_dst_expression(), 'Calc::Expression::ReversePolishNotation';
            };

            it '_dst_expression has right value' => sub {
                is $convertor->_get_dst_expression()->get_as_string(), '12+4*6+3/';
            };

        };


        describe 'check convertor state for right expression: (1+2) * 14 /6 +2 * (3+2) -->' => sub {
            my $convertor;
            
            before each => sub {
                $convertor = Calc::ExpressionConvertor::SimpleToReversePolish->new('(1+2) * 14 /6 +2 * (3+2)');
            };

            it '_src_expression_string filled right' => sub {
                is $convertor->{_src_expression_string}, '(1+2) * 14 /6 +2 * (3+2)';
            };

            it '_stack is empty' => sub {
                cmp_deeply $convertor->{_stack}, [];
            };

            it '&has_errors' => sub {
                cmp_deeply $convertor->has_errors(), 0;
            };

            it '_src_expression is SimplehNotation' => sub {
                is ref $convertor->_get_src_expression(), 'Calc::Expression::SimpleNotation';
            };

            it '_src_expression check for &get_as_string' => sub {
                is $convertor->_get_src_expression()->get_as_string(), '(1+2)*14/6+2*(3+2)';
            };

            it '_dst_expression is ReversePolishNotation' => sub {
                is ref $convertor->_get_dst_expression(), 'Calc::Expression::ReversePolishNotation';
            };

            it '_dst_expression has right value' => sub {
                is $convertor->_get_dst_expression()->get_as_string(), '12+14*6/232+*+';
            };

        };
    };


};

runtests();
