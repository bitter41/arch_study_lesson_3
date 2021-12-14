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
    $self->__validate();
    return $self      if $self->has_errors();
    $self->_convert() if $expression_string;

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

=head2 C<__get_src_expression>

Вернуть объект исходного выражения

=cut

sub __get_src_expression {
    my ($self) = @_;

    return $self->{_src_expression};
}

=head2 C<__validate>

Валидация состояния объекта после инициализации

=cut

sub __validate {
    my ($self) = @_;

    my $src_expression = $self->__get_src_expression();

    return 1 if $src_expression->is_valid();

    my $not_valid_lexemes = $src_expression->get_not_valid_lexemes();

    foreach (@$not_valid_lexemes) {
        push @{$self->{_errors}}, {
            lexeme      => $_,
            description => 'Found wrong lexeme in expression: ' . $_->get_value(),
        };
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

Есть ли какие то ошибки в работе конвертора?

=cut

sub has_errors {
    my ($self) = @_;

    return 1 if scalar @{$self->get_errors()};

    return 0;
}

1;
