import { set } from '@vueuse/core';
import { defineStore } from 'pinia';
import { Characters } from './../types/index';
import { FetchNUI } from "@/utils";

import type { Page } from "@/types";

export const DefaultData = defineStore("DefaultData", {
    state: () => ({
        locales: {} as { [key: string]: string },
        page: false as Page | false,
        subpage: {
            settings: false,
            warning_page: false,
            animation_page: false,
            context: false
        } as Record<string, boolean>,
        cid: 1,
        characters_limit: 5,
        characters: [
            {
                cid: 0,
                citizenid: '',
                identifier: '',
                charinfo: {
                    firstname: '',
                    lastname: '',
                    height: 0,
                    birthdate: '',
                    phone: '',
                    nationality: '',
                    gender: 0
                },
                job: {
                    name: '',
                    label: '',
                    grade: {
                        name: ''
                    }
                },
                money: {
                    bank: 0,
                    cash: 0
                }
            }
        ],
        character: {
            cid: 0,
            citizenid: '',
            identifier: '',
            charinfo: {
                firstname: '',
                lastname: '',
                height: 0,
                birthdate: '',
                phone: '',
                nationality: '',
                gender: 0
            },
            job: {
                name: '',
                label: '',
                grade: {
                    name: ''
                }
            },
            money: {
                bank: 0,
                cash: 0
            }
        },
        location_type: "locations",
        locations: [],
        location: {},
        backgrounds: [],
        settings: {
            streamer_mode: false,
            mute_music: false,
            focus_player: false,
            camera_filter_mode: false,
            camera_filter_type: 1,
            particle_show: false,
            particle_type: 1,
            scenario_mode: false,
            scenario_type: 1,
            weather_mode: false,
            weather_type: 1,
            time_mode: false,
            time_type: 12,
            background_mode: false,
            color_theme: {
                name: "default",
                color: "#00FFEA"
            },
            background: {}
        },
        context: {},
        animation_data: {
            initial: false,
            text: 'Loading Game'
        },
        register_model: {
            firstname: "",
            lastname: "",
            height: 150,
            birthday: {
                day: 1,
                month: 1,
                year: 1990
            },
            nationality: "",
            gender: 0,
        },
        music: null,
        colors: [
            {
                name: "default",
                color: "#00FFEA",
                secondary: "#00998c"
            },
            {
                name: "blue",
                color: "#007bff",
                secondary: "#0056b3"
            },
            {
                name: "red",
                color: "#dc3545",
                secondary: "#b02a37"
            },
            {
                name: "green",
                color: "#28a745",
                secondary: "#1e7e34"
            },
            {
                name: "yellow",
                color: "#ffc107",
                secondary: "#cc9a06"
            },
            {
                name: "purple",
                color: "#6f42c1",
                secondary: "#5a32a3"
            },
            {
                name: "orange",
                color: "#fd7e14",
                secondary: "#c76b0d"
            },
            {
                name: "white",
                color: "#ffffff",
                secondary: "#dcdcdc"
            },
        ],
        config: {},
        transaction_id: '',
        disable_delete_character: false,
    }),
    actions: {
        ChangePage(page: Page | false) {
            this.page = page;
            this.subpage = {
                settings: false,
                warning_page: false,
                animation_page: false,
                context: false
            };

            if (page === 'Selection') {
                FetchNUI("CHANGED_PAGE", {
                    page: 'Selection'
                });
            } else if (page === 'Creator') {
                FetchNUI("CHANGED_PAGE", {
                    page: 'Creator'
                });
            }
        },
        ChangeCharacter(index: number) {
            this.character = this.characters[index];
            this.cid = (this.character as Characters).cid;

            FetchNUI("CHANGE_CHARACTER", {
                characterData: this.character as Characters,
            });
        },
        ChangeSubpage(subpage: string) {
            if (this.subpage[subpage] !== undefined) {
                this.subpage[subpage] = !this.subpage[subpage];
            } else {
                console.warn(`Subpage ${subpage} does not exist.`);
            }
        },
        GetCharacterIndex() {
            return this.characters.findIndex((character: Characters) => character.cid === this.cid);
        },
        GetGender(type: string | number): any {
            if (typeof type === "string") {
                return this.locales[type === 'm' ? 'man' : 'woman'] || type;
            } else if (typeof type === "number") {
                return this.locales[type === 0  ? 'man' : 'woman'] || type.toString();
            }
        },
        IsFormValid() {
            const form = this.register_model;
            return form.firstname.trim() !== '' && form.lastname.trim() !== '' && form.height > 0 && form.birthday.day > 0 && form.birthday.month > 0 && form.birthday.year > 0 && form.nationality.trim() !== ''
        },
        RegisterContext(action: string) {
            if (action === 'code') {
                this.context = {
                    title: this.locales.open_new_slots,
                    description: this.locales.open_new_slots_desc,
                    items: [
                        {
                            label: this.locales.enter_code,
                            type: "text",
                            model: "transaction_id"
                        },
                    ],
                    buttons: {
                        cancel: {
                            label: this.locales.open_new_slots_cancel,
                            action: () => {
                                this.subpage.context = false;
                            }
                        },
                        confirm: {
                            label: this.locales.open_new_slots_confirm,
                            action: async () => {
                                if (!this.transaction_id || this.transaction_id === '') {
                                    return;
                                }

                                const response = await FetchNUI("CHECK_TEBEX_CODE", {
                                    code: this.transaction_id
                                });

                                if (response.status == 'success') {
                                    this.subpage.context = false;
                                    this.characters_limit = response.slot;
                                } else {
                                    return
                                }
                            }
                        }
                    }
                };
                this.subpage.context = true;
            } else if (action === 'delete') {
                const characterIndex = this.GetCharacterIndex();

                if (characterIndex === -1) {
                    console.warn("Character not found.");
                    return;
                };

                this.context = {
                    title: this.locales.delete_character,
                    description: this.locales.delete_desc,
                    buttons: {
                        cancel: {
                            label: this.locales.delete_cancel,
                            action: () => {
                                this.subpage.context = false;
                            }
                        },
                        confirm: {
                            label: this.locales.delete_confirm,
                            action: () => {
                                this.DeleteCharacter();
                                this.subpage.context = false;
                            }
                        }
                    }
                };
                this.subpage.context = true;
            } else {
                console.warn(`Context action ${action} is not defined.`);
            }
        },
        PlayCharacter() {
            const characterIndex = this.GetCharacterIndex();
            if (characterIndex === -1) {
                console.warn("Character not found.");
                return;
            };

            this.subpage = {
                settings: false,
                warning_page: false,
                animation_page: false,
                context: false
            };

            const charater = this.character as Characters;

            FetchNUI("PLAY_CHARACTER", {
                characterData: charater,
            });

            this.page = false;

            this.animation_data = {
                initial: true,
                text: this.locales.loading_character
            };

            this.subpage.animation_page = true;
            (this.music as any).pause();
        },
        CreateCharacter() {
            if (!this.IsFormValid()) {
                return;
            }

            this.subpage = {
                settings: false,
                warning_page: false,
                animation_page: false,
                context: false
            };

            const formatedForm = {
                ...this.register_model,
                cid: this.characters.length + 1,
            };

            this.page = false;

            this.animation_data = {
                initial: true,
                text: this.locales.creating_character
            };

            this.subpage.animation_page = true;

            setTimeout(() => {
                FetchNUI("CREATE_CHARACTER", formatedForm);
            }, 500);
            (this.music as any).pause();
        },
        SpawnLocation() {
            if (this.location_type == "apartment") {
                FetchNUI("SPAWN_APARTMENT", {
                    apartmentType: (this.location as any).id,
                });
            } else {
                FetchNUI("SPAWN_LOCATION", {});
            }
        },
        SelectSpawnLocation(location: any) {
            // if (location.id == (this.location as any).id) {
            //     if (this.location_type == "apartment") {
            //         FetchNUI("SPAWN_APARTMENT", {
            //             apartmentType: location.id,
            //         });
            //     } else {
            //         FetchNUI("SPAWN_LOCATION", {});
            //     }
            // } else {
                this.location = location;
                if (this.location_type == "apartment") {
                    FetchNUI("UPDATE_APARTMENT", {
                        x: location.coords.x,
                        y: location.coords.y,
                        z: location.coords.z,
                        w: location.coords.w
                    });
                } else {
                    FetchNUI("UPDATE_SPAWN", {
                        x: location.coords.x,
                        y: location.coords.y,
                        z: location.coords.z,
                        w: location.coords.w
                    });
                }
            // }
        },
        GetSettings() {
            const settings = localStorage.getItem("settings");

            if (settings) {
                this.settings = JSON.parse(settings);
            } else {
                localStorage.setItem("settings", JSON.stringify(this.settings));
            }

            FetchNUI("GET_SETTINGS", this.settings);
        },
        SetSettings(setting: string, model: boolean) {
            if ((this.settings as any)[setting] !== undefined) {
                (this.settings as any)[setting] = model;

                localStorage.setItem("settings", JSON.stringify(this.settings));

                FetchNUI("SETTINGS_UPDATE", {
                    setting: setting,
                    value: model
                });

                if (setting === "mute_music") {
                    if (model) {
                        (this.music as any).pause();
                    } else {
                        (this.music as any).play();
                    };
                }
            } else {
                console.warn(`Setting ${setting} does not exist.`);
            };
        },
        DecreaseSetting(setting: string) {
            if ((this.settings as any)[setting] !== undefined) {
                if (typeof (this.settings as any)[setting] === 'number') {
                    const currentValue = (this.settings as any)[setting];

                    if (currentValue != 1) {
                        if (currentValue > 1) {
                            (this.settings as any)[setting] = currentValue - 1;
                        } else {
                            (this.settings as any)[setting] = 1;
                        };

                        FetchNUI("SETTINGS_UPDATE", {
                            setting: setting,
                            value: (this.settings as any)[setting]
                        });

                        localStorage.setItem("settings", JSON.stringify(this.settings));
                    }
                } else {
                    console.warn(`Setting ${setting} is not a number.`);
                }
            } else {
                console.warn(`Setting ${setting} does not exist!`);
            }
        },
        IncreaseSetting(setting: string) {
            if ((this.settings as any)[setting] !== undefined) {
                if (typeof (this.settings as any)[setting] === 'number') {
                    const currentValue = (this.settings as any)[setting];
                    const maxValue = (this.config as any)[setting];

                    if (currentValue != maxValue) {
                        if (currentValue < maxValue) {
                            (this.settings as any)[setting] = currentValue + 1;
                        } else {
                            (this.settings as any)[setting] = maxValue;
                        };

                        FetchNUI("SETTINGS_UPDATE", {
                            setting: setting,
                            value: (this.settings as any)[setting]
                        });

                        localStorage.setItem("settings", JSON.stringify(this.settings));
                    };
                } else {
                    console.warn(`Setting ${setting} is not a number.`);
                }
            } else {
                console.warn(`Setting ${setting} does not exist!`);
            }
        },
        SetThemeColor() {
            const currentIndex = this.colors.findIndex(c => c.name === this.settings.color_theme.name);

            if (currentIndex !== -1) {
                if (currentIndex >= this.colors.length - 1) {
                    this.settings.color_theme = this.colors[0];
                } else {
                    this.settings.color_theme = this.colors[currentIndex + 1];
                };

                localStorage.setItem("settings", JSON.stringify(this.settings));
            } else {
                console.warn(`Color theme ${this.settings.color_theme.name} does not exist.`);
                this.settings.color_theme = this.colors[0];
            }
        },
        GetThemeColor() {
            const colorTheme = this.settings.color_theme;

            if (this.colors.find(c => c.name === colorTheme.name)) {
                return this.colors.find(c => c.name === colorTheme.name)?.color || "#00FFEA";
            } else {
                console.warn(`Color theme ${colorTheme.name} does not exist.`);
                return "#00FFEA";
            }
        },
        GetThemeSecondaryColor() {
            const colorTheme = this.settings.color_theme;

            if (this.colors.find(c => c.name === colorTheme.name)) {
                return this.colors.find(c => c.name === colorTheme.name)?.secondary || "#00998c";
            } else {
                console.warn(`Color theme ${colorTheme.name} does not exist.`);
                return "#00998c";
            }
        },
        GetThemeRGBA(color: string, opacity: number) {
            const newColor = color.replace('#', '');
            let r = parseInt(newColor.substring(0, 2), 16);
            let g = parseInt(newColor.substring(2, 4), 16);
            let b = parseInt(newColor.substring(4, 6), 16);
            let result = 'rgba(' + r + ',' + g + ',' + b + ',' + opacity / 100 + ')';
            return result
        },
        DeleteCharacter() {
            const characterIndex = this.GetCharacterIndex();
            if (characterIndex === -1) {
                console.warn("Character not found.");
                return;
            }

            const charater = this.character as Characters;

            FetchNUI("DELETE_CHARACTER", {
                citizenid: charater.citizenid,
            });

            if (this.characters.length <= 1) {
                this.ChangePage('Creator');
                this.characters.splice(characterIndex, 1);
                (this.character as Characters) = {
                    cid: 0,
                    citizenid: '',
                    identifier: '',
                    charinfo: {
                        firstname: '',
                        lastname: '',
                        height: 0,
                        birthdate: '',
                        phone: '',
                        nationality: '',
                        gender: 0
                    },
                    job: {
                        name: '',
                        label: '',
                        grade: {
                            name: ''
                        }
                    },
                    money: {
                        bank: 0,
                        cash: 0
                    }
                };
                this.cid = (this.character as Characters).cid;
                FetchNUI("CHANGE_CHARACTER", {
                    characterData: 'no-data',
                });
            } else {
                this.characters.splice(characterIndex, 1);
                this.character = this.characters[characterIndex === 0 ? 0 : characterIndex - 1];
                this.cid = (this.character as Characters).cid;
                FetchNUI("CHANGE_CHARACTER", {
                    characterData: this.character as Characters,
                });
            }
        },
        ChangeBackground(location: any) {
            this.settings.background = location;
            localStorage.setItem("settings", JSON.stringify(this.settings));

            FetchNUI("CHANGE_BACKGROUND", {
                background: location,
            });
        }
    }
});