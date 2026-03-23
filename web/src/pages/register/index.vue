<script setup lang="ts">
import { onMounted } from 'vue';
import { DefaultData } from '@/store/index';
import { storeToRefs } from 'pinia';
import { AnimatePresence, motion } from 'motion-v';

import type { Ref } from 'vue';
import type { Page, Locales, SubPage, RegisterModel } from '@/types/index';

const StoreData = DefaultData();
const { locales, page, subpage, register_model } = storeToRefs(StoreData) as {
    locales: Ref<Locales>,
    page: Ref<Page>,
    subpage: Ref<SubPage>,
    register_model: Ref<RegisterModel>
};

import Text from '@/components/inputs/text.vue';
import Range from '@/components/inputs/range.vue';
import Date from '@/components/inputs/date.vue';
import Buttons from '@/components/inputs/button.vue';
import Menu from '@/components/inputs/menu.vue';
import Slots from '@/components/slots/index.vue';

onMounted(() => {
    window.addEventListener('keydown', (event) => {
        if (event.key == 'Enter') {
            if (page.value !== 'Creator') return;
            StoreData.CreateCharacter();
        }
    });
});
</script>

<template>
    <div v-if="page == 'Creator' && !subpage.warning_page && !subpage.animation_page" class="w-[3.0208vw] h-[21.8229vw] rounded-[21.8229vw] bg-[#FFFFFF8C] absolute -left-[2.2396vw] top-[7.3438vw]" style="filter: blur(6.0677vw);"></div>
    <div v-if="page == 'Creator' && !subpage.warning_page && !subpage.animation_page" class="w-[3.0208vw] h-[21.8229vw] rounded-[21.8229vw] absolute -left-[2.2396vw] top-[26.7188vw]" style="filter: blur(6.0677vw);" :style="`background: ${StoreData.GetThemeColor()}8c;`"></div>
    <AnimatePresence mode="sync">
        <motion.div :initial="{ x: '-100%', opacity: 0 }" :animate="{ x: '0', opacity: 1 }" :exit="{ x: '-100%', opacity: 0 }" :transition="{ duration: 0.5, ease: 'easeInOut' }" v-if="page == 'Creator' && !subpage.warning_page && !subpage.animation_page" class="flex flex-col items-start absolute left-[4.1146vw] gap-x-[.7813vw] z-50">
            <div class="flex flex-col items-start gap-y-[.3646vw]">
                <div class="w-[13.8021vw] h-[3.0729vw] py-[.3125vw] pl-[.3125vw] flex items-center gap-x-[.5208vw] relative">
                    <img src="/imgs/line.png" alt="line" class="w-[13.8021vw] h-[3.0729vw] absolute top-0 left-0" />
                    <div class="w-[2.3438vw] h-[2.3438vw] flex items-center justify-center rounded-[.1042vw] border-[.026vw] border-solid" :style="`background: radial-gradient(74.18% 50% at 50% 50%, ${StoreData.GetThemeRGBA(StoreData.GetThemeColor(), 14)} 0%, ${StoreData.GetThemeRGBA(StoreData.GetThemeSecondaryColor(), 14)} 100%);border-color: ${StoreData.GetThemeColor()}8C;`">
                        <i class="fa-solid fa-users text-[1.1458vw]" :style="`color: ${StoreData.GetThemeColor()};`"></i>
                    </div>
                    <div>
                        <p class="font-['Poppins-LightItalic'] text-[#FFF] text-[.7292vw] line-clamp-1 leading-none tracking-[.6125vw] uppercase">{{ locales.character }}</p>
                        <p class="font-['Poppins-BoldItalic'] text-[#FFF] text-[1.0938vw] line-clamp-1 leading-none uppercase">{{ locales.creator_menu }}</p>
                    </div>
                </div>
                <p class="text-[#FFF]/85 text-[.625vw] w-[13.8021vw] leading-tight font-['Poppins-LightItalic']">{{ locales.creator_menu_desc }}</p>
            </div>
            <div class="flex flex-col items-start gap-y-[1.0938vw] w-[13.3333vw] mt-[.7813vw]">
                <Text v-model="register_model.firstname" :title="locales.firstname" :description="locales.firstname_desc" placeholder="John" />
                <Text v-model="register_model.lastname" :title="locales.lastname" :description="locales.lastname_desc" placeholder="Doe" />
                <Range v-model="register_model.height" :title="locales.height" :description="locales.height_desc" placeholder="Height in cm" />
                <Date v-model="register_model.birthday" :title="locales.birthdate" :description="locales.birthdate_desc" placeholder="DD/MM/YYYY" />
                <Buttons v-model="register_model.gender" :title="locales.gender" :description="locales.gender_desc" placeholder="Gender" />
                <Menu v-model="register_model.nationality" :title="locales.nationality" :description="locales.nationality_desc" placeholder="Select" />
                <div class="w-[13.8021vw] h-[2.7604vw] flex items-center justify-center border-[.026vw] border-solid rounded-[.0521vw]" :class="StoreData.IsFormValid() ? 'cursor-pointer' : 'opacity-50'" @click="StoreData.CreateCharacter()" :style="`background: radial-gradient(74.18% 50% at 50% 50%, ${StoreData.GetThemeRGBA(StoreData.GetThemeColor(), 14)} 0%, ${StoreData.GetThemeRGBA(StoreData.GetThemeSecondaryColor(), 14)} 100%);border-color: ${StoreData.GetThemeColor()}8C;`">
                    <p class="text-[.625vw] font-['Poppins-Medium'] line-clamp-1 leading-tight" :style="`color: ${StoreData.GetThemeColor()};`">{{ locales.create_new_character }}</p>
                </div>
                <Slots />
            </div>
        </motion.div>
    </AnimatePresence>
</template>