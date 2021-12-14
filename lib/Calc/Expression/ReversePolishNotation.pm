package Calc::Expression::ReversePolishNotation;

=head1 DESCRIPTION

Класс представляющий математическое выражение в обратной польской записи

=cut

use Data::Dumper;
use Calc::LexemeFactory;

use base qw( Calc::Expression );


=head2 C<_parse>($expression_string)

Распарсить строку на лексемы

=cut

sub _parse {
    my ($self, $expression_string) = @_;

    # TODO: Открытая возможность научить приложение принимать на входе от клиента обратную польскую запись
    die 'Not implemented yet';
}


1;
