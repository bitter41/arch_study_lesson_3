package Calc::Calculator;

=head1 DESCRIPTION

Абстрактный класс калькулятора
# TODO: Открытая возможность научить приложение вычислять значение выражений разного формата
# TODO: За счет реализации дочерних классов калькулятора

=cut

use Data::Dumper;

use base qw ( Calc::BaseActor );



=head2 C<new>

Конструктор

=cut

sub new {
    my ($class, $expression_string, $params) = @_;

    my $self = {
        _src_expression_string => $expression_string,
        _src_expression        => undef,
        _stack                 => [],
        _errors                => [],
        _result                => undef,
        _debug_mode            => delete $params->{debug_mode} || 0,
    };

    bless $self, $class;

    $self->_init();
    $self->_validate_src_expression();
    $self->_calc();

    return $self;
}

=head2 C<_calc> 

Вычисление результата выражения

=cut

sub _calc {
    my ($self) = @_;

    die 'Abstract method, must be implemented';
}


=head2 C<get_result> 

Возврат реузультата вычисления

=cut

sub get_result {
    my ($self) = @_;

    return unless $self->{_result};
    return $self->{_result}->get_value();
}


=head2 C<is_debug_enabled> 

Включен ли режим дебага

=cut

sub is_debug_enabled {
    my ($self) = @_;

    return $self->{_debug_mode};
}


1;
