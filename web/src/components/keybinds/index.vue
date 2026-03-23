<script setup lang="ts">
import { DefaultData } from '@/store/index';
import { storeToRefs } from 'pinia';

import type { Ref } from 'vue';
import type { Page, SubPage, Characters } from '@/types/index';

const StoreData = DefaultData();
const { locales, page, subpage, characters } = storeToRefs(StoreData) as {
    locales: Ref<any>,
    page: Ref<Page>,
    subpage: Ref<SubPage>,
    characters: Ref<Characters[]>
};

const PreviousCharacter = () => {
    const currentIndex = StoreData.GetCharacterIndex();

    if (currentIndex > 0) {
        StoreData.ChangeCharacter(currentIndex - 1);
    } else {
        StoreData.ChangeCharacter(characters.value.length - 1);
    }
};

const NextCharacter = () => {
    const currentIndex = StoreData.GetCharacterIndex();

    if (currentIndex < characters.value.length - 1) {
        StoreData.ChangeCharacter(currentIndex + 1);
    } else {
        StoreData.ChangeCharacter(0);
    }
};
</script>

<template>
    <div v-if="(page == 'Creator' || page == 'Selection') && (!subpage.warning_page && !subpage.animation_page)" class="flex items-center gap-x-[.5208vw] absolute bottom-[2.5vw] right-[2.5vw]">
        <div class="flex items-center gap-x-[.3125vw] group cursor-pointer" @click="PreviousCharacter">
            <p class="text-[.7292vw] font-['Poppins-Regular'] text-[#FFF]/55 line-clamp-1 group-hover:text-[#FFF]">{{ locales.previous_character }}</p>
            <div class="w-[1.25vw] h-[1.25vw] bg-[#FFF]/10 rounded-[.0521vw] flex items-center justify-center group-hover:bg-[#FFF]/20">
                <i class="fa-solid fa-arrow-left text-[.7292vw] text-[#FFF]/55 line-clamp-1 group-hover:text-[#FFF]"></i>
            </div>
        </div>
        <div class="flex items-center gap-x-[.3125vw] group cursor-pointer" @click="NextCharacter">
            <p class="text-[.7292vw] font-['Poppins-Regular'] text-[#FFF]/55 line-clamp-1 group-hover:text-[#FFF]">{{ locales.next_character }}</p>
            <div class="w-[1.25vw] h-[1.25vw] bg-[#FFF]/10 rounded-[.0521vw] flex items-center justify-center group-hover:bg-[#FFF]/20">
                <i class="fa-solid fa-arrow-right text-[.7292vw] text-[#FFF]/55 line-clamp-1 group-hover:text-[#FFF]"></i>
            </div>
        </div>
        <div class="flex items-center gap-x-[.3125vw] group cursor-pointer" @click="StoreData.ChangeSubpage('settings')">
            <p class="text-[.7292vw] font-['Poppins-Regular'] text-[#FFF]/55 line-clamp-1 group-hover:text-[#FFF]">{{ locales.settings }}</p>
            <div class="w-[1.25vw] h-[1.25vw] bg-[#FFF]/10 rounded-[.0521vw] flex items-center justify-center group-hover:bg-[#FFF]/20">
                <p class="text-[.7292vw] font-['Arame'] text-[#FFF]/55 line-clamp-1 group-hover:text-[#FFF]">S</p>
            </div>
        </div>
    </div>
</template>