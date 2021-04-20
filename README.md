## Description
DIY tools for web development

makefiles.sh:
- bash script for BEM nested file structure creation
- creates css files for block and optionally element(s) or modifier(s) in blocks folder
- adds imports for the block and element(s) or modifier(s) to pages/index.css
- has an option to also media queries to new or existing BEM block and specified elements/options
- has an option to add media queries to all existing .css files in a block folder: -a "breakpoint1_value breakpoint2_value" bemBlockName
- Usage: ./makefiles [-s \"425 768 1024\" || -a \"425 768 1024\"] bemBlockName [__bemElementOrModifierName]
