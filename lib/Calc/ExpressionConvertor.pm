package Calc::ExpressionConvertor;

=head1 DESCRIPTION

Абстрактный класс конвертора выражений из одного формата в другой
# TODO: Открытая возможность научить приложение конвертировать разные известные форматы/нотации выражений в другие известные
# TODO: За счет реализации дочерних классов конверторов

=cut

use Data::Dumper;

use base qw ( Calc::BaseActor );


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
    $self->_validate_src_expression();
    return $self      if $self->has_errors();
    $self->_convert() if $expression_string;
    $self->__validate_dst_expression();

    return $self;
}


=head2 C<_convert>

Конвертировать выражение из одного формата в другой

=cut

sub _convert {
    my ($self) = @_;

    die 'Abstract method, must be implemented';
}


=head2 C<get_dst_expression>

Вернуть объект результирующего выражения

=cut

sub get_dst_expression {
    my ($self) = @_;

    return $self->{_dst_expression};
}


=head2 C<__validate_dst_expression>

Валидация результирующего выражения

=cut

sub __validate_dst_expression {
    my ($self) = @_;

    my $dst_expression = $self->get_dst_expression();
    
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


1;
