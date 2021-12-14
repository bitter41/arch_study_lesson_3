package Calc::LexemeFactory;

=head1 DESCRIPTION

Класс представляющий фабрику по созданию лексем

=cut

use Data::Dumper;

use constant KNOWN_LEXEMES => (
    '^\+'  => 'Calc::Lexeme::Operator',    # +
    '^-'   => 'Calc::Lexeme::Operator',    # -
    '^\*'  => 'Calc::Lexeme::Operator',    # *
    '^\/'  => 'Calc::Lexeme::Operator',    # /
    '^\('  => 'Calc::Lexeme::Bracket',     # (
    '^\)'  => 'Calc::Lexeme::Bracket',     # )
    '^\d+' => 'Calc::Lexeme::Number',      # number of any digits
);

=head2 C<new>

Конструктор

=cut

sub new {
    my ($class) = @_;

    my $self = {};

    bless $self, $class;

    return $self;
}

sub get_known_lexemes {
    my ($self) = @_;

    return KNOWN_LEXEMES;
}

1;