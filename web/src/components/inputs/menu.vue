<script setup lang="ts">
import Countires from '@/api/countries.json';
import { ref, shallowRef, useTemplateRef } from 'vue';
import { onClickOutside } from '@vueuse/core'
import { DefaultData } from '@/store/index';
import { storeToRefs } from 'pinia';
import { AnimatePresence, motion } from 'motion-v';

const StoreData = DefaultData();
const { locales } = storeToRefs(StoreData)

const model = defineModel<string|boolean>({ default: false });

const searchQuery = ref('');

const filteredCountries = () => {
    if (!searchQuery.value) {
        return Countires;
    }
    return Countires.filter(country => country.toLowerCase().includes(searchQuery.value.toLowerCase()));
};

const modal = shallowRef(false)
const modalRef = useTemplateRef('modalRef')
const buttonRef = useTemplateRef('buttonRef')

onClickOutside(
  modalRef,
  () => {
    modal.value = false
  },
  {
    ignore: [buttonRef],
  }
)

defineProps<{
    title: string;
    description: string;
    placeholder: string;
}>();

function GetModel() {
    return model.value !== '' && model.value !== false ? model.value : false;
}

function SetModel(value: string) {
    model.value = value;
}
</script>

<template>
    <div class="flex flex-col items-center gap-y-[.3229vw] w-[13.8021vw] h-full relative">
        <div class="flex items-center justify-between w-full">
            <div class="flex items-center">
                <div class="flex items-center gap-x-[.2083vw]">
                    <div class="w-[.7292vw] h-[.7292vw] relative flex items-center justify-center">
                        <div class="w-full h-full rotate-45 rounded-[.1042vw] border-[.026vw] border-solid absolute top-0 left-0":style="`background: radial-gradient(74.18% 50% at 50% 50%, ${StoreData.GetThemeRGBA(StoreData.GetThemeColor(), 14)} 0%, ${StoreData.GetThemeRGBA(StoreData.GetThemeSecondaryColor(), 14)} 100%);border-color: ${StoreData.GetThemeColor()}8C;`">
                        </div>
                        <i class="fa-solid fa-gear text-[.5208vw]" :style="`color: ${StoreData.GetThemeColor()};`"></i>
                    </div>
                    <p class="font-['Arame'] text-[.7292vw] text-[#FFF] line-clamp-1 leading-none">{{ title }}</p>
                </div>
            </div>
            <p class="text-[#FFFFFF8C] font-['Poppins-Regular'] text-[.7292vw] leading-none line-clamp-1">{{ description }}</p>
        </div>
        <div class="w-full h-[2.0313vw] flex items-center justify-between relative">
            <div ref="buttonRef" class="w-full h-[2.0313vw] flex items-center justify-between bg-[#FFFFFF0D] border-[#FFFFFF40] border-solid border-[.026vw] pl-[.8333vw] pr-[.5208vw] cursor-pointer" @click="modal = !modal">
                <p class="font-['Poppins-Regular'] text-[#FFFFFF] text-[.625vw] line-clamp-1 leading-tight">{{ GetModel() ? GetModel() : locales.select_nationality }}</p>
                <div class="w-[.9896vw] h-[.9896vw] bg-[#FFFFFF0D] border-[.026vw] border-solid border-[#FFFFFF40] flex items-center justify-center rounded-[.0521vw]">
                    <i class="fa-solid fa-angle-down text-[.5208vw] text-[#FFF]"></i>
                </div>
            </div>
            <AnimatePresence mode="sync">
                <motion.div :initial="{ opacity: 0 }" :animate="{ opacity: 1 }" :exit="{ opacity: 0 }" :transition="{ duration: 0.3 }" v-if="modal" ref="modalRef" class="w-full h-[10.625vw] flex flex-col items-center justify-start absolute top-0 right-[-14.3229vw]">
                    <div class="w-full h-[2.0313vw] flex items-center bg-[#FFFFFF0D] border-[#FFFFFF40] border-solid border-[.026vw] px-[.5208vw]">
                        <i class="fa-solid fa-magnifying-glass text-[.7292vw] text-[#FFFF]/55"></i>
                        <input type="text" class="w-full h-full bg-transparent outline-none text-[#FFF] font-['Poppins-Regular'] text-[.625vw] leading-tight pl-[.5208vw]" :placeholder="locales.search_nationality" v-model="searchQuery" />
                    </div>
                    <div id="hide-scroll" class="w-full h-full flex flex-col items-start mt-[.3125vw] gap-y-[.3125vw] max-h-[8.3333vw] overflow-y-auto">
                        <div v-for="(country, index) in filteredCountries()" id="nationality-div" :key="index" class="w-full h-max border-[.026vw] border-solid py-[.1563vw] cursor-pointer rounded-[.0521vw]" :style="`--color: ${StoreData.GetThemeColor()};--theme-color: ${StoreData.GetThemeRGBA(StoreData.GetThemeColor(), 14)};--secondary-color: ${StoreData.GetThemeRGBA(StoreData.GetThemeSecondaryColor(), 14)}`" @click="SetModel(country); modal = false">
                            <p class="text-[.625vw] font-['Poppins-Regular'] text-[#FFF] text-center">{{ country }}</p>
                        </div>
                    </div>
                </motion.div>
            </AnimatePresence>
        </div>
    </div>
</template>

<style>
#hide-scroll::-webkit-scrollbar {
    width: 0vw;
    background: transparent;
}

#nationality-div {
    background: #FFFFFF0D;
    border-color: #FFFFFF40;
}

#nationality-div:hover {
    background: radial-gradient(74.18% 50% at 50% 50%, var(--theme-color) 0%, var(--secondary-color) 100%);
    border-color: var(--color);
}
</style>