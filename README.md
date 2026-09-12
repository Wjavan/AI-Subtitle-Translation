# PotPlayer AI Subtitle Translation

A powerful AngelScript plugin for real-time subtitle translation in PotPlayer using any OpenAI-compatible LLM API.

---

## Features

### AI-Powered Translation
- **Multi-platform Support** — Compatible with OpenAI, DeepSeek, Alibaba Bailian (Qwen), Zhipu GLM, Moonshot, Google Gemini, Ollama, and any OpenAI-compatible API
- **80+ Languages** — Translate subtitles into or from any of 80+ languages with automatic source language detection
- **Context-Aware Translation** — Uses previous subtitle lines as context for more accurate and natural translations
- **Hallucination Detection** — Automatically detects and retries overlong or anomalous translations

### Performance & Cost Optimization
- **Prompt Caching** — Supports prompt cache retention for OpenAI official API, reducing costs for repeated translations
- **Context Caching** — Caches translation context to minimize token usage, with automatic fallback to standard chat mode
- **Minimal Token Usage** — Optimized for extremely low token consumption per subtitle line

### Smart Error Handling
- **Echo Detection** — Detects when models output the original text instead of translating, and automatically retries with improved prompts
- **Retry Mechanisms** — Configurable retry modes (0-3) for unstable network conditions
- **Integer Overflow Protection** — Safe parsing of numeric values to prevent runtime errors

### Developer-Friendly
- **Configurable Parameters** — Fine-tune delay, retry mode, context lines, and cache mode via a single config string
- **Reasoning Model Support** — Compatible with DeepSeek-R1, QwQ, and other reasoning models (automatically strips `` and `` tags)
- **Multilingual UI** — Plugin interface supports Korean, Traditional Chinese, Simplified Chinese, and English
- **Local Model Support** — Use Ollama for completely free, private, offline translation with no API costs

---

## Download

| File | Size |
|------|------|
| [SubtitleTranslate - Universal.as](https://github.com/Wjavan/AI-Subtitle-Translation/releases/download/v1.0.0/SubtitleTranslate.-.Universal.as) | 68 KB |
| [SubtitleTranslate - Universal.ico](https://github.com/Wjavan/AI-Subtitle-Translation/releases/download/v1.0.0/SubtitleTranslate.-.Universal.ico) | 23 KB |

## Quick Install

1. Download both files from [Releases](https://github.com/Wjavan/AI-Subtitle-Translation/releases)
2. Copy to your PotPlayer subtitle translate directory:
   ```
   ~\PotPlayer\Extension\Subtitle\Translate\
   ```
3. **Completely restart PotPlayer**
4. Go to **Preferences → Subtitles → Subtitle Translation**, select **"AI Translate"**
5. Enter your API config (examples below)

---

## Configuration

The config string uses pipe-separated values:

```
Model|API_URL|nullkey|Delay_ms|Retry_mode|Context_lines|Cache_mode
```

### Config Examples

| Provider | Config String |
|----------|---------------|
| **Alibaba Bailian** | `qwen-flash\|https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions\|nullkey\|500\|retry1\|3\|auto` |
| **DeepSeek** | `deepseek-chat\|https://api.deepseek.com/v1/chat/completions\|nullkey\|0\|0\|3\|auto` |
| **OpenAI** | `gpt-4o-mini\|https://api.openai.com/v1/chat/completions\|nullkey\|0\|0\|3\|auto` |
| **Ollama** | `qwen2.5:7b\|http://localhost:11434/v1/chat/completions\|nullkey\|0\|0\|3\|off` |
| **Google Gemini** | `gemini-2.0-flash\|https://generativelanguage.googleapis.com/v1beta/openai/chat/completions\|nullkey\|0\|0\|3\|auto` |

---

### Model Integration Capability

This system supports integration with major mainstream AI models through a unified interface, allowing on-demand access and flexible switching across cloud APIs, free tiers, and local private deployment:

| Integration Mode | Supported Range |
| --- | --- |
| Domestic Cloud Services | Alibaba Cloud Bailian (Qwen series), DeepSeek (chat / reasoner), Zhipu AI (GLM series), and other mainstream models |
| International Services | OpenAI (GPT series), Google Gemini, and other general-purpose models |
| Local Deployment | Any open-source / local model via Ollama and similar frameworks |

Key Features:

- **Multi-provider compatibility**: A unified interface connects to mainstream models both domestically and internationally — switching providers requires no changes to business logic, making multi-model comparison and disaster-recovery migration easy.
- **Cost-tiered selection**: Coverage ranges from free tiers and low-cost models to mid/high-end general-purpose models, so the right model can be selected based on task complexity.
- **Flexible extensibility**: New mainstream models can be continuously onboarded — adding a provider only requires a corresponding integration configuration, with no system restructuring.
- **Privacy control**: Local deployment supports data-stay-on-premises and offline scenarios.
---

## Usage Tips

1. Start with small context (1-3 lines) to minimize token usage
2. Enable retry mode (`retry1`) for unstable network conditions
3. Use `cache=auto` for long videos to reduce costs 

---

## Troubleshooting

### Plugin not showing in PotPlayer
- Ensure files are named exactly: `SubtitleTranslate - Universal.as` and `SubtitleTranslate - Universal.ico`
- The filenames **must match** (including the space around the hyphen)
- Completely kill PotPlayer via Task Manager and restart
- Check AngelScript console (`Ctrl+L`) for compilation errors

### Translation shows garbled text
- The `.as` file must have a **single UTF-8 BOM** — re-download from Releases
- Do not edit the `.as` file with editors that strip or duplicate the BOM

### Translation shows original text (not translated)
- Check your API key and URL are correct
- Verify the model is supported by your provider
- Try `cache=off` if caching causes issues

### API returns 401/403
- Ensure your API key is entered correctly in the password field
- Some providers require enabling the model in their dashboard first

---

## FAQ

**Q: Is this plugin free?**
A: The plugin is free and open-source (GPL-3.0). Cloud LLM APIs charge per token.

**Q: How much does it cost per movie?**
A: A 2-hour movie has ~1,500 subtitle lines. The total cost is calculated by multiplying the line count by the per-line rate, plus any additional fees (e.g., translation, timing, or formatting) — so the final price depends on the model you choose.

**Q: Can I use this with a VPN/proxy?**
A: Yes. The plugin uses PotPlayer's built-in HTTP client which respects system proxy settings.

---

## Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

---

## License

GPL-3.0 — see [LICENSE](LICENSE) file.

---

If you like this project, please ⭐ star the repo!
