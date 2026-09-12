/*
    Real-time subtitle translation for PotPlayer using any OpenAI-compatible LLM API
    Optimized for minimal token usage. Supports Bailian, OpenAI, DeepSeek, GLM, Moonshot, Gemini, Ollama, etc.
*/

// Plugin Information Functions
string GetTitle() {
    return "{$CP949=AI 번역$}"
         + "{$CP950=AI 翻譯$}"
         + "{$CP936=AI 翻译$}"
         + "{$CP0=AI Translate$}";
}

// The version number will be replaced during the installation process
string GetVersion() {
    return "1.9.4";
}

string GetDesc() {
    return "Real-time subtitle translation using any OpenAI-compatible LLM API.";
}

string GetLoginTitle() {
    return "{$CP949=OpenAI 모델 및 API 키 구성$}"
         + "{$CP950=OpenAI 模型與 API 金鑰配置$}"
         + "{$CP936=OpenAI 模型与 API 密钥配置$}"
         + "{$CP0=OpenAI Model + API URL and API Key Configuration$}";
}

string GetLoginDesc() {
    return "{$CP949=모델 이름, API 주소, 선택적 nullkey, 지연(ms) 및 재시도 모드(0-3)를 입력하십시오 (예: gpt-5-nano|https://api.openai.com/v1/chat/completions|nullkey|500|retry1).$}"
         + "{$CP949=\n\n설치 프로그램에서 미리 구성한 값이 있다면 PotPlayer 패널에서 다시 설정하기 전까지 해당 값을 사용하며, 패널에서 설정하면 해당 설정이 항상 우선 적용됩니다.$}"
         + "{$CP949=\n\n선택적으로 cache=auto 또는 cache=off 를 추가하여 문맥 캐시 모드를 제어할 수 있으며, auto 는 지원되지 않을 경우 chat 방식으로 자동 전환됩니다.$}"
         + "{$CP950=請輸入模型名稱、API 地址、可選的 nullkey、延遲毫秒與重試模式(0-3)（例如: gpt-5-nano|https://api.openai.com/v1/chat/completions|nullkey|500|retry1）。$}"
         + "{$CP950=\n\n如果安裝包已寫入預設配置，在 PotPlayer 面板中未重新設定之前會沿用這些配置；一旦在面板中調整，將始終以面板設定為準。$}"
         + "{$CP950=\n\n可選加上 cache=auto 或 cache=off 以控制上下文快取模式，auto 會在不支援時自動回退至 chat。$}"
         + "{$CP936=请输入模型名称、API 地址、可选的 nullkey、延迟毫秒和重试模式(0-3)（例如: gpt-5-nano|https://api.openai.com/v1/chat/completions|nullkey|500|retry1）。$}"
         + "{$CP936=\n\n如果安装包已经写入默认配置，在 PotPlayer 面板中没有重新设置之前会继续使用这些配置；一旦在面板中修改，将始终以面板设置为准。$}"
         + "{$CP936=\n\n可选追加 cache=auto 或 cache=off 用于控制上下文缓存模式，auto 在不支持时会自动回退到 chat。$}"
         + "{$CP0=Please enter the model name, API URL, optional 'nullkey', optional delay in ms, and retry mode 0-3 (e.g., gpt-5-nano|https://api.openai.com/v1/chat/completions|nullkey|500|retry1).$}"
         + "{$CP0=\n\nInstaller defaults will remain in effect until you update the settings in PotPlayer's panel, and any panel changes will always take priority.$}"
         + "{$CP0=\n\nOptionally append cache=auto or cache=off to control context caching. Auto falls back to chat when caching is unsupported.$}"
         + "{$CP0=\n\nFor OpenAI official API you can also append retention=24h (or cache24h) to extend prompt cache retention. For Gemini official API you can append gcache=cachedContents/... to reuse an explicit cache.$}";
}

string GetUserText() {
    return "{$CP949=모델 이름|API 주소|nullkey|지연(ms)|재시도 모드|문맥 자막 수|캐시 모드 (현재: " + GPT_selected_model + " | " + GPT_apiUrl + " | " + GPT_delay_ms + " | " + GPT_retry_mode + " | " + GPT_context_subtitle_count + " | " + GPT_context_cache_mode + ")$}"
         + "{$CP950=模型名稱|API 地址|nullkey|延遲ms|重試模式|上下文字幕條數|快取模式 (目前: " + GPT_selected_model + " | " + GPT_apiUrl + " | " + GPT_delay_ms + " | " + GPT_retry_mode + " | " + GPT_context_subtitle_count + " | " + GPT_context_cache_mode + ")$}"
         + "{$CP936=模型名称|API 地址|nullkey|延迟ms|重试模式|上下文字幕条数|缓存模式 (目前: " + GPT_selected_model + " | " + GPT_apiUrl + " | " + GPT_delay_ms + " | " + GPT_retry_mode + " | " + GPT_context_subtitle_count + " | " + GPT_context_cache_mode + ")$}"
         + "{$CP0=Model Name|API URL|nullkey|Delay ms|Retry mode|Context subtitle count|Cache mode|Retention|Gemini cached_content (Current: " + GPT_selected_model + " | " + GPT_apiUrl + " | " + GPT_delay_ms + " | " + GPT_retry_mode + " | " + GPT_context_subtitle_count + " | " + GPT_context_cache_mode + " | " + GPT_prompt_cache_retention + " | " + GPT_gemini_cached_content + ")$}";
}

string GetPasswordText() {
    return "{$CP949=API 키:$}"
         + "{$CP950=API 金鑰:$}"
         + "{$CP936=API 密钥:$}"
         + "{$CP0=API Key:$}";
}

// Global Variables
// Pre-configured values (auto-filled by installer)
string GPT_pre_api_key = ""; // will be replaced during installation
string GPT_pre_selected_model = "qwen-flash"; // will be replaced during installation
string GPT_pre_apiUrl = "https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions"; // will be replaced during installation
string GPT_pre_delay_ms = "0"; // will be replaced during installation
string GPT_pre_retry_mode = "0"; // will be replaced during installation
string GPT_pre_context_subtitle_count = "3"; // number of previous subtitle entries used as context
string GPT_pre_context_cache_mode = "off"; // auto | off
string GPT_pre_prompt_cache_retention = ""; // ""(default), in-memory, 24h (OpenAI official only)
string GPT_pre_gemini_cached_content = ""; // optional cachedContents/... name for Gemini OpenAI-compatible endpoint
string GPT_pre_small_model = "0"; // 0 | 1
string GPT_pre_check_hallucination = "0"; // 0 | 1
string GPT_pre_model_token_limits_json = "{}"; // serialized token limit rules (injected by installer)

// Context-specific identifiers to prevent collisions with other subtitle translator scripts.
const string GPT_CTX_TRANSLATION_FAILURE_WARNING_PREFIX = "[Translation failed - please share a screenshot with the developer] ";

string GPT_api_key = GPT_pre_api_key;
string GPT_selected_model = GPT_pre_selected_model; // Default model
string GPT_apiUrl = GPT_pre_apiUrl; // Default API URL
string GPT_delay_ms = GPT_pre_delay_ms; // Request delay in ms
string GPT_retry_mode = GPT_pre_retry_mode; // Auto retry mode
string GPT_context_subtitle_count = GPT_pre_context_subtitle_count; // Previous subtitle entries used as context
string GPT_context_cache_mode = GPT_pre_context_cache_mode; // auto | off
string GPT_prompt_cache_retention = GPT_pre_prompt_cache_retention; // "" | in-memory | 24h
string GPT_gemini_cached_content = GPT_pre_gemini_cached_content; // cachedContents/... (optional)
string GPT_small_model = GPT_pre_small_model;
string GPT_check_hallucination = GPT_pre_check_hallucination;
string GPT_UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64)";
array<string> GPT_subtitleHistory;  // Global subtitle history
array<string> GPT_translationHistory;  // Global translation history (for context-dedup)
bool GPT_context_cache_disabled_for_session = false;
bool GPT_disable_thinking_for_session = false; // model rejected enable_thinking parameter
string GPT_context_cache_disable_key = "";
bool GPT_token_rules_initialized = false;
int GPT_default_model_token_limit = 4096;
array<string> GPT_token_rule_types;
array<string> GPT_token_rule_values;
array<int> GPT_token_rule_limits;

// Helper functions to load configuration while respecting installer defaults
string BuildConfigSentinel(const string &in key) {
    return "#__POTPLAYER_CFG_UNSET__#" + key + "#__";
}

