package Calc::Expression::SimpleNotation;

=head1 DESCRIPTION

Класс представляющий математическое выражение в простой форме

=cut

use Data::Dumper;
use Calc::LexemeFactory;

use base qw( Calc::Expression );

use constant ALLOWED_LEXEME_TYPES => [qw( number operator bracket_left bracket_right )];


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
    my @known_lexemes  = $lexeme_factory->get_known_lexemes();

    $expression_string =~ s/\s+//g; # Сразу избавимся от пробелов

    my $loop_cnt       = 0;
    my $unknown_lexeme_found;
    while ($expression_string) {

        $unknown_lexeme_found = 1;
        foreach my $lexeme_regexp (@known_lexemes) {
            if ( $expression_string =~ s/($lexeme_regexp)// ) {
                push @expression, $lexeme_factory->create($1);
                $unknown_lexeme_found = 0;
            };
        };

        # Если нашли неизвестную лексему,
        # то все равно достаем ее из строки и создаем объект лексемы,
        # фабрика вернет специальный Calc::Lexeme::Unknown объект
        if ($unknown_lexeme_found) {
            $expression_string =~ s/(^.)//;
            push @expression, $lexeme_factory->create($1);
        };

        $loop_cnt++;
        die "Something wrong: too long expression or infinite loop found" if $loop_cnt > 100;
    }

    $self->{_expression} = \@expression;
}


1;
