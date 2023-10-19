#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Term::ANSIColor qw(:constants);

my @supported_games = qw/assaultcube openarena minetest/;

sub print_help {
    say "Usage: $0 [--help | -h] (--install | -i | --uninstall | -d) [--client | --server] [GAME_NAME]";
    say "\nSupported games: " . join(', ', @supported_games);
    exit 0;
}

sub yellow_string {
    my ($message) = @_;
    return BOLD . YELLOW . $message . RESET;
}

sub green_string {
    my ($message) = @_;
    return BOLD . GREEN . $message . RESET;
}

sub red_string {
    my ($message) = @_;
    return BOLD . RED . $message . RESET;
}

sub install_game {
    my ($game) = @_;

    die red_string("Error: Game '$game' not supported"), "\n" unless grep { $_ eq $game } @supported_games;

    say yellow_string("[Installing the game $game]");

    my $result = system "apt-get install -y $game";

    if ($result == 0) {
        say green_string("[Game $game installed]");
    } else {
        say red_string("Error: Unable to install the game $game");
    }
}

sub uninstall_game {
    my ($game) = @_;

    say yellow_string("[Uninstalling the game $game]");

    my $result = system "apt-get purge -y $game && apt-get autoremove -y --purge";

    if ($result == 0) {
        say green_string("[Game $game uninstalled]");
    } else {
        say red_string("[Error uninstalling the game $game]");
    }
}

sub select_game {
    say BOLD, "Select the game to install/uninstall:", RESET;

    for my $i (0 .. $#supported_games) {
        say green_string("$i. "), $supported_games[$i];
    }

    say BOLD, "Enter the game number you want to select (or 'q' to quit):", RESET;

    while (1) {
        my $input = <STDIN>;
        chomp $input;

        if ($input eq 'q') {
            last;
        } elsif ($input =~ /^\d+$/ && $input >= 0 && $input <= $#supported_games) {
            my $selected_game = $supported_games[$input];
            say BOLD, "Selected game: $selected_game", RESET;
            return $selected_game;
        } else {
            say red_string("Error: Invalid option. Enter the game number or 'q' to quit:");
        }
    }
}

sub run_server {
    my ($selected_game) = @_;

    my %game_server = (
        "assaultcube" => "/usr/games/assaultcube-server",
        "minetest" => "/usr/games/minetest --server --gameid minetest --worldname world"
    );

    my $server_command = $game_server{$selected_game};

    die red_string("Error: Unrecognized game server") if (!$server_command);

    say yellow_string("[Starting the server for $selected_game]");

    system $server_command;
    say red_string("[Stopping the server for $selected_game]");
}

sub run_client {
    my ($selected_game) = @_;

    my %game_client = (
        "assaultcube" => "/usr/games/assaultcube",
        "minetest" => "/usr/games/minetest"
    );

    my $client_command = $game_client{$selected_game};

    die red_string("Error: Unrecognized game server") if (!$client_command);

    say yellow_string("[Starting the $selected_game client]");
    system $client_command;
    say yellow_string("[Stopping the client for $selected_game]");
}

sub main {
    my ($help, $install, $uninstall, $client, $server);

    GetOptions(
        "help|h" => \$help,
        "install|i" => \$install,
        "uninstall|d" => \$uninstall,
        "client|c" => \$client,
        "server|s" => \$server,
    );

    print_help() if ($help);

    die red_string("Error: You must choose between --install and --uninstall"), "\n" unless ($install xor $uninstall);

    my $selected_game = shift @ARGV;

    if ($install) {
        die red_string("Error: Choose --client or --server for installation"), "\n" if ($client && $server);

        $selected_game = select_game() unless $selected_game;

        install_game($selected_game);

        if ($client) {
            run_client($selected_game);
        } elsif ($server) {
            run_server($selected_game);
        }
    } elsif ($uninstall) {
        die red_string("Error: You cannot choose --client or --server for uninstallation"), "\n" if ($client || $server);

        $selected_game = select_game() unless $selected_game;

        uninstall_game($selected_game);
    }
}

main();
