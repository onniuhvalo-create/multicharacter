<script setup lang="ts">
import { DefaultData } from '@/store/index';
import { storeToRefs } from 'pinia';
import { AnimatePresence, motion } from 'motion-v';

import type { Ref } from 'vue';
import type { SubPage, AnimationData } from '@/types';

const StoreData = DefaultData();
const { subpage, animation_data } = storeToRefs(StoreData) as {
    subpage: Ref<SubPage>;
    animation_data: Ref<AnimationData>;
};
</script>

<template>
    <AnimatePresence mode="sync">
        <motion.div
            v-bind="animation_data.initial
                ? { initial: { opacity: 0 }, animate: { opacity: 1 }, exit: { opacity: 0 }, transition: { duration: 0.5, ease: 'easeInOut' } }
                : { animate: { opacity: 1 }, exit: { opacity: 0 }, transition: { duration: 0.5, ease: 'easeInOut' } }"  v-if="!subpage.warning_page && subpage.animation_page" class="w-full h-full flex flex-col items-center justify-between absolute top-0 left-0 bg-[#000]">
            <motion.div v-if="!subpage.warning_page && subpage.animation_page" :initial="{ opacity: 0 }" :animate="{ opacity: 1 }" :exit="{ opacity: 0 }" :transition="{ duration: 0.5, ease: 'easeInOut' }" class="w-full h-full relative">
                <div class="absolute bottom-[2.5vw] right-[2.5vw] flex items-center justify-center gap-[.625vw]">
                    <p class="font-['Arame'] text-[.9375vw] text-[#FFF]/70">{{ animation_data.text }}</p>
                    <div class="w-[1.4583vw] h-[1.4583vw] border-[.2604vw] border-solid border-[#FFF]/70 border-b-transparent rounded-[50%] inline-block box-border animate-spin"></div>
                </div>
            </motion.div>
        </motion.div>
    </AnimatePresence>
</template>