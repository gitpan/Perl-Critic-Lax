use strict;
use warnings;
package Perl::Critic::Lax;
{
  $Perl::Critic::Lax::VERSION = '0.009';
}
# ABSTRACT: policies that let you slide on common exceptions


1;

__END__
=pod

=head1 NAME

Perl::Critic::Lax - policies that let you slide on common exceptions

=head1 VERSION

version 0.009

=head1 DESCRIPTION

The Perl-Critic-Lax distribution includes versions of core Perl::Critic modules
with built-in exceptions.  If you really like a Perl::Critic policy, but find
that you often violate it in a specific way that seems pretty darn reasonable,
maybe there's a Lax policy.  If there isn't, send one in!

=head1 AUTHOR

Ricardo Signes <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Ricardo Signes <rjbs@cpan.org>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

