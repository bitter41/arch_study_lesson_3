package Calc::Lexeme::Unknown;

=head1 DESCRIPTION

Класс представляющий неизвестную для калькулятора лексему

=cut

use base qw( Calc::Lexeme );


=head2 C<get_regexp>

Получить регулярное выражение соответствующее лексеме

=cut

sub get_regexp {
    my ($self) = @_;

    return '^.';
}

=head2 C<get_type>

Вернуть тип лексемы

=cut

sub get_type { 'unknown' }

=head2 C<is_valid>

Является ли лексема валидной?

=cut

sub is_valid { 0 }

1;