<script setup lang="ts">
import { onMounted } from 'vue';
import { DefaultData } from '@/store/index';
import { storeToRefs } from 'pinia';
import { AnimatePresence, motion } from 'motion-v';

import type { Ref } from 'vue';
import type { Page, SubPage, Locales, AnimationData } from '@/types/index';

import LoginHeader from '@/components/login/header/index.vue';
import LoginItem from '@/components/login/item/index.vue';
import Slots from '@/components/slots/index.vue';

const StoreData = DefaultData();
const { locales, page, subpage, characters, character, settings, disable_delete_character } = storeToRefs(StoreData) as {
    locales: Ref<Locales>,
    page: Ref<Page>,
    subpage: Ref<SubPage>,
    characters: Ref<any[]>
    character: Ref<any>,
    animation_data: Ref<AnimationData>
    settings : Ref<any>
    disable_delete_character: Ref<boolean>
};

onMounted(() => {
    window.addEventListener('keydown', (event) => {
        if (!subpage.value.warning_page && !subpage.value.animation_page) {
            if (event.key == 'ArrowRight') {
                if (page.value !== 'Selection') return;
                const currentIndex = StoreData.GetCharacterIndex();

                if (currentIndex < characters.value.length - 1) {
                    StoreData.ChangeCharacter(currentIndex + 1);
                } else {
                    StoreData.ChangeCharacter(0);
                }
            } else if (event.key == 'ArrowLeft') {
                if (page.value !== 'Selection') return;

                const currentIndex = StoreData.GetCharacterIndex();
                if (currentIndex > 0) {
                    StoreData.ChangeCharacter(currentIndex - 1);
                } else {
                    StoreData.ChangeCharacter(characters.value.length - 1);
                }
            } else if (event.key.toUpperCase() == 'S') {
                if (page.value !== 'Selection' && page.value !== 'Creator') return;
                const isAnyInputFocused = document.activeElement instanceof HTMLInputElement;
                if (isAnyInputFocused) return;

                subpage.value.settings = !subpage.value.settings;
            } else if (event.key == 'Enter') {
                if (page.value == 'Selection' && !subpage.value.context && !subpage.value.settings) {
                    StoreData.PlayCharacter();
                } else if (page.value == 'Creator' && !subpage.value.context && !subpage.value.settings) {
                    StoreData.CreateCharacter();
                }
            }
        };
    });
});
</script>

