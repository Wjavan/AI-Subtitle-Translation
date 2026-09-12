<h1 align="center">PotPlayer AI Subtitle Translation<br>PotPlayer AI 字幕翻译</h1>

<div align="center">
  <img width="256" height="256" alt="SubtitleTranslate" src="https://github.com/user-attachments/assets/0ae6c19f-d276-4a85-8a14-c4f682a75322" />
</div>

A powerful AngelScript plugin for PotPlayer that provides real-time subtitle translation using any OpenAI-compatible LLM API.

> 一款强大的 PotPlayer AngelScript 插件，可调用任意 OpenAI 兼容的 LLM API 实现字幕实时翻译。

<h2>Features<br>功能特性</h2>

- **Multi-platform Support**: Compatible with Bailian, OpenAI, DeepSeek, GLM, Moonshot, Gemini, Ollama, and other OpenAI-compatible APIs
- **Real-time Translation**: Instant subtitle translation with minimal token usage
- **Context Awareness**: Uses previous subtitle entries as context for better translations
- **Advanced Caching**: Supports context caching and prompt caching for improved performance
- **Multiple Languages**: Supports 80+ languages with auto-detection
- **Error Handling**: Robust retry mechanisms and hallucination detection

> - **多平台支持**：兼容百炼、OpenAI、DeepSeek、GLM、Moonshot、Gemini、Ollama 及其他 OpenAI 兼容 API
> - **实时翻译**：字幕即时翻译，token 消耗极低
> - **上下文感知**：利用前序字幕作为上下文，提升翻译质量
> - **高级缓存**：支持上下文缓存与提示词缓存，优化性能
> - **多语言**：支持 80+ 种语言，可自动识别源语言
> - **错误处理**：健壮的重试机制与幻觉检测

<h2>Installation<br>安装</h2>

1. Download the plugin files:
   - `SubtitleTranslate - Universal.as` - Main plugin file
   - `SubtitleTranslate - Universal.ico` - Plugin icon
2. Place the files in your PotPlayer scripts directory:
   ```
   PotPlayer\Extension\Subtitle\Translate
   ```
3. Restart PotPlayer

> 1. 下载插件文件：
>    - `SubtitleTranslate - Universal.as` - 插件主文件
>    - `SubtitleTranslate - Universal.ico` - 插件图标
> 2. 将文件放入 PotPlayer 脚本目录：
>    ```
>    PotPlayer\Extension\Subtitle\Translate
>    ```
> 3. 重启 PotPlayer

<h2>Configuration<br>配置</h2>

1. Open PotPlayer and go to Preferences → Subtitles → Subtitle Translation
2. Configure your API settings:
   - **Model Name**: e.g., `gpt-4`, `qwen-flash`, `claude-3-haiku`
   - **API URL**: Your API endpoint URL
   - **API Key**: Your API authentication key
   - **Delay**: Request delay in milliseconds (optional)
   - **Retry Mode**: Error retry mode (0-3)
   - **Context Lines**: Number of previous subtitle entries to use as context
   - **Cache Mode**: Context caching mode (auto/off)

> 1. 打开 PotPlayer，进入 选项 → 字幕 → 字幕翻译
> 2. 配置 API 参数：
>    - **模型名称**：例如 `gpt-4`、`qwen-flash`、`claude-3-haiku`
>    - **API 地址**：你的 API 端点 URL
>    - **API 密钥**：你的 API 认证密钥
>    - **延迟**：请求间隔毫秒数（可选）
>    - **重试模式**：错误重试模式（0-3）
>    - **上下文行数**：用作上下文的前序字幕条数
>    - **缓存模式**：上下文缓存模式（auto/off）

<h3>Configuration Examples<br>配置示例</h3>

<h4>OpenAI Official API<br>OpenAI 官方 API</h4>

```
gpt-4|https://api.openai.com/v1/chat/completions|your-api-key|0|0|3|auto
```

<h4>Alibaba Cloud Bailian (DashScope)<br>阿里云百炼（DashScope）</h4>

