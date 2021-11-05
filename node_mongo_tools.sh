#!/bin/bash

gnome-terminal --tab -- code ~/dev/yandex/express-mesto
gnome-terminal --tab -- postman
gnome-terminal --tab -- mongodb-compass
cd dev/yandex/express-mesto && git branch && git status
