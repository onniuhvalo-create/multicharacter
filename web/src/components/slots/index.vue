<script setup lang="ts">
import { DefaultData } from '@/store/index';
import { storeToRefs } from 'pinia';

import type { Ref } from 'vue';
import type { Page, Characters, CharacterLimit } from '@/types/index';

const StoreData = DefaultData();
const { page, characters, characters_limit, cid } = storeToRefs(StoreData) as {
    page: Ref<Page>
    characters: Ref<Characters[]>
    characters_limit: Ref<CharacterLimit>
    cid: Ref<number>
};
</script>

<template>
    <div class="flex items-center gap-x-[0.8889vh]">
        <template v-for="(number, index) in characters_limit" :key="number">
            <div v-if="characters[index]" class="w-[3.3333vh] h-[3.3333vh] rounded-[0.0926vh] border-solid border-[0.0926vh] flex items-center justify-center cursor-pointer" :style="`${characters[index].cid == cid && page !== 'Creator' ? `background: radial-gradient(74.18% 50% at 50% 50%, ${StoreData.GetThemeRGBA(StoreData.GetThemeColor(), 14)} 0%, ${StoreData.GetThemeRGBA(StoreData.GetThemeSecondaryColor(), 14)} 100%);border-color: ${StoreData.GetThemeColor()}8C;` : 'background: #FFFFFF0D;border-color: #FFFFFF40;' }`" @click="StoreData.ChangeCharacter(index);StoreData.ChangePage('Selection')">
                <p class="font-['Poppins-Regular'] text-[#FFF] text-[1.2963vh] leadint-tight">{{ number }}</p>
            </div>
            <div v-else class="w-[3.3333vh] h-[3.3333vh] rounded-[0.0926vh] border-solid border-[0.0926vh] border-[#FFFFFF40] flex items-center justify-center cursor-pointer bg-[#FFFFFF0D]" @click="StoreData.ChangePage('Creator')">
                <i class="fa-solid fa-plus text-[#FFF]/55 text-[1.2963vh] leadint-tight"></i>
            </div>
        </template>
        <div class="w-[3.3333vh] h-[3.3333vh] rounded-[0.0926vh] border-[#FFFFFF40] border-solid border-[0.0926vh] flex items-center justify-center cursor-pointer bg-[#FFFFFF0D]" @click="StoreData.ChangeSubpage('context');StoreData.RegisterContext('code')">
            <i class="fa-solid fa-key-skeleton text-[#FFF]/55 text-[1.2963vh] leadint-tight"></i>
        </div>
    </div>
</template>