<script setup lang="ts">
import { ref } from 'vue'
import { DefaultData } from '@/store/index';
import { storeToRefs } from 'pinia';

const StoreData = DefaultData();
const { } = storeToRefs(StoreData)

const model = defineModel<{ day: number, month: number, year: number }>({
  default: () => ({ day: 0, month: 0, year: 0 })
});

const day = ref<number | null>(null)
const month = ref<number | null>(null)
const year = ref<number | null>(null)

const dayInput = ref<HTMLInputElement | null>(null)
const monthInput = ref<HTMLInputElement | null>(null)
const yearInput = ref<HTMLInputElement | null>(null)

function onDayInput(event: Event) {
  const input = event.target as HTMLInputElement
  let value = input.value

  if (value === '') {
    day.value = null
    model.value.day = 0;
    return
  }

  if (!/^\d+$/.test(value)) return

  if (value.length > 2) {
    value = value.slice(0, 2)
    input.value = value
  }

  const num = parseInt(value)
  if (num > 31) day.value = 31
  else if (num < 1) day.value = 1
  else day.value = num

  if (value.length === 2) {
    monthInput.value?.focus()
  }

  model.value.day = day.value;
}

function onMonthInput(event: Event) {
  const input = event.target as HTMLInputElement
  let value = input.value

  if (value === '') {
    month.value = null
    model.value.month = 0;
    return
  }

  if (!/^\d+$/.test(value)) return

  if (value.length > 2) {
    value = value.slice(0, 2)
    input.value = value
  }

  const num = parseInt(value)
  if (num > 12) month.value = 12
  else if (num < 1) month.value = 1
  else month.value = num

  if (value.length === 2) {
    yearInput.value?.focus()
  }

  model.value.month = month.value;
}

function onYearInput(event: Event) {
  const input = event.target as HTMLInputElement
  let value = input.value

  if (value === '') {
    year.value = null
    model.value.year = 0;
    return
  }

  if (!/^\d+$/.test(value)) return

  if (value.length > 4) {
    value = value.slice(0, 4)
    input.value = value
  }

  const num = parseInt(value)
  if (value.length === 4) {
    if (num > 2100) year.value = 2100
    else if (num < 1900) year.value = 1900
    else year.value = num
  } else {
    year.value = num
  }

  model.value.year = year.value;
}

defineProps<{
    title: string;
    description: string;
    placeholder: string;
}>();
</script>

<template>
    <div class="w-full h-max flex flex-col items-center gap-y-[.3229vw]">
        <div class="flex items-center justify-between w-full">
            <div class="flex items-center">
                <div class="flex items-center gap-x-[.2083vw]">
                    <div class="w-[.7292vw] h-[.7292vw] relative flex items-center justify-center">
                        <div class="w-full h-full rotate-45 rounded-[.1042vw] border-[.026vw] border-solid absolute top-0 left-0" :style="`background: radial-gradient(74.18% 50% at 50% 50%, ${StoreData.GetThemeRGBA(StoreData.GetThemeColor(), 14)} 0%, ${StoreData.GetThemeRGBA(StoreData.GetThemeSecondaryColor(), 14)} 100%);border-color: ${StoreData.GetThemeColor()}8C;`">
                        </div>
                        <i class="fa-solid fa-gear text-[.5208vw]" :style="`color: ${StoreData.GetThemeColor()};`"></i>
                    </div>
                    <p class="font-['Arame'] text-[.7292vw] text-[#FFF] line-clamp-1 leading-none">{{ title }}</p>
                </div>
            </div>
            <p class="text-[#FFFFFF8C] font-['Poppins-Regular'] text-[.7292vw] leading-none line-clamp-1">{{ description }}</p>
        </div>
        <div class="w-[13.8021vw] h-[2.0313vw] rounded-[.0521vw] bg-[#FFFFFF0D] border-[.026vw] border-solid border-[#FFFFFF40] flex items-center justify-center gap-x-[.1563vw]">
            <input type="number" :value="day ?? ''" @input="onDayInput" ref="dayInput" placeholder="DD" class="text-[.625vw] font-['Poppins-Regular'] text-[#FFF] placeholder:text-[#FFFFFF8C] line-clamp-1 leading-tight w-[1.1458vw] outline-none border-none text-center" />
            <p class="text-[.625vw] font-['Poppins-Regular'] text-[#FFFFFF8C] line-clamp-1 leading-tight">/</p>
            <input type="number" :value="month ?? ''" @input="onMonthInput" ref="monthInput" placeholder="MM" class="text-[.625vw] font-['Poppins-Regular'] text-[#FFF] placeholder:text-[#FFFFFF8C] line-clamp-1 leading-tight  w-[1.1458vw] outline-none border-none text-center" />
            <p class="text-[.625vw] font-['Poppins-Regular'] text-[#FFFFFF8C] line-clamp-1 leading-tight">/</p>
            <input type="number" :value="year ?? ''" @input="onYearInput" ref="yearInput" placeholder="YYYY" class="text-[.625vw] font-['Poppins-Regular'] text-[#FFF] placeholder:text-[#FFFFFF8C] line-clamp-1 leading-tight w-[1.6667vw] outline-none border-none text-center" />
        </div>
    </div>
</template>