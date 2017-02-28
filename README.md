# LINE Login Sample

LINE の Web loginのサンプル
https://developers.line.me/web-api/integrating-web-login-v2

# インストール
```
git clone git@github.com:seteen/line-login-sample.git
cd line-login-sample
bundle install --path vendor/bundle
```
環境変数の設定
```
# in line-login-sample
cp .env.sample .env
```
.envにLINE LoginのChannel ID, Channel Secretを登録

# 使い方
```
# in line-login-sample
bundle exec rails s
```

1. 上記を実行
1. `http://localhost:3000/line/login` にアクセス
1. `login` リンクを押下
1. LINEでログイン
1. `app/controllers/line_controller.rb` の `binding.pry` で動作が止まる
1. `app/controllers/line_controller.rb` 内で定義しているメソッドなどを試してみる
