# PotPlayer AI Subtitle Translation

<div align="center">
  <img width="256" height="256" alt="SubtitleTranslate" src="https://github.com/user-attachments/assets/0ae6c19f-d276-4a85-8a14-c4f682a75322" />
</div>

A powerful AngelScript plugin for PotPlayer that provides real-time subtitle translation using any OpenAI-compatible LLM API.

## Features

- **Multi-platform Support**: Compatible with Bailian, OpenAI, DeepSeek, GLM, Moonshot, Gemini, Ollama, and other OpenAI-compatible APIs
- **Real-time Translation**: Instant subtitle translation with minimal token usage
- **Context Awareness**: Uses previous subtitle entries as context for better translations
- **Advanced Caching**: Supports context caching and prompt caching for improved performance
- **Multiple Languages**: Supports 80+ languages with auto-detection
- **Error Handling**: Robust retry mechanisms and hallucination detection

## Installation

1. Download the plugin files:
   - `SubtitleTranslate - Universal-3.as` - Main plugin file
   - `SubtitleTranslate_-_Universal_b1a211.ico` - Plugin icon

2. Place the files in your PotPlayer scripts directory:
   ```
   PotPlayer\Scripts\
   ```

3. Restart PotPlayer

## Configuration

1. Open PotPlayer and go to Preferences → Subtitles → Subtitle Translation
2. Configure your API settings:
   - **Model Name**: e.g., `gpt-4`, `qwen-flash`, `claude-3-haiku`
   - **API URL**: Your API endpoint URL
   - **API Key**: Your API authentication key
   - **Delay**: Request delay in milliseconds (optional)
   - **Retry Mode**: Error retry mode (0-3)
   - **Context Lines**: Number of previous subtitle entries to use as context
   - **Cache Mode**: Context caching mode (auto/off)

### Configuration Examples

#### OpenAI Official API
```
gpt-4|https://api.openai.com/v1/chat/completions|your-api-key|0|0|3|auto
```

#### Alibaba Cloud Bailian (DashScope)
```
qwen-flash|https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions|your-api-key|500|retry1|3|auto
```

#### DeepSeek
```
deepseek-chat|https://api.deepseek.com/v1/chat/completions|your-api-key|0|0|3|auto
```

## Supported APIs

- **OpenAI**: Official OpenAI API
- **Alibaba Cloud**: Bailian/DashScope
- **Baidu**: ERNIE Bot
- **DeepSeek**: DeepSeek API
- **Zhipu AI**: GLM models
- **Moonshot**: Moonshot API
- **Google**: Gemini API
- **Ollama**: Local models
- **Custom**: Any OpenAI-compatible endpoint

## Advanced Features

### Context Caching
- Reduces token usage by caching translation context
- Automatically falls back to standard chat when caching is unsupported

### Prompt Caching (OpenAI Official)
- Extends prompt cache retention (24h/in-memory)
- Reduces costs for repeated translations

### Hallucination Detection
- Detects and retries overlong translations
- Prevents model output that's excessively long

### Echo Detection
- Detects when models echo input text instead of translating
- Automatically retries with improved prompts

## Language Support

Supports 80+ languages including:
- Chinese (Simplified/Traditional)
- English, Spanish, French, German, Japanese, Korean
- Arabic, Russian, Portuguese, Italian, and more
- Auto-detection for unknown source languages

## Usage Tips

1. **Start with small context** (1-3 lines) to minimize token usage
2. **Use appropriate models** for your language pairs
3. **Enable retry mode** for unstable network conditions
4. **Monitor token usage** to control costs
5. **Use context caching** for long videos

## Troubleshooting

### Common Issues

1. **API Key Error**: Verify your API key and endpoint URL
2. **Model Not Found**: Check if your model is available on the selected API
3. **Network Timeout**: Increase delay or enable retry mode
4. **Poor Translation Quality**: Adjust context lines or try different models

### Error Messages

- `[Translation failed - please share a screenshot with the developer]`: Translation failed, check API settings
- `Echo detected`: Model returned source text, retrying with improved prompt
- `Hallucination detected`: Translation is too long, retrying

## Contributing

This project is forked from [Felix3322/PotPlayer_ChatGPT_Translate](https://github.com/Felix3322/PotPlayer_ChatGPT_Translate) and enhanced with additional features.

## License

GPL-3.0 License - see [LICENSE](LICENSE) file for details.

## Support

If you encounter any issues or have feature requests, please open an issue in the GitHub repository.