string LoadInstallerConfig(const string &in key, const string &in installerValue, const string &in fallbackKey = "") {
    string sentinel = BuildConfigSentinel(key);
    string storedValue = HostLoadString(key, sentinel);
    if (storedValue == sentinel && fallbackKey != "") {
        string fallbackSentinel = BuildConfigSentinel(fallbackKey);
        string fallbackValue = HostLoadString(fallbackKey, fallbackSentinel);
        if (fallbackValue != fallbackSentinel && fallbackValue != "")
            return fallbackValue;
    }
    if (storedValue == sentinel || (storedValue == "" && installerValue != ""))
        return installerValue;
    return storedValue;
}

void EnsureConfigDefault(const string &in key, const string &in value) {
    string sentinel = BuildConfigSentinel(key);
    string stored = HostLoadString(key, sentinel);
    if (stored == sentinel || (stored == "" && value != ""))
        HostSaveString(key, value);
}

void EnsureInstallerDefaultsPersisted() {
    EnsureConfigDefault("gpt_api_key", GPT_pre_api_key);
    EnsureConfigDefault("gpt_selected_model", GPT_pre_selected_model);
    EnsureConfigDefault("gpt_apiUrl", GPT_pre_apiUrl);
    EnsureConfigDefault("gpt_delay_ms", GPT_pre_delay_ms);
    EnsureConfigDefault("gpt_retry_mode", GPT_pre_retry_mode);
    EnsureConfigDefault("gpt_context_subtitle_count", GPT_pre_context_subtitle_count);
    EnsureConfigDefault("gpt_context_cache_mode", GPT_pre_context_cache_mode);
    EnsureConfigDefault("gpt_prompt_cache_retention", GPT_pre_prompt_cache_retention);
    EnsureConfigDefault("gpt_gemini_cached_content", GPT_pre_gemini_cached_content);
    EnsureConfigDefault("gpt_small_model", GPT_pre_small_model);
    EnsureConfigDefault("gpt_check_hallucination", GPT_pre_check_hallucination);
}

void RefreshConfiguration() {
    EnsureInstallerDefaultsPersisted();
    GPT_api_key = LoadInstallerConfig("gpt_api_key", GPT_pre_api_key, "wc_api_key");
    GPT_selected_model = LoadInstallerConfig("gpt_selected_model", GPT_pre_selected_model, "wc_selected_model");
    GPT_apiUrl = LoadInstallerConfig("gpt_apiUrl", GPT_pre_apiUrl, "wc_apiUrl");
    GPT_delay_ms = LoadInstallerConfig("gpt_delay_ms", GPT_pre_delay_ms, "wc_delay_ms");
    GPT_retry_mode = LoadInstallerConfig("gpt_retry_mode", GPT_pre_retry_mode, "wc_retry_mode");
    GPT_context_subtitle_count = LoadInstallerConfig("gpt_context_subtitle_count", GPT_pre_context_subtitle_count);
    GPT_context_cache_mode = NormalizeCacheMode(LoadInstallerConfig("gpt_context_cache_mode", GPT_pre_context_cache_mode));
    GPT_prompt_cache_retention = NormalizePromptCacheRetention(LoadInstallerConfig("gpt_prompt_cache_retention", GPT_pre_prompt_cache_retention));
    GPT_gemini_cached_content = LoadInstallerConfig("gpt_gemini_cached_content", GPT_pre_gemini_cached_content).Trim();
    GPT_small_model = LoadInstallerConfig("gpt_small_model", GPT_pre_small_model);
    GPT_check_hallucination = LoadInstallerConfig("gpt_check_hallucination", GPT_pre_check_hallucination);
}

// Supported Language List
array<string> LangTable =
{
    "", // Auto Detect
    "af", // Afrikaans
    "sq", // Albanian
    "am", // Amharic
    "ar", // Arabic
    "hy", // Armenian
    "az", // Azerbaijani
    "eu", // Basque
    "be", // Belarusian
    "bn", // Bengali
    "bs", // Bosnian
    "bg", // Bulgarian
    "ca", // Catalan
    "ceb", // Cebuano
    "ny", // Chichewa
    "zh-CN", // Chinese (Simplified)
    "zh-TW", // Chinese (Traditional)
    "co", // Corsican
    "hr", // Croatian
    "cs", // Czech
    "da", // Danish
    "nl", // Dutch
    "en", // English
    "eo", // Esperanto
    "et", // Estonian
    "tl", // Filipino
    "fi", // Finnish
    "fr", // French
    "fy", // Frisian
    "gl", // Galician
    "ka", // Georgian
    "de", // German
    "el", // Greek
    "gu", // Gujarati
    "ht", // Haitian Creole
    "ha", // Hausa
    "haw", // Hawaiian
    "he", // Hebrew
    "hi", // Hindi
    "hmn", // Hmong
    "hu", // Hungarian
    "is", // Icelandic
    "ig", // Igbo
    "id", // Indonesian
    "ga", // Irish
    "it", // Italian
    "ja", // Japanese
    "jw", // Javanese
    "kn", // Kannada
    "kk", // Kazakh
    "km", // Khmer
    "ko", // Korean
    "ku", // Kurdish (Kurmanji)
    "ky", // Kyrgyz
    "lo", // Lao
    "la", // Latin
    "lv", // Latvian
    "lt", // Lithuanian
    "lb", // Luxembourgish
    "mk", // Macedonian
    "ms", // Malay
    "mg", // Malagasy
    "ml", // Malayalam
    "mt", // Maltese
    "mi", // Maori
    "mr", // Marathi
    "mn", // Mongolian
    "my", // Myanmar (Burmese)
    "ne", // Nepali
    "no", // Norwegian
    "ps", // Pashto
    "fa", // Persian
    "pl", // Polish
    "pt", // Portuguese
    "pa", // Punjabi
    "ro", // Romanian
    "ru", // Russian
    "sm", // Samoan
    "gd", // Scots Gaelic
    "sr", // Serbian
    "st", // Sesotho
    "sn", // Shona
    "sd", // Sindhi
    "si", // Sinhala
    "sk", // Slovak
    "sl", // Slovenian
    "so", // Somali
    "es", // Spanish
    "su", // Sundanese
    "sw", // Swahili
    "sv", // Swedish
    "tg", // Tajik
    "ta", // Tamil
    "te", // Telugu
    "th", // Thai
    "tr", // Turkish
    "uk", // Ukrainian
    "ur", // Urdu
    "uz", // Uzbek
    "vi", // Vietnamese
    "cy", // Welsh
    "xh", // Xhosa
    "yi", // Yiddish
    "yo", // Yoruba
    "zu"  // Zulu
};

array<string> GetSrcLangs() {
    array<string> ret = LangTable;
    return ret;
}

array<string> GetDstLangs() {
    array<string> ret = LangTable;
    return ret;
}

bool IsDigits(const string &in s) {
    if (s.length() == 0)
        return false;
    for (uint i = 0; i < s.length(); i++) {
        uint8 c = s[i];
        if (c < 48 || c > 57)
            return false;
    }
    return true;
}

int ParseInt(const string &in s) {
    int v = 0;
    for (uint i = 0; i < s.length(); i++) {
        uint8 c = s[i];
        if (c < 48 || c > 57)
            return 0;
        if (v > 214748364) return 0;  // Overflow protection
        v = v * 10 + (c - 48);
    }
    return v;
}

string BuildAuthHeaders(const string &in key) {
    string trimmedKey = key.Trim();
    string lowerKey = string(trimmedKey).MakeLower();
    string headers = "Content-Type: application/json";
    if (trimmedKey != "" && lowerKey != "nullkey")
        headers = "Authorization: Bearer " + trimmedKey + "\n" + headers;
    return headers;
}

