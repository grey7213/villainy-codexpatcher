<template>
  <n-config-provider :theme="darkTheme" :theme-overrides="hackerThemeOverrides" :locale="naiveLocale" :date-locale="naiveDateLocale">
    <n-message-provider>
      <n-dialog-provider>
        <n-layout class="app-layout">
        <!-- 顶部 Header -->
        <n-layout-header bordered class="app-header">
          <div class="header-left">
            <n-button
              quaternary
              class="menu-toggle hide-tablet"
              @click="sidebarCollapsed = !sidebarCollapsed"
            >
              <template #icon>
                <n-icon><MenuOutline /></n-icon>
              </template>
            </n-button>
            <img src="/logo.svg" alt="logo" class="app-logo" />
            <span class="term-prompt">root@villainy</span><span class="term-colon">:</span><span class="term-path">~</span><span class="term-sign">$</span>
            <span class="title">Villain Y Patcher</span>
            <span class="title-badge">private console</span>
            <span class="terminal-caret" aria-hidden="true"></span>
          </div>
          <div class="header-right">
            <n-tooltip v-if="appVersion" trigger="hover" placement="bottom">
              <template #trigger>
                <span class="version-link" aria-label="Version">
                  v{{ appVersion }}
                </span>
              </template>
              {{ $t('common.version') }}
            </n-tooltip>

            <!-- WeChat -->
            <n-popover trigger="click" placement="bottom-end" :width="200">
              <template #trigger>
                <button class="social-link" aria-label="微信">
                  <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor"><path d="M8.691 2.188C3.891 2.188 0 5.476 0 9.53c0 2.212 1.17 4.203 3.002 5.55a.59.59 0 0 1 .213.665l-.39 1.48c-.019.07-.048.141-.048.213 0 .163.13.295.29.295a.326.326 0 0 0 .167-.054l1.903-1.114a.864.864 0 0 1 .717-.098 10.16 10.16 0 0 0 2.837.403c.276 0 .543-.027.811-.05-.857-2.578.157-4.972 1.932-6.446 1.703-1.415 3.882-1.98 5.853-1.838-.576-3.583-4.196-6.348-8.596-6.348zM5.785 5.991c.642 0 1.162.529 1.162 1.18a1.17 1.17 0 0 1-1.162 1.178A1.17 1.17 0 0 1 4.623 7.17c0-.651.52-1.18 1.162-1.18zm5.813 0c.642 0 1.162.529 1.162 1.18a1.17 1.17 0 0 1-1.162 1.178 1.17 1.17 0 0 1-1.162-1.178c0-.651.52-1.18 1.162-1.18zm5.34 2.867c-1.797-.052-3.746.512-5.161 1.71-1.484 1.255-2.263 3.057-1.944 4.85.976 5.58 9.277 7.679 14.6 4.066.061-.04.135-.06.211-.06a.29.29 0 0 1 .089.014l1.523.868a.29.29 0 0 0 .14.047c.134 0 .24-.11.24-.247 0-.06-.023-.12-.038-.177l-.327-1.233a.582.582 0 0 1 .181-.555C23.002 17.394 24 15.829 24 14.098c0-3.226-3.13-5.765-7.062-5.24zm-3.85 3.045c.56 0 1.012.46 1.012 1.028a1.02 1.02 0 0 1-1.012 1.028 1.02 1.02 0 0 1-1.013-1.028c0-.568.453-1.028 1.013-1.028zm5.886 0c.56 0 1.012.46 1.012 1.028a1.02 1.02 0 0 1-1.012 1.028 1.02 1.02 0 0 1-1.013-1.028c0-.568.453-1.028 1.013-1.028z"/></svg>
                </button>
              </template>
              <div style="text-align: center; padding: 8px 0">
                <img src="/wechat-villainy.jpg" alt="Villain Y 微信" class="wechat-card" />
                <div style="margin-top: 8px; font-size: 12px; opacity: 0.78">Villain y · 辽宁 大连</div>
                <div style="margin-top: 2px; font-size: 11px; opacity: 0.55">扫码添加微信</div>
              </div>
            </n-popover>

            <LocaleSwitch />
          </div>
        </n-layout-header>

        <!-- Tab 导航 -->
        <n-tabs v-model:value="activeTab" type="line" class="main-tabs" @update:value="handleTabChange">
          <n-tab name="enhance">
            <template #icon>
              <n-icon><SparklesOutline /></n-icon>
            </template>
            {{ $t('nav.enhance') }}
          </n-tab>
          <n-tab name="sessions">
            <template #icon>
              <n-icon><ListOutline /></n-icon>
            </template>
            {{ $t('nav.sessions') }}
          </n-tab>
          <n-tab name="settings">
            <template #icon>
              <n-icon><SettingsOutline /></n-icon>
            </template>
            {{ $t('nav.settings') }}
          </n-tab>
          <n-tab name="help">
            <template #icon>
              <n-icon><HelpCircleOutline /></n-icon>
            </template>
            {{ $t('nav.help') }}
          </n-tab>
          <n-tab name="cooperation">
            <template #icon>
              <n-icon><ChatbubblesOutline /></n-icon>
            </template>
            {{ $t('nav.cooperation') }}
          </n-tab>
        </n-tabs>

        <!-- 主内容区 -->
        <n-layout has-sider class="app-content" v-show="activeTab === 'sessions'">
          <!-- 左侧会话列表 -->
          <n-layout-sider
            bordered
            :width="340"
            :collapsed-width="0"
            :collapsed="sidebarCollapsed"
            :native-scrollbar="false"
            class="session-sider"
            collapse-mode="transform"
            @collapse="sidebarCollapsed = true"
            @expand="sidebarCollapsed = false"
          >
            <SessionList />
          </n-layout-sider>

          <!-- 移动端遮罩 -->
          <div
            v-if="!sidebarCollapsed && isMobile"
            class="sidebar-overlay"
            @click="sidebarCollapsed = true"
          />

          <!-- 右侧内容区 -->
          <n-layout-content class="main-content">
            <PreviewPanel ref="previewPanelRef" v-model:cleanReasoning="cleanReasoning" />
            <ActionBar :preview-panel-ref="previewPanelRef" :clean-reasoning="cleanReasoning" />
          </n-layout-content>
        </n-layout>

        <!-- 其他 Tab 内容 -->
        <n-layout-content v-show="activeTab !== 'sessions'" class="tab-content">
          <div v-if="activeTab === 'enhance'" class="content-wrapper">
            <PromptEnhancePanel />
          </div>
          <div v-if="activeTab === 'settings'" class="content-wrapper">
            <SettingsPanel />
          </div>
          <div v-if="activeTab === 'help'" class="content-wrapper">
            <HelpPanel />
          </div>
          <div v-if="activeTab === 'cooperation'" class="content-wrapper">
            <CooperationPanel />
          </div>
        </n-layout-content>

        <!-- 底部日志面板 -->
        <LogPanel />
      </n-layout>
    </n-dialog-provider>
    </n-message-provider>
  </n-config-provider>
