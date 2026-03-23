<script setup lang="ts">
defineProps<{
    image: string;
    title: string;
    description: string;
}>();
</script>

<template>
    <div class="w-[24.537vh] h-[3.7037vh] rounded-[0.0926vh] overflow-hidden relative" :style="`background-image: url(nui://0r-multicharacterv3/web/build/imgs/${image}.png);background-position: center center; background-repeat: no-repeat; background-size: cover;`">
        <div class="flex flex-col items-center justify-center absolute w-full h-full" style="background: radial-gradient(30% 80% at 50% 50%, rgba(6, 6, 6, 0.95) 0%, rgba(6, 6, 6, 0.00) 100%)">
            <p class="text-[1.3889vh] font-['Poppins-SemiBold'] text-[#FFF] leading-none line-clamp-1 relative z-[2]">{{ title }}</p>
            <p class="text-[1.2037vh] font-['Poppins-Medium'] text-[#FFF] leading-none line-clamp-1 relative z-[2]">{{ description }}</p>
        </div>
    </div>
</template>