// API Key and API Base verification process
string ServerLogin(string User, string Pass) {
    RefreshConfiguration();
    string errorAccum = "";
    User = User.Trim();
    Pass = Pass.Trim();
    string lowerPass = string(Pass).MakeLower();
    array<string> tokens;
    int start = 0;
    for (int i = 0; i <= int(User.length()); i++) {
        if (i == int(User.length()) || User.substr(i, 1) == "|") {
            string token = User.substr(start, i - start).Trim();
            tokens.insertLast(token);
            start = i + 1;
        }
    }
    string userModel = "";
    string customApiUrl = "";
    bool allowNullApiKey = (Pass == "" || lowerPass == "nullkey");
    string delayToken = "";
    string retryToken = "";
    string contextSubtitleCountToken = "";
    string cacheToken = "";
    string promptCacheRetentionToken = GPT_prompt_cache_retention;
    string geminiCachedContentToken = GPT_gemini_cached_content;
    string smallModelToken = "";
    string halluToken = "";
    string normalizedCacheMode = GPT_context_cache_mode;
    if (tokens.length() >= 1) {
        userModel = tokens[0];
    }
    for (int i = 1; i < int(tokens.length()); i++) {
        string t = tokens[i];
        string lowered = ToLower(t);
        if (lowered == "nullkey")
            allowNullApiKey = true;
        else if (lowered.length() >= 5 && lowered.substr(0,5) == "retry" && IsDigits(t.substr(5)))
            retryToken = t.substr(5);
        else if (IsDigits(t))
            delayToken = t;
        else if (lowered.length() >= 6 && lowered.substr(0,6) == "cache=")
            cacheToken = lowered.substr(6);
        else if (lowered.length() >= 8 && lowered.substr(0,8) == "context=" && IsDigits(t.substr(8)))
            contextSubtitleCountToken = t.substr(8);
        else if (lowered.length() >= 13 && lowered.substr(0,13) == "contextlines=" && IsDigits(t.substr(13)))
            contextSubtitleCountToken = t.substr(13);
        else if (lowered.length() >= 15 && lowered.substr(0,15) == "subtitlecount=" && IsDigits(t.substr(15)))
            contextSubtitleCountToken = t.substr(15);
        else if (lowered == "cacheauto" || lowered == "cacheon" || lowered == "cache")
            cacheToken = "auto";
        else if (lowered == "cacheoff" || lowered == "nocache")
            cacheToken = "off";
        else if (lowered.length() >= 10 && lowered.substr(0,10) == "retention=")
            promptCacheRetentionToken = lowered.substr(10);
        else if (lowered == "cache24h")
            promptCacheRetentionToken = "24h";
        else if (lowered == "cachemem" || lowered == "cachememory")
            promptCacheRetentionToken = "in-memory";
        else if (lowered.length() >= 15 && lowered.substr(0,15) == "cachedcontent=")
            geminiCachedContentToken = t.substr(15).Trim();
        else if (lowered.length() >= 15 && lowered.substr(0,15) == "cached_content=")
            geminiCachedContentToken = t.substr(15).Trim();
        else if (lowered.length() >= 7 && lowered.substr(0,7) == "gcache=")
            geminiCachedContentToken = t.substr(7).Trim();
        else if (lowered == "gcacheoff" || lowered == "nocachedcontent")
            geminiCachedContentToken = "";
        else if (lowered == "smallmodel=1" || lowered == "smallmodel")
            smallModelToken = "1";
        else if (lowered == "smallmodel=0")
            smallModelToken = "0";
        else if (lowered == "checkhallucination=1" || lowered == "hallucination=1")
            halluToken = "1";
        else if (lowered == "checkhallucination=0" || lowered == "hallucination=0")
            halluToken = "0";
        else if (customApiUrl == "")
            customApiUrl = t;
    }
    if (retryToken != "")
        GPT_retry_mode = retryToken;
    if (delayToken != "")
        GPT_delay_ms = delayToken;
    if (contextSubtitleCountToken != "")
        GPT_context_subtitle_count = contextSubtitleCountToken;
    if (cacheToken != "")
        normalizedCacheMode = NormalizeCacheMode(cacheToken);
    else
        normalizedCacheMode = NormalizeCacheMode(normalizedCacheMode);
    promptCacheRetentionToken = NormalizePromptCacheRetention(promptCacheRetentionToken);
    if (smallModelToken != "")
        GPT_small_model = smallModelToken;
    if (halluToken != "")
        GPT_check_hallucination = halluToken;
    
    if (userModel == "")
        userModel = GPT_selected_model;

    if (userModel == "") {
        errorAccum += "Model name not entered. Please enter a valid model name.\n";
        return errorAccum;
    }
    string apiUrlLocal = "";
    if (customApiUrl != "") {
        apiUrlLocal = customApiUrl;
        while (apiUrlLocal != "" && apiUrlLocal.substr(apiUrlLocal.length()-1, 1) == "/")
            apiUrlLocal = apiUrlLocal.substr(0, apiUrlLocal.length()-1);
    } else {
        apiUrlLocal = GPT_apiUrl;
    }

    if (Pass == "")
        Pass = GPT_api_key;
    
    if (string(Pass).MakeLower() == "nullkey")
        allowNullApiKey = true;

    if (!allowNullApiKey && Pass == "") {
        errorAccum += "API Key not configured. Please enter a valid API Key.\n";
        return errorAccum;
    }
    string storedApiKey = (lowerPass == "nullkey" || (allowNullApiKey && Pass == "")) ? "nullkey" : Pass;
    bool isOfficial = IsOpenAIOfficialApiUrl(apiUrlLocal);
    bool isGemini = IsGeminiApiUrl(apiUrlLocal);
    bool isBailianLogin = IsBailianApiUrl(apiUrlLocal);
    string verifyHeaders = BuildAuthHeaders(Pass);
    string testSystemMsg = "You are a test assistant.";
    string testUserMsg = "Hello";
    string testPromptCacheKey = BuildPromptCacheKey(userModel, "verify", "verify");
    string testRequestData = BuildChatPayload(
        userModel,
        testSystemMsg,
        testUserMsg,
        isOfficial,
        testPromptCacheKey,
        promptCacheRetentionToken,
        isGemini,
        geminiCachedContentToken,
        isBailianLogin,
        false
    );
    string testErrorMsg = "";
    string testResponse = HostUrlGetString(apiUrlLocal, GPT_UserAgent, verifyHeaders, testRequestData);
    if (testResponse != "") {
        JsonReader testReader;
        JsonValue testRoot;
            if (testReader.parse(testResponse, testRoot)) {
                if (testRoot.isObject() && testRoot["choices"].isArray() && testRoot["choices"].size() > 0) {
                    GPT_selected_model = userModel;
                    GPT_api_key = storedApiKey;
                    HostSaveString("gpt_api_key", GPT_api_key);
                    HostSaveString("gpt_selected_model", GPT_selected_model);
                    HostSaveString("gpt_apiUrl", apiUrlLocal);
                    HostSaveString("gpt_delay_ms", GPT_delay_ms);
                    HostSaveString("gpt_retry_mode", GPT_retry_mode);
                    HostSaveString("gpt_context_subtitle_count", GPT_context_subtitle_count);
                    GPT_context_cache_mode = normalizedCacheMode;
                    HostSaveString("gpt_context_cache_mode", GPT_context_cache_mode);
                    GPT_prompt_cache_retention = promptCacheRetentionToken;
                    HostSaveString("gpt_prompt_cache_retention", GPT_prompt_cache_retention);
                    GPT_gemini_cached_content = geminiCachedContentToken;
                    HostSaveString("gpt_gemini_cached_content", GPT_gemini_cached_content);
                    HostSaveString("gpt_small_model", GPT_small_model);
                    HostSaveString("gpt_check_hallucination", GPT_check_hallucination);
                    GPT_context_cache_disabled_for_session = false;
                    GPT_context_cache_disable_key = "";
                    return "200 ok";
                } else {
                    if (testRoot.isObject() && testRoot["error"].isObject() && testRoot["error"]["message"].isString()) {
                        errorAccum += "Test message error: " + testRoot["error"]["message"].asString() + "\n";
                        testErrorMsg = testRoot["error"]["message"].asString();
                    } else
                        errorAccum += "Test message response invalid.\n";
            }
        } else {
            errorAccum += "Failed to parse test message response.\n";
        }
    } else {
        errorAccum += "No response from server when sending test message.\n";
    }
    // Fallback: if Bailian API rejected enable_thinking parameter, retry without it
    if (isBailianLogin && testErrorMsg != "" && ToLower(testErrorMsg).find("enable_thinking") != -1) {
        HostPrintUTF8("Model does not support enable_thinking, retrying without it.\n");
        GPT_disable_thinking_for_session = true;
        string retryRequestData = BuildChatPayload(
            userModel,
            testSystemMsg,
            testUserMsg,
            isOfficial,
            testPromptCacheKey,
            promptCacheRetentionToken,
            isGemini,
            geminiCachedContentToken,
            isBailianLogin,
            true
        );
        string retryResponse = HostUrlGetString(apiUrlLocal, GPT_UserAgent, verifyHeaders, retryRequestData);
        if (retryResponse != "") {
            JsonReader retryReader;
            JsonValue retryRoot;
            if (retryReader.parse(retryResponse, retryRoot)) {
                if (retryRoot.isObject() && retryRoot["choices"].isArray() && retryRoot["choices"].size() > 0) {
                    GPT_selected_model = userModel;
                    GPT_api_key = storedApiKey;
                    HostSaveString("gpt_api_key", GPT_api_key);
                    HostSaveString("gpt_selected_model", GPT_selected_model);
                    HostSaveString("gpt_apiUrl", apiUrlLocal);
                    HostSaveString("gpt_delay_ms", GPT_delay_ms);
                    HostSaveString("gpt_retry_mode", GPT_retry_mode);
                    HostSaveString("gpt_context_subtitle_count", GPT_context_subtitle_count);
                    GPT_context_cache_mode = normalizedCacheMode;
                    HostSaveString("gpt_context_cache_mode", GPT_context_cache_mode);
                    GPT_prompt_cache_retention = promptCacheRetentionToken;
                    HostSaveString("gpt_prompt_cache_retention", GPT_prompt_cache_retention);
                    GPT_gemini_cached_content = geminiCachedContentToken;
                    HostSaveString("gpt_gemini_cached_content", GPT_gemini_cached_content);
                    HostSaveString("gpt_small_model", GPT_small_model);
                    HostSaveString("gpt_check_hallucination", GPT_check_hallucination);
                    GPT_context_cache_disabled_for_session = false;
                    GPT_context_cache_disable_key = "";
                    return "200 ok (enable_thinking disabled for this model)";
                }
            }
        }
    }

    if (apiUrlLocal.find("chat/completions") == -1) {
        string correctedApiUrl = apiUrlLocal + "/chat/completions";
        bool correctedIsOfficial = IsOpenAIOfficialApiUrl(correctedApiUrl);
        bool correctedIsGemini = IsGeminiApiUrl(correctedApiUrl);
        bool correctedIsBailian = IsBailianApiUrl(correctedApiUrl);
        string correctedTestRequestData = BuildChatPayload(
            userModel,
            testSystemMsg,
            testUserMsg,
            correctedIsOfficial,
            testPromptCacheKey,
            promptCacheRetentionToken,
            correctedIsGemini,
            geminiCachedContentToken,
            correctedIsBailian,
            false
        );
        string correctedTestResponse = HostUrlGetString(correctedApiUrl, GPT_UserAgent, verifyHeaders, correctedTestRequestData);
        if (correctedTestResponse != "") {
            JsonReader correctedReader;
            JsonValue correctedRoot;
            if (correctedReader.parse(correctedTestResponse, correctedRoot)) {
                if (correctedRoot.isObject() && correctedRoot["choices"].isArray() && correctedRoot["choices"].size() > 0) {
                    apiUrlLocal = correctedApiUrl;
                    GPT_selected_model = userModel;
                    GPT_api_key = storedApiKey;
                    HostSaveString("gpt_api_key", GPT_api_key);
                    HostSaveString("gpt_selected_model", GPT_selected_model);
                    HostSaveString("gpt_apiUrl", apiUrlLocal);
                    HostSaveString("gpt_delay_ms", GPT_delay_ms);
                    HostSaveString("gpt_retry_mode", GPT_retry_mode);
                    HostSaveString("gpt_context_subtitle_count", GPT_context_subtitle_count);
                    GPT_context_cache_mode = normalizedCacheMode;
                    HostSaveString("gpt_context_cache_mode", GPT_context_cache_mode);
                    GPT_prompt_cache_retention = promptCacheRetentionToken;
                    HostSaveString("gpt_prompt_cache_retention", GPT_prompt_cache_retention);
                    GPT_gemini_cached_content = geminiCachedContentToken;
                    HostSaveString("gpt_gemini_cached_content", GPT_gemini_cached_content);
                    HostSaveString("gpt_small_model", GPT_small_model);
                    HostSaveString("gpt_check_hallucination", GPT_check_hallucination);
                    GPT_context_cache_disabled_for_session = false;
                    GPT_context_cache_disable_key = "";
                    return "Warning: Your API base was auto-corrected to: " + apiUrlLocal + "\n200 ok";
                } else {
                    if (correctedRoot.isObject() && correctedRoot["error"].isObject() && correctedRoot["error"]["message"].isString())
                        errorAccum += "Auto-correction test error: " + correctedRoot["error"]["message"].asString() + "\n";
                    else
                        errorAccum += "Auto-correction test response invalid.\n";
                }
            } else {
                errorAccum += "Failed to parse auto-correction test response.\n";
            }
        } else {
            errorAccum += "No response from server after auto-correction.\n";
        }
    }
    if (isOfficial) {
        string verifyUrl = "";
        int pos = apiUrlLocal.find("chat/completions");
        if (pos != -1)
            verifyUrl = apiUrlLocal.substr(0, pos) + "models";
        else
            verifyUrl = "https://api.openai.com/v1/models";
        string verifyResponse = HostUrlGetString(verifyUrl, GPT_UserAgent, verifyHeaders, "");
        if (verifyResponse == "")
            errorAccum += "Server connection failed: Unable to retrieve model list. Check network and API Base.\n";
        else {
            JsonReader reader;
            JsonValue root;
            if (!reader.parse(verifyResponse, root))
                errorAccum += "Failed to parse model list response. Check API Base and API Key.\n";
            else {
                if (root.isObject() && root["error"].isObject() && root["error"]["message"].isString())
                    errorAccum += "API error during model list retrieval: " + root["error"]["message"].asString() + "\n";
                else if (root.isObject() && root["data"].isArray()) {
                    bool modelFound = false;
                    int dataSize = root["data"].size();
                    for (int i = 0; i < dataSize; i++) {
                        JsonValue element = root["data"][i];
                        if (element.isObject() && element["id"].isString()) {
                            if (element["id"].asString() == userModel) {
                                modelFound = true;
                                break;
                            }
                        }
                    }
                    if (!modelFound)
                        errorAccum += "The specified model '" + userModel + "' is not available in the official API.\n";
                } else
                    errorAccum += "Invalid format of model list response.\n";
            }
        }
    } else {
        errorAccum += "API verification via model list skipped for third-party API Base.\n";
    }
    if (!allowNullApiKey && Pass.length() < 20)
        errorAccum += "API Key verification failed: API Key length may too short. Please verify your API Key.\n";
    if (errorAccum != "")
        return "API verification failed with the following issues:\n\n" + errorAccum;
    return "Unknown error during API verification. Please check your network, API Key, and API Base settings.\n";
}

