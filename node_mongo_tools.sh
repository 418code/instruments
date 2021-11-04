#!/bin/bash

gnome-terminal --tab  --working-directory="dev/yandex/express-mesto" -- code .
gnome-terminal --tab -- postman
gnome-terminal --tab -- mongodb-compass
cd dev/yandex/express-mesto && git branch && git status
