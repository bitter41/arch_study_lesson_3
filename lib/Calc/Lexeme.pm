package Calc::Lexeme;

=head1 DESCRIPTION

Абстрактный класс представляющий лексему
# TODO: Открытая возможность расширять словарь лексем за счет добавления классов дочерних лексем

=cut

use Data::Dumper;

=head2 C<new>

Конструктор

=cut

sub new {
    my ($class, $lexeme_string) = @_;

    my $self = {
        _lexeme_string => $lexeme_string,
    };

    bless $self, $class;

    return $self;
}


=head2 C<get_regexp>

Получить регулярное выражение соответствующее лексеме

=cut

sub get_regexp {
    my ($self) = @_;

    die 'Abstract method, must be implemented';
}


=head2 C<get_type>

Вернуть тип лексемы

=cut

sub get_type {
    my ($self) = @_;

    die 'Abstract method, must be implemented';
}

=head2 C<get_priority>

Вернуть приоритет лексемы,
имеет смысл только для операторов.

=cut

sub get_priority {
    my ($self) = @_;

    die 'Lexeme not an operator, only operstors has priority';
}


=head2 C<get_value>

Вернуть значение лексемы

=cut

sub get_value {
    my ($self) = @_;

    return $self->{_lexeme_string};
}


=head2 C<is_valid>

Является ли лексема валидной?

=cut

sub is_valid {
    my ($self) = @_;

    my $lexeme_regexp = $self->get_regexp();

    return $self->get_value() =~ /$lexeme_regexp/ ? 1 : 0;
}


1;