// Logout Interface to clear model name and API Key
void ServerLogout() {
    GPT_api_key = "";
    GPT_selected_model = GPT_pre_selected_model;
    GPT_apiUrl = GPT_pre_apiUrl;
    GPT_delay_ms = GPT_pre_delay_ms;
    GPT_retry_mode = GPT_pre_retry_mode;
    GPT_context_subtitle_count = GPT_pre_context_subtitle_count;
    GPT_context_cache_mode = GPT_pre_context_cache_mode;
    GPT_prompt_cache_retention = GPT_pre_prompt_cache_retention;
    GPT_gemini_cached_content = GPT_pre_gemini_cached_content;
    GPT_small_model = GPT_pre_small_model;
    GPT_context_cache_disabled_for_session = false;
    GPT_context_cache_disable_key = "";
    GPT_disable_thinking_for_session = false;
    GPT_disable_thinking_for_session = false;
    HostSaveString("gpt_api_key", "");
    HostSaveString("gpt_selected_model", GPT_selected_model);
    HostSaveString("gpt_apiUrl", GPT_apiUrl);
    HostSaveString("gpt_delay_ms", GPT_delay_ms);
    HostSaveString("gpt_retry_mode", GPT_retry_mode);
    HostSaveString("gpt_context_subtitle_count", GPT_context_subtitle_count);
    HostSaveString("gpt_context_cache_mode", GPT_context_cache_mode);
    HostSaveString("gpt_prompt_cache_retention", GPT_prompt_cache_retention);
    HostSaveString("gpt_gemini_cached_content", GPT_gemini_cached_content);
    HostSaveString("gpt_small_model", GPT_small_model);
    HostSaveString("gpt_check_hallucination", GPT_check_hallucination);
    HostPrintUTF8("Successfully logged out.\n");
}

// JSON String Escape Function
string JsonEscape(const string &in input) {
    string output = input;
    output.replace("\\", "\\\\");
    output.replace("\"", "\\\"");
    output.replace("\n", "\\n");
    output.replace("\r", "\\r");
    output.replace("\t", "\\t");
    return output;
}

// Function to estimate token count based on character length
int EstimateTokenCount(const string &in text) {
    return int(float(text.length()) / 4);
}

