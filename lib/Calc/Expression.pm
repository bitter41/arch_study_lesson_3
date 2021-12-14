package Calc::Expression;

=head1 DESCRIPTION

Абстракный класс, представляющий математическое выражение
# TODO: Открытая возможность расширять приложение по кол-ву нотаций, которое приложение может распознавать
# TODO: За счет реализации дочерних классов выражений

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

    $self->_parse($expression_string) if $expression_string;

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

    push @{$self->get_lexemes()}, $lexeme_obj;
}


=head2 C<push>($lexeme_obj)

Извлечь лексему с конца выражения

=cut

sub pop {
    my ($self) = @_;

    return pop @{$self->get_lexemes()};
}


=head2 C<get_lexemes>

Получить выражение в виде списка лексем

=cut

sub get_lexemes {
    my ($self) = @_;

    return $self->{_expression};
}

=head2 C<get_as_string>

Получить выражение в виде строки

=cut

sub get_as_string {
    my ($self) = @_;

    my $expression = '';
    foreach (@{$self->get_lexemes()}) {
        $expression .= $_->get_value();
    }

    return $expression;
}


=head2 C<get_not_valid_lexemes>

Получить список невалидных лексем

=cut

sub get_not_valid_lexemes {
    my ($self) = @_;

    my @not_valid_lexemes = grep { !$_->is_valid() } @{$self->get_lexemes()};

    return \@not_valid_lexemes;
}


=head2 C<is_valid>

Валидно ли выражение?

=cut

sub is_valid {
    my ($self) = @_;

    my $not_valid_lexemes = $self->get_not_valid_lexemes();
    
    return 0 if scalar @$not_valid_lexemes > 0;

    return 1;
}


1;