# $Id$

package BeerFestDB::Dumper::Template;

use 5.008;

use strict; 
use warnings;

use Moose;

use Carp;
use Scalar::Util qw(looks_like_number);
use Template;
use POSIX qw(ceil);

our $VERSION = '0.01';

extends 'BeerFestDB::Dumper';

has 'template'   => ( is       => 'ro',
                      isa      => 'Str',
                      required => 1 );

has 'filehandle' => ( is       => 'ro',
                      isa      => 'FileHandle',
                      required => 1,
                      default  => sub { \*STDOUT } );

has 'logos'      => ( is       => 'ro',
                      isa      => 'ArrayRef',
                      required => 1,
                      default  => sub { [] } );

sub dump {

    my ( $self, $casks ) = @_;

    unless ( $casks ) {
        $casks = $self->select_festival_casks();
        $casks = $self->unique_casks( $casks );
    }

    # N.B. Changes here need to be documented in the POD.
    my @caskinfo;
    foreach my $cask ( @$casks ) {
        my %caskdata;
	$caskdata{brewery} = $cask->gyle_id()->company_id()->name();
	$caskdata{beer}    = $cask->gyle_id()->product_id()->name();
	$caskdata{abv}     = $cask->gyle_id()->abv();

        $caskdata{sale_volume} = $cask->sale_volume_id()->sale_volume_description();

        my $currency = $cask->currency_code();
        my $format   = $currency->currency_format();
        $caskdata{currency} = $currency->currency_symbol();

	$caskdata{price}   = $self->format_price( $cask->sale_price(), $format );
        if ( looks_like_number( $caskdata{price} ) ) {
            $caskdata{half_price} = $self->format_price( ceil($cask->sale_price() / 2), $format );
        }
        else {
            $caskdata{half_price} = $caskdata{price};
        }

        push @caskinfo, \%caskdata;
    }

    my $vars = {
        logos => $self->logos(),
        casks => \@caskinfo,
    };

    my $template = Template->new()
        or die( "Cannot create Template object: " . Template->error() );

    $template->process($self->template(), $vars, $self->filehandle() )
        or die( "Template processing error: " . $template->error() );

    return;
}

1;
__END__

=head1 NAME

BeerFestDB::Dumper::Template - Export data via Template Toolkit

=head1 SYNOPSIS

 use BeerFestDB::Dumper::Template;
 
 # $rs is a DBIx::Class::ResultSet; @logos is an array of image file names.
 my $t = BeerFestDB::Dumper::Template->new( template => 'template.tt2',
                                            logos    => \@logos );
 $t->dump( $rs );

=head1 DESCRIPTION

This module describes a Moose class which can be used to process Cask
resultsets through a given Template Toolkit template. This can be used
to generate cask-end signs, HTML listings of the available beers,
conceivably even a full beer festival programme.

=head2 DETAILS

Currently the script defines the following variables which may be
referenced in the template:

=over 2

=item casks

A list of cask hashrefs, each of which has the following keys:

=over 2

=item brewery

=item beer

=item abv

=item currency

=item price

=item half_price

=item sale_volume

=back

=item logos

An arrayref containing the names of image files which can be
referenced in the template to place logos etc.

=back

=head2 OPTIONS

=over 2

=item template

=item filehandle

=item logos

=back

=head2 EXPORT

None by default.

=head1 SEE ALSO

L<BeerFestDB::Dumper>, L<BeerFestDB::Dumper::OODoc>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Tim F. Rayner

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=head1 BUGS

Probably.

=cut
