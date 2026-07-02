# Releasing Table Tool

GitHub releases are built automatically when a version tag is pushed. The
resulting app is ad hoc signed, not Developer ID signed, and not notarized, so
macOS may warn users before it will open. The existing `scripts/release.sh`
remains the Developer ID and notarization path for a future signed release.

## Create a GitHub release

1. Set `CFBundleShortVersionString` in `Table Tool/Info.plist` to the release
   version and commit the change.
2. Tag that commit with the same version, prefixed by `v`, then push the tag:

   ```sh
   git tag v1.3.0
   git push origin v1.3.0
   ```

The Release workflow tests the project, builds a universal macOS app, packages
it as a ZIP, writes a SHA-256 checksum, and publishes both files in a GitHub
Release with automatically generated release notes.

The workflow rejects a tag that does not exactly match the app version. If a
run fails, delete the remote tag, fix the issue in a new commit, recreate the
tag on that commit, and push it again. Do not move a tag after a release has
been published.
