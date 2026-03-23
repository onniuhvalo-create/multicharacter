fx_version 'cerulean'
game {'gta5'}
lua54 'yes'

author 'Baasha Studio'
description 'Visit Our Discord: https://discord.gg/FZMWRCtCs6 | Website: https://store.baashabhai.com/'

scriptname '0r-multicharacterv3'
version '1.0.6'

shared_scripts {
    '@ox_lib/init.lua',
    'config/*.lua',
    'shared/*.lua',
}

client_scripts {
    'client/*.lua',
    'modules/**/**/client.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'modules/**/**/server.lua',
    'server/*.lua',
}

escrow_ignore {
    'config/*.lua',
    'locales/*.lua',
    'shared/*.lua',
    'modules/**/**/*.lua',
    'client/*.lua',
    'server/*.lua',
}

files {
    'web/build/*.*',
    'web/build/**/*.*',
    'locales/*.json',
}

ui_page 'web/build/index.html'

dependencies {
    'ox_lib',
}
dependency '/assetpacks'