</template>

<script setup>
import { ref, watch, onMounted, onUnmounted, computed } from 'vue'
import { useI18n } from 'vue-i18n'
import { darkTheme, zhCN, dateZhCN, enUS, dateEnUS, NDialogProvider } from 'naive-ui'
import { SettingsOutline, MenuOutline, ListOutline, SparklesOutline, HelpCircleOutline, ChatbubblesOutline } from '@vicons/ionicons5'
import SessionList from './components/SessionList.vue'
import PreviewPanel from './components/PreviewPanel.vue'
import ActionBar from './components/ActionBar.vue'
import LogPanel from './components/LogPanel.vue'
import PromptEnhancePanel from './components/PromptEnhancePanel.vue'
import SettingsPanel from './components/SettingsPanel.vue'
import HelpPanel from './components/HelpPanel.vue'
import CooperationPanel from './components/CooperationPanel.vue'
import LocaleSwitch from './components/LocaleSwitch.vue'
import { useSessionStore } from './stores/sessionStore'
import { useSettingsStore } from './stores/settingsStore'
import { useLogStore } from './stores/logStore'
import { useLocaleStore } from './stores/localeStore'
import { api } from './services/api'

const { t } = useI18n()
const activeTab = ref('enhance')

// 黑客终端主题：覆盖 naive-ui 组件配色 / 字体 / 圆角
const MONO_FONT = "'JetBrains Mono', 'Fira Code', 'Cascadia Code', 'SFMono-Regular', 'Menlo', 'Consolas', monospace"
const hackerThemeOverrides = {
  common: {
    primaryColor: '#3fb950',
    primaryColorHover: '#56d364',
    primaryColorPressed: '#2ea043',
    primaryColorSuppl: '#2ea043',
    successColor: '#3fb950',
    successColorHover: '#56d364',
    successColorPressed: '#2ea043',
    infoColor: '#58a6ff',
    warningColor: '#d29922',
    errorColor: '#f85149',
    bodyColor: '#0d1117',
    cardColor: '#131922',
    modalColor: '#131922',
    popoverColor: '#1c2431',
    tableColor: '#131922',
    inputColor: '#0d1117',
    borderColor: '#283040',
    textColorBase: '#e6edf3',
    textColor1: '#e6edf3',
    textColor2: '#c9d1d9',
    textColor3: '#8b949e',
    fontFamily: MONO_FONT,
    fontFamilyMono: MONO_FONT,
    borderRadius: '3px',
    borderRadiusSmall: '2px',
  },
  Button: {
    textColorPrimary: '#0d1117',
    textColorHoverPrimary: '#0d1117',
    textColorPressedPrimary: '#0d1117',
    fontWeight: '600',
  },
  Tabs: {
    tabTextColorActiveLine: '#3fb950',
    tabTextColorHoverLine: '#56d364',
    barColor: '#3fb950',
  },
}

const sidebarCollapsed = ref(false)
const isMobile = ref(false)
const previewPanelRef = ref(null)
const cleanReasoning = ref(true)  // 是否清理推理内容
const appVersion = ref('')

const sessionStore = useSessionStore()
const settingsStore = useSettingsStore()
const logStore = useLogStore()
const localeStore = useLocaleStore()

// Naive UI locale
const naiveLocale = computed(() => {
  return localeStore.currentLocale === 'en-US' ? enUS : zhCN
})

const naiveDateLocale = computed(() => {
  return localeStore.currentLocale === 'en-US' ? dateEnUS : dateZhCN
})

// 初始化：加载会话列表
sessionStore.fetchSessions()

// Tab 切换时加载设置
function handleTabChange(tab) {
  if (tab === 'settings') {
    settingsStore.loadSettings()
  }
}

// 响应式检测
const checkMobile = () => {
  isMobile.value = window.innerWidth < 768
  if (isMobile.value) {
    sidebarCollapsed.value = true
  }
}

async function loadAppVersion() {
  try {
    const result = await api.get('/version')
    appVersion.value = result.version || ''
  } catch {
    appVersion.value = ''
  }
}

onMounted(() => {
  checkMobile()
  loadAppVersion()
  window.addEventListener('resize', checkMobile)
})

onUnmounted(() => {
  window.removeEventListener('resize', checkMobile)
})

// WebSocket 连接管理
let ws = null
let reconnectTimer = null
const wsConnected = ref(false)

const connectWebSocket = () => {
  const wsProtocol = window.location.protocol === 'https:' ? 'wss:' : 'ws:'
  const wsUrl = `${wsProtocol}//${window.location.host}/api/ws`

  ws = new WebSocket(wsUrl)

  ws.onopen = () => {
    wsConnected.value = true
    console.log('WebSocket connected')
  }

  ws.onclose = () => {
    wsConnected.value = false
    console.log('WebSocket disconnected, reconnecting...')
    // 3秒后重连
    reconnectTimer = setTimeout(connectWebSocket, 3000)
  }

  ws.onerror = (error) => {
    console.error('WebSocket error:', error)
  }

  ws.onmessage = (event) => {
    try {
      const data = JSON.parse(event.data)
      if (data.type === 'log') {
        const { level, message } = data.data
        logStore.addLog(message, level)
      }
    } catch (e) {
      console.error('WebSocket message parse error:', e)
    }
  }
}

connectWebSocket()

// 组件卸载时清理 WebSocket
onUnmounted(() => {
  if (reconnectTimer) {
    clearTimeout(reconnectTimer)
  }
  if (ws) {
    ws.close()
  }
})
</script>

<style scoped>
.app-layout {
  height: 100vh;
  display: flex;
  flex-direction: column;
}

.app-header {
  height: var(--header-height);
  padding: 0 16px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  background: var(--color-bg-1);
  box-shadow: inset 0 -1px 0 var(--color-primary-soft);
}

