# package-installer

This Bash script reads a file with a list of packages and installs them on a Debian based system.

## Usage

Use the instructions below to download and run the script. Feel free to fork or copy them, but be aware of the limitations that this repository license implies.

### Download the script

Use the command below to download the script to your computer:

```
curl -o package-installer.sh https://raw.githubusercontent.com/olooeez/useful-scripts/main/debian/package-installer/package-installer.sh
```

If you don't have curl installed, you can use wget to do the same thing, using the command below:

```
wget -O package-installer.sh https://raw.githubusercontent.com/olooeez/useful-scripts/main/debian/package-installer/package-installer.sh
```

### Make the script executable

To make the script executable, use the command bellow:

```
chmod +x package-installer.sh
```

### Create a package.txt file

Create a package.txt file, like [this one](https://raw.githubusercontent.com/olooeez/useful-scripts/main/debian/package-installer/packages.txt), to select the packages you want to install.

### Run the script

Finally, run the script with the command below:

```
./package-installer.sh
```

## Contributing

If you would like to contribute to this project, please feel free to open a pull request. All contributions are welcome!

## License

This project is licensed under the [MIT](https://github.com/olooeez/useful-scripts/blob/main/LICENSE) License. See the LICENSE file for details.