// Function to get the model's maximum context length
int GetModelMaxTokens(const string &in modelName) {
    EnsureTokenRulesLoaded();
    string trimmedModel = modelName.Trim();
    if (trimmedModel == "")
        return GPT_default_model_token_limit;

    for (uint i = 0; i < GPT_token_rule_types.length(); i++) {
        string matchType = GPT_token_rule_types[i];
        string matchValue = GPT_token_rule_values[i];
        int limit = GPT_token_rule_limits[i];
        if (matchType == "prefix") {
            if (trimmedModel.length() >= matchValue.length() &&
                trimmedModel.substr(0, matchValue.length()) == matchValue)
                return limit;
        } else if (matchType == "contains") {
            if (trimmedModel.find(matchValue) != -1)
                return limit;
        } else if (matchType == "equals") {
            if (trimmedModel == matchValue)
                return limit;
        }
    }

    return GPT_default_model_token_limit;
}

// Translation Function
string Translate(string Text, string &in SrcLang, string &in DstLang) {
    RefreshConfiguration();

    if (GPT_api_key == "") {
        HostPrintUTF8("API Key not configured. Please enter it in the settings menu.\n");
        return "";
    }

    if (DstLang == "" || DstLang == "Auto Detect") {
        HostPrintUTF8("Target language not specified. Please select a target language.\n");
        return "";
    }

    if (SrcLang == "" || SrcLang == "Auto Detect") {
        SrcLang = "";
    }

    // Skip non-translatable content (pure numbers, punctuation, symbols) - 0 tokens
    if (!IsTranslatable(Text))
        return Text;

    // Skip onomatopoeia and highly repetitive text (ASR mishearing background music) - 0 tokens
    // Return empty so PotPlayer does not display the noisy music subtitle
    if (IsOnomatopoeiaOrRepetitive(Text))
        return "";

    // Normalize newlines in subtitle text to spaces (avoid delimiter ambiguity)
    string cleanText = Text;
    cleanText.replace("\r\n", " ");
    cleanText.replace("\n", " ");
    cleanText.replace("\r", " ");
    cleanText = cleanText.Trim();
    if (cleanText == "")
        return Text;

    GPT_subtitleHistory.insertLast(cleanText);

    int maxContextLines = ParseInt(GPT_context_subtitle_count);
    if (maxContextLines < 0)
        maxContextLines = 0;
    if (maxContextLines > 20)
        maxContextLines = 20;

    array<string> contextSegments;
    int addedContextLines = 0;
    string currentText = cleanText;
    int idx = int(GPT_subtitleHistory.length()) - 2;
    while (idx >= 0 && addedContextLines < maxContextLines) {
        string subtitle = GPT_subtitleHistory[idx].Trim();
        if (subtitle == "" || subtitle == currentText) {
            idx--;
            continue;
        }
        // Normalize context lines too
        subtitle.replace("\r\n", " ");
        subtitle.replace("\n", " ");
        subtitle.replace("\r", " ");
        subtitle = subtitle.Trim();
        if (subtitle == "") {
            idx--;
            continue;
        }
        contextSegments.insertAt(0, subtitle);
        addedContextLines++;
        idx--;
    }

    string context = "";
    for (uint ctxIndex = 0; ctxIndex < contextSegments.length(); ctxIndex++) {
        if (ctxIndex > 0)
            context += "\n";
        context += contextSegments[ctxIndex];
    }

    int historyTarget = maxContextLines + 32;
    if (historyTarget < 64)
        historyTarget = 64;
    if (historyTarget > 256)
        historyTarget = 256;
    int shrinkTarget = historyTarget - 16;
    if (shrinkTarget < 32)
        shrinkTarget = 32;
    const uint historyTargetCount = historyTarget > 0 ? uint(historyTarget) : 0;
    const uint shrinkTargetCount = shrinkTarget > 0 ? uint(shrinkTarget) : 0;
    if (GPT_subtitleHistory.length() > historyTargetCount) {
        while (GPT_subtitleHistory.length() > shrinkTargetCount) {
            GPT_subtitleHistory.removeAt(0);
        }
    }

    string sourceLabel = (SrcLang == "" ? "Auto Detect" : SrcLang);
    string targetLangCode = DstLang;
    string targetLabel = targetLangCode;

    // Minimal system prompt for token efficiency
    string systemMsg;
    if (context != "") {
        systemMsg = "Translate to " + targetLabel + ". Translate ONLY the text after >>>. Earlier lines are reference context — never translate, repeat, or merge them into your output.";
    } else {
        systemMsg = "Translate to " + targetLabel + ". Output translation only, never echo the input.";
    }
    string echoRetrySystem = "Translate to " + targetLabel + ". CRITICAL: output only the translated text in the target language. Never repeat or echo the source text. Translate this: ";

    // Minimal user prompt format
    string userMsg;
    if (context != "") {
        userMsg = context + "\n>>> " + cleanText;
    } else {
        userMsg = cleanText;
    }

    bool isOpenAIOfficial = IsOpenAIOfficialApiUrl(GPT_apiUrl);
    bool isGeminiApi = IsGeminiApiUrl(GPT_apiUrl);
    bool isBailian = IsBailianApiUrl(GPT_apiUrl);
    bool enableOpenAIPromptCacheControls = isOpenAIOfficial;
    string promptCacheRetention = isOpenAIOfficial ? NormalizePromptCacheRetention(GPT_prompt_cache_retention) : "";
    string promptCacheKey = isOpenAIOfficial ? BuildPromptCacheKey(GPT_selected_model, sourceLabel, targetLabel) : "";

    string requestData = BuildChatPayload(
        GPT_selected_model,
        systemMsg,
        userMsg,
        enableOpenAIPromptCacheControls,
        promptCacheKey,
        promptCacheRetention,
        isGeminiApi,
        GPT_gemini_cached_content,
        isBailian,
        GPT_disable_thinking_for_session
    );

    string headers = BuildAuthHeaders(GPT_api_key);
    int delayInt = ParseInt(GPT_delay_ms);
    int retryModeInt = ParseInt(GPT_retry_mode);

    string cacheSessionKey = GPT_context_cache_mode + "|" + GPT_apiUrl + "|" + GPT_selected_model + "|" + promptCacheRetention + "|" + GPT_gemini_cached_content;
    if (cacheSessionKey != GPT_context_cache_disable_key)
        GPT_context_cache_disabled_for_session = false;
    GPT_context_cache_disable_key = cacheSessionKey;

    string translation = "";
    string response = "";
    bool echoRetried = false;

    // Unified Retry Loop: Handles Network, API Errors, and Hallucinations
    int maxRetries = retryModeInt;
    if (maxRetries < 0) maxRetries = 0;
    if (maxRetries > 10) maxRetries = 10; // Hard cap to prevent infinite loops / UI freeze
    

    int attempts = 0;

    while (attempts <= maxRetries) {
        if (attempts > 0) {
            if (delayInt > 0) HostSleep(delayInt);
        }

        translation = "";
        response = "";

        // Try Context Caching first if enabled
        if (GPT_context_cache_mode != "off" && !GPT_context_cache_disabled_for_session && ShouldTryResponsesEndpoint(GPT_apiUrl)) {
            string responsesUrl = DeriveResponsesUrl(GPT_apiUrl);
            string cacheFailure = "";
            if (responsesUrl != "") {
                translation = TranslateWithResponses(responsesUrl, headers, GPT_selected_model, systemMsg, userMsg, promptCacheKey, promptCacheRetention, cacheFailure);
            } else {
                cacheFailure = "Unable to resolve responses endpoint from current API URL.";
            }
            if (translation != "") {
                            translation = CleanTranslationOutput(translation);
                            translation = StripRepeatedContext(translation);
                            if (translation == "")
                                continue;
                            // Echo detection: model returned source text unchanged
                            if (!echoRetried && IsEchoTranslation(translation, cleanText)) {
                                HostPrintUTF8("Echo detected (model returned source text). Retrying with stronger prompt...\n");
                                echoRetried = true;
                                requestData = BuildChatPayload(GPT_selected_model, echoRetrySystem, userMsg,
                                    enableOpenAIPromptCacheControls, promptCacheKey, promptCacheRetention,
                                    isGeminiApi, GPT_gemini_cached_content, isBailian, GPT_disable_thinking_for_session);
                                attempts++;
                                continue;
                            }
                            // Check for Hallucination
                            if (GPT_check_hallucination == "1" && IsOverlongTranslation(translation, Text)) {
                                HostPrintUTF8("Hallucination detected (Length > 5x). Retrying...\n");
                                attempts++;
                                continue; 
                            }                break; // Success
            }

            if (!GPT_context_cache_disabled_for_session) {
                string fallbackMessage = cacheFailure == "" ? "Context caching failed." : "Context caching failed: " + cacheFailure;
                if (ShouldDisableContextCacheForSession(cacheFailure)) {
                    // Permanent capability errors should disable responses attempts for this session.
                    GPT_context_cache_disabled_for_session = true;
                    HostPrintUTF8(fallbackMessage + "\nUsing chat completions for this session.\n");
                } else {
                    HostPrintUTF8(fallbackMessage + "\nUsing chat completions for this request.\n");
                }
            }
        }

        // Standard Chat Completion
        response = ExecuteSimple(GPT_apiUrl, headers, requestData);

        if (response == "") {
             // Network failure
             attempts++;
             continue;
        }

        JsonReader Reader;
        JsonValue Root;
        if (!Reader.parse(response, Root)) {
            HostPrintUTF8("Failed to parse API response.\n");
            attempts++;
            continue;
        }

        JsonValue choices = Root["choices"];
        if (choices.isArray() && choices.size() > 0 &&
            choices[0].isObject() &&
            choices[0]["message"].isObject() &&
            choices[0]["message"]["content"].isString()) {
            translation = choices[0]["message"]["content"].asString();
            // Strip thinking tags from reasoning models
            translation = StripThinkTags(translation);
            // Remove echoed >>> delimiter and any translated context lines
            translation = CleanTranslationOutput(translation);
            translation = StripRepeatedContext(translation);
            // Empty content (reasoning model bug or content filter) -> return original
            if (translation == "") {
                HostPrintUTF8("Empty content received, returning original text.\n");
                return Text;
            }
            // Echo detection: model returned source text unchanged
            if (!echoRetried && IsEchoTranslation(translation, cleanText)) {
                HostPrintUTF8("Echo detected (model returned source text). Retrying with stronger prompt...\n");
                echoRetried = true;
                requestData = BuildChatPayload(GPT_selected_model, echoRetrySystem, userMsg,
                    enableOpenAIPromptCacheControls, promptCacheKey, promptCacheRetention,
                    isGeminiApi, GPT_gemini_cached_content, isBailian, GPT_disable_thinking_for_session);
                attempts++;
                continue;
            }
            // Check finish_reason for truncation
            if (choices[0]["finish_reason"].isString() && choices[0]["finish_reason"].asString() == "length") {
                HostPrintUTF8("Warning: translation truncated due to max token limit.\n");
            }
            // Check for Hallucination
            if (GPT_check_hallucination == "1" && IsOverlongTranslation(translation, Text)) {
                HostPrintUTF8("Hallucination detected (Length > 5x). Retrying...\n");
                attempts++;
                continue;
            }
            break; // Success
        } else if (Root.isObject() &&
                   Root["error"].isObject() &&
                   Root["error"]["message"].isString()) {
            string errorMessage = Root["error"]["message"].asString();
            HostPrintUTF8("API Error: " + errorMessage + "\n");
            string loweredError = ToLower(errorMessage);
            // Check if enable_thinking is not supported by this model
            if (isBailian && !GPT_disable_thinking_for_session && loweredError.find("enable_thinking") != -1) {
                HostPrintUTF8("Model does not support enable_thinking, disabling for this session.\n");
                GPT_disable_thinking_for_session = true;
                requestData = BuildChatPayload(
                    GPT_selected_model,
                    systemMsg,
                    userMsg,
                    enableOpenAIPromptCacheControls,
                    promptCacheKey,
                    promptCacheRetention,
                    isGeminiApi,
                    GPT_gemini_cached_content,
                    isBailian,
                    true
                );
                continue;
            }
            if (enableOpenAIPromptCacheControls && loweredError.find("prompt_cache") != -1) {
                enableOpenAIPromptCacheControls = false;
                requestData = BuildChatPayload(
                    GPT_selected_model,
                    systemMsg,
                    userMsg,
                    false,
                    promptCacheKey,
                    promptCacheRetention,
                    isGeminiApi,
                    GPT_gemini_cached_content,
                    isBailian,
                    GPT_disable_thinking_for_session
                );
                HostPrintUTF8("Prompt cache control fields are unsupported on this endpoint. Retrying without them.\n");
            }
             // API returned an error (e.g. rate limit, context length). 
             // Should we retry? Usually yes for rate limits, maybe no for invalid request.
             // For simplicity and robustness, we retry.
            attempts++;
            continue;
        } else {
            HostPrintUTF8("Translation failed. Unknown response format.\n");
            attempts++;
            continue;
        }
    }

    if (translation == "") {
         string failureMessage = "Translation failed after retries.";
         if (response != "") failureMessage += " Last response: " + response;
         HostPrintUTF8(failureMessage + "\n");
         return FormatFailureTranslation(response, "Translation failed. Check settings and network.");
    }

    bool isFailureTranslation = translation.length() >= GPT_CTX_TRANSLATION_FAILURE_WARNING_PREFIX.length() &&
                                translation.substr(0, GPT_CTX_TRANSLATION_FAILURE_WARNING_PREFIX.length()) == GPT_CTX_TRANSLATION_FAILURE_WARNING_PREFIX;

    if (!isFailureTranslation && GPT_selected_model.find("gemini") != -1) {
        while (translation.length() > 0 && translation.substr(translation.length() - 1, 1) == "\n") {
            translation = translation.substr(0, translation.length() - 1);
        }
    }
    if (!isFailureTranslation && (targetLangCode == "fa" || targetLangCode == "ar" || targetLangCode == "he")) {
        string UNICODE_RLE = "\u202B";
        translation = UNICODE_RLE + translation;
    }
    // Store successful translation for context-dedup
    GPT_translationHistory.insertLast(translation.Trim());
    int trHistTarget = 64;
    if (int(GPT_translationHistory.length()) > trHistTarget) {
        while (int(GPT_translationHistory.length()) > trHistTarget - 16) {
            GPT_translationHistory.removeAt(0);
        }
    }

    SrcLang = "UTF8";
    DstLang = "UTF8";
    return translation.Trim();
}

