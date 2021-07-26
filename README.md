# Example-VCI

[VirtualCast](https://virtualcast.jp/)の[VCI](https://virtualcast.jp/wiki/vci/top)を作成するチュートリアルプロジェクト.

詳細は下記参照:
- [【VCI入門】初めてのVCI作成チュートリアル](https://zenn.dev/koduki/articles/7fe5f37ec17071)
- [【VCI入門】Luaスクリプトを使ってスライドを作ってみる](https://zenn.dev/koduki/articles/2ec924d1f22a03)


## デバッグ

VCIスクリプトをリアルタイムで変更するには`EmbeddedScriptWorkspace`に`main.lua`を置けばよい。ただし、それだとバージョン管理が困難なのでAssets配下にスクリプトフォルダを作成し、そのファイルとハードリンクを作ることで対応。

cmdを管理者権限で`mklink /h`を使って以下のようにハードリンクを作成する。

```bash
mklink /h "C:\Users\koduki\AppData\LocalLow\infiniteloop Co,Ltd\VirtualCast\EmbeddedScriptWorkspace\LazerPointer\main.lua"  "C:\Users\koduki\git\example-vci\Assets\MyAssets\Scripts\LazerPointer\main.lua"
C:\Users\koduki\AppData\LocalLow\infiniteloop Co,Ltd\VirtualCast\EmbeddedScriptWorkspace\LazerPointer\main.lua <<===>> C:\Users\koduki\git\example-vci\Assets\MyAssets\Scripts\LazerPointer\main.lua のハードリンクが作成されました
```