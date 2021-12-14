package Calc::ExpressionConvertor;

=head1 DESCRIPTION

Абстрактный класс конвертора выражений из одного формата в другой
# TODO: Открытая возможность научить приложение конвертировать разные известные форматы/нотации выражений в другие известные
# TODO: За счет реализации дочерних классов конверторов

=cut

use Data::Dumper;


=head2 C<new>

Конструктор

=cut

sub new {
    my ($class, $expression_string) = @_;

    my $self = {
        _src_expression_string => $expression_string,
        _src_expression        => undef,
        _stack                 => [],
        _dst_expression        => undef,
        _errors                => [],
    };

    bless $self, $class;

    $self->_init();
    $self->__validate_src_expression();
    return $self      if $self->has_errors();
    $self->_convert() if $expression_string;
    $self->__validate_dst_expression();

    return $self;
}


=head2 C<_init> 

Инициализация конвертора

=cut

sub _init {
    my ($self) = @_;

    die 'Abstract method, must be implemented';
}


=head2 C<_convert>

Конвертировать выражение из одного формата в другой

=cut

sub _convert {
    my ($self) = @_;

    die 'Abstract method, must be implemented';
}


=head2 C<_get_src_expression>

Вернуть объект исходного выражения

=cut

sub _get_src_expression {
    my ($self) = @_;

    return $self->{_src_expression};
}


=head2 C<_get_dst_expression>

Вернуть объект результирующего выражения

=cut

sub _get_dst_expression {
    my ($self) = @_;

    return $self->{_dst_expression};
}


=head2 C<__validate_src_expression>

Валидация исходного выражения

=cut

sub __validate_src_expression {
    my ($self) = @_;

    my $src_expression = $self->_get_src_expression();

    return 1 if $src_expression->is_valid();

    my $not_valid_lexemes = $src_expression->get_not_valid_lexemes();

    foreach (@$not_valid_lexemes) {
        $self->_add_error('Found wrong lexeme in expression: ' . $_->get_value());
    }

    return 0;
}


=head2 C<__validate_dst_expression>

Валидация результирующего выражения

=cut

sub __validate_dst_expression {
    my ($self) = @_;

    my $dst_expression = $self->_get_dst_expression();
    
    return 1 if $dst_expression->is_valid() && !$self->has_errors();

    my $not_valid_lexemes = $dst_expression->get_not_valid_lexemes();

    foreach my $lexeme (@$not_valid_lexemes) {
        if ($lexeme->get_type() eq 'bracket_left') {
            $self->_add_error('Seems you missed close bracket lexeme in dst expression, because found lexeme: ' . $lexeme->get_value());
        }
        else {
            $self->_add_error('Found wrong lexeme in dst expression: ' . $lexeme->get_value());
        }
    }

    $dst_expression->clear() if $self->has_errors();
    
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

Есть ли какие то ошибки в работе конвертора?

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

Извлечь лексему из стка

=cut

sub _pop_from_stack {
    my ($self) = @_;

    return pop @{$self->{_stack}};
}

1;
