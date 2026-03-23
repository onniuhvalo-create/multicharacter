<script setup lang="ts">
import { DefaultData } from '@/store/index';
import { storeToRefs } from 'pinia';
import { AnimatePresence, motion } from 'motion-v';

import type { Ref } from 'vue';
import type { Page, SubPage } from '@/types/index';

const StoreData = DefaultData();
const { locales, page, subpage, locations, location } = storeToRefs(StoreData) as {
    locales: Ref<any>,
    page: Ref<Page>,
    subpage: Ref<SubPage>,
    locations: Ref<any[]>,
    location: Ref<any>
};

function smoothScrollBy(element: any, distance: any, duration = 300) {
    const start = element.scrollLeft;
    const startTime = performance.now();

    function step(currentTime: number) {
        const elapsed = currentTime - startTime;
        const progress = Math.min(elapsed / duration, 1);
        const ease = progress < 0.5
            ? 2 * progress * progress
            : -1 + (4 - 2 * progress) * progress;
        element.scrollLeft = start + distance * ease;

        if (progress < 1) {
            requestAnimationFrame(step);
        }
    }

    requestAnimationFrame(step);
}

function ScrollRight() {
    const dataElement = document.getElementById('data');
    if (dataElement) {
        smoothScrollBy(dataElement, 200);
    }
}

function ScrollLeft() {
    const dataElement = document.getElementById('data');
    if (dataElement) {
        smoothScrollBy(dataElement, -200);
    }
}
</script>