```
qwen-flash|https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions|your-api-key|500|retry1|3|auto
```

<h4>DeepSeek</h4>

```
deepseek-chat|https://api.deepseek.com/v1/chat/completions|your-api-key|0|0|3|auto
```

<h2>Supported APIs<br>支持的 API</h2>

- **OpenAI**: Official OpenAI API
- **Alibaba Cloud**: Bailian/DashScope
- **Baidu**: ERNIE Bot
- **DeepSeek**: DeepSeek API
- **Zhipu AI**: GLM models
- **Moonshot**: Moonshot API
- **Google**: Gemini API
- **Ollama**: Local models
- **Custom**: Any OpenAI-compatible endpoint

> - **OpenAI**：OpenAI 官方 API
> - **阿里云**：百炼 / DashScope
> - **百度**：文心一言
> - **DeepSeek**：DeepSeek API
> - **智谱 AI**：GLM 系列模型
> - **Moonshot**：Moonshot API
> - **Google**：Gemini API
> - **Ollama**：本地模型
> - **自定义**：任意 OpenAI 兼容端点

<h2>Advanced Features<br>高级特性</h2>

<h3>Context Caching<br>上下文缓存</h3>

- Reduces token usage by caching translation context
- Automatically falls back to standard chat when caching is unsupported

> - 通过缓存翻译上下文降低 token 消耗
> - 缓存不受支持时自动回退到标准对话模式

<h3>Prompt Caching (OpenAI Official)<br>提示词缓存（OpenAI 官方）</h3>

- Extends prompt cache retention (24h/in-memory)
- Reduces costs for repeated translations

> - 延长提示词缓存保留时间（24h/内存中）
> - 降低重复翻译成本

<h3>Hallucination Detection<br>幻觉检测</h3>

- Detects and retries overlong translations
- Prevents model output that's excessively long

> - 检测并重试过长的翻译结果
> - 防止模型输出异常冗长的内容

<h3>Echo Detection<br>回显检测</h3>

- Detects when models echo input text instead of translating
- Automatically retries with improved prompts

> - 检测模型回显原文而非翻译的情况
> - 自动以优化后的提示词重试

<h2>Language Support<br>语言支持</h2>

Supports 80+ languages including:
- Chinese (Simplified/Traditional)
- English, Spanish, French, German, Japanese, Korean
- Arabic, Russian, Portuguese, Italian, and more
- Auto-detection for unknown source languages

> 支持 80+ 种语言，包括：
> - 中文（简体/繁体）
> - 英语、西班牙语、法语、德语、日语、韩语
> - 阿拉伯语、俄语、葡萄牙语、意大利语等
> - 未知源语言自动识别

<h2>Usage Tips<br>使用建议</h2>

1. **Start with small context** (1-3 lines) to minimize token usage
2. **Use appropriate models** for your language pairs
3. **Enable retry mode** for unstable network conditions
4. **Monitor token usage** to control costs
5. **Use context caching** for long videos

> 1. **从较小的上下文开始**（1-3 行），以最小化 token 消耗
> 2. 为你的语言对**选择合适的模型**
> 3. 网络不稳定时**开启重试模式**
> 4. **监控 token 用量**以控制成本
> 5. 长视频**使用上下文缓存**

<h2>Contributing<br>参与贡献</h2>

This project is forked from [Felix3322/PotPlayer_ChatGPT_Translate](https://github.com/Felix3322/PotPlayer_ChatGPT_Translate) and enhanced with additional features.

> 本项目 fork 自 [Felix3322/PotPlayer_ChatGPT_Translate](https://github.com/Felix3322/PotPlayer_ChatGPT_Translate)，并在此基础上增强了更多功能。

<h2>License<br>许可证</h2>

GPL-3.0 License - see [LICENSE](LICENSE) file for details.

> GPL-3.0 许可证 - 详见 [LICENSE](LICENSE) 文件。

<h2>Support<br>支持</h2>

If you encounter any issues or have feature requests, please open an issue in the GitHub repository.

> 如遇到任何问题或有功能需求，请在 GitHub 仓库提交 issue。
