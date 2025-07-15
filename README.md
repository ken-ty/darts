# outshotx

OutshotX は ハードダーツ用のアウトショット管理アプリです。
あなたのダーツ練習をサポートします。

## 開発

### ローカライズ

ローカライズは、`lib/l10n/app_localizations.dart` で行っています。 

```sh
flutter gen-l10n
```


### アプリアイコン（launcher icon）の更新

アイコン画像（assets/appIcon.png）を変更したら、下記コマンド1行で全プラットフォームのアイコンを再生成できます。

```sh
flutter pub get && flutter pub run flutter_launcher_icons:main
```

（dart run flutter_launcher_icons でもOK）

---

## リリース

以下のファイルを配置してください.

- `key.properties` を `android/` に配置
- `kenty-release-key.jks` を `android/app/` に配置
