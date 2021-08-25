#!/usr/bin/perl

use strict;
use warnings;
use Test::More;

use AI::Perceptron::Simple;

use FindBin;
use constant MODULE_NAME => "AI::Perceptron::Simple";

my @attributes = qw ( has_trees trees_coverage_more_than_half has_other_living_things );

my $total_headers = scalar @attributes;

my $perceptron = AI::Perceptron::Simple->new( {
    initial_value => 0.01,
    attribs => \@attributes
} );

ok( AI::Perceptron::Simple->can("save_perceptron_as_YAML"), "&save_perceptron_as_YAML is persent" );
ok( AI::Perceptron::Simple->can("preserve_as_YAML"), "&preserve_as_YAML is present" );

my $yaml_nerve_file = $FindBin::Bin . "/portable_nerve.yaml";

# save file
AI::Perceptron::Simple::save_perceptron_as_YAML( $perceptron, $yaml_nerve_file );
ok( -e $yaml_nerve_file, "Found the YAML perceptron." );
# load and check
ok( my $transfered_nerve = AI::Perceptron::Simple::load_perceptron_from_YAML( $yaml_nerve_file ), "&loaded_perceptron_from_YAML" );

is_deeply( $transfered_nerve, $perceptron, "&load_perceptron_from_YAML - correct data after loading" );


# test synonyms
AI::Perceptron::Simple::preserve_as_YAML( $perceptron, $yaml_nerve_file );
ok( -e $yaml_nerve_file, "Synonym - Found the YAML perceptron." );

ok( $transfered_nerve = AI::Perceptron::Simple::revive_from_YAML( $yaml_nerve_file ), "&revive_from_YAML is working correctly" );

is_deeply( $transfered_nerve, $perceptron, "&revive_from_YAML - correct data after loading" );


done_testing();

# besiyata d'shmaya


