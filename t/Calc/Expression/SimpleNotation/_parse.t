use Data::Dumper;
use Test::Spec;
use Test::Spec::Mocks;
use Data::Structure::Util qw( unbless );
use lib qw( ./lib ../lib );

describe 'Calc::Expression::SimpleNotation::_parse(): ' => sub {

    it 'should include module Calc::Expression successfuly' => sub {
        use_ok('Calc::Expression::SimpleNotation');
    };

    describe '[SUCCESS] ' => sub {
        it 'should fill _expression field with 3 lexemes and call LexemeFactory 3 times for expression: 2 + 3' => sub {
            my $expr = mock();
            Calc::LexemeFactory->expects('create')->returns('some_obj')->exactly(3);
            Calc::Expression::SimpleNotation::_parse($expr, '2 + 3');

            unbless($expr);
            cmp_deeply $expr, {
                _expression => [qw( some_obj some_obj some_obj )],
            };
        };

        it 'should fill _expression field with 3 lexemes and call LexemeFactory 3 times for expression with wrong lexeme: 2 + X' => sub {
            my $expr = mock();
            Calc::LexemeFactory->expects('create')->returns('some_obj')->exactly(3);
            Calc::Expression::SimpleNotation::_parse($expr, '2 + 3');

            unbless($expr);
            cmp_deeply $expr, {
                _expression => [qw( some_obj some_obj some_obj )],
            };
        };
    };
};

runtests();
