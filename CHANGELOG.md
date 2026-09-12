# Changelog

## [1.9.4] - 2026-09-12

### Added
- Support for `<think>` and `<reasoning>` tags (DeepSeek-R1, QwQ, etc.)
- Echo detection — detects and retries when model echoes input instead of translating
- Prompt cache retention support for OpenAI official API (`retention=24h`)
- Gemini cached_content support (`gcache=cachedContents/...`)
- Integer overflow protection in ParseInt
- Multilingual UI (Korean, Traditional Chinese, Simplified Chinese, English)

### Fixed
- Double UTF-8 BOM causing compilation failure
- `DstLang = "UTF8"` causing PotPlayer to reject translated output
- Authorization header now uses proper `Bearer` scheme
- StripThinkTags now matches both `<think>` and `<reasoning>` formats

### Changed
- Default model changed to `qwen-flash` (best cost/performance ratio)
- Config format extended with more optional parameters

## [1.0.0] - 2026-08-17

### Initial Release
- Forked from [Felix3322/PotPlayer_ChatGPT_Translate](https://github.com/Felix3322/PotPlayer_ChatGPT_Translate)
- Multi-platform API support (OpenAI, DeepSeek, GLM, Moonshot, Gemini, Ollama)
- Context-aware translation
- Hallucination detection
- 80+ language support
