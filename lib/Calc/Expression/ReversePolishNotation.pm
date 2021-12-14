package Calc::Expression::ReversePolishNotation;

=head1 DESCRIPTION

Класс представляющий математическое выражение в обратной польской записи

=cut

use Data::Dumper;
use Calc::LexemeFactory;

use base qw( Calc::Expression );

use constant ALLOWED_LEXEME_TYPES => [qw( number operator )];


=head2 C<_get_allowed_lexeme_types>

Получить список разрешенных типов лексем для данного выражения

=cut

sub _get_allowed_lexeme_types { ALLOWED_LEXEME_TYPES }


=head2 C<_parse>($expression_string)

Распарсить строку на лексемы

=cut

sub _parse {
    my ($self, $expression_string) = @_;

    # TODO: Открытая возможность научить приложение принимать на входе от клиента обратную польскую запись
    die 'Not implemented yet';
}


1;
