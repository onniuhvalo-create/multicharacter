import { set } from '@vueuse/core';
import { DefaultData } from "@/store";
import { FetchNUI } from "@/utils";
import { storeToRefs } from "pinia";

import type { Ref } from "vue";
import type { Page, SubPage, AnimationData } from "@/types";

export default function () {
    const StoreData = DefaultData();
    const { locales, page, subpage, animation_data, characters, characters_limit, location_type, locations, location, settings, music, config, backgrounds, disable_delete_character } = storeToRefs(StoreData) as {
        locales: Ref<any>;
        page: Ref<Page>;
        subpage: Ref<SubPage>;
        animation_data: Ref<AnimationData>;
        characters: Ref<any[]>;
        characters_limit: Ref<number>;
        location_type: Ref<string>;
        locations: Ref<any[]>;
        location: Ref<any>;
        settings: Ref<any>;
        music: Ref<HTMLAudioElement | null>;
        config: Ref<any>;
        backgrounds: Ref<any[]>;
        disable_delete_character: Ref<boolean>;
    };

    window.addEventListener("message", async ({ data }) => {
        switch (data.action) {
            case "CHECK_NUI":
                FetchNUI("CHECKED_NUI", {});
                break;
            case "CLOSE_NUI":
                page.value = false;
                subpage.value = {
                    settings: false,
                    warning_page: false,
                    animation_page: false,
                    context: false
                };

                setTimeout(() => {
                    const main = document.getElementById("main");
                    if (main) {
                        main.style.display = "none";
                    }
                }, 350);
                break;
            case "SET_LOCALES":
                locales.value = data.payload.locales;
                break;
            case "ANIMATION_SHOW":
                const main = document.getElementById("main");

                if (main) {
                    main.style.display = "flex";
                };

                subpage.value.animation_page = true;
                animation_data.value = {
                    initial: data.payload.initial,
                    text: data.payload.text
                };
                break;
            case "ANIMATION_UPDATE":
                animation_data.value = {
                    initial: data.payload.initial,
                    text: data.payload.text
                };
                break;
            case "ANIMATION_HIDE":
                subpage.value.animation_page = false;
                animation_data.value = {
                    initial: false,
                    text: ''
                };
                break;
            case "WARNING_MESSAGE_SHOW":
                subpage.value.warning_page = true;
                subpage.value.animation_page = false;
                break;
            case "WARNING_MESSAGE_SKIP":
                FetchNUI('HIDING_WARNING_SCREEN', {});
                break;
            case "CHANGE_PAGE":
                page.value = data.payload.page;
                if (page.value === 'Selection') {
                    FetchNUI("CHANGED_PAGE", {
                        page: 'Selection'
                    });
                } else if (page.value === 'Creator') {
                    FetchNUI("CHANGED_PAGE", {
                        page: 'Creator'
                    });
                }
                break;
            case "CHARACTER_LIST_UPDATE":
                characters.value = data.payload.characters;
                characters_limit.value = data.payload.character_slot;

                if (data.payload.characters.length > 0) {
                    StoreData.ChangeCharacter(0);
                }
                break;
            case "SET_CONFIG":
                config.value = data.payload;
                disable_delete_character.value = data.payload.disable_delete_character;
                break;
            case "SET_BACKGROUNDS":
                backgrounds.value = data.payload.backgrounds;

                if (settings.value.background) {
                    const background = backgrounds.value.find(bg => bg.id === settings.value.background.id);

                    if (!background) {
                        StoreData.ChangeBackground(backgrounds.value[0]);
                    };
                } else {
                    settings.value.background = backgrounds.value[0];
                    localStorage.setItem("settings", JSON.stringify(settings.value));
                }
                break;
            case "CHANGE_SPAWN_SELECTOR":
                location_type.value = data.payload.type;
                break;
            case "SHOW_SPAWN_SELECTOR":
                if (location_type.value === "spawn") {
                    locations.value = [
                        data.payload.last_location,
                        ...data.payload.locations,
                    ];

                    location.value = data.payload.last_location;
                } else {
                    locations.value = data.payload.locations;
                }

                page.value = "Spawn";
                break;
            case "PLAY_SONG":
                music.value = new Audio(`nui://0r-multicharacterv3/web/build/sounds/${data.payload.song}`);
                music.value.loop = true;
                music.value.volume = data.payload.volume;
                
                if (!settings.value.mute_music) {
                    music.value.play().catch((error) => {
                        console.error("Error playing music:", error);
                    });
                };
                break;
            default:
                console.warn(`Unknown action received: ${data.action}`);
                break;
        }
    });
}