string FormatFailureTranslation(const string &in rawResponse, const string &in fallbackMessage) {
    string detail = rawResponse.Trim();
    if (detail == "")
        detail = fallbackMessage;
    return GPT_CTX_TRANSLATION_FAILURE_WARNING_PREFIX + detail;
}

// Plugin Initialization
void OnInitialize() {
    HostPrintUTF8("AI translation plugin loaded.\n");
    RefreshConfiguration();
    GPT_context_cache_disabled_for_session = false;
    GPT_context_cache_disable_key = "";
    if (GPT_api_key != "") {
        HostPrintUTF8("Saved API Key, model name, and API URL loaded.\n");
    }
}

// Plugin Finalization
void OnFinalize() {
    HostPrintUTF8("AI translation plugin unloaded.\n");
}
string ToLower(const string &in s) {
    return s.MakeLower();
}

string NormalizeCacheMode(const string &in mode) {
    string trimmed = mode.Trim();
    if (trimmed == "")
        return "auto";
    string lower = ToLower(trimmed);
    if (lower == "off" || lower == "disable" || lower == "disabled" || lower == "chat")
        return "off";
    return "auto";
}

string NormalizePromptCacheRetention(const string &in retention) {
    string trimmed = retention.Trim();
    if (trimmed == "")
        return "";
    string lower = ToLower(trimmed);
    if (lower == "24h")
        return "24h";
    if (lower == "in_memory" || lower == "in-memory" || lower == "memory" || lower == "mem" || lower == "default")
        return "in-memory";
    return "";
}

bool IsOpenAIOfficialApiUrl(const string &in apiUrl) {
    return ToLower(apiUrl).find("api.openai.com") != -1;
}

bool IsGeminiApiUrl(const string &in apiUrl) {
    string lower = ToLower(apiUrl);
    return lower.find("generativelanguage.googleapis.com") != -1;
}

// Check if URL belongs to Alibaba Cloud Bailian (DashScope)
bool IsBailianApiUrl(const string &in apiUrl) {
    string lower = ToLower(apiUrl);
    if (lower.find("dashscope.aliyuncs.com") != -1)
        return true;
    if (lower.find(".maas.aliyuncs.com") != -1)
        return true;
    return false;
}

// Check if text contains actual translatable content (not just numbers/punctuation/symbols)
bool IsTranslatable(const string &in text) {
    string t = text.Trim();
    if (t == "")
        return false;
    // Check if contains at least one letter (CJK or Latin)
    for (uint i = 0; i < t.length(); i++) {
        uint8 c = t[i];
        // Latin letters
        if ((c >= 65 && c <= 90) || (c >= 97 && c <= 122))
            return true;
        // CJK Unified Ideographs (U+4E00-U+9FFF) - check UTF-8 lead bytes
        if (c >= 0xE4 && c <= 0xE9)
            return true;
        // Hiragana/Katakana (U+3040-U+30FF)
        if (c == 0xE3)
            return true;
        // Hangul (U+AC00-U+D7AF)
        if (c == 0xEA || c == 0xEB || c == 0xEC)
            return true;
        // Cyrillic (U+0400-U+04FF)
        if (c == 0xD0 || c == 0xD1)
            return true;
    }
    return false;
}

