## Description
DIY tools for web development

makefiles.sh:
- bash script for BEM nested file structure creation
- creates css files for block and optionally element(s) or modifier(s) in blocks folder
- adds imports for the block and element(s) or modifier(s) to pages/index.css
- has an option to also add predefined media queries to all new css files inside the BEM block
- if called on an existing block, will add new elements/modifiers without overwriting existing elements
- Usage: ./makefiles bemBlockName [__bemElementOrModifierName] [-m]
