export interface Characters {
    cid: number;
    citizenid?: string;
    identifier?: string;
    charinfo: {
        firstname: string;
        lastname: string;
        height: number;
        birthdate: string;
        phone: string;
        nationality: string;
        gender: string | number;
    }
    job: {
        name?: string;
        label: string;
        grade: {
            name: string;
        }
    };
    money: {
        bank: number;
        cash: number;
    };
}

export interface Locales {
    [key: string]: string
}

export interface Locations {
    id: number;
    name: string;
    coords: {
        x: number;
        y: number;
        z: number;
    };
    image: string;
}[]

export type Page = 'Creator' | 'Selection' | 'Spawn' | 'Background' | false;

export type CharacterLimit = number;

export interface SubPage {
    [key: string]: boolean
}

export interface Settings {
    streamer_mode: boolean,
    mute_music: boolean,
    focus_player: boolean,
    camera_filter_mode: boolean,
    camera_filter_type: number,
    particle_show: boolean,
    particle_type: number,
    scenario_mode: boolean,
    scenario_type: number,
    weather_mode: boolean,
    weather_type: number,
    time_mode: boolean,
    time_type: number,
    background_mode: boolean,
    color_theme: {
        name: string,
        color: string,
    };
}

export interface RegisterModel {
    firstname: string,
    lastname: string,
    height: number,
    birthday: {
        day: number,
        month: number,
        year: number,
    },
    nationality: string,
    gender: number,
}

export interface Context {
    title: string;
    description: string;
    items: {
        label: string;
        type: string;
        model: string;
    }[];
    buttons: {
        cancel: {
            label: string;
            action: () => void;
        };
        confirm: {
            label: string;
            action: () => void;
        };
    };
}

export interface AnimationData {
    initial: boolean;
    text: string;
}