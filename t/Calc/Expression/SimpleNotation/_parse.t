use Data::Dumper;
use Test::Spec;
use Test::Spec::Mocks;
use Data::Structure::Util qw( unbless );
use lib qw( ./lib ../lib );

use constant KNOWN_LEXEME_REGEXPS => (
    '^\+',
    '^-',
    '^\*',
    '^\/',
    '^\(',
    '^\)',
    '^\d+',
);

describe 'Calc::Expression::SimpleNotation::_parse(): ' => sub {

    it 'should include module Calc::Expression successfuly' => sub {
        use_ok('Calc::Expression::SimpleNotation');
    };

    describe '[SUCCESS] ' => sub {
        my $expr;
        my $factory;

        before each => sub {
            $expr    = mock();
            $factory = mock();
            $factory->expects('get_known_lexemes')->returns(KNOWN_LEXEME_REGEXPS)->once;
            Calc::LexemeFactory->expects('new')->returns($factory)->once;
        };

        it 'should fill _expression field with 3 lexemes and call LexemeFactory 3 times for expression: 2 + 3' => sub {
            $factory->expects('create')->returns('some_obj')->exactly(3);

            Calc::Expression::SimpleNotation::_parse($expr, '2 + 3');

            unbless($expr);
            cmp_deeply $expr, {
                _expression => [qw( some_obj some_obj some_obj )],
            };
        };

        it 'should fill _expression field with 3 lexemes and call LexemeFactory 3 times for expression with wrong lexeme: 2 + X' => sub {
            $factory->expects('create')->returns('some_obj')->exactly(3);

            Calc::Expression::SimpleNotation::_parse($expr, '2 + X');

            unbless($expr);
            cmp_deeply $expr, {
                _expression => [qw( some_obj some_obj some_obj )],
            };
        };

        it 'should fill _expression field with 11 lexemes and call LexemeFactory 11 times for expression with all known lexemes: (2 + 3) * 4 / 2 - 1' => sub {
            $factory->expects('create')->returns('some_obj')->exactly(11);

            Calc::Expression::SimpleNotation::_parse($expr, '(2 + 3) * 4 / 2 - 1');

            unbless($expr);
            cmp_deeply $expr, {
                _expression => [qw( some_obj some_obj some_obj some_obj some_obj some_obj some_obj some_obj some_obj some_obj some_obj )],
            };
        };
    };
};

runtests();
