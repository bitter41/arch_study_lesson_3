package Calc::Lexeme::Number;

=head1 DESCRIPTION

Класс представляющий числовую лексему

=cut

use base qw( Calc::Lexeme );


=head2 C<get_regexp>

Получить регулярное выражение соответствующее лексеме

=cut

sub get_regexp {
    my ($self) = @_;

    return '^\d+';
}

=head2 C<get_type>

Вернуть тип лексемы

=cut

sub get_type { 'number' }

1;
