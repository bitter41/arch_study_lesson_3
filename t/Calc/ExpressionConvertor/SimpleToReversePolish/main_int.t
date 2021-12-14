use Data::Dumper;
use Test::Spec;
use Test::Spec::Mocks;
use lib qw( ./lib ../lib );


describe 'Calc::ExpressionConvertor::SimpleToReversePolish int: ' => sub {
    
    it 'should include module Calc::ExpressionConvertor::SimpleToReversePolish successfuly' => sub {
        use_ok('Calc::ExpressionConvertor::SimpleToReversePolish');
    };

    describe 'check convertor state for right expression: 2 + 3 -->' => sub {
        my $convertor;
        
        before each => sub {
            Calc::ExpressionConvertor::SimpleToReversePolish->expects('_convert')->once();

            $convertor = Calc::ExpressionConvertor::SimpleToReversePolish->new('2 + 3');
        };

        it '_src_expression_string filled right' => sub {
            is $convertor->{_src_expression_string}, '2 + 3';
        };

        it '_stack is empty' => sub {
            cmp_deeply $convertor->{_stack}, [];
        };

        it '&has_errors' => sub {
            cmp_deeply $convertor->has_errors, 0;
        };

        it '_src_expression is SimplehNotation' => sub {
            is ref $convertor->{_src_expression}, 'Calc::Expression::SimpleNotation';
        };

        it '_src_expression check for &get_as_string' => sub {
            is $convertor->{_src_expression}->get_as_string(), '2+3';
        };

        it '_dst_expression is ReversePolishNotation' => sub {
            is ref $convertor->{_dst_expression}, 'Calc::Expression::ReversePolishNotation';
        };


    };


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
            cmp_deeply $convertor->has_errors, 1;
        };

        it '&get_errors not empty' => sub {
            cmp_deeply $convertor->get_errors(), [{
                description => 'Found wrong lexeme in expression: X',
                lexeme      => ignore(),
            },
            {
                description => 'Found wrong lexeme in expression: %',
                lexeme      => ignore(),
            }];
        };

        it '_src_expression is SimplehNotation' => sub {
            is ref $convertor->{_src_expression}, 'Calc::Expression::SimpleNotation';
        };

        it '_src_expression check for &get_as_string' => sub {
            is $convertor->{_src_expression}->get_as_string(), '2+3X45/2%';
        };

        it '_dst_expression is ReversePolishNotation' => sub {
            is ref $convertor->{_dst_expression}, 'Calc::Expression::ReversePolishNotation';
        };


    };

};

runtests();
