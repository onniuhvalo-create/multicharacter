<script setup lang="ts">
import { AnimatePresence, motion } from 'motion-v';
import { DefaultData } from '@/store/index';
import { storeToRefs } from 'pinia';

import type { Ref } from 'vue';
import type { SubPage, Settings } from '@/types/index';

const StoreData = DefaultData();
const { locales, subpage, settings } = storeToRefs(StoreData) as {
  locales: Ref<any>,
  subpage: Ref<SubPage>,
  settings: Ref<Settings>
};

import Color from './components/color.vue';
import Switch from './components/switch.vue';
import Buttons from './components/buttons.vue';
import Background from './components/background.vue';
</script>

<template>
  <AnimatePresence mode="sync">
    <motion.div :initial="{ x: '200%', opacity: 0 }" :animate="{ x: 0, opacity: 1 }" :exit="{ x: '200%', opacity: 0 }" :transition="{ duration: 0.5 }" v-if="subpage.settings" class="w-max absolute top-1/2 right-[4.1146vw] -translate-y-1/2 flex flex-col items-start justify-center">
      <div class="w-[13.2813vw] h-[2.9688vw] relative flex items-center justify-end p-[.2344vw]">
        <img src="/imgs/lline.png" alt="lines" class="w-full h-full absolute top-0 right-0" />
        <div class="flex items-center gap-x-[.5208vw]">
          <div class="flex flex-col items-end">
            <p class="font-['Poppins-LightItalic'] text-[#FFF] text-[.7292vw] line-clamp-1 leading-none tracking-[.401vw] uppercase">{{ locales.menu }}</p>
              <p class="font-['Poppins-BoldItalic'] text-[#FFF] text-[1.0938vw] line-clamp-1 leading-none uppercase">{{ locales.settings }}</p>
          </div>
          <div class="w-[2.3438vw] h-[2.3438vw] flex items-center justify-center border-[.026vw] border-solid rounded-[.1042vw]" :style="`background: radial-gradient(74.18% 50% at 50% 50%, ${StoreData.GetThemeRGBA(StoreData.GetThemeColor(), 14)} 0%, ${StoreData.GetThemeRGBA(StoreData.GetThemeSecondaryColor(), 14)} 100%);border-color: ${StoreData.GetThemeColor()}8C;`">
            <i class="fa-solid fa-gear text-[1.3542vw]" :style="`color: ${StoreData.GetThemeColor()};`"></i>
          </div>
        </div>
      </div>
      <div class="flex flex-col items-start gap-y-[1.0417vw] mt-[.6771vw]">
        <Switch icon="fa-solid fa-signal-stream" :title="locales.streamer_mode" :description="locales.streamer_mode_desc" setting="streamer_mode" v-model="settings.streamer_mode" />
        <Switch icon="fa-solid fa-music" :title="locales.mute_music" :description="locales.mute_music_desc" setting="mute_music" v-model="settings.mute_music" />
        <Switch icon="fa-solid fa-user" :title="locales.focus_player" :description="locales.focus_player_desc" setting="focus_player" v-model="settings.focus_player" />
        <Switch icon="fa-solid fa-camera" :title="locales.filter_mode" :description="locales.filter_mode_desc" setting="camera_filter_mode" v-model="settings.camera_filter_mode" />
        <Buttons icon="fa-solid fa-images-user" :title="locales.filter_type" :description="`${locales.filter_type_desc}: ${settings.camera_filter_type}`" setting="camera_filter_type" />
        <Switch icon="fa-solid fa-stars" :title="locales.particle_mode" :description="locales.particle_mode_desc" setting="particle_show" v-model="settings.particle_show" />
        <Buttons icon="fa-solid fa-images-user" :title="locales.particle_type" :description="`${locales.particle_type_desc}: ${settings.particle_type}`" setting="particle_type" />
        <Switch icon="fa-solid fa-stars" :title="locales.scenario_mode" :description="locales.scenario_mode_desc" setting="scenario_mode" v-model="settings.scenario_mode" />
        <Buttons icon="fa-solid fa-images-user" :title="locales.scenario_type" :description="`${locales.scenario_type_desc}: ${settings.scenario_type}`" setting="scenario_type" />
        <Switch icon="fa-solid fa-stars" :title="locales.weather_mode" :description="locales.weather_mode_desc" setting="weather_mode" v-model="settings.weather_mode" />
        <Buttons icon="fa-solid fa-images-user" :title="locales.weather_type" :description="`${locales.weather_type_desc}: ${settings.weather_type}`" setting="weather_type" />
        <Switch icon="fa-solid fa-stars" :title="locales.time_mode" :description="locales.time_mode_desc" setting="time_mode" v-model="settings.time_mode" />
        <Buttons icon="fa-solid fa-images-user" :title="locales.time_type" :description="`${locales.time_type_desc}: ${settings.time_type}`" setting="time_type" />
        <Background icon="fa-solid fa-images" :title="locales.background_type" :description="locales.background_type_desc" />
        <Color icon="fa-solid fa-palette" :title="locales.color_type" :description="locales.color_type_desc" />
      </div>
    </motion.div>
  </AnimatePresence>
</template>