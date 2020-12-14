<div align="center">

# asdf-wasi-sdk ![Build](https://github.com/coolreader18/asdf-wasi-sdk/workflows/Build/badge.svg) ![Lint](https://github.com/coolreader18/asdf-wasi-sdk/workflows/Lint/badge.svg)

[wasi-sdk](https://github.com/WebAssembly/wasi-sdk) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Why?](#why)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`: generic POSIX utilities.
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add wasi-sdk
# or
asdf plugin add https://github.com/coolreader18/asdf-wasi-sdk.git
```

wasi-sdk:

```shell
# Show all installable versions
asdf list-all wasi-sdk

# Install specific version
asdf install wasi-sdk latest

# Set a version globally (on your ~/.tool-versions file)
asdf global wasi-sdk latest

# Now wasi-sdk commands are available
wasicc --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/coolreader18/asdf-wasi-sdk/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Noah](https://github.com/coolreader18/)
