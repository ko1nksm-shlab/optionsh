# option.sh

Option parse code for POSIX-compliant shell scripts that high function and short.

**⚠️ No maintenance anymore.** Use the [getoptions - An elegant option parser for shell scripts (sh, bash, zsh and all POSIX shells)](https://github.com/ko1nksm/getoptions).

## Sample

Implements step by step.

* option1.sh: Supports flag option and parameters only
* option2.sh: Supports option argument
* option3.sh: Supports a mixture of options and operands
* option4.sh: Stop option parsing with --
* option5.sh: Supports combined short options
* option6.sh: Supports combined option and argument
* option7.sh: Supports optional option argument
* option8.sh: Inverse flag option with +, --no-

Note: This sample reuses the `OPTIND` and `OPTARG` variables for other purposes.

[Explanation](https://qiita.com/ko1nksm/items/7d37852b9fc581b1266e) is in Japanese only, sorry.

## Test

Tested by [shellspec](https://github.com/shellspec/shellspec).

## License

Unlicense. Feel free to use it.