// Detect onomatopoeia and highly repetitive text (common from ASR mishearing background music)
// Returns true if text should be passed through without API call (saves tokens)
bool IsOnomatopoeiaOrRepetitive(const string &in text) {
    string t = ToLower(text.Trim());
    if (t == "")
        return false;

    // Music note symbols (♪ U+266A, ♫ U+266B) indicate song/lyrics subtitles
    if (t.find("\xe2\x99\xaa") != -1 || t.find("\xe2\x99\xab") != -1)
        return true;

    // Split into words by common delimiters
    array<string> words;
    string current = "";
    for (uint i = 0; i < t.length(); i++) {
        uint8 c = t[i];
        if ((c >= 97 && c <= 122) || (c >= 48 && c <= 57)) {
            current = current + t.substr(i, 1);
        } else {
            if (current != "") {
                words.insertLast(current);
                current = "";
            }
        }
    }
    if (current != "")
        words.insertLast(current);

    if (words.length() == 0)
        return false;

    // Common onomatopoeia / sound-effect words (ASR often mishears music as these)
    string onomatopoeia = "|boom|bang|crash|beep|buzz|hum|thump|thud|clang|clank|ding|dong|whoosh|swish|swoosh|pow|zap|zip|zoom|roar|growl|hiss|sizzle|crackle|pop|snap|tap|knock|pound|pulse|beat|drum|bass|wub|ooh|aah|ahh|ohh|la|laa|na|naa|hey|yeah|yea|yay|whoa|woah|wow|uh|um|hmm|mmm|huh|yo|ay|oy|doo|duh|wee|woo|yah|yep|whoo|shh|hush|blah|meh|nah|";

    int wordCount = 0;
    int onoCount = 0;
    // Count unique words
    array<string> uniqueWords;
    for (uint i = 0; i < words.length(); i++) {
        string w = words[i];
        if (w == "")
            continue;
        wordCount++;
        // Check onomatopoeia
        if (onomatopoeia.find("|" + w + "|") != -1)
            onoCount++;
        // Track unique
        bool found = false;
        for (uint j = 0; j < uniqueWords.length(); j++) {
            if (uniqueWords[j] == w) {
                found = true;
                break;
            }
        }
        if (!found)
            uniqueWords.insertLast(w);
    }

    if (wordCount == 0)
        return false;

    // All words are onomatopoeia -> skip (e.g. "boom boom boom", "la la la")
    if (onoCount == wordCount)
        return true;

    // High repetition: 3+ words and <=2 unique words (e.g. "boom boom boom boom")
    if (wordCount >= 3 && uniqueWords.length() <= 2)
        return true;

    // High repetition ratio: most frequent word accounts for >=60% of all words
    // Catches mixed music/lyrics like "boom boom I love you boom boom"
    if (wordCount >= 5) {
        int maxFreq = 0;
        for (uint ui = 0; ui < uniqueWords.length(); ui++) {
            int cnt = 0;
            for (uint wi = 0; wi < words.length(); wi++) {
                if (words[wi] == uniqueWords[ui])
                    cnt++;
            }
            if (cnt > maxFreq)
                maxFreq = cnt;
        }
        // maxFreq / wordCount >= 0.6  (use integer math to avoid float)
        if (maxFreq * 10 >= wordCount * 6)
            return true;
    }

    return false;
}

// Strip <think>...</think> tags from model output (reasoning models)
string StripThinkTags(const string &in text) {
    if (text == "")
        return text;
    string result = text;
    string lower = ToLower(result);
    // Handle both old  and new 
    while (true) {
        int idx = lower.find("<think");
        if (idx == -1) break;
        int endIdx = lower.find("</think>", idx);
        if (endIdx == -1) {
            result = result.substr(0, idx);
            break;
        }
        result = result.substr(0, idx) + result.substr(endIdx + 8);
        lower = ToLower(result);
    }
    return result.Trim();
}

// Detect when the model simply echoes the source text instead of translating.
// Compares case-insensitively; ignores short texts (<=8 chars) where echo may be legitimate (e.g. "OK").
bool IsEchoTranslation(const string &in translation, const string &in source) {
    string t = ToLower(translation.Trim());
    string s = ToLower(source.Trim());
    if (t == "" || s == "" || s.length() <= 8)
        return false;
    return t == s;
}

// When context subtitles are provided, the model sometimes merges previous lines
// into the current translation (e.g. translating "because X" as "Previous sentence——因为X").
// This strips a leading repeat of a recent translation.
string StripRepeatedContext(const string &in text) {
    if (text == "" || GPT_translationHistory.length() == 0)
        return text;
    string result = text;
    int checkCount = int(GPT_translationHistory.length());
    if (checkCount > 5) checkCount = 5;
    int startIdx = int(GPT_translationHistory.length()) - checkCount;
    for (int hi = startIdx; hi < int(GPT_translationHistory.length()); hi++) {
        string prev = GPT_translationHistory[hi].Trim();
        int plen = int(prev.length());
        if (plen < 6) continue;
        // Only strip if the previous translation occupies a large prefix of the result
        int minMatch = plen * 6 / 10; // at least 60% of prev must match
        if (minMatch < 12) minMatch = 12; // minimum 12 bytes (4 CJK chars) to avoid false positives
        if (minMatch < 6) minMatch = 6;
        if (int(result.length()) <= minMatch) continue;
        // Check if result starts with prev (exact)
        if (int(result.length()) >= plen && result.substr(0, plen) == prev) {
            result = result.substr(plen);
        } else {
            // Try progressively shorter prefixes of prev (model may vary punctuation)
            for (int mlen = plen - 1; mlen >= minMatch; mlen--) {
                if (int(result.length()) >= mlen && result.substr(0, mlen) == prev.substr(0, mlen)) {
                    result = result.substr(mlen);
                    break;
                }
            }
        }
        if (result != text && result.Trim() != "") {
            // Strip leading connecting punctuation (handles UTF-8 multi-byte chars)
            bool stripped = true;
            while (stripped && result.length() > 0) {
                stripped = false;
                // 3-byte UTF-8 punctuation: em dash, Chinese comma/period, quotes, etc.
                if (result.length() >= 3) {
                    string p3 = result.substr(0, 3);
                    if (p3 == "\xe2\x80\x94" || p3 == "\xef\xbc\x8c" || p3 == "\xe3\x80\x82" ||
                        p3 == "\xe3\x80\x81" || p3 == "\xef\xbc\x9b" || p3 == "\xef\xbc\x9a" ||
                        p3 == "\xef\xbd\x9e" || p3 == "\xe2\x80\x9c" || p3 == "\xe2\x80\x9d" ||
                        p3 == "\xe2\x80\x98" || p3 == "\xe2\x80\x99") {
                        result = result.substr(3);
                        stripped = true;
                        continue;
                    }
                }
                // 1-byte ASCII punctuation and whitespace
                string ch = result.substr(0, 1);
                if (ch == " " || ch == "\t" || ch == "," || ch == "." || ch == ";" ||
                    ch == ":" || ch == "-" || ch == "~" || ch == "!" || ch == "?") {
                    result = result.substr(1);
                    stripped = true;
                }
            }
            return result.Trim();
        }
    }
    return result;
}

// Post-process model output: remove echoed >>> delimiter and context lines.
// Models sometimes translate context lines or echo the >>> delimiter;
// the actual translation is always the text after the last >>> on the last line.
string CleanTranslationOutput(const string &in text) {
    if (text == "")
        return text;
    string result = text;

    // Take text after the last >>> if the delimiter appears
    int lastDelim = -1;
    int searchPos = 0;
    while (true) {
        int found = result.find(">>>", searchPos);
        if (found == -1) break;
        lastDelim = found;
        searchPos = found + 3;
    }
    if (lastDelim != -1)
        result = result.substr(lastDelim + 3);

    // Take only the last non-empty line (context translations appear on earlier lines)
    int lastNewline = -1;
    for (uint i = 0; i < result.length(); i++) {
        uint8 c = result[i];
        if (c == 10 || c == 13) // \n or \r
            lastNewline = int(i);
    }
    if (lastNewline != -1)
        result = result.substr(lastNewline + 1);

    return result.Trim();
}

