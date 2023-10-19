#!/usr/bin/perl

use strict;
use warnings;
use File::Find;
use List::Util qw(shuffle);

our $new_wallpaper_path = get_wallpaper_path();
our $wallpapers_ref = find_wallpapers($new_wallpaper_path);

sub get_wallpaper_path {
    my $path;

    if (@ARGV == 1) {
        $path = $ARGV[0];
    } else {
        $path = $ENV{"WALLPAPER_PATH"};
    }

    die "Error: You need to define your wallpapers folder via environment variables or passing it as an argument\n" unless (defined $path);
    die "Error: $path doesn't exist\n" unless (-e $path);

    return $path;
}

sub find_wallpapers {
    my $path = shift;

    my @wallpapers;

    find(
        sub {
            push @wallpapers, $File::Find::name if -f && /\.(jpg|png|jpeg|gif)$/i;
        },
        $path
    );

    return \@wallpapers;
}

sub get_current_wallpaper {
    my $current_wallpaper = `gsettings get org.gnome.desktop.background picture-uri`;
    chomp($current_wallpaper);

    return $current_wallpaper;
} 

sub set_wallpaper {
    my $random_image = shift;
    my $current_wallpaper = get_current_wallpaper();

    while ($random_image eq $current_wallpaper) {
        $random_image = (shuffle @$wallpapers_ref)[0];
    }

    my $theme = `gsettings get org.gnome.desktop.interface gtk-theme`;
    chomp($theme);

    my $cmd;

    if ($theme =~ /dark/) {
        $cmd = "gsettings set org.gnome.desktop.background picture-uri-dark 'file://$random_image'";
    } else {
        $cmd = "gsettings set org.gnome.desktop.background picture-uri 'file://$random_image'";
    }

    system($cmd);
}

if (@$wallpapers_ref) {
    my $random_image = (shuffle @$wallpapers_ref)[0];

    set_wallpaper($random_image);
}
