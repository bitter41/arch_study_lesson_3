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

1;
