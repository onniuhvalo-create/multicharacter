<script setup lang="ts">
import { DefaultData } from '@/store/index';
import { storeToRefs } from 'pinia';

const StoreData = DefaultData();
const { } = storeToRefs(StoreData)

defineProps<{
    icon: string;
    title: string;
    description: string;
}>();
</script>

<template>
    <div class="flex items-center">
        <div class="flex items-center justify-between relative">
            <div class="w-[1.1458vw] h-[1.1458vw] border-solid rotate-45 border-[.026vw] rounded-[.1042vw]" :style="`background: radial-gradient(74.18% 50% at 50% 50%, ${StoreData.GetThemeRGBA(StoreData.GetThemeColor(), 14)} 0%, ${StoreData.GetThemeRGBA(StoreData.GetThemeSecondaryColor(), 14)} 100%);border-color: ${StoreData.GetThemeColor()}8C;`"></div>
            <i :class="icon" class="text-[.5729vw] absolute top-1/2 left-1/2 -translate-1/2" :style="`color: ${StoreData.GetThemeColor()};`"></i>
        </div>
        <div class="flex flex-col items-start justify-center w-[9.375vw] ml-[.4167vw]">
            <p class="font-['Arame'] text-[.7292vw] text-[#FFFFFF] leading-tight line-clamp-1">{{ title }}</p>
            <p class="font-['Poppins-Regular'] text-[.625vw] text-[#FFFFFF8C] leading-tight line-clamp-1">{{ description }}</p>
        </div>
        <div class="w-[2.3958vw] h-max p-[.2604vw] bg-[#FFFFFF0D] border-[.0521vw] border-solid border-[#FFFFFF40] rounded-[.0521vw] flex items-center justify-center cursor-pointer" @click="StoreData.SetThemeColor()">
            <div class="w-[1.875vw] h-[1.0417vw] rounded-[.0521vw]" :style="`background: ${StoreData.GetThemeColor()};`"></div>
        </div>
    </div>
</template>