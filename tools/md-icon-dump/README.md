# md-icon-dump
This is the tool used to generate the icon spreadsheet data. It consists of two scripts that I wrote:

* A Powershell script to yank all the white PNGs out of a download of the [MD icons](https://github.com/google/material-design-icons/releases).
* A Lua script that takes the JSON output from [TexturePacker](https://www.codeandweb.com/texturepacker) and converts it to something that the Icon component can use.

## Usage

1. Download the latest release of the MD icons from the link above.
2. Extract all the folders in the download to a folder named `md-icons`. Put `grab-images.ps1` in the parent directory.
3. Open Powershell; run `grab-images.ps1`. It will put all the white images into folders in `sorted-md-icons`, sorted by size.
4. Manually remove the `ic_play_circle_filled_white_*pt_2x.png` files from the sorted files, because those are black for some reason.
5. Using TexturePacker, pack all the folders that you want to include (I suggest 18pt, 24pt, 36pt, and 48pt). Set algorithm to basic, max. size to 1024, multi-pack to true, extrude to 4. Data files should follow the form `sheet-{n1}.json`, and texture files should follow the form `sheet-{n1}.png`.
6. Put `parse-spritesheets.lua` in the same folder that you exported the packed spritesheets.
7. Run `parse-spritesheets.lua` from that folder.
8. Copy the contents of the `spritesheet.lua` file from that folder to `src/Components/Icon/Spritesheets.lua`
9. Upload all the spritesheet files
10. Update their references in `src/Components/Icon/init.lua`
11. ???
12. Profit