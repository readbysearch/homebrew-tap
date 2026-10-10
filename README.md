# homebrew-code2pdf

Homebrew formula for [code2pdf](https://github.com/readbysearch/code2pdf) - A tool for converting source code to PDF with syntax highlighting.

## Installation

```bash
# Add this tap
brew tap readbysearch/code2pdf

# Install code2pdf
brew install code2pdf
```

Or in one step: `brew install readbysearch/code2pdf/code2pdf`. This installs both `code2pdf` and `code2txt`.

## Dependencies

Everything is installed automatically; no `pip install` needed:
- Python 3.14 with Pygments (syntax highlighting) and WeasyPrint (HTML → PDF), in a private virtualenv
- pango (text layout, including Chinese/Japanese/Korean)
- ghostscript (PDF merging)
- jq (JSON processing)

## Updating

To update to the latest version:
```bash
brew update
brew upgrade code2pdf
```

## Troubleshooting

If you encounter any issues with installation:

1. First, try running:
```bash
brew doctor
```

2. If problems persist, you can try:
```bash
brew uninstall code2pdf
brew untap readbysearch/code2pdf
brew tap readbysearch/code2pdf
brew install code2pdf
```

3. If you still have issues, please [open an issue](https://github.com/readbysearch/homebrew-code2pdf/issues) in this repository.

## Contributing

If you find any issues with the formula, please [open an issue](https://github.com/readbysearch/homebrew-code2pdf/issues) or submit a pull request.

For issues with the code2pdf tool itself, please visit the [main repository](https://github.com/readbysearch/code2pdf).

## License

This project is licensed under the GNU Affero General Public License v3.0 (AGPL-3.0).

- For commercial use, please [open a GitHub issue](https://github.com/readbysearch/code2pdf/issues) to discuss licensing options
- For non-commercial use, you must comply with AGPL-3.0 terms
