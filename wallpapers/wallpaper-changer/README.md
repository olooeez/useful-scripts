# wallpaper-changer

This Perl script is designed to change your desktop wallpaper in a GNOME environment by randomly selecting an image from a specified folder. It ensures that the wallpaper is not changed to the current wallpaper to avoid unnecessary updates.

## Usage

Follow the steps below to use the script:

### Prerequisites

Make sure you have Perl installed on your system. Additionally, this script is designed for GNOME desktop environments. 

### Download the script

You can download the Perl script to your computer using the following command:

```
curl -o wallpaper-changer.pl https://raw.githubusercontent.com/olooeez/useful-scripts/master/wallpapers/wallpaper-changer/wallpaper-changer.pl
```

If you prefer using `wget`, you can use the following command:

```
wget -O wallpaper-changer.pl https://raw.githubusercontent.com/olooeez/useful-scripts/master/wallpapers/wallpaper-changer/wallpaper-changer.pl
```

### Make the script executable

Before running the script, make it executable with the following command:

```
chmod +x wallpaper-changer.pl
```

### Run the script

To change your wallpaper, execute the script with:

```
./wallpaper-changer.pl
```

The script will select a random image from the specified folder as your wallpaper.

## Customization

You can customize the script by modifying the accepted file extensions and the gsettings schema used for changing the wallpaper.

## Contributing

If you want to contribute to this project, please feel free to open a pull request. All contributions are welcome!

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
