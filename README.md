## Description
DIY tools for web development

makefiles.sh:
- bash script for BEM nested file structure creation
- creates css files for block and optionally element(s) or modifier(s) in blocks folder
- adds imports for the block and element(s) or modifier(s) to pages/index.css
- has an option to also media queries to new or existing BEM block and specified elements/options
- has an option to add media queries to all existing .css files in a block folder: -a "breakpoint1_value breakpoint2_value" bemBlockName
- Usage: ./makefiles [-s \"425 768 1024\" || -a \"425 768 1024\"] bemBlockName [__bemElementOrModifierName]

node_mongo_tools.sh:
- starts VSCode + postman + MongoDB Compass (has to be installed already on Ubuntu 20.04+)
- shows where you are in the project by running git commands
- Usage: put in home folder, edit path to project and type . ./node_mongo_tools.sh
