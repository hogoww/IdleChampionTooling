# IdleChampionTooling

Tooling for the Game Idle champions http://www.idlechampions.com

## Other great tools
Other tools are available at the following links:
- Kleho's website: https://idle.kleho.ru/list/
- ByteGlow: https://ic.byteglow.com/
- Fenomas: https://fenomas.com/idle/

## Current features
- A queriable database of idle champions adventure, areas [...] (Characters unsupported yet)
- Extractor of redeem codes for idle combo link
- Run planner [work in progress]
  Meant to plan the areas on which you will land and their characteristics.
Allow to prepare your briv runs with other than 4/9 jumps, to allow you to avoid bad areas ! (Range, hit based, armored ....)

## Server Call features
**Use at your own risks*
I do not know the stance of CNE on such tools, I don't know whether what I do is authorized.
However, I still need such tool for myself, I do not enjoy opening thousands of chests every days.

- Analyse user datas [work in progress]
  - Chests
  - Inventory state
- Ability to redeem chests
- Ability to open chests of line (Do not do this while Idle Champion is running)
- Ability to analyse the opened chests results [Work in progress]

## How to Install
1  Download the Pharo Launcher https://pharo.org/download.  
2 - Install & Open it.  
3 - Create a new image (top left, "new").  
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

StPlayground openContents: BaselineOfIdleChampionTooling new initialPlayground
```

6 - Create image  
7 - Select the created image  
8 - Launch  
9 - Wait for the image to be ready, and follow the comments in the window that'll appear :) 



The work on server calls is heavily inspired and adapted from Idle combo: https://github.com/dhusemann/idlecombos/
