fx_version "cerulean"
game "gta5"
author "Sezay | 6-services"
description "six-gps"

shared_scripts {
	'@es_extended/imports.lua'
}

server_scripts {
    'config.lua',
    'server/esx.lua',
    'server/qb.lua',
    'server/server.lua',
}

client_scripts {
    'config.lua',
    'client/esx.lua',
    'client/qb.lua',
    'client/client.lua',
}

lua54 'yes' 

escrow_ignore {
	'config.lua',
	'server/*.lua',
	'client/*.lua',
}