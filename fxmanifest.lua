fx_version 'bodacious'
games { 'gta5' }
version '1.0'

client_scripts {
    '@vrp/lib/utils.lua',
	'config.lua',
    'client/*.lua',
}

server_scripts {
    '@vrp/lib/utils.lua',
    'config.lua',
    'server/*.lua',
}

ui_page {
    'nui/index.html',
}
files {
    'nui/index.html',
    'nui/assets/*.css',
    'nui/assets/*.js',
    'nui/assets/images/*.png',
}
