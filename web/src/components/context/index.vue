<script setup lang="ts">
import { DefaultData } from '@/store/index';
import { storeToRefs } from 'pinia';
import { AnimatePresence, motion } from 'motion-v';

import { onClickOutside } from '@vueuse/core'
import { useTemplateRef } from 'vue'

import type { Ref } from 'vue';
import type { SubPage, Context } from '@/types/index';

const StoreData = DefaultData();
const { subpage, context, transaction_id } = storeToRefs(StoreData) as unknown as {
  subpage: Ref<SubPage>,
  context: Ref<Context | null>
  transaction_id: Ref<string>
};

const modalRef = useTemplateRef<HTMLElement | null>('context-modal')

onClickOutside(
  modalRef,
  (event) => {
    subpage.value.context = false;
  },
)

const GetModel = (data: string) => {
  if (data === 'transaction_id') {
    return transaction_id.value;
  }
}

const UpdateModel = (data: string, value: string) => {
  if (data === 'transaction_id') {
    transaction_id.value = value;
  }
}
</script>

<template>
  <AnimatePresence mode="sync">
    <motion.div :initial="{ opacity: 0 }" :animate="{ opacity: 1 }" :exit="{ opacity: 0 }" :transition="{ duration: 0.3 }" v-if="subpage.context && context && context.title" ref="context-modal" class="p-[.3125vw] h-max absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 rounded-[.1042vw] border-[.026vw] border-solid border-[#FFFFFF40] flex flex-col items-start gap-y-[.2083vw] z-50 w-[18.9583vw] bg-[#00000083]">
      <div class="flex flex-col items-start">
        <p class="font-['Poppins-Medium'] text-[.7292vw] text-[#FFF] leading-tight line-clamp-1">{{ context.title }}</p>
        <p class="font-['Poppins-Regular'] text-[.625vw] text-[#FFFFFF8C] line-clamp-2 leading-tight">{{ context.description }}</p>
      </div>
      <div class="flex flex-col w-full h-max">
        <template v-for="(data, index) in context.items" :key="index">
          <p class="text-[.625vw] text-[#FFF] font-['Poppins-Regular'] line-clamp-1 leading-tight py-[.2083vw] px-[.2083vw]">{{ data.label }}</p>
          <input v-if="data.type == 'text'" type="text" class="w-full h-[2.0313vw] bg-[#FFFFFF0D] rounded-[.0521vw] border-[.026vw] border-solid border-[#FFFFFF40] text-[#FFF] font-['Poppins-Regular'] text-[.625vw] leading-tight pl-[.5208vw] outline-none" :value="GetModel(data.model)" @input="UpdateModel(data.model, ($event.target as HTMLInputElement).value)" />
        </template>
      </div>
      <div class="w-full h-max flex items-center gap-x-[.3646vw]">
        <div class="w-full h-[2.0313vw] border-[.026vw] border-solid border-[#FF33008C] flex items-center justify-center rounded-[.0521vw] cursor-pointer" style="background: radial-gradient(74.18% 50% at 50% 50%, rgba(255, 51, 0, 0.14) 0%, rgba(181, 36, 0, 0.14) 100%);" @click="context.buttons.cancel.action()">
          <p class="text-[.625vw] text-[#FF3300] font-['Poppins-Regular'] line-clamp-1 leading-tight">{{ context.buttons.cancel.label }}</p>
        </div>
        <div class="w-full h-[2.0313vw] border-[.026vw] border-solid flex items-center justify-center rounded-[.0521vw] cursor-pointer" :style="`background: radial-gradient(74.18% 50% at 50% 50%, ${StoreData.GetThemeRGBA(StoreData.GetThemeColor(), 14)} 0%, ${StoreData.GetThemeRGBA(StoreData.GetThemeSecondaryColor(), 14)} 100%);border-color: ${StoreData.GetThemeColor()}8C;`" @click="context.buttons.confirm.action()">
          <p class="text-[.625vw] font-['Poppins-Regular'] line-clamp-1 leading-tight" :style="`color: ${StoreData.GetThemeColor()};`">{{ context.buttons.confirm.label }}</p>
        </div>
      </div>
    </motion.div>
  </AnimatePresence>
</template>