bool ShouldTryResponsesEndpoint(const string &in apiUrl) {
    if (IsGeminiApiUrl(apiUrl))
        return false;
    return true;
}

bool ShouldDisableContextCacheForSession(const string &in failureReason) {
    string lower = ToLower(failureReason.Trim());
    if (lower == "")
        return false;
    if (lower.find("404") != -1 || lower.find("not found") != -1)
        return true;
    if (lower.find("unsupported") != -1 || lower.find("does not support") != -1)
        return true;
    if (lower.find("unknown parameter") != -1 || lower.find("unrecognized") != -1 || lower.find("invalid parameter") != -1)
        return true;
    if (lower.find("no response from responses endpoint") != -1)
        return true;
    if (lower.find("route") != -1 || lower.find("endpoint") != -1 || lower.find("responses endpoint") != -1)
        return true;
    return false;
}

string BuildPromptCacheKey(const string &in modelName, const string &in sourceLang, const string &in targetLang) {
    string key = "potplayer_subtitle_translate_v2";
    string model = ToLower(modelName.Trim());
    string src = ToLower(sourceLang.Trim());
    string dst = ToLower(targetLang.Trim());
    if (model != "")
        key += "|" + model;
    if (src == "")
        src = "auto";
    if (dst == "")
        dst = "auto";
    key += "|" + src + ">" + dst;
    return key;
}

string BuildChatPayload(
    const string &in modelName,
    const string &in systemMsg,
    const string &in userMsg,
    bool includePromptCacheControls,
    const string &in promptCacheKey,
    const string &in promptCacheRetention,
    bool includeGeminiCachedContent,
    const string &in geminiCachedContent,
    bool isBailian = false,
    bool disableThinking = false
) {
    string escapedModel = JsonEscape(modelName);
    string escapedSystem = JsonEscape(systemMsg);
    string escapedUser = JsonEscape(userMsg);
    string payload = "{\"model\":\"" + escapedModel + "\"";

    // Prompt cache controls: OpenAI official only (not Bailian)
    string cacheKey = promptCacheKey.Trim();
    if (includePromptCacheControls && cacheKey != "" && !isBailian)
        payload += ",\"prompt_cache_key\":\"" + JsonEscape(cacheKey) + "\"";

    string retention = NormalizePromptCacheRetention(promptCacheRetention);
    if (includePromptCacheControls && retention != "" && !isBailian)
        payload += ",\"prompt_cache_retention\":\"" + JsonEscape(retention) + "\"";

    payload += ",\"messages\":[{\"role\":\"system\",\"content\":\"" + escapedSystem + "\"},{\"role\":\"user\",\"content\":\"" + escapedUser + "\"}]";

    // Temperature for translation consistency
    payload += ",\"temperature\":0.3";

    // Gemini cached content (not Bailian)
    string cachedContent = geminiCachedContent.Trim();
    if (includeGeminiCachedContent && cachedContent != "" && !isBailian)
        payload += ",\"google\":{\"cached_content\":\"" + JsonEscape(cachedContent) + "\"}";

    // Disable thinking for Bailian reasoning models (saves tokens, avoids empty content bug)
    if (isBailian && !disableThinking)
        payload += ",\"enable_thinking\":false";

    payload += "}";
    return payload;
}

void EnsureTokenRulesLoaded() {
    if (GPT_token_rules_initialized)
        return;
    GPT_token_rules_initialized = true;
    GPT_default_model_token_limit = 4096;
    GPT_token_rule_types.resize(0);
    GPT_token_rule_values.resize(0);
    GPT_token_rule_limits.resize(0);

    JsonReader reader;
    JsonValue root;
    if (!reader.parse(GPT_pre_model_token_limits_json, root))
        return;
    if (!root.isObject())
        return;

    if (root["default"].isInt())
        GPT_default_model_token_limit = root["default"].asInt();
    else if (root["default"].isString()) {
        int parsedDefault = ParseInt(root["default"].asString());
        if (parsedDefault > 0)
            GPT_default_model_token_limit = parsedDefault;
    }

    JsonValue rulesNode = root["rules"];
    if (!rulesNode.isArray())
        return;

    int count = rulesNode.size();
    for (int i = 0; i < count; i++) {
        JsonValue entry = rulesNode[i];
        if (!entry.isObject())
            continue;
        string matchType = "";
        string matchValue = "";
        int limit = 0;
        if (entry["type"].isString())
            matchType = entry["type"].asString();
        if (entry["value"].isString())
            matchValue = entry["value"].asString();
        if (entry["tokens"].isInt())
            limit = entry["tokens"].asInt();
        else if (entry["tokens"].isString())
            limit = ParseInt(entry["tokens"].asString());
        if (matchType != "" && matchValue != "" && limit > 0) {
            GPT_token_rule_types.insertLast(matchType);
            GPT_token_rule_values.insertLast(matchValue);
            GPT_token_rule_limits.insertLast(limit);
        }
    }
}

string DeriveResponsesUrl(const string &in originalUrl) {
    string url = originalUrl.Trim();
    while (url.length() > 0 && url.substr(url.length() - 1, 1) == "/")
        url = url.substr(0, url.length() - 1);
    if (url == "")
        return "";
    if (url.find("/responses") != -1)
        return url;
    int chatPos = url.find("/chat/completions");
    if (chatPos != -1)
        return url.substr(0, chatPos) + "/responses";
    return url + "/responses";
}

string ExecuteSimple(const string &in url, const string &in headers, const string &in payload) {
    return HostUrlGetString(url, GPT_UserAgent, headers, payload);
}

string BuildResponsesPayload(
    const string &in modelName,
    const string &in systemMsg,
    const string &in userMsg,
    const string &in promptCacheKey,
    const string &in promptCacheRetention
) {
    string escapedSystem = JsonEscape(systemMsg);
    string escapedUser = JsonEscape(userMsg);
    string payload = "{\"model\":\"" + JsonEscape(modelName) + "\"";
    string cacheKey = promptCacheKey.Trim();
    if (cacheKey != "")
        payload += ",\"prompt_cache_key\":\"" + JsonEscape(cacheKey) + "\"";
    string retention = NormalizePromptCacheRetention(promptCacheRetention);
    if (retention != "")
        payload += ",\"prompt_cache_retention\":\"" + JsonEscape(retention) + "\"";
    payload += ",\"input\":[";
    payload += "{\"role\":\"system\",\"content\":[{\"type\":\"input_text\",\"text\":\"" + escapedSystem + "\"}]}";
    payload += ",{\"role\":\"user\",\"content\":[{\"type\":\"input_text\",\"text\":\"" + escapedUser + "\"}]}";
    payload += "]}";
    return payload;
}

string ExtractResponsesText(JsonValue &in root) {
    if (!root.isObject())
        return "";

    JsonValue output = root["output"];
    if (!output.isArray())
        return "";

    int size = output.size();
    for (int i = 0; i < size; i++) {
        JsonValue entry = output[i];
        if (!entry.isObject())
            continue;
        JsonValue content = entry["content"];
        if (!content.isArray())
            continue;
        int csize = content.size();
        for (int j = 0; j < csize; j++) {
            JsonValue part = content[j];
            if (part.isObject()) {
                if (part["type"].isString() && part["type"].asString() == "output_text" && part["text"].isString())
                    return part["text"].asString();
            } else if (part.isString()) {
                return part.asString();
            }
        }
    }
    return "";
}

string TranslateWithResponses(
    const string &in responsesUrl,
    const string &in headers,
    const string &in modelName,
    const string &in systemMsg,
    const string &in userMsg,
    const string &in promptCacheKey,
    const string &in promptCacheRetention,
    string &out failureReason
) {
    string requestData = BuildResponsesPayload(modelName, systemMsg, userMsg, promptCacheKey, promptCacheRetention);
    string response = ExecuteSimple(responsesUrl, headers, requestData);
    if (response == "") {
        failureReason = "No response from Responses endpoint.";
        return "";
    }

    JsonReader reader;
    JsonValue root;
    if (!reader.parse(response, root)) {
        failureReason = "Failed to parse Responses API response.";
        return "";
    }

    string translatedText = ExtractResponsesText(root);
    if (translatedText != "") {
        return translatedText;
    }

    if (root.isObject() && root["error"].isObject() && root["error"]["message"].isString()) {
        failureReason = root["error"]["message"].asString();
    } else {
        failureReason = "Responses API returned no usable output.";
    }
    return "";
}

bool IsOverlongTranslation(const string &in translation, const string &in original) {
    if (original.length() == 0) return false;
    return translation.length() > (original.length() * 5);
}
