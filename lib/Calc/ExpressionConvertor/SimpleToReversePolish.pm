package Calc::ExpressionConvertor::SimpleToReversePolish;

=head1 DESCRIPTION

Класс конвертирующий выражение из простой нотации в обратную польскую

=cut

use Data::Dumper;

use base qw( Calc::ExpressionConvertor );

use Calc::Expression::ReversePolishNotation;
use Calc::Expression::SimpleNotation;



=head2 C<_init> 

Инициализация конвертора

=cut

sub _init {
    my ($self) = @_;

    $self->{_src_expression} = Calc::Expression::SimpleNotation->new( $self->{_src_expression_string} );
    $self->{_dst_expression} = Calc::Expression::ReversePolishNotation->new();
}


=head2 C<_convert>

Конвертировать выражение из одного формата в другой

=cut

sub _convert {
    my ($self) = @_;

    my $src_expression = $self->_get_src_expression();
    return 0 unless $src_expression->is_valid();

    foreach my $lexeme (@{$src_expression->get_lexemes()}) {
        my $lexeme_type = $lexeme->get_type();

        if ($lexeme_type eq 'number') {
            $self->get_dst_expression()->push($lexeme);
        }
        elsif ($lexeme_type eq 'operator') {
            $self->__unload_operators($lexeme);
            $self->_push_to_stack($lexeme);
        }
        elsif ($lexeme_type eq 'bracket_left') {
            $self->_push_to_stack($lexeme);
        }
        elsif ($lexeme_type eq 'bracket_right') {
            $self->__unload_stack('bracket_left');
        }
    }
    $self->__unload_stack();
    
    return 1;
}


=head2 C<__unload_stack>($stop_lexeme_type)

Выгрузить стек в выходное выражение
Опционально можно передать тип стоп лексемы, до которой будет выгружен стек

=cut

sub __unload_stack {
    my ($self, $stop_lexeme_type) = @_;

    my $stop_lexeme_found = 0;
    while (my $lexeme = $self->_pop_from_stack()) {
        if ( $stop_lexeme_type && $stop_lexeme_type eq $lexeme->get_type()) {
            $stop_lexeme_found = 1;
            last;
        }
        $self->get_dst_expression()->push($lexeme);
    }

    if ($stop_lexeme_type && !$stop_lexeme_found) {
        $self->_add_error('Seems you missed lexeme of type ' . $stop_lexeme_type);
        return 0;
    };

    return 1;
}


=head2 C<__unload_operators>($operator_lexeme)

Выгрузить операторы из стека в результрующее выражение

=cut

sub __unload_operators {
    my ($self, $operator_lexeme) = @_;

    
    return $self->_add_error('Cant unload operators by empty operator')
        unless $operator_lexeme;

    return $self->_add_error('Wrong lexeme found on unload_operators: lexeme "' . $operator_lexeme->get_value() . '" of type ' . $operator_lexeme->get_type() )
        if $operator_lexeme->get_type() ne 'operator';

    while (my $lexeme = $self->_pop_from_stack()) {
        if (
            $lexeme->get_type() ne 'operator'
            || $lexeme->get_priority() < $operator_lexeme->get_priority()
        ) {
            $self->_push_to_stack($lexeme);
            last;
        }

        $self->get_dst_expression()->push($lexeme);
    }

    return 1;
}

1;
