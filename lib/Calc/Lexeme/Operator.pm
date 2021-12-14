package Calc::Lexeme::Operator;

=head1 DESCRIPTION

Класс представляющий лексему математической операции

=cut

use Data::Dumper;

use base qw( Calc::Lexeme );


=head2 C<get_type>

Вернуть тип лексемы

=cut

sub get_type { 'operator' }


=head2 C<get_priority>

Вернуть приоритет лексемы

=cut

sub get_priority {
    my ($self) = @_;

    # По умолчанию - самый низкий приоритет
    return 0;
}

1;
