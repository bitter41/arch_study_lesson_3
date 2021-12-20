package Calc::Lexeme::Bracket::Left;

=head1 DESCRIPTION

Класс представляющий лексему открывающей скобки
# TODO: Открытая возможность научить приложение распознавать разные скобки, за счет добавления дочерних классов к текущему

=cut

use base qw( Calc::Lexeme::Bracket );


=head2 C<get_regexp>

Получить регулярное выражение соответствующее лексеме

=cut

sub get_regexp {
    my ($self) = @_;

    return '^\(';
}

=head2 C<get_type>

Вернуть тип лексемы

=cut

sub get_type { 'bracket_left' }

1;
