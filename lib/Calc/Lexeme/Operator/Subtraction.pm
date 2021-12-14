package Calc::Lexeme::Operator::Subtraction;

=head1 DESCRIPTION

Класс представляющий лексему операции вычитания

=cut


use base qw( Calc::Lexeme::Operator );


=head2 C<get_regexp>

Получить регулярное выражение соответствующее лексеме

=cut

sub get_regexp {
    my ($self) = @_;

    return '^-';
}

1;
