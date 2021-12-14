package Calc::Lexeme::Operator::Multiplication;

=head1 DESCRIPTION

Класс представляющий лексему умножения

=cut

use base qw( Calc::Lexeme::Operator );


=head2 C<get_regexp>

Получить регулярное выражение соответствующее лексеме

=cut

sub get_regexp {
    my ($self) = @_;

    return '^\*';
}


=head2 C<get_priority>

Вернуть приоритет лексемы

=cut

sub get_priority {
    my ($self) = @_;

    # Приоритет выше дефолтного
    return 1;
}

1;