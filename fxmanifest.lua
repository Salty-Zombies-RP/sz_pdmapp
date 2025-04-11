fx_version "cerulean"
game "gta5"

title "LB Phone - Dealership"
description "Dealership App"
author "Sean 'Solao Bajiuik' Stoves"
version "1.0.0"

shared_script {
    'config.lua'
}

client_script {
    "client/main.lua"
}

files {
    "ui/**/*"
}

ui_page "ui/index.html"
