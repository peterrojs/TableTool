# Releasing Table Tool

Releases are built, Developer ID signed, notarized, and stapled locally with
`scripts/release.sh`, then uploaded to a GitHub Release. The old tag-triggered
Release workflow is kept for manual runs only (`workflow_dispatch`); it
produces an ad hoc signed build and should not normally be used.

## One-time prerequisites

1. A "Developer ID Application" certificate for team J9W42C7K2A installed in
   the login keychain (create at developer.apple.com).
2. Notarization credentials stored in the keychain:

   ```sh
   xcrun notarytool store-credentials tabletool-notary \
     --apple-id <apple-id> --team-id J9W42C7K2A \
     --password <app-specific-password>
   ```

## Cut a release

1. Set `CFBundleShortVersionString` in `Table Tool/Info.plist` to the release
   version, bump `CFBundleVersion`, and commit the change.
2. Build, sign, notarize, and staple:

   ```sh
   scripts/release.sh
   ```

   This archives a universal Release build, exports it with Developer ID
   signing, submits it for notarization (waits for acceptance), staples the
   ticket, and verifies the result with `spctl`.

3. Package the stapled app for distribution (the ZIP created inside
   `release.sh` is only the notarization submission; re-zip after stapling):

   ```sh
   version=1.3.1
   ditto -c -k --sequesterRsrc --keepParent \
     "build/export/Table Tool.app" "TableTool-${version}-macOS.zip"
   shasum -a 256 "TableTool-${version}-macOS.zip" \
     > "TableTool-${version}-macOS.zip.sha256"
   ```

4. Tag the release commit with the same version, prefixed by `v`, push it,
   and publish the GitHub release with both files:

   ```sh
   git tag "v${version}"
   git push origin main "v${version}"
   gh release create "v${version}" \
     "TableTool-${version}-macOS.zip" \
     "TableTool-${version}-macOS.zip.sha256" \
     --title "Table Tool ${version}" \
     --generate-notes
   ```

Do not move a tag after a release has been published; if something is wrong,
fix it in a new commit and cut a new patch release.
