# Releasing code2pdf

## 1. In readbysearch/code2pdf

```bash
# Run the tests on macOS, and on an exact replica of the CI checkout (Ubuntu's own packages)
.venv/bin/pytest -q
git archive HEAD | tar -xf - -C /tmp/ci          # then run pytest in ubuntu:24.04 / 26.04 containers,
                                                # started as GitHub does: docker run -d ... tail -f /dev/null,
                                                # then docker exec (its PID 1 never reaps orphans)

# If selection, help text or messages changed: the Haiku pass of the agent eval (see CLAUDE.md)

# Set the plugin's version to the release (installed skills only update when it changes)
#   plugins/code2pdf/.claude-plugin/plugin.json: "version": "X.Y.0"

git push origin main
git tag -a vX.Y -m "vX.Y: what changed"       # vX.Y for new features, vX.Y.Z for fixes
git push origin vX.Y
```

Pushing the tag runs `.github/workflows/release-deb.yml`: it builds the `.deb`, runs lintian, tests
it on fresh Ubuntu 24.04 and 26.04, then creates the GitHub release (notes generated from the
commits) with `code2pdf_X.Y.Z_all.deb` and `code2pdf_all.deb` attached. There is nothing to do by
hand on the Releases page. Check the run with `gh run list --workflow release-deb.yml`. If it
fails, don't move the tag: fix the problem and release the next patch version (v3.7 and v3.10
have tags but no release).

## 2. New SHA256 of the tag tarball

```bash
curl -sL https://github.com/readbysearch/code2pdf/archive/refs/tags/vX.Y.tar.gz | shasum -a 256
```

## 3. In this repo (readbysearch/homebrew-tap), through a pull request

Update `code2pdf.rb` on a branch:
- `url` to the new tag (the version is read from the URL)
- `sha256` from step 2
- If you bump WeasyPrint/Pygments/pypdf, refresh the `resource` blocks (copy them from
  homebrew-core's `Formula/w/weasyprint.rb`, which is kept in sync)

```bash
brew audit --strict --online readbysearch/tap/code2pdf
git switch -c code2pdf-X.Y && git commit -am "code2pdf X.Y"   # Homebrew's own style, e.g. "code2pdf 3.12"
git push -u origin code2pdf-X.Y && gh pr create --fill
```

Don't push the formula to `main` directly: the new version would have no bottles, and every
install would build code2pdf from source again (2 to 3 minutes instead of seconds).

The pull request's checks (`.github/workflows/tests.yml`) build a bottle, a pre-built code2pdf, on
each platform: Apple silicon on macOS 14, 15 and 26, Intel on macOS 15, and Linux. `brew test-bot`
reinstalls code2pdf from each bottle and runs the formula's test; then the `pour` job installs it
on a fresh runner, as a user's `brew install` would, and prints with it (`.github/check.py`). Its
log shows how long the install took, and the first and the second print.

When they pass, publish the bottles:

```bash
gh workflow run publish.yml -f pull_request=N
```

`brew pr-pull` puts the pull request's commits on `main` with a commit adding the `bottle do`
block, and uploads the bottles to this repo's release `code2pdf-X.Y`. If a bottle turns out bad,
delete the `bottle do` block and push: installs build from source again, as before.

## 4. Check

```bash
brew update && brew upgrade readbysearch/tap/code2pdf
brew info readbysearch/tap/code2pdf | grep 'Poured from bottle'
brew test readbysearch/tap/code2pdf
code2pdf --version            # first line: code2pdf X.Y (commit ..., date)
```

Versions: vX.Y.Z+1 for fixes (v3.10.1), vX.Y+1 for new features (v3.11, v3.12), vX+1.0 for
breaking changes (v3.0).
