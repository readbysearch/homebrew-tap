# readbysearch/homebrew-tap

Homebrew formulae from readbysearch. Currently:

- [code2pdf](https://github.com/readbysearch/code2pdf) — print source code to PDF: syntax highlighting, a contents page, bundled IBM Plex fonts, colour or black & white themes, CJK support (also installs `code2txt`)

## Installation

```bash
brew install readbysearch/tap/code2pdf
```

Or tap once, then use short names:

```bash
brew tap readbysearch/tap
brew install code2pdf
```

### Moving from the old `readbysearch/code2pdf` tap

This repository used to be `readbysearch/homebrew-code2pdf`. The old tap keeps working through GitHub's redirect, but to switch to the new name:

```bash
brew uninstall code2pdf
brew untap readbysearch/code2pdf
brew install readbysearch/tap/code2pdf
```

## Dependencies

Everything is installed automatically; no `pip install` needed:
- Python 3.14 with Pygments (syntax highlighting), WeasyPrint (HTML → PDF) and pypdf (joining big documents rendered in parts), in a private virtualenv
- pango (text layout, including Chinese/Japanese/Korean)

## Updating

To update to the latest version:
```bash
brew update
brew upgrade code2pdf
```

## Troubleshooting

If you encounter any issues with installation:

- **`A brew install ... process has already locked ...`**: Homebrew tripped over its own lock while upgrading shared dependencies. Run `brew install readbysearch/tap/code2pdf` again; the second run continues where the first stopped.
- **`Could not symlink ... site-packages/pycparser`** (or another Python package): something was `pip install`ed into Homebrew's Python. code2pdf still works; to let Homebrew take over those files, run `brew link --overwrite pycparser`.

1. First, try running:
```bash
brew doctor
```

2. If problems persist, you can try:
```bash
brew uninstall code2pdf
brew untap readbysearch/tap
brew install readbysearch/tap/code2pdf
```

3. If you still have issues, please [open an issue](https://github.com/readbysearch/homebrew-tap/issues) in this repository.

## Contributing

If you find any issues with the formula, please [open an issue](https://github.com/readbysearch/homebrew-tap/issues) or submit a pull request.

For issues with the code2pdf tool itself, please visit the [main repository](https://github.com/readbysearch/code2pdf).

## License

This project is licensed under the GNU Affero General Public License v3.0 (AGPL-3.0).

- For commercial use, please [open a GitHub issue](https://github.com/readbysearch/code2pdf/issues) to discuss licensing options
- For non-commercial use, you must comply with AGPL-3.0 terms
