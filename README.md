# 株式会社ゆめみ iOS 未経験者エンジニア向けコードチェック課題（https://yumemi-ios-junior-engineer-codecheck.app.swift.cloud）

### 注意：このREADMEは課題完了後に書いています、また反省も兼ねてネガティブな意見が含まれるかもしれません。

名前：都道府県占いアプリ

結果：与えられた基本的な機能は実装できた

内容：

まず基本的な内容として、APIを使った機能はできている。
それに加えて、Realmを使った履歴保存機能を追加した。
あとは時間がなかったため、占い結果の表示の際のアニメーションの追加で全てです。

## ファイルごとの役割
### Realm:
このファイルは名前の通りRealm関連で統一しようと思っていました、中身はRealmデータベースで使用するためのモデルクラスが含まれています。
### Desigh:
このファイルはよくわかりません、最初は設計としてRouterを入れましたが、なぜか途中からデザインの要素が強くなり非同期画像表示や色のファイルが含まれました、色はともかく非同期画像は移動するべきだと思います。
### API:
ここはAPI関連のファイルです。
### Logic:
ここが基本的なロジックが全て詰まっているファイルです。ここのファイルがViewとAPIとLogicを繋げる役割を果たしています。
データクラスや単純なvalidationも含まれていますが、この中のRealm Logicが悩まされました。このファイルをLogicファオルに入れるかRealmファイルに入れるかで悩みましたが、
保存や取得という動作的な役割なのでLogicに入れましたが、やっぱりRealmに入れた方が綺麗なのかもしれません。
### Views:
ここはViewのファイルですが、InputViewがなかなか冗長になってしまったなと反省しています。
