package Calc::Expression;

=head1 DESCRIPTION

Абстракный класс, представляющий математическое выражение

=cut

use Data::Dumper;
use Calc::LexemeFactory;

=head2 C<new>

Конструктор

=cut

sub new {
    my ($class, $expression_string) = @_;

    my $self = {
        _expression => [],
    };

    bless $self, $class;

    $self->_parse($expression_string);

    return $self;
}


=head2 C<_parse>($expression_string)

Распарсить строку на лексемы

=cut


sub _parse {
    my ($self, $expression_string) = @_;

    die 'Abstract method, must be implemented';
}


=head2 C<push>($lexeme_obj)

Поместить лексему в конец выражения

=cut

sub push {
    my ($self, $lexeme_obj) = @_;

    push @{$self->{_expression}}, $lexeme_obj;
}

=head2 C<push>($lexeme_obj)

Извлечь лексему с конца выражения

=cut

sub pop {
    my ($self) = @_;

    return pop @{$self->{_expression}};
}


1;