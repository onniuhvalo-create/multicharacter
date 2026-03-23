<script setup lang="ts">
import { DefaultData } from '@/store/index';
import { storeToRefs } from 'pinia';

const StoreData = DefaultData();
const { } = storeToRefs(StoreData)

const model = defineModel();

defineProps<{
    title: string;
    description: string;
    placeholder: string;
}>();

function SetModel(value: string) {
    model.value = value;
}
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
        <input type="text" class="w-full h-[2.0313vw] bg-[#FFFFFF0D] rounded-[.0521vw] border-[.026vw] border-solid border-[#FFFFFF40] flex items-center justify-center text-center outline-none text-[#FFF] font-['Poppins-Regular'] text-[.625vw] placeholder:text-[#FFF]/55" :placeholder="placeholder" @input="SetModel(($event.target as HTMLInputElement).value)" />
    </div>
</template>