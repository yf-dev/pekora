<template>
  <div class="flex gap-2 items-center flex-col sm:flex-row">
    <label class="flex-auto w-full sm:w-32 text-center sm:text-start" :for="name">{{ name }}</label>
    <select
      v-if="inputType === 'select'"
      :class="inputClasses"
      :name="name"
      :value="options?.findIndex((option) => option.value === modelValue) ?? 0"
      @change="onInput"
    >
      <option v-for="(option, index) in options" :key="option.label" :value="index">
        {{ option.label }}
      </option>
    </select>
    <input
      v-else-if="inputType === 'file'"
      :class="inputClasses"
      :type="inputType"
      :name="name"
      :value="undefined"
      @input="onInput"
    />
    <div
      v-else-if="inputType === 'color'"
      :class="[...inputClasses, 'cursor-pointer']"
      :style="{
        backgroundColor: modelValue as string,
      }"
      @click="colorPicker!.click()"
    >
      <input
        :type="inputType"
        :name="name"
        :value="undefined"
        @input="onInput"
        class="block w-full cursor-pointer opacity-0"
        ref="colorPicker"
      />
    </div>

    <input
      v-else
      :class="inputClasses"
      :type="inputType"
      :name="name"
      :value="modelValue"
      :step="step"
      @input="onInput"
    />
  </div>
</template>

<script setup lang="ts" generic="T">
import { computed, ref } from 'vue'

const props = defineProps<{
  modelValue: T
  name: string
  inputType: 'text' | 'number' | 'file' | 'color' | 'select'
  step?: number | 'any'
  options?: {
    label: string
    value: T
  }[]
}>()
const emit = defineEmits<{
  (e: `update:modelValue`, a: T): void
}>()

const colorPicker = ref<HTMLInputElement | null>(null)

const inputClasses = computed(() => {
  const base = [
    'flex-auto',
    'w-full',
    'sm:w-40',
    'py-1',
    'px-2',
    'border-0',
    'leading-6',
    'rounded',
    'ring-1',
    'ring-inset',
    'ring-pekora-blue-300',
    'placeholder:text-gray-400',
    'focus:ring-2',
    'focus:ring-inset',
    'focus:ring-pekora-blue-500',
    'focus-visible:ring-2',
    'focus-visible:ring-inset',
    'focus-visible:ring-pekora-blue-500',
    'focus-visible:outline-none',
  ]
  return base
})

function onInput(e: Event) {
  const target = e.target as HTMLInputElement
  if (props.inputType === 'select') {
    emit('update:modelValue', props.options![Number(target.value)].value as T)
    return
  } else if (props.inputType === 'number') {
    emit('update:modelValue', Number(target.value) as T)
    return
  } else if (props.inputType === 'file') {
    emit('update:modelValue', target.files as T)
    return
  }
  emit('update:modelValue', target.value as T)
}
</script>
