<script setup lang="ts">
import event from '@/utils/event';
import { DefaultData } from '@/store/index';
import { storeToRefs } from 'pinia';

const StoreData = DefaultData();
const { } = storeToRefs(StoreData)

import type { Ref } from 'vue';

const model = defineModel() as Ref<number>;

defineProps<{
    title: string;
    description: string;
    placeholder: string;
}>();

function GetModel() {
    return model.value;
}

function SetModel(value: string) {
    const num = Number(value);
    model.value = num + 150;
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
        <div class="w-full h-[2.0313vw] bg-[#FFFFFF0D] rounded-[.0521vw] border-[.026vw] border-solid border-[#FFFFFF40] flex items-center justify-between pl-[.7292vw] gap-x-[.7292vw] pr-[.4688vw]">
            <input
                type="range"
                min="0"
                max="50"
                value="0"
                class="w-full h-1/2 bg-transparent outline-none appearance-none custom-range"
                oninput="this.style.background = `linear-gradient(to right, #FFF ${this.value * 2}%, #FFFFFF0D ${this.value * 2}%)`;"
                @input="SetModel(($event.target as HTMLInputElement).value)"
            />
            <div class="w-[2.9167vw] h-[1.0938vw] border-[.026vw] border-solid rounded-[.0521vw] flex items-center justify-center" :style="`background: radial-gradient(74.18% 50% at 50% 50%, ${StoreData.GetThemeRGBA(StoreData.GetThemeColor(), 14)} 0%, ${StoreData.GetThemeRGBA(StoreData.GetThemeSecondaryColor(), 14)} 100%);border-color: ${StoreData.GetThemeColor()}8C;`">
                <p class="font-['Poppins-Regular'] text-[.625vw] text-[#FFF] leading-none uppercase">{{ Number(GetModel()) }}</p>
            </div>
        </div>
    </div>
</template>

<style>
    .custom-range {
        -webkit-appearance: none;
        appearance: none;
        width: 100%;
        height: .1563vw;
        background: #FFFFFF0D;
        border-radius: 9999px;
        outline: none;
        position: relative;
    }

    .custom-range::-webkit-slider-runnable-track {
        height: 0.2083vw;
        border-radius: 9999px;
    }

    .custom-range::-webkit-slider-thumb {
        -webkit-appearance: none;
        height: .5729vw;
        width: 1.0417vw;
        background: #ffffff;
        border-radius: .0521vw;
        margin-top: -0.1563vw;
        position: relative;
        z-index: 2;
    }
</style>