<template>
    <div v-if="page == 'Selection' && !subpage.warning_page && !subpage.animation_page" class="w-[5.3704vh] h-[38.7963vh] rounded-[38.7963vh] bg-[#FFFFFF8C] absolute -left-[3.9815vh] top-[13.0556vh]" style="filter: blur(6.0677vw);"></div>
    <div v-if="page == 'Selection' && !subpage.warning_page && !subpage.animation_page" class="w-[5.3704vh] h-[38.7963vh] rounded-[38.7963vh] absolute -left-[3.9815vh] top-[47.5vh]" style="filter: blur(6.0677vw);" :style="`background: ${StoreData.GetThemeColor()}8c;`"></div>
    <AnimatePresence mode="sync">
        <motion.div :initial="{ x: '-100%', opacity: 0 }" :animate="{ x: '0', opacity: 1 }" :exit="{ x: '-100%', opacity: 0 }" :transition="{ duration: 0.5, ease: 'easeInOut' }" v-if="page == 'Selection' && !subpage.warning_page && !subpage.animation_page" class="flex flex-col items-start absolute left-[7.3148vh] z-50">
            <div class="flex flex-col items-start gap-y-[0.6481vh]">
                <div class="w-[24.537vh] h-[5.463vh] py-[0.5556vh] pl-[0.5556vh] flex items-center gap-x-[0.9259vh]">
                    <img src="/imgs/line.png" alt="line" class="w-[24.537vh] h-[5.463vh] absolute top-0 left-0" />
                    <div class="w-[4.1667vh] h-[4.1667vh] flex items-center justify-center rounded-[0.1852vh] border-[0.0463vh] border-solid" :style="`background: radial-gradient(74.18% 50% at 50% 50%, ${StoreData.GetThemeRGBA(StoreData.GetThemeColor(), 14)} 0%, ${StoreData.GetThemeRGBA(StoreData.GetThemeSecondaryColor(), 14)} 100%);border-color: ${StoreData.GetThemeColor()}8C;`">
                        <i class="fa-solid fa-users text-[2.037vh]" :style="`color: ${StoreData.GetThemeColor()};`"></i>
                    </div>
                    <div class="flex flex-col items-start">
                        <p class="font-['Poppins-LightItalic'] text-[#FFF] text-[1.2963vh] line-clamp-1 leading-none tracking-[1.0185vh] uppercase">{{ locales.character }}</p>
                        <p class="font-['Poppins-BoldItalic'] text-[#FFF] text-[1.9444vh] line-clamp-1 leading-none uppercase">{{ locales.selection_menu }}</p>
                    </div>
                </div>
                <p class="text-[#FFF]/85 text-[1.1111vh] w-[24.537vh] leading-tight font-['Poppins-LightItalic']">{{ locales.selection_menu_desc }}</p>
            </div>
            <div class="flex flex-col items-start mt-[1.3889vh] gap-y-[3.0556vh] w-[24.537vh]">
                <div class="flex flex-col items-start gap-y-[1.1111vh] w-full">
                    <LoginHeader image="cd-frame" :title="locales.character" :description="locales.details" />
                    <div class="w-full grid justify-between gap-y-[1.1111vh] min-w-[11.3889vh]" style="grid-template-columns: repeat(2, max-content);">
                        <LoginItem icon="fa-solid fa-user" :title="locales.firstname" :description="character.charinfo.firstname" />
                        <LoginItem icon="fa-solid fa-user" :title="locales.lastname" :description="character.charinfo.lastname" />
                        <LoginItem icon="fa-solid fa-cake-candles" :title="locales.birthdate" :description="character.charinfo.birthdate" />
                        <LoginItem icon="fa-solid fa-phone" :title="locales.phone" :description="settings.streamer_mode ? '***********' : character.charinfo.phone" />
                        <LoginItem icon="fa-solid fa-venus-mars" :title="locales.gender" :description="character.charinfo.height ? StoreData.GetGender(character.charinfo.gender) + ' - ' + character.charinfo.height : StoreData.GetGender(character.charinfo.gender)" />
                        <LoginItem icon="fa-solid fa-flag" :title="locales.nationality" :description="character.charinfo.nationality" />
                    </div>
                </div>
                <div class="flex flex-col items-start gap-y-[1.1111vh] w-full">
                    <LoginHeader image="jb-frame" :title="locales.job" :description="locales.information" />
                    <div class="w-full grid justify-between gap-y-[1.1111vh]" style="grid-template-columns: repeat(2, max-content);">
                        <LoginItem icon="fa-solid fa-briefcase" :title="locales.job" :description="character.job.label" />
                        <LoginItem icon="fa-solid fa-angles-up" :title="locales.rank" :description="character.job.grade.name" />
                    </div>
                </div>
                <div class="flex flex-col items-start gap-y-[1.1111vh] w-full">
                    <LoginHeader image="fi-frame" :title="locales.finance" :description="locales.information" />
                    <div class="w-full grid justify-between gap-y-[1.1111vh]" style="grid-template-columns: repeat(2, max-content);">
                        <LoginItem icon="fa-solid fa-building-columns" :title="locales.bank" :description="String(character.money.bank)" />
                        <LoginItem icon="fa-solid fa-wallet" :title="locales.cash" :description="String(character.money.cash)" />
                    </div>
                </div>
                <div class="w-full flex items-center justify-center gap-x-[0.8333vh]">
                    <div class="flex items-center justify-center w-full h-[4.9074vh] rounded-[0.0926vh] border-[0.0463vh] border-solid cursor-pointer group transition-all duration-300" @click="StoreData.PlayCharacter()" :style="`background: radial-gradient(74.18% 50% at 50% 50%, ${StoreData.GetThemeRGBA(StoreData.GetThemeColor(), 14)} 0%, ${StoreData.GetThemeRGBA(StoreData.GetThemeSecondaryColor(), 14)} 100%);border-color: ${StoreData.GetThemeColor()}8C;`">
                        <p class="text-[1.1111vh] font-['Poppins-Regular'] leading-tight line-clamp-1 transition-all duration-300" :style="`color: ${StoreData.GetThemeColor()};`">{{ locales.play }}</p>
                    </div>
                    <div v-if="!disable_delete_character" class="flex items-center justify-center w-full h-[4.9074vh] rounded-[0.0926vh] border-[0.0463vh] border-solid border-[#FF33008C] cursor-pointer group transition-all duration-300 hover:bg-[#FF3300]" style="background: radial-gradient(74.18% 50% at 50% 50%, rgba(255, 51, 0, 0.14) 0%, rgba(181, 36, 0, 0.14) 100%);" @click="StoreData.ChangeSubpage('context');StoreData.RegisterContext('delete')">
                        <p class="text-[1.1111vh] font-['Poppins-Regular'] text-[#FF3300] leading-tight line-clamp-1 transition-all duration-300">{{ locales.delete }}</p>
                    </div>
                </div>
                <Slots />
            </div>
        </motion.div>
    </AnimatePresence>
</template>