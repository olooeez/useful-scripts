# gamer-runner

The gamer-runner is a tool I developed with the purpose of providing enjoyable moments with my friends during my monitoring activities, when there were not many participants at times. It was created in Perl and its function is to automate the installation and execution of various games in the Ubuntu environment of the college while also setting up a local network (LAN) server to allow other players on the same network to connect, enabling joint gaming.

## Prerequisites

Before using the gamer-runner, it is essential to check if your machine meets the following prerequisites:

1. **Ubuntu System**: The script has been meticulously designed to operate in the Ubuntu environment. Ensure that you are using an Ubuntu distribution on your system.

2. **Perl**: Perl is the scripting language used by gamer-runner to automate the installation and configuration of games. To ensure that Perl is installed on your machine, run the following command in the terminal:

```
perl --version
```

If Perl is not present, you can install it with the following command:

```
sudo apt-get install perl
```

3. **Network Connectivity**: Ensure that your machine is connected to a local network (LAN) to allow other players to connect to the server created by the script.

The following steps outline how to install and use gamer-runner:

### Step 1: Obtain the Script

Download the script to your machine using the following command:

```
wget https://raw.githubusercontent.com/olooeez/useful-scripts/main/games/gamer-runner/gamer-runner.pl
```

### Step 2: Execute the Script

Run the gamer-runner with the following command:

```
sudo perl gamer-runner.pl --help
```

The script provides a variety of commands and subcommands. The following commands are particularly useful:

1. Install a game and start the client:

```
sudo perl gamer-runner.pl --install --client
```

2. Install a game and start the server:

```
sudo perl gamer-runner.pl --install --server
```

3. Uninstall a game:

```
sudo perl gamer-runner.pl --uninstall
```

### Step 3: Remove the Script

To delete the script, use the following command:

```
rm gamer-runner.pl
```

## Contributing

If you are interested in contributing to enhance this project, please feel free to open a pull request. We are open to all forms of collaboration!

## License

Finally, I emphasize that this script is available under the [MIT License](https://github.com/olooeez/useful-scripts/blob/main/LICENSE). For additional information, please refer to the LICENSE file.