<template>
    <AnimatePresence mode="sync">
        <motion.div :initial="{ opacity: 0 }" :animate="{ opacity: 1 }" :exit="{ opacity: 0 }" :transition="{ duration: 0.5 }" v-if="page == 'Spawn' && !subpage.warning_page && !subpage.animation_page" class="w-full h-full pt-[3.9063vw] pb-[3.8021vw] px-[4.6354vw] flex flex-col items-start justify-between">
            <motion.div :initial="{ y: '-100%' }" :animate="{ y: 0 }" :exit="{ y: '-100%' }" :transition="{ duration: 0.5 }" v-if="page == 'Spawn' && !subpage.warning_page && !subpage.animation_page" class="flex items-start justify-between w-full">
                <div class="flex flex-col items-start gap-y-[.3646vw]">
                    <div class="w-[13.8021vw] h-[3.0729vw] py-[.3125vw] pl-[.3125vw] flex items-center gap-x-[.5208vw] relative">
                        <img src="/imgs/line.png" alt="line" class="w-[13.8021vw] h-[3.0729vw] absolute top-0 left-0" />
                        <div class="w-[2.3438vw] h-[2.3438vw] flex items-center justify-center rounded-[.1042vw] border-[.026vw] border-solid" :style="`background: radial-gradient(74.18% 50% at 50% 50%, ${StoreData.GetThemeRGBA(StoreData.GetThemeColor(), 14)} 0%, ${StoreData.GetThemeRGBA(StoreData.GetThemeSecondaryColor(), 14)} 100%);border-color: ${StoreData.GetThemeColor()}8C;`">
                            <i class="fa-solid fa-users text-[1.1458vw]" :style="`color: ${StoreData.GetThemeColor()};`"></i>
                        </div>
                        <div class="flex flex-col items-start">
                            <p class="font-['Poppins-LightItalic'] text-[#FFF] text-[.7292vw] line-clamp-1 leading-none tracking-[.4667vw] uppercase">{{ locales.selector }}</p>
                            <p class="font-['Poppins-BoldItalic'] text-[#FFF] text-[1.0938vw] line-clamp-1 leading-none uppercase">{{ locales.spawns }}</p>
                        </div>
                    </div>
                    <p class="text-[#FFF]/85 text-[.625vw] w-[13.8021vw] leading-tight font-['Poppins-LightItalic']">{{ locales.spawns_desc }}</p>
                </div>
                <div class="flex items-center gap-x-[.5208vw] relative">
                    <div class="flex flex-col items-end">
                        <p class="font-['Poppins-LightItalic'] text-[#FFF] text-[.7292vw] line-clamp-1 leading-none tracking-[.4667vw] uppercase">{{ locales.select }}</p>
                        <p class="font-['Poppins-BoldItalic'] text-[#FFF] text-[1.0938vw] line-clamp-1 leading-none uppercase">{{ locales.spawns }}</p>
                    </div>
                    <div class="flex items-center justify-center w-[2.3438vw] h-[2.3438vw] rounded-[.0521vw] border-[.026vw] border-solid cursor-pointer group transition-all duration-300" @click="StoreData.SpawnLocation()" :style="`background: radial-gradient(74.18% 50% at 50% 50%, ${StoreData.GetThemeRGBA(StoreData.GetThemeColor(), 14)} 0%, ${StoreData.GetThemeRGBA(StoreData.GetThemeSecondaryColor(), 14)} 100%);border-color: ${StoreData.GetThemeColor()}8C;`">
                        <i class="fa-regular fa-check text-[#FFF] text-[.9375vw]"></i>
                    </div>
                </div>
            </motion.div>
            <motion.div :initial="{ y: '200%' }" :animate="{ y: 0 }" :exit="{ y: '200%' }" :transition="{ duration: 0.5 }" v-if="page == 'Spawn' && !subpage.warning_page && !subpage.animation_page" class="flex flex-col w-full items-center gap-y-[.3646vw]">

                <div class="flex items-center w-full">
                    <div class="flex items-center gap-x-[.4688vw] min-w-[9.5vw] w-max max-w-[12.5vw]">
                        <div class="min-w-[1.0417vw] min-h-[1.0417vw] w-[1.0417vw] h-[1.0417vw] flex items-center justify-center border-[.0521vw] border-solid border-[#FFFFFF40] rounded-full">
                            <i class="fa-solid fa-info text-[.625vw]" :style="`color: ${StoreData.GetThemeColor()};`"></i>
                        </div>
                        <p class="text-[.7292vw] text-[#FFFFFF] font-['Poppins-Medium'] line-clamp-1 leading-tight">{{ locales.spawns_info }}</p>
                    </div>
                    <div class="w-full h-[.0521vw] bg-[#FFFFFF40] ml-[.3125vw] mr-[.4688vw]"></div>
                    <div class="flex items-center gap-x-[.2604vw]">
                        <div class="w-[1.6667vw] h-[1.6667vw] flex items-center justify-center rounded-[.0521vw] bg-[#FFFFFF0D] border-[.026vw] border-solid border-[#FFFFFF40] cursor-pointer hover:bg-[#FFFFFF1A]" @click="ScrollLeft">
                            <i class="fa-solid fa-angle-left text-[.7292vw] text-[#FFF]"></i>
                        </div>
                        <div class="w-[1.6667vw] h-[1.6667vw] flex items-center justify-center rounded-[.0521vw] bg-[#FFFFFF0D] border-[.026vw] border-solid border-[#FFFFFF40] cursor-pointer hover:bg-[#FFFFFF1A]" @click="ScrollRight">
                            <i class="fa-solid fa-angle-right text-[.7292vw] text-[#FFF]"></i>
                        </div>
                    </div>
                </div>
                <div id="data" class="flex items-start w-full h-max gap-x-[.5208vw] overflow-x-auto scrollbar-hide">
                    <div v-for="(loc, index) in locations" :key="index" class="flex flex-col items-start w-max h-max gap-y-[.2604vw]" @click="StoreData.SelectSpawnLocation(loc)">
                        <div class="flex flex-col items-center w-[12.3958vw] h-[8.3333vw] rounded-[.0521vw] border-[.026vw] border-solid p-[.5208vw] gap-y-[.3646vw] cursor-pointer" :style="loc.id == location.id ? `border-color: ${StoreData.GetThemeColor()}8C;background: radial-gradient(74.18% 50% at 50% 50%, ${StoreData.GetThemeRGBA(StoreData.GetThemeColor(), 14)} 0%, ${StoreData.GetThemeRGBA(StoreData.GetThemeSecondaryColor(), 14)} 100%);` : 'border-color: #FFFFFF40;background: #FFFFFF0D;'">
                            <img :src="`nui://0r-multicharacterv3/web/build/imgs/${loc.img}.png`" alt="test-image" class="w-full h-[5.3646vw] object-cover rounded-[.0521vw]" />
                            <div class="flex items-center gap-x-[.3125vw] w-full">
                                <div class="min-w-[1.5625vw] min-h-[1.5625vw] w-[1.5625vw] h-[1.5625vw] flex items-center justify-center rounded-[.0521vw] border-solid border-[.026vw]" :style="loc.id == location.id ? `border-color: ${StoreData.GetThemeColor()}8C;background: radial-gradient(74.18% 50% at 50% 50%, ${StoreData.GetThemeRGBA(StoreData.GetThemeColor(), 14)} 0%, ${StoreData.GetThemeRGBA(StoreData.GetThemeSecondaryColor(), 14)} 100%);` : 'border-color: #FFFFFF40;background: #FFFFFF0D;'">
                                    <i :class="`${loc.icon}`" class="text-[.7292vw]" :style="`color: ${loc.id == location.id ? `${StoreData.GetThemeColor()}` : '#FFF'}`"></i>
                                </div>
                                <div class="w-full h-[1.5625vw] px-[.5208vw] flex items-center justify-start bg-[#FFFFFF0D] border-[.026vw] border-solid border-[#FFFFFF40]">
                                    <p class="font-['Poppins-Medium'] text-[.7292vw] text-[#FFF] line-clamp-1 leading-tight">{{ loc.label }}</p>
                                </div>
                            </div>
                        </div>
                        <div class="w-full h-[.0521vw]" :style="`background: ${loc.id == location.id ? `${StoreData.GetThemeColor()}` : '#FFFFFF8C'}`"></div>
                    </div>
                </div>
            </motion.div>
        </motion.div>
    </AnimatePresence>
</template>

<style scoped>
#data {
    scroll-behavior: smooth;
}

.scrollbar-hide::-webkit-scrollbar {
    display: none;
}
</style>