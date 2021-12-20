package Calc::BaseActor;

=head1 DESCRIPTION

Абстрактный класс для обобщающий конвертор и калькулятор
# TODO: По хорошему тут видимо надо выделять интерфейсы для 
# TODO: - сущностей со стеком вычислений, 
# TODO: - сущностей со стеком ошибок,
# TODO: - сущностей, которые работают с выражениями

=cut

use Data::Dumper;

=head2 C<_init> 

Инициализация калькулятора

=cut

sub _init {
    my ($self) = @_;

    die 'Abstract method, must be implemented';
}


=head2 C<_get_src_expression>

Вернуть объект выражения

=cut

sub _get_src_expression {
    my ($self) = @_;

    return $self->{_src_expression};
}


=head2 C<_validate_src_expression>

Валидация выражения

=cut

sub _validate_src_expression {
    my ($self) = @_;

    my $src_expression = $self->_get_src_expression();

    return 1 if $src_expression->is_valid();

    my $not_valid_lexemes = $src_expression->get_not_valid_lexemes();

    foreach (@$not_valid_lexemes) {
        $self->_add_error('Found wrong lexeme in expression: ' . $_->get_value());
    }

    return 0;
}


=head2 C<get_errors>

Получить список ошибок

=cut

sub get_errors {
    my ($self) = @_;

    return $self->{_errors};
}


=head2 C<has_errors>

Есть ли какие то ошибки в работе калькулятора?

=cut

sub has_errors {
    my ($self) = @_;

    return 1 if scalar @{$self->get_errors()};

    return 0;
}


=head2 C<_add_error>($message)

Добавить сообщение об ошибке

=cut

sub _add_error {
    my ($self, $message) = @_;

    push @{$self->{_errors}}, $message;

    return 0;
}


=head2 C<_push_to_stack>($lexeme)

Положить в стек лексему

=cut

sub _push_to_stack {
    my ($self, $lexeme) = @_;

    push @{$self->{_stack}}, $lexeme;
}


=head2 C<_pop_from_stack>

Извлечь лексему из стека

=cut

sub _pop_from_stack {
    my ($self) = @_;

    return pop @{$self->{_stack}};
}


=head2 C<_get_stack_as_string>

Получить лексемы из стека в виде строки

=cut

sub _get_stack_as_string {
    my ($self) = @_;

    my @lexeme_values_array = map { $_->get_value() } @{$self->{_stack}};
    my $lexemes_in_stack = join ', ', @lexeme_values_array;

    return $lexemes_in_stack;
}


=head2 C<_get_stack_length>

Получить длину стека

=cut

sub _get_stack_length {
    my ($self) = @_;

    return scalar @{$self->{_stack}};
}


1;
