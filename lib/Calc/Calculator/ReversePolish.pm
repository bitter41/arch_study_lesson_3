package Calc::Calculator::ReversePolish;

=head1 DESCRIPTION

Класс калькулятора, вычисляющего выражения в обратной польской нотации

=cut

use Data::Dumper;

use base qw ( Calc::Calculator );

use Calc::Expression::ReversePolishNotation;


=head2 C<_init> 

Инициализация калькулятора

=cut

sub _init {
    my ($self) = @_;

    $self->{_src_expression} = Calc::Expression::ReversePolishNotation->new( $self->{_src_expression_string} );
}


=head2 C<_calc> 

Вычисление результата выражения

=cut

sub _calc {
    my ($self) = @_;

    print "lexeme\tstack\n" if $self->is_debug_enabled();

    my $lexeme_factory = Calc::LexemeFactory->new();

    foreach my $lexeme (@{ $self->_get_src_expression()->get_lexemes() }) {
        my $lexeme_type = $lexeme->get_type();

        if ($lexeme_type eq 'number') {
            $self->_push_to_stack($lexeme);
        }
        elsif ($lexeme_type eq 'operator') {
            my $operator                = $lexeme->get_value();
            my $number_lexeme_right     = $self->_pop_from_stack()->get_value();
            my $number_lexeme_obj_left  = $self->_pop_from_stack();

            unless ($number_lexeme_obj_left) {
                $self->_add_error("Not found second operand while doing operation \'$operator\' with operand \'$number_lexeme_right\'");
                return;                
            }
            my $number_lexeme_left  = $number_lexeme_obj_left->get_value();

            my $result_of_operation = eval("$number_lexeme_left $operator $number_lexeme_right");

            if (defined $result_of_operation) {
                my $result_lexeme = $lexeme_factory->create($result_of_operation);
                $self->_push_to_stack($result_lexeme);
            }
            else {
                $self->_add_error("Something wrong while doing operation \'$operator\' with operands: \'$number_lexeme_left\' and \'$number_lexeme_right\'");
                return;
            }
        }
        print $lexeme->get_value() . "\t" . $self->_get_stack_as_string() . "\n" if $self->is_debug_enabled();
    }

    if ($self->_get_stack_length() > 1) {
        $self->_add_error('Something wrong with expression, have some unused lexemes in stack: ' . $self->_get_stack_as_string());
        return;
    };

    $self->{_result} = $self->_pop_from_stack();
}


1;
