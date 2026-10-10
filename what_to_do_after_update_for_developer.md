Here's the process to update code2pdf and homebrew-tap after making changes:

# 1. In code2pdf repo:

```bash
# Commit your changes
git add .
git commit -m "Your changes description"
git push

# Create new version tag (e.g., v1.0.1)
git tag -a v1.0.1 -m "Release description"
git push origin v1.0.1

# Create GitHub release
# Go to GitHub > Releases > Create new release
# Select the new tag v1.0.1
# Add release notes
# Publish release
```

# 2. Get new SHA256:

```bash
curl -L https://github.com/readbysearch/code2pdf/archive/refs/tags/v1.0.1.tar.gz | shasum -a 256
```

# 3. In homebrew-tap repo:

```bash
# Update code2pdf.rb with:
# - New version number (v1.0.1)
# - New SHA256
# - If you bump WeasyPrint/Pygments, refresh the `resource` blocks
#   (copy them from homebrew-core's Formula/w/weasyprint.rb, which is kept in sync)
brew audit --strict --online readbysearch/tap/code2pdf
git add code2pdf.rb
git commit -m "Update to v1.0.1"
git push
```

# 4. Update local installation:

```bash
brew update
brew upgrade readbysearch/tap/code2pdf
```
The key is to always create a new version tag when you want to release updates, following semantic versioning (v1.0.0 → v1.0.1 for small fixes, v1.1.0 for new features, v2.0.0 for breaking changes).
