# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

#
asdf plugin test wasi-sdk https://github.com/coolreader18/asdf-wasi-sdk.git "wasicc --version"
```

Tests are automatically run in GitHub Actions on push and PR.
