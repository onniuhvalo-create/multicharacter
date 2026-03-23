<script setup lang="ts">
import { DefaultData } from '@/store/index';
import { storeToRefs } from 'pinia';

const StoreData = DefaultData();
const { } = storeToRefs(StoreData)

defineProps<{
    icon: string;
    title: string;
    description: string | number;
}>();
</script>

<template>
    <div class="flex items-center gap-x-[0.9259vh] min-w-[11.3889vh]">
        <div class="w-[3.6111vh] h-[3.6111vh] flex items-center justify-center rounded-[0.1852vh] border-[0.0463vh] border-solid" :style="`background: radial-gradient(74.18% 50% at 50% 50%, ${StoreData.GetThemeRGBA(StoreData.GetThemeColor(), 14)} 0%, ${StoreData.GetThemeRGBA(StoreData.GetThemeSecondaryColor(), 14)} 100%);border-color: ${StoreData.GetThemeColor()}8C;`">
            <i :class="icon" class="text-[1.6667vh]" :style="`color: ${StoreData.GetThemeColor()};`"></i>
        </div>
        <div class="flex flex-col items-start">
            <p class="font-['Arame'] text-[1.2963vh] leading-tight line-clamp-1 text-[#FFF]">{{ title }}</p>
            <p class="font-['Poppins-Regular'] text-[1.1111vh] leading-tight line-clamp-1 text-[#FFF] max-w-[3.5417vw]">{{ description }}</p>
        </div>
    </div>
</template>