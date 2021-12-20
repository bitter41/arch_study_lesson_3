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

    my @expression     = ();

    my $lexeme_factory = Calc::LexemeFactory->new();

    # Здесь более простая реализация парсера по сравнению с Calc::Expression::SimpleNotation
    # Этот парсер просто разбирает строку на лексемы на основе пробела в качестве разделителя
    my @lexemes_as_string_array = split / /, $expression_string;
    foreach my $lexeme_string (@lexemes_as_string_array) {
        push @expression, $lexeme_factory->create($lexeme_string);
    }

    $self->{_expression} = \@expression;
}


1;
