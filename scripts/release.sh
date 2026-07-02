#!/bin/bash
# Build, sign (Developer ID), notarize, and staple Table Tool.
#
# One-time prerequisites:
#   1. A "Developer ID Application" certificate for team J9W42C7K2A
#      installed in the login keychain (create at developer.apple.com).
#   2. Notarization credentials stored in the keychain:
#        xcrun notarytool store-credentials tabletool-notary \
#          --apple-id <apple-id> --team-id J9W42C7K2A \
#          --password <app-specific-password>
set -euo pipefail
cd "$(dirname "$0")/.."

ARCHIVE=build/TableTool.xcarchive
EXPORT=build/export
APP="$EXPORT/Table Tool.app"
ZIP=build/TableTool.zip

xcodebuild -project "Table Tool.xcodeproj" -scheme "Table Tool" \
  -configuration Release archive -archivePath "$ARCHIVE"

xcodebuild -exportArchive -archivePath "$ARCHIVE" \
  -exportOptionsPlist ExportOptions.plist -exportPath "$EXPORT"

ditto -c -k --keepParent "$APP" "$ZIP"
xcrun notarytool submit "$ZIP" --keychain-profile tabletool-notary --wait
xcrun stapler staple "$APP"

spctl -a -t exec -vv "$APP"
echo "Done: $APP is signed, notarized, and stapled."
