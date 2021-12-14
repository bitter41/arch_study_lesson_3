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

    my $self = {};

    bless $self, $class;

    $self->_parse($expression_string);

    return $self;
}

=head2 C<_parse>($expression_string)

Распарсить строку на лексемы

=cut


sub _parse {
    my ($self, $expression_string) = @_;

    die 'Abstract methon, must be implemented';
}

1;