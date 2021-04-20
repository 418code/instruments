## Description
DIY tools for web development

makefiles.sh:
- bash script for BEM nested file structure creation
- creates css files for block and optionally element(s) or modifier(s) in blocks folder
- adds imports for the block and element(s) or modifier(s) to pages/index.css
- has an option to also media queries to new or existing BEM block and specified elements/options
- Usage: ./makefiles [-m "425 768 1024"] bemBlockName [__bemElementOrModifierName]
