<h1 align="center">PotPlayer AI Subtitle Translation<br>PotPlayer AI 字幕翻译</h1>

<div align="center">

![License](https://img.shields.io/github/license/Wjavan/AI-Subtitle-Translation?style=flat-square)
![Version](https://img.shields.io/badge/version-1.9.4-blue?style=flat-square)
![PotPlayer](https://img.shields.io/badge/PotPlayer-Plugin-orange?style=flat-square)
![Stars](https://img.shields.io/github/stars/Wjavan/AI-Subtitle-Translation?style=flat-square)
![Downloads](https://img.shields.io/github/downloads/Wjavan/AI-Subtitle-Translation/total?style=flat-square)

</div>

<div align="center">
  <img width="128" height="128" alt="logo" src="./assets/logo.png" />
</div>

A powerful AngelScript plugin for PotPlayer that provides real-time subtitle translation using any OpenAI-compatible LLM API. Supports 80+ languages, context-aware translation, hallucination detection, and prompt caching.

> 一款强大的 PotPlayer AngelScript 插件，可调用任意 OpenAI 兼容的 LLM API 实现字幕实时翻译。支持 80+ 种语言、上下文感知翻译、幻觉检测及提示词缓存。

---

## Why This Plugin? <br>为什么选择本插件？

| Feature | Built-in Translators | This Plugin |
|---------|---------------------|-------------|
| AI-powered translation | ❌ | ✅ |
| Context-aware (multi-line) | ❌ | ✅ |
| Works with any LLM API | ❌ | ✅ |
| Hallucination detection | ❌ | ✅ |
| Prompt caching (cost saving) | ❌ | ✅ |
| 80+ languages | Limited | ✅ |
| No API cost for local models | N/A | ✅ (Ollama) |

> | 特性 | 内置翻译器 | 本插件 |
> |------|-----------|--------|
> | AI 驱动翻译 | ❌ | ✅ |
> | 上下文感知（多行） | ❌ | ✅ |
> | 兼容任意 LLM API | ❌ | ✅ |
> | 幻觉检测 | ❌ | ✅ |
> | 提示词缓存（省钱） | ❌ | ✅ |
> | 80+ 种语言 | 有限 | ✅ |
> | 本地模型零成本 | 不适用 | ✅（Ollama） |

---

## Quick Start <br>快速开始

1. Download `SubtitleTranslate - Universal.as` and `SubtitleTranslate - Universal.ico` from [Releases](https://github.com/Wjavan/AI-Subtitle-Translation/releases)
2. Copy both files to your PotPlayer subtitle translate directory:
   ```
   D:\PotPlayer\Extension\Subtitle\Translate\
   ```
   *(Adjust the drive letter to match your PotPlayer installation)*
3. Restart PotPlayer completely (kill via Task Manager if needed)
4. Go to **Preferences → Subtitles → Subtitle Translation**, select "AI Translate"
5. Enter your API config (see examples below)

> 1. 从 [Releases](https://github.com/Wjavan/AI-Subtitle-Translation/releases) 下载 `SubtitleTranslate - Universal.as` 和 `SubtitleTranslate - Universal.ico`
> 2. 将两个文件复制到 PotPlayer 字幕翻译目录：
>    ```
>    D:\PotPlayer\Extension\Subtitle\Translate\
>    ```
>    *（根据你的 PotPlayer 安装位置调整盘符）*
> 3. 完全重启 PotPlayer（必要时用任务管理器结束进程）
> 4. 进入 **选项 → 字幕 → 字幕翻译**，选择"AI Translate"
> 5. 输入你的 API 配置（见下方示例）

---

<h2>Features<br>功能特性</h2>

- **Multi-platform Support**: Compatible with Bailian, OpenAI, DeepSeek, GLM, Moonshot, Gemini, Ollama, and other OpenAI-compatible APIs
- **Real-time Translation**: Instant subtitle translation with minimal token usage
- **Context Awareness**: Uses previous subtitle entries as context for better translations
- **Advanced Caching**: Supports context caching and prompt caching for improved performance
- **Multiple Languages**: Supports 80+ languages with auto-detection
- **Error Handling**: Robust retry mechanisms, hallucination detection, and echo detection
- **Thinking Tag Support**: Compatible with reasoning models (`<think>` and `<reasoning>` tags)
- **Multilingual UI**: Plugin UI supports Korean, Traditional Chinese, Simplified Chinese, and English

> - **多平台支持**：兼容百炼、OpenAI、DeepSeek、GLM、Moonshot、Gemini、Ollama 及其他 OpenAI 兼容 API
> - **实时翻译**：字幕即时翻译，token 消耗极低
> - **上下文感知**：利用前序字幕作为上下文，提升翻译质量
> - **高级缓存**：支持上下文缓存与提示词缓存，优化性能
> - **多语言**：支持 80+ 种语言，可自动识别源语言
> - **错误处理**：健壮的重试机制、幻觉检测及回显检测
> - **思考标签支持**：兼容推理模型（`<think>` 和 `<reasoning>` 标签）
> - **多语言界面**：插件界面支持韩语、繁体中文、简体中文和英语

---

<h2>Configuration<br>配置</h2>

### Config Format <br>配置格式

The config string uses pipe-separated values:

```
Model|API_URL|nullkey|Delay_ms|Retry_mode|Context_lines|Cache_mode
```

> 配置字符串使用管道符分隔：

> ```
> 模型|API地址|nullkey|延迟ms|重试模式|上下文行数|缓存模式
> ```

### Configuration Examples <br>配置示例

<h4>Alibaba Cloud Bailian (Free Tier Available) <br>阿里云百炼（有免费额度）</h4>

```
qwen-flash|https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions|nullkey|500|retry1|3|auto
```

> 💡 **Tip**: `qwen-flash` is extremely cheap and fast. New users get free credits on [Bailian Console](https://bailian.console.aliyun.com/).

> > 💡 **提示**：`qwen-flash` 极便宜且快速。新用户在 [百炼控制台](https://bailian.console.aliyun.com/) 可领取免费额度。

<h4>DeepSeek</h4>

```
deepseek-chat|https://api.deepseek.com/v1/chat/completions|nullkey|0|0|3|auto
```

<h4>OpenAI Official API <br>OpenAI 官方 API</h4>

```
gpt-4o-mini|https://api.openai.com/v1/chat/completions|nullkey|0|0|3|auto
```

<h4>Ollama (Local, Free) <br>Ollama（本地，免费）</h4>

```
qwen2.5:7b|http://localhost:11434/v1/chat/completions|nullkey|0|0|3|off
```

> > 💡 Run `ollama pull qwen2.5:7b` first, then use the config above. No API key needed (`nullkey`).

> > 💡 先运行 `ollama pull qwen2.5:7b`，然后使用上述配置。无需 API 密钥（`nullkey`）。

<h4>Google Gemini</h4>

```
gemini-2.0-flash|https://generativelanguage.googleapis.com/v1beta/openai/chat/completions|nullkey|0|0|3|auto
```

---

<h2>Supported APIs<br>支持的 API</h2>

| Provider | Models | API Cost | Recommended |
|----------|--------|----------|-------------|
| Alibaba Cloud (Bailian) | qwen-flash, qwen-plus | Very low / Free tier | ⭐ Best value |
| DeepSeek | deepseek-chat | Very low | ⭐ Great quality |
| OpenAI | gpt-4o-mini, gpt-4o | Medium | Standard |
| Zhipu AI | glm-4-flash | Low / Free tier | Good |
| Moonshot | moonshot-v1-8k | Low | Good |
| Google Gemini | gemini-2.0-flash | Low / Free tier | Good |
| Ollama | Any local model | Free | Best for privacy |
| Custom | Any OpenAI-compatible | Varies | Flexible |

> | 服务商 | 模型 | API 费用 | 推荐 |
> |--------|------|---------|------|
> | 阿里云（百炼） | qwen-flash, qwen-plus | 极低 / 免费额度 | ⭐ 性价比最佳 |
> | DeepSeek | deepseek-chat | 极低 | ⭐ 翻译质量好 |
> | OpenAI | gpt-4o-mini, gpt-4o | 中等 | 标准 |
> | 智谱 AI | glm-4-flash | 低 / 免费额度 | 不错 |
> | Moonshot | moonshot-v1-8k | 低 | 不错 |
> | Google Gemini | gemini-2.0-flash | 低 / 免费额度 | 不错 |
> | Ollama | 任意本地模型 | 免费 | 隐私首选 |
> | 自定义 | 任意 OpenAI 兼容 | 不定 | 灵活 |

---

<h2>Advanced Features<br>高级特性</h2>

<h3>Context Caching<br>上下文缓存</h3>

- Reduces token usage by caching translation context
- Automatically falls back to standard chat when caching is unsupported
- Set `cache=auto` to enable, `cache=off` to disable

> - 通过缓存翻译上下文降低 token 消耗
> - 缓存不受支持时自动回退到标准对话模式
> - 设置 `cache=auto` 启用，`cache=off` 禁用

<h3>Prompt Caching (OpenAI Official)<br>提示词缓存（OpenAI 官方）</h3>

- Extends prompt cache retention (24h/in-memory)
- Reduces costs for repeated translations
- Append `retention=24h` or `cache24h` to config

> - 延长提示词缓存保留时间（24h/内存中）
> - 降低重复翻译成本
> - 在配置中追加 `retention=24h` 或 `cache24h`

<h3>Hallucination Detection<br>幻觉检测</h3>

- Detects and retries overlong translations
- Prevents model output that's excessively long compared to input

> - 检测并重试过长的翻译结果
> - 防止模型输出相比输入异常冗长的内容

<h3>Echo Detection<br>回显检测</h3>

- Detects when models echo input text instead of translating
- Automatically retries with improved prompts

> - 检测模型回显原文而非翻译的情况
> - 自动以优化后的提示词重试

<h3>Reasoning Model Support<br>推理模型支持</h3>

- Automatically strips `<think>` and `<reasoning>` tags from model output
- Compatible with DeepSeek-R1, QwQ, and other reasoning models

> - 自动剥离模型输出中的 `<think>` 和 `<reasoning>` 标签
> - 兼容 DeepSeek-R1、QwQ 等推理模型

---

<h2>Language Support<br>语言支持</h2>

Supports 80+ languages including:

- Chinese (Simplified/Traditional)
- English, Spanish, French, German, Japanese, Korean
- Arabic, Russian, Portuguese, Italian, and more
- Auto-detection for unknown source languages

> 支持 80+ 种语言，包括：
>
> - 中文（简体/繁体）
> - 英语、西班牙语、法语、德语、日语、韩语
> - 阿拉伯语、俄语、葡萄牙语、意大利语等
> - 未知源语言自动识别

---

<h2>Usage Tips<br>使用建议</h2>

1. **Start with small context** (1-3 lines) to minimize token usage
2. **Use `qwen-flash` or `gpt-4o-mini`** for best cost/performance ratio
3. **Enable retry mode** (`retry1`) for unstable network conditions
4. **Use `cache=auto`** for long videos to reduce costs
5. **Try Ollama** for completely free, private, offline translation
6. **Monitor token usage** on your API provider's dashboard

> 1. **从较小的上下文开始**（1-3 行），以最小化 token 消耗
> 2. **使用 `qwen-flash` 或 `gpt-4o-mini`** 获得最佳性价比
> 3. 网络不稳定时**开启重试模式**（`retry1`）
> 4. 长视频**使用 `cache=auto`** 降低成本
> 5. **尝试 Ollama** 实现完全免费、隐私、离线翻译
> 6. 在 API 服务商控制台**监控 token 用量**

---

<h2>Troubleshooting<br>故障排除</h2>

### Plugin not showing in PotPlayer <br>插件在 PotPlayer 中不显示

- Ensure files are named exactly: `SubtitleTranslate - Universal.as` and `SubtitleTranslate - Universal.ico`
- The filenames **must match** (including the space around the hyphen)
- Completely kill PotPlayer via Task Manager and restart
- Check AngelScript console (`Ctrl+L`) for compilation errors

> - 确保文件名完全正确：`SubtitleTranslate - Universal.as` 和 `SubtitleTranslate - Universal.ico`
> - 文件名**必须匹配**（包括连字符周围的空格）
> - 通过任务管理器完全结束 PotPlayer 后重启
> - 检查 AngelScript 控制台（`Ctrl+L`）是否有编译错误

### Translation shows garbled text <br>翻译显示乱码

- This is a BOM (Byte Order Mark) issue — the `.as` file must have a single UTF-8 BOM
- Re-download from [Releases](https://github.com/Wjavan/AI-Subtitle-Translation/releases) to get the correct file
- Do not edit the `.as` file with editors that strip or double the BOM

> - 这是 BOM（字节顺序标记）问题 — `.as` 文件必须包含单个 UTF-8 BOM
> - 从 [Releases](https://github.com/Wjavan/AI-Subtitle-Translation/releases) 重新下载正确文件
> - 不要用会去除或重复 BOM 的编辑器修改 `.as` 文件

### Translation shows original text (not translated) <br>显示原文而非翻译

- Check your API key and URL are correct
- Verify the model name is supported by your API provider
- Check your network can reach the API endpoint
- Try setting `cache=off` if caching causes issues

> - 检查 API 密钥和地址是否正确
> - 确认模型名称被你的 API 服务商支持
> - 检查网络能否访问 API 端点
> - 如缓存导致问题，尝试设置 `cache=off`

### API returns 401/403 <br>API 返回 401/403

- Ensure your API key is entered correctly in the password field
- For OpenAI-compatible APIs, the key is sent as `Authorization: Bearer <key>`
- Some providers require enabling the model in their dashboard first

> - 确保在密码栏正确输入了 API 密钥
> - 对于 OpenAI 兼容 API，密钥以 `Authorization: Bearer <key>` 方式发送
> - 部分服务商需要先在控制台启用对应模型

---

<h2>FAQ<br>常见问题</h2>

<details>
<summary><b>Is this plugin free?</b></summary>

The plugin itself is free and open-source (GPL-3.0). However, cloud LLM APIs (OpenAI, DeepSeek, etc.) charge per token. For completely free usage, use [Ollama](https://ollama.com) with a local model.

> 插件本身免费开源（GPL-3.0）。但云端 LLM API（OpenAI、DeepSeek 等）按 token 收费。如需完全免费使用，请用 [Ollama](https://ollama.com) 运行本地模型。

</details>

<details>
<summary><b>Which model is best for subtitle translation?</b></summary>

For Chinese users: `qwen-flash` (Bailian) offers the best cost/performance ratio with free credits. For English speakers: `gpt-4o-mini` or `deepseek-chat`. For offline use: `qwen2.5:7b` via Ollama.

> 中文用户推荐 `qwen-flash`（百炼），性价比最佳且有免费额度。英语用户推荐 `gpt-4o-mini` 或 `deepseek-chat`。离线使用推荐 `qwen2.5:7b`（Ollama）。

</details>

<details>
<summary><b>How much does it cost per movie?</b></summary>

A typical 2-hour movie has ~1,500 subtitle lines. With `qwen-flash` (~0.01 yuan/million tokens), a movie costs less than ¥0.01. With `gpt-4o-mini`, about $0.01-0.02.

> 一部典型的 2 小时电影约 1,500 条字幕。使用 `qwen-flash`（约 0.01 元/百万 token），一部电影花费不到 ¥0.01。使用 `gpt-4o-mini` 约 $0.01-0.02。

</details>

<details>
<summary><b>Can I use this with a VPN/proxy?</b></summary>

Yes. The plugin uses PotPlayer's built-in HTTP client which respects system proxy settings. Configure your proxy in Windows Settings → Network → Proxy.

> 可以。插件使用 PotPlayer 内置 HTTP 客户端，遵循系统代理设置。在 Windows 设置 → 网络 → 代理中配置代理。

</details>

---

<h2>Contributing<br>参与贡献</h2>

Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

This project is forked from [Felix3322/PotPlayer_ChatGPT_Translate](https://github.com/Felix3322/PotPlayer_ChatGPT_Translate) and enhanced with additional features.

> 欢迎贡献！请参阅 [CONTRIBUTING.md](CONTRIBUTING.md) 了解指南。

> 本项目 fork 自 [Felix3322/PotPlayer_ChatGPT_Translate](https://github.com/Felix3322/PotPlayer_ChatGPT_Translate)，并在此基础上增强了更多功能。

---

<h2>License<br>许可证</h2>

GPL-3.0 License - see [LICENSE](LICENSE) file for details.

> GPL-3.0 许可证 - 详见 [LICENSE](LICENSE) 文件。

---

<h2>Support<br>支持</h2>

If you find this plugin helpful, please consider:

- ⭐ Starring this repository
- Sharing it with others
- Reporting bugs or suggesting features via [Issues](https://github.com/Wjavan/AI-Subtitle-Translation/issues)

> 如果这个插件对你有帮助，请考虑：
>
> - ⭐ 给本仓库点 Star
> - 分享给其他人
> - 通过 [Issues](https://github.com/Wjavan/AI-Subtitle-Translation/issues) 报告 bug 或建议功能

---

<div align="center">

**If you like this project, please give it a Star! ⭐**

**如果你喜欢这个项目，请点个 Star！⭐**

</div>
