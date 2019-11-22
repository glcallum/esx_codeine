resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

description 'GLC Drugs'

version '1.0.2'

server_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'server/glc_drugs_sv.lua',
	'config.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/glc_drugs_cl.lua'
}

client_script "av_anticheat.lua"