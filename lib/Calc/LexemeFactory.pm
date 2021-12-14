package Calc::LexemeFactory;

=head1 DESCRIPTION

Класс представляющий фабрику по созданию лексем

=cut

use Data::Dumper;

use constant KNOWN_LEXEME_CLASSES => (
    'Calc::Lexeme::Operator::Addition',
    'Calc::Lexeme::Operator::Subtraction',
    'Calc::Lexeme::Operator::Multiplication',
    'Calc::Lexeme::Operator::Division',
    'Calc::Lexeme::Bracket::Left',
    'Calc::Lexeme::Bracket::Right',
    'Calc::Lexeme::Number',
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


=head2 C<get_known_lexemes>

Возвращает список с регулярками известных лексем

=cut

sub get_known_lexemes {
    my ($self) = @_;

    my @known_lexeme_regexps = ();
    foreach my $class (KNOWN_LEXEME_CLASSES) {
        eval("require $class");
        push @known_lexeme_regexps, $class->get_regexp();
    }

    return @known_lexeme_regexps;
}

=head2 C<create>($lexeme_string)

Создает объект лексемы

=cut

sub create {
    my ($self, $lexeme_string) = @_;

    my $lexeme_obj;

    foreach my $class (KNOWN_LEXEME_CLASSES) {
        eval("require $class");

        my $lexeme_regexp = $class->get_regexp();
        next unless $lexeme_string =~ /$lexeme_regexp/;

        $lexeme_obj = $class->new($lexeme_string);
        last;
    }

    unless ($lexeme_obj) {
        require Calc::Lexeme::Unknown;
        $lexeme_obj = Calc::Lexeme::Unknown->new($lexeme_string) ;
    }

    return $lexeme_obj;
}

1;