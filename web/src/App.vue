<script setup lang="ts">
import nuiEvents from "@/utils/event";
import { onMounted } from 'vue';
import { DefaultData } from '@/store/index'
import { storeToRefs } from 'pinia'

const StoreData = DefaultData();
const { } = storeToRefs(StoreData);

import Warning from '@/pages/warning/index.vue';
import Animation from '@/pages/animation/index.vue';
import Register from '@/pages/register/index.vue';
import Login from '@/pages/login/index.vue';
import Spawn from '@/pages/spawn/index.vue';
import Background from '@/pages/backgroundSelect/index.vue';

import Context from '@/components/context/index.vue';
import Settings from '@/components/settings/index.vue';
import Keybinds from '@/components/keybinds/index.vue';

onMounted(() => {
    StoreData.GetSettings();
    nuiEvents();
});
</script>

<template>
    <div id="main" class="w-screen h-screen relative flex items-center" style="background: radial-gradient(71.74% 50% at 50% 50%, rgba(6, 6, 6, 0.00) 0%, rgba(6, 6, 6, 0.95) 100%);display: none;">
        <Warning />
        <Animation />
        <Login />
        <Register />
        <Spawn />
        <Background />

        <Context />
        <Settings />
        <Keybinds />
    </div>
</template> 