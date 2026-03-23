<script setup lang="ts">
import { DefaultData } from '@/store/index';
import { storeToRefs } from 'pinia';

const StoreData = DefaultData();
const { locales } = storeToRefs(StoreData)

const model = defineModel()

defineProps<{
    title: string;
    description: string;
    placeholder: string;
}>();

function GetModel() {
    return model.value;
}

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
        <div class="w-[13.8021vw] h-[2.6042vw] flex items-center gap-x-[.3646vw]">
            <div class="w-full h-[2.6042vw] flex items-center justify-center rounded-[.0521vw] cursor-pointer border-[.026vw] border-solid relative overflow-hidden" :style="GetModel() == 'man' ? `border-color: ${StoreData.GetThemeColor()}8C;background: radial-gradient(74.18% 50% at 50% 50%, ${StoreData.GetThemeRGBA(StoreData.GetThemeColor(), 14)} 0%, ${StoreData.GetThemeRGBA(StoreData.GetThemeSecondaryColor(), 14)} 100%);` : 'border-color: #FFFFFF40;background: #FFFFFF0D;'" @click="SetModel('man')">
                <svg width="6.0938vw" height="2.6042vw" viewBox="0 0 117 50" fill="none" class="absolute right-[0]" xmlns="http://www.w3.org/2000/svg">
                    <path d="M150 39L127.5 16L105 39L127.5 62L150 39Z" stroke="url(#paint0_radial_72_390)" stroke-width="0.5"/>
                    <path d="M93 48L70.5 25L48 48L70.5 71L93 48Z" stroke="url(#paint1_radial_72_390)" stroke-width="0.5"/>
                    <path d="M46 11L23.5 -12L1 11L23.5 34L46 11Z" stroke="url(#paint2_radial_72_390)" stroke-width="0.5"/>
                    <path d="M107 2L84.5 -21L62 2L84.5 25L107 2Z" stroke="url(#paint3_radial_72_390)" stroke-width="0.5"/>
                    <defs>
                        <radialGradient id="paint0_radial_72_390" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(127.5 39) rotate(-12.8043) scale(33.8415 13.4665)">
                            <stop :stop-color="GetModel() == 'man' ? StoreData.GetThemeColor() : '#FFF'"/>
                            <stop offset="1" :stop-color="GetModel() == 'man' ? '#00998C' : '#FFF'" stop-opacity="0"/>
                        </radialGradient>
                        <radialGradient id="paint1_radial_72_390" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(70.5 48) rotate(-12.8043) scale(33.8415 13.4665)">
                            <stop :stop-color="GetModel() == 'man' ? StoreData.GetThemeColor() : '#FFF'"/>
                            <stop offset="1" :stop-color="GetModel() == 'man' ? '#00998C' : '#FFF'" stop-opacity="0"/>
                        </radialGradient>
                        <radialGradient id="paint2_radial_72_390" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(23.5 11) rotate(-12.8043) scale(33.8415 13.4665)">
                            <stop :stop-color="GetModel() == 'man' ? StoreData.GetThemeColor() : '#FFF'"/>
                            <stop offset="1" :stop-color="GetModel() == 'man' ? '#00998C' : '#FFF'" stop-opacity="0"/>
                        </radialGradient>
                        <radialGradient id="paint3_radial_72_390" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(84.5 2) rotate(-12.8043) scale(33.8415 13.4665)">
                            <stop :stop-color="GetModel() == 'man' ? StoreData.GetThemeColor() : '#FFF'"/>
                            <stop offset="1" :stop-color="GetModel() == 'man' ? '#00998C' : '#FFF'" stop-opacity="0"/>
                        </radialGradient>
                    </defs>
                </svg>
                <img src="/imgs/man.png" alt="man" class="w-[2.4479vw] h-[2.3958vw] absolute bottom-0 left-0 z-[2]">
                <img src="/imgs/man.png" alt="man" class="w-[2.4479vw] h-[2.3958vw] absolute bottom-0 left-0" style="filter: blur(.5208vw);">
                <p class="text-[.7292vw] font-['Poppins-Regular'] line-clamp-1 leading-tight ml-[1.0417vw]" :class="GetModel() == 'man' ? 'text-[#FFFFFF]' : 'text-[#FFFFFF8C]'">{{ locales.man }}</p>
            </div>
            <div class="w-full h-[2.6042vw] flex items-center justify-center rounded-[.0521vw] cursor-pointer border-[.026vw] border-solid relative overflow-hidden" :style="GetModel() == 'woman' ? `border-color: ${StoreData.GetThemeColor()}8C;background: radial-gradient(74.18% 50% at 50% 50%, ${StoreData.GetThemeRGBA(StoreData.GetThemeColor(), 14)} 0%, ${StoreData.GetThemeRGBA(StoreData.GetThemeSecondaryColor(), 14)} 100%);` : 'border-color: #FFFFFF40;background: #FFFFFF0D;'" @click="SetModel('woman')">
                <svg width="3.2292vw" height="2.6042vw" viewBox="0 0 62 50" fill="none" class="absolute right-[.625vw]" xmlns="http://www.w3.org/2000/svg">
                    <path d="M61 48L38.5 25L16 48L38.5 71L61 48Z" stroke="url(#paint0_radial_72_399)" stroke-width="0.5"/>
                    <path d="M46 11L23.5 -12L1 11L23.5 34L46 11Z" stroke="url(#paint1_radial_72_399)" stroke-width="0.5"/>
                    <defs>
                        <radialGradient id="paint0_radial_72_399" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(38.5 48) rotate(-12.8043) scale(33.8415 13.4665)">
                            <stop :stop-color="GetModel() == 'woman' ? StoreData.GetThemeColor() : '#FFF'"/>
                            <stop offset="1" :stop-color="GetModel() == 'woman' ? '#00998C' : '#FFF'" stop-opacity="0"/>
                        </radialGradient>
                        <radialGradient id="paint1_radial_72_399" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(23.5 11) rotate(-12.8043) scale(33.8415 13.4665)">
                            <stop :stop-color="GetModel() == 'woman' ? StoreData.GetThemeColor() : '#FFF'"/>
                            <stop offset="1" :stop-color="GetModel() == 'woman' ? '#00998C' : '#FFF'" stop-opacity="0"/>
                        </radialGradient>
                    </defs>
                </svg>
                <img src="/imgs/woman.png" alt="woman" class="w-[2.9167vw] h-[2.6042vw] absolute bottom-0 left-0 z-[2]">
                <img src="/imgs/woman.png" alt="woman" class="w-[2.9167vw] h-[2.6042vw] absolute bottom-0 left-0" style="filter: blur(.5208vw);">
                <p class="text-[.7292vw] font-['Poppins-Regular'] line-clamp-1 leading-tight ml-[1.0417vw]" :class="GetModel() == 'woman' ? 'text-[#FFFFFF]' : 'text-[#FFFFFF8C]'">{{ locales.woman }}</p>
            </div>
        </div>
    </div>
</template>