.header-left {
  display: flex;
  align-items: center;
  gap: 12px;
}

.app-logo {
  width: 28px;
  height: 28px;
  display: block;
  flex-shrink: 0;
}

.header-right {
  display: flex;
  align-items: center;
  gap: 8px;
}

.social-link {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 28px;
  height: 28px;
  border-radius: var(--radius-sm);
  color: var(--color-text-3);
  background: none;
  border: none;
  cursor: pointer;
  padding: 0;
  text-decoration: none;
  transition: color 0.2s, background 0.2s;
}
.social-link:hover {
  color: var(--color-text-1);
  background: var(--color-bg-3);
}

.version-link {
  color: var(--color-primary-hover);
  display: inline-flex;
  align-items: center;
  font-size: 13px;
  font-weight: 600;
  line-height: 1;
  text-decoration: none;
  padding: 5px 8px;
  border: 1px solid var(--color-primary-pressed);
  border-radius: var(--radius-sm);
  background: var(--color-primary-soft);
  transition: color 0.2s, background 0.2s, border-color 0.2s;
}

.version-link:hover {
  color: var(--color-text-1);
  border-color: var(--color-primary-hover);
  background: var(--color-primary-pressed);
}

.wechat-card {
  width: 160px;
  height: auto;
  border-radius: 6px;
  border: 1px solid var(--color-border);
}

@media (max-width: 600px) {
  .title-badge {
    display: none;
  }
}

.menu-toggle {
  display: none;
}

.title {
  font-size: 16px;
  font-weight: 600;
  color: var(--color-text-1);
  letter-spacing: 0;
  text-shadow: 0 0 8px var(--color-glow);
}

.term-prompt {
  font-family: var(--font-mono);
  font-size: 13px;
  color: var(--color-primary);
  text-shadow: 0 0 6px var(--color-glow);
}
.term-colon { color: var(--color-text-3); font-family: var(--font-mono); font-size: 13px; }
.term-path { color: var(--color-info); font-family: var(--font-mono); font-size: 13px; }
.term-sign { color: var(--color-text-2); font-family: var(--font-mono); font-size: 13px; margin-right: 2px; }

@media (max-width: 600px) {
  .term-prompt, .term-colon, .term-path, .term-sign {
    display: none;
  }
}

.title-badge {
  color: var(--color-primary);
  border: 1px solid var(--color-primary-pressed);
  background: var(--color-primary-soft);
  border-radius: var(--radius-sm);
  font-family: var(--font-mono);
  font-size: 11px;
  letter-spacing: 0.5px;
  padding: 2px 8px;
  text-transform: uppercase;
  text-shadow: 0 0 6px var(--color-glow);
}

.title-badge::before {
  content: '[';
  opacity: 0.6;
}
.title-badge::after {
  content: ']';
  opacity: 0.6;
}

.main-tabs {
  padding: 0 16px;
  background: var(--color-bg-1);
  border-bottom: 1px solid var(--color-border);
}

.main-tabs :deep(.n-tabs-nav) {
  padding: 0;
}

.app-content {
  flex: 1;
  min-height: 0;
}

.session-sider {
  background: var(--color-bg-1);
}

.sidebar-overlay {
  display: none;
}

.main-content {
  display: flex;
  flex-direction: column;
  padding: 16px;
  padding-bottom: 56px; /* 日志面板收起时的高度 + 安全边距 */
  background: var(--color-bg-2);
}

.tab-content {
  flex: 1;
  padding: 16px;
  padding-bottom: 56px;
  background: var(--color-bg-2);
  overflow: auto;
}

.content-wrapper {
  max-width: 960px;
  margin: 0 auto;
}

/* 响应式布局 */
@media (max-width: 1024px) {
  .menu-toggle {
    display: flex;
  }

  .session-sider {
    position: fixed;
    top: calc(var(--header-height) + 40px);
    left: 0;
    bottom: 0;
    z-index: 100;
    background: var(--color-bg-1);
  }

  .sidebar-overlay {
    display: block;
    position: fixed;
    top: calc(var(--header-height) + 40px);
    left: 0;
    right: 0;
    bottom: 0;
    background: var(--color-overlay);
    z-index: 99;
  }
}

@media (max-width: 768px) {
  .main-content, .tab-content {
    padding: 12px;
  }
}
</style>
