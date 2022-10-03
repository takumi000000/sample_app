# README

起動方法
```
1, GemfileからRubyとRailsのバージョンをローカル環境のバージョンに合わせる

2, バンドルインストールをする(エラーが起こるなどあった場合は、$ bundle update をしてバンドルインストールする。)
$ bundle install

3, データベースを作成(sqlite3の環境が必要)
$ rails db:create

4, マイグレートする(dbの例といてseedファイルを作成しているので必要なら$ rails db:seed )
$ rails db:migrate

5, Railsを立ち上げてログイン画面が出れば成功。
$ rails s
```

- ユーザー名を入力します。
  既出のユーザー名の場合はログインを、新しいユーザー名の場合は新規作成します。

- 
