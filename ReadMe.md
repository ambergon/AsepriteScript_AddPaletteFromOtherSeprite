# AsepriteScript_AddPaletteFromOtherSeprite
指定したディレクトリにあるasepriteファイルをリストで表示し、選択したファイルのパレットを追加で読み込むスクリプトです。


## Config
AddPaletteFromOtherSeprite.luaの先頭に変更項目があります。
```
local offset = 0
local ColorPalette_Directory = "D:/OneDrive/ColorPalette"
```


### offset
<br>読み込むカラーパレットのオフセットを指定します。
<br>指定しただけ読み込んだカラーパレットの先頭からスキップします。
<br>1にするとパレットの先頭をスキップできるので、透過色に使用している色を読み込まないようにできます。


### ColorPalette_Directory
asepriteファイルを読み込むディレクトリを指定します。


## Requirements
Aseprite Version : v1.3.12-x64

## Installation
1. スクリプト用のフォルダを開く。
```
File -> Scripts -> Open Scripts Folder
```

2. luaファイルを入れる。
3. 再読み込みする。
```
File -> Scripts -> Rescan Script Folder
```



## Usage
<br>File -> Scripts -> AddPaletteFromOtherSeprite
<br>or 
<br>Register your own shortcuts
<br>Edit -> Keyboard Shortcuts -> AddPaletteFromOtherSeprite


## Author
ambergon
