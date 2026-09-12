# Contributing to AI Subtitle Translation

Thank you for your interest in contributing! 🎉

## How to Contribute

### Reporting Bugs

1. Check existing [Issues](https://github.com/Wjavan/AI-Subtitle-Translation/issues) to avoid duplicates
2. Open a new issue with:
   - PotPlayer version
   - Plugin version (shown in Preferences → Subtitles → Subtitle Translation)
   - API provider and model used
   - Steps to reproduce
   - Expected vs actual behavior
   - AngelScript console output (`Ctrl+L`) if available

### Suggesting Features

1. Open an issue with the `enhancement` label
2. Describe the feature and its use case
3. If possible, suggest how it could be implemented

### Submitting Code Changes

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/my-feature`
3. Make your changes
4. Test thoroughly with PotPlayer
5. Commit with a clear message
6. Open a Pull Request

### Development Notes

- The plugin is written in **AngelScript** (not Python or JavaScript)
- Files must be saved as **UTF-8 with BOM** and **CRLF line endings**
- Test with multiple API providers if possible
- Avoid breaking changes to the config string format

## Code Style

- Keep functions small and focused
- Comment non-obvious logic
- Maintain multilingual UI strings (KR, TW, CN, EN)
