# TerraTex-Reloaded

> [!WARNING]  
> This Repository targets MTA:SA - It is currently not maintained anymore as I focus on a bunch of new projects. - The Script was latest 2018 fully functional - I can not garantee that this is still the case as a lot > of the stuff is outdated (e.g. UI Libs)

Refactored TerraTex Script - Pay Attention, this Version is not compatible with the old one.

> [!NOTE]  
> There are still a lot of open issues - as refactoring was never finished. Some of the Features are outdated.

## Requirements

* Server MTA:SA 1.5
* MySQL Database


## Installation

1. Create A Database and import all sql files (update files in correct Order) from Directory "terratex_reallife/SQLS"
2. Edit config_example.lua and rename to config.lua
3. Edit database_config_example.lua and rename to database_config.lua
4. UPDATE ACL.XML of the Server -> Add the TerraTex Script resource to admin

## How to change Styles via scss
For the TerraTex script we work with the source SCSS Files. We also deliver compiled css files but if you want to change some more stuff we would suggest to use scss.
To use it you have to install a sass compiler.
We are using Node-Sass for that you have to install nodeJs & NPM and you can install node-sass with "npm install node-sass -g"
After that you can simply run "node-sass --output-sytle compressed terratex_reallife/UI/styles/css/uncompiled/ -r -o terratex_reallife/UI/styles/css" to compile our scss files

Dieses Material steht unter der Creative-Commons-Lizenz Namensnennung-Nicht kommerziell 4.0 International. Um eine Kopie dieser Lizenz zu sehen, besuchen Sie http://creativecommons.org/licenses/by-nc/4.0/.

<a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/"><img alt="Creative Commons Lizenzvertrag" style="border-width:0" src="https://i.creativecommons.org/l/by-nc/4.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">TerraTex Reallife Script</span> von <a xmlns:cc="http://creativecommons.org/ns#" href="http://terratex.eu" property="cc:attributionName" rel="cc:attributionURL">Colin Weber</a> ist lizenziert unter einer <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/">Creative Commons Namensnennung-Nicht kommerziell 4.0 International Lizenz</a>.

