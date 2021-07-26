# スライドボードVCI

[VirtualCast](https://virtualcast.jp/)でスライを作るための[VCI](https://virtualcast.jp/wiki/vci/top).

このプロジェクトには以下の２つのVCIが含まれます。
- スライドボード
- レーザポインター

## 実装参考

以下のチュートリアルをベースに作成しています。

- [【VCI入門】初めてのVCI作成チュートリアル](https://zenn.dev/koduki/articles/7fe5f37ec17071)
- [【VCI入門】Luaスクリプトを使ってスライドを作ってみる](https://zenn.dev/koduki/articles/2ec924d1f22a03)


## デバッグ

VCIスクリプトをリアルタイムで変更するには`EmbeddedScriptWorkspace`に`main.lua`置くことでVCIを再アップロードしなくても直接スクリプトを変更できる。ただし、それだとバージョン管理が困難なのでAssets配下にスクリプトフォルダを作成し、そのファイルとハードリンクを作成する。

cmdを管理者権限起動し`mklink /h`を使って以下のようにハードリンクを作成する。

```bash
mklink /h "%UserProfile%\AppData\LocalLow\infiniteloop Co,Ltd\VirtualCast\EmbeddedScriptWorkspace\スライドボード\main.lua"  "%userprofile%\git\vci-slideboard\Assets\MyAssets\Scripts\slide.lua"
mklink /h "%UserProfile%\AppData\LocalLow\infiniteloop Co,Ltd\VirtualCast\EmbeddedScriptWorkspace\LazerPointer\main.lua"  "%userprofile%\git\vci-slideboard\Assets\MyAssets\Scripts\lazer_pointer.lua"
```
