# clone-repos

This script allows you to clone all of the repositories belonging to a specific user on GitHub. You can choose to clone the repositories using either HTTP or SSH.

## Requirements

- curl
- git

## Usage

1. Download or clone the script.
2. Make the script executable by running `chmod +x clone-repos.sh`.
3. Run the script with `./clone-repos.sh`.
4. Follow the prompts to enter your GitHub username and choose the cloning protocol (HTTP or SSH).
5. The repositories will be cloned into a new directory with the name `{username}-repos`. If the directory already exists, you will be prompted to overwrite it or cancel the operation.

## Contributing

If you have suggestions for improvements or want to report a bug, please open an issue or a pull request.

## License

This script is licensed under the MIT License. See the [LICENSE](https://github.com/olooeez/useful-scripts/blob/main/LICENSE) file for details.
