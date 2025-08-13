<template>
  <div class="bg-white rounded shadow p-4">
    <h3 class="text-lg text-pekora-blue-700 font-bold text-center pt-2 pb-4">Subtitle Preview</h3>

    <!-- Sample Text Selector -->
    <div class="mb-4">
      <InputBox
        v-model="selectedSampleIndex"
        name="Sample Text"
        input-type="select"
        :options="sampleTextOptions"
      />
    </div>

    <!-- Preview Window -->
    <div
      class="relative w-full bg-gray-900 rounded overflow-hidden"
      :style="{ aspectRatio: `${props.videoWidth} / ${props.videoHeight}` }"
    >
      <div class="absolute inset-0 bg-gradient-to-tr from-pekora-blue-950 to-pekora-blue-600">
        <svg :viewBox="`0 0 ${props.videoWidth} ${props.videoHeight}`">
          <text
            :font-family="props.fontName || 'Arial, sans-serif'"
            :font-size="`${props.textSize}px`"
            :fill="props.textColor"
            :stroke="props.strokeColor"
            :stroke-width="props.strokeWidth * 2"
            stroke-linecap="round"
            stroke-linejoin="round"
            paint-order="stroke"
            :x="`${props.horizontalPosition}%`"
            :y="`${props.verticalPosition}%`"
            dominant-baseline="middle"
            :style="{
              textAnchor: 'middle',
              transform: `translate(0, -${props.textSize / 2}px)`,
            }"
          >
            {{ currentSampleText }}
          </text>
        </svg>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed, ref } from 'vue'
import InputBox from './InputBox.vue'

interface Props {
  fontName: string
  textSize: number
  textColor: string
  horizontalPosition: number
  verticalPosition: number
  strokeWidth: number
  strokeColor: string
  videoWidth: number
  videoHeight: number
}

const props = defineProps<Props>()

// Sample texts for preview
const sampleTexts = [
  'Hello World! 안녕하세요!',
  '한글 자막 테스트입니다',
  'English Subtitle Test',
  'Long subtitle text that might overflow the preview window, so it needs to be resized accordingly',
  '日本語字幕テスト',
  'Numbers & Symbols: 123 !@#',
  'UPPERCASE TEXT SAMPLE',
  'Mixed 한글 English 日本語',
]

const selectedSampleIndex = ref(0)

const sampleTextOptions = computed(() =>
  sampleTexts.map((text, index) => ({
    label: text.length > 30 ? text.substring(0, 30) + '...' : text,
    value: index,
  })),
)

const currentSampleText = computed(() => sampleTexts[selectedSampleIndex.value])
</script>
