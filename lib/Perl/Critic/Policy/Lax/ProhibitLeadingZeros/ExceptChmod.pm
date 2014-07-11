use strict;
use warnings;
package Perl::Critic::Policy::Lax::ProhibitLeadingZeros::ExceptChmod;
# ABSTRACT: leading zeroes are okay as the first arg to chmod
$Perl::Critic::Policy::Lax::ProhibitLeadingZeros::ExceptChmod::VERSION = '0.011';
#pod =head1 DESCRIPTION
#pod
#pod This is a stupid mistake:
#pod
#pod   my $x = 1231;
#pod   my $y = 2345;
#pod   my $z = 0032;
#pod
#pod This is not:
#pod
#pod   chmod 0600, "secret_file.txt";
#pod
#pod =cut

use Perl::Critic::Utils;
use parent qw(Perl::Critic::Policy);

my $DESCRIPTION = q{Integer with leading zeros outside of chmod};
my $EXPLANATION = "Only use leading zeros on numbers indicating file modes";

sub default_severity { $SEVERITY_MEDIUM     }
sub default_themes   { qw(lax bugs)         }
sub applies_to       { 'PPI::Token::Number' }

my $LEADING_ZERO_RE = qr{\A [+-]? (?: 0+ _* )+ [1-9]}mx;

sub violates {
  my ($self, $element, undef) = @_;

  return unless $element =~ $LEADING_ZERO_RE;
  return if $element->sprevious_sibling eq 'chmod';

  my $working = eval { $element->parent->parent };
  if ($element->parent->isa('PPI::Statement::Expression')) {
    my $working = $element->parent->parent;
    while (eval { $working->isa('PPI::Structure::List') }) {
      $working = $working->parent;
    }

    return if $working and ($working->children)[0] eq 'chmod';
  }

  return $self->violation($DESCRIPTION, $EXPLANATION, $element);
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Perl::Critic::Policy::Lax::ProhibitLeadingZeros::ExceptChmod - leading zeroes are okay as the first arg to chmod

=head1 VERSION

version 0.011

=head1 DESCRIPTION

This is a stupid mistake:

  my $x = 1231;
  my $y = 2345;
  my $z = 0032;

This is not:

  chmod 0600, "secret_file.txt";

=head1 AUTHOR

Ricardo Signes <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Ricardo Signes <rjbs@cpan.org>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
