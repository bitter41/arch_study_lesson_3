package Calc::Lexeme::Bracket::Right;

=head1 DESCRIPTION

Класс представляющий лексему закрывающей скобки

=cut

use base qw( Calc::Lexeme::Bracket );


=head2 C<get_regexp>

Получить регулярное выражение соответствующее лексеме

=cut

sub get_regexp {
    my ($self) = @_;

    return '^\)';
}

=head2 C<get_type>

Вернуть тип лексемы

=cut

sub get_type { 'bracket_right' }

1;
