<template>
  <div class="log-panel" :class="{ collapsed: logStore.collapsed }">
    <div class="panel-header" @click="logStore.toggle">
      <div class="header-left">
        <n-icon class="toggle-icon" :class="{ expanded: !logStore.collapsed }">
          <ChevronUpOutline />
        </n-icon>
        <span class="title">{{ $t('log.title') }}</span>
        <n-tag v-if="logStore.logs.length > 0" size="small">
          {{ logStore.logs.length }}
        </n-tag>
      </div>
      <n-button
        v-if="logStore.logs.length > 0"
        text
        size="small"
        @click.stop="logStore.clearLogs"
      >
        {{ $t('common.clearAll') }}
      </n-button>
    </div>

    <n-collapse-transition :show="!logStore.collapsed">
      <div class="panel-content" ref="contentRef">
        <div
          v-for="log in logStore.logs"
          :key="log.id"
          class="log-entry"
          :class="log.type"
        >
          <span class="time">{{ log.timestamp }}</span>
          <span class="level">[{{ log.type.toUpperCase() }}]</span>
          <span class="message">{{ log.message }}</span>
        </div>
        <n-empty v-if="logStore.logs.length === 0" :description="$t('log.empty')" size="small" />
      </div>
    </n-collapse-transition>
  </div>
</template>

<script setup>
import { ref, watch, nextTick } from 'vue'
import { ChevronUpOutline } from '@vicons/ionicons5'
import { useLogStore } from '../stores/logStore'

const logStore = useLogStore()
const contentRef = ref(null)

// 自动滚动到底部
watch(
  () => logStore.logs.length,
  () => {
    nextTick(() => {
      if (contentRef.value) {
        contentRef.value.scrollTop = contentRef.value.scrollHeight
      }
    })
  }
)
</script>

<style scoped>
.log-panel {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  background: var(--color-bg-1);
  border-top: 1px solid var(--color-border);
  box-shadow: 0 -1px 0 var(--color-primary-soft);
  transition: height 0.3s;
  z-index: 200;
}

.log-panel.collapsed {
  height: 40px;
}

.log-panel:not(.collapsed) {
  height: 180px;
}

.panel-header {
  height: 40px;
  padding: 0 16px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  cursor: pointer;
  user-select: none;
}

.panel-header:hover {
  background: var(--color-bg-3);
}

.header-left {
  display: flex;
  align-items: center;
  gap: 8px;
}

.toggle-icon {
  transition: transform 0.2s;
  color: var(--color-text-3);
}

.toggle-icon.expanded {
  transform: rotate(180deg);
}

.title {
  font-size: 13px;
  font-weight: 500;
  color: var(--color-text-1);
}

.panel-content {
  height: 140px;
  overflow-y: auto;
  padding: 8px 16px;
  background: #060906;
}

.log-entry {
  display: flex;
  align-items: flex-start;
  gap: 8px;
  padding: 4px 0;
  font-size: 12px;
  font-family: var(--font-mono);
}

.log-entry .time {
  color: var(--color-text-4);
  flex-shrink: 0;
}

.log-entry .level {
  flex-shrink: 0;
  font-weight: 600;
}

.log-entry .message {
  color: var(--color-text-2);
  word-break: break-all;
}

.log-entry.info .level {
  color: var(--color-info);
}

.log-entry.success .level {
  color: var(--color-success);
  text-shadow: 0 0 6px var(--color-glow);
}

.log-entry.warn .level {
  color: var(--color-warning);
}

.log-entry.error .level {
  color: var(--color-error);
}
</style>
