<script setup lang="ts">
import { onMounted, ref } from 'vue';
import { DefaultData } from '@/store/index';
import { storeToRefs } from 'pinia';
import { AnimatePresence, motion } from 'motion-v';

import type { Ref } from 'vue';
import type { Page, SubPage } from '@/types/index';
import { FetchNUI } from '@/utils';

const StoreData = DefaultData();
const { locales, page, subpage } = storeToRefs(StoreData) as {
    locales: Ref<any>;
    page: Ref<Page>;
    subpage: Ref<SubPage>;
};

onMounted(() => {
    const TransactionSound = new Audio('nui://0r-multicharacterv3/web/build/sounds/transition-sound.ogg');
    window.addEventListener('keydown', (event) => {
        if (event.key) {
            if (subpage.value.warning_page) {
                subpage.value.warning_page = false;
                TransactionSound.volume = 0.2;
                TransactionSound.currentTime = 0;
                TransactionSound.play();

                setTimeout(() => {
                    subpage.value.animation_page = true;

                    FetchNUI('HIDING_WARNING_SCREEN', {});
                }, 550);
            }
        }
    });
});
</script>

<template>
    <div v-if="!page && !subpage.animation_page" class="w-full h-full flex flex-col items-center justify-between absolute top-0 left-0 bg-[#000]">
        <AnimatePresence :initial="false" mode="sync">
            <motion.div v-if="subpage.warning_page" :animate="{ opacity: 1 }" :exit="{ opacity: 0 }" :transition="{ duration: 0.5, ease: 'easeInOut' }" class="flex flex-col items-center justify-center absolute -translate-x-1/2 -translate-y-1/2 top-1/2 left-1/2 z-10">
                <i class="fa-light fa-triangle-exclamation text-[2.5vw] text-[#FFF]"></i>
                <h2 class="text-[1.875vw] text-[#FFF] font-['Arame']">{{ locales.warning_header }}</h2>
                <div class="flex mt-[2.5vw] w-[62.5vw]">
                    <p class="text-[.9375vw] text-[#FFF]/70 font-['Arame']">{{ locales.warning_desc }}</p>
                </div>
            </motion.div>
            <motion.div v-if="subpage.warning_page" :animate="{ opacity: 1 }" :exit="{ opacity: 0 }" :transition="{ duration: 0.5, ease: 'easeInOut' }" class="absolute bottom-[2.5vw] right-[2.5vw] animate-pulse">
                <p class="text-[.9375vw] text-[#FFF]/70 font-['Arame']">{{ locales.press_any_key }}</p>
            </motion.div>
        </AnimatePresence>
    </div>
</template>