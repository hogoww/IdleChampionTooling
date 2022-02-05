# IdleChampionTooling

Tooling for the Game Idle champions http://www.idlechampions.com

For other tools, consider using those great websites:
- Kleho's website: https://idle.kleho.ru/list/
- ByteGlow: https://ic.byteglow.com/
- Fenomas: https://fenomas.com/idle/

Currently implemented:
-A queriable database of idle champions adventure, areas [...]
- Extractor of redeem codes for idle combo link
- Run planner [work in progress]
  Meant to plan the areas on which you will land and their characteristics.
Allow to prepare your briv runs with other than 4/9 jumps, to allow you to avoid bad areas ! (Range, hit based, armored ....)

To install:
1 - Download the Pharo Launcher https://pharo.org/download.
2 - Install & Open it.
3 - Create a new image (top left, "new")
4 - Use the Pharo 10 template, either for 64 or 32 bit depending on your machine.
5 - copy paste the following script in the "initializing script" text area.
```smalltalk
PharoDarkTheme beCurrent.
IceRepository reset.
World closeAllWindowsDiscardingChanges.

Metacello new
  baseline: 'IdleChampionTooling';
  repository: 'github://hogoww/IdleChampionTooling';
  load.

StPlayground openContents: BaselineOfIdleChampionTooling new initialPlayground```
6 - Create image
7 - Select the created image
8 - Launch 
9 - Wait for the image to be ready, and follow the comments in the window that'll appear :)
