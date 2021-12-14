use Data::Dumper;
use Test::Spec;
use Test::Spec::Mocks;
use lib qw( ./lib ../lib );

describe 'Calc::Expression::new(): ' => sub {

    it 'should include module Calc::Expression successfuly' => sub {
        use_ok('Calc::Expression');
    };

    describe '[SUCCESS] ' => sub {

        it 'should return obj of Calc::Expression and call &__parse with right args' => sub {
            Calc::Expression->expects('_parse')->with_deep('2 + 3')->once();
            is ref Calc::Expression->new('2 + 3'), 'Calc::Expression';
        };

    };
};

runtests();
