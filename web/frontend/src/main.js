import { createApp } from 'vue'
import { createPinia } from 'pinia'
import naive from 'naive-ui'
import App from './App.vue'
import i18n from './locales'
// 自托管 JetBrains Mono 字体（离线，随构建打包，不依赖任何 CDN）
// 仅打包 latin 子集：界面为中文+英文，拉丁字符用等宽字体，中文走系统兜底
import '@fontsource/jetbrains-mono/latin-400.css'
import '@fontsource/jetbrains-mono/latin-500.css'
import '@fontsource/jetbrains-mono/latin-600.css'
import '@fontsource/jetbrains-mono/latin-700.css'
import './styles/theme.css'
import './styles/main.css'

const app = createApp(App)
const pinia = createPinia()

app.use(pinia)
app.use(naive)
app.use(i18n)
app.mount('#app')
