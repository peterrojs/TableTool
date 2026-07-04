<img style='margin: 0 auto' src="Table%20Tool/Images.xcassets/AppIcon.appiconset/icon_128x128@2x.png" width=128 height=128>

# Table Tool

A simple CSV editor for macOS.

> **About this fork:** This is a maintained fork of the original
> [jakob/TableTool](https://github.com/jakob/TableTool), updated to run on
> current macOS versions and Apple Silicon. Releases are built as universal
> binaries (Apple Silicon + Intel) and require macOS 11 or later.

**[Download the latest release](https://github.com/peterrojs/TableTool/releases/latest)**

<img style='margin: 0 auto' src="Artwork/Screenshots/2026-07-04%20TableTool%201.3%20Customers.png" width=800>

CSV is a widely used file format for storing and exchanging tabular data, and
almost every spreadsheet and database app (e.g. Excel and Numbers) supports it.
Unfortunately, not all CSV files are made equal: they differ in record
delimiters (comma or semicolon), character encodings, decimal separators and
quoting styles.

Table Tool handles these issues automatically. It detects the format of a CSV
file for you and displays its contents in a table view, making it the easy way
to create, edit and convert CSV files.

## Features

- **Open files:** Table Tool detects the format specifications of a CSV file
  (record delimiter, character encoding, etc.) automatically. You can also set
  them manually.
- **Edit files:** Edit cells, rows and columns in a grid-based interface, with
  full undo/redo support.
- **Convert files:** Convert an existing CSV file to a different format.

## Installation

Download the ZIP from the
[latest release](https://github.com/peterrojs/TableTool/releases/latest),
unzip it and move `Table Tool.app` to your Applications folder.

Release builds are ad hoc signed and not notarized, so macOS will warn you the
first time you open the app. To approve it, try to open the app once, then go
to **System Settings → Privacy & Security** and click **Open Anyway**.

## What's different in this fork

The upstream project has been dormant for a while and its last release predates
Apple Silicon. This fork:

- Modernizes the Xcode project for current macOS SDKs and Apple Silicon,
  building a universal binary with a macOS 11.0 deployment target
- Replaces deprecated AppKit/Foundation API usage and migrates document types
  to UTI-based declarations
- Adds GitHub Actions CI and an automated release workflow that builds, tests
  and publishes tagged versions (see [RELEASING.md](RELEASING.md))

No features have been added or removed beyond keeping the app working — the
goal is simply a CSV editor that runs on today's Macs.

## Building from source

Requires a recent Xcode. Clone the repository, open
`Table Tool.xcodeproj` and build the `Table Tool` scheme, or from the command
line:

```sh
xcodebuild -project "Table Tool.xcodeproj" -scheme "Table Tool" build
```

## Project scope & contributing

Table Tool seeks to be a great and simple CSV file editor and nothing more.
Formatting options or features like formulas are out of scope. If something is
broken or missing, please [open an issue](https://github.com/peterrojs/TableTool/issues)
— well-documented issues and pull requests are what move this project forward.

## Credits

Table Tool was made by [Sandro Peham](https://github.com/SandroPeham),
[Andreas Aigner](https://github.com/aigi) and
[Jakob Egger](https://github.com/jakob).

## Licence

Table Tool is distributed under the [MIT Licence](LICENSE).
