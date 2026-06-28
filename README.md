# Furima（フリマアプリ）

テックキャンプ最終課題として制作した、フリーマーケットサイトのクローンアプリケーションです。

## デモ

https://furima-39372.onrender.com

※ Render の無料プランのため、初回アクセス時や一定時間アクセスがない場合、表示まで時間がかかることがあります。

### Basic認証

| 項目 | 値 |
|------|-----|
| ID | admin |
| Pass | 2222 |

## 使用技術

| カテゴリ | 技術 |
|----------|------|
| 言語 | Ruby 3.1.4 |
| フレームワーク | Ruby on Rails 6.1 |
| DB（ローカル） | MySQL |
| DB（本番） | PostgreSQL（Neon） |
| フロント | JavaScript / Webpacker |
| ホスティング | Render |
| 画像ストレージ | Active Storage / AWS S3 |
| 認証 | Devise |
| 決済 | PayJP |
| テスト | RSpec |

## 機能一覧

### ユーザー機能

- **新規登録** — ニックネーム、氏名（漢字・カナ）、生年月日、メールアドレス、パスワードでアカウント作成
- **ログイン / ログアウト** — Devise による認証
- **プロフィール表示** — ユーザーが出品した商品一覧を確認
- **プロフィール編集** — ニックネーム・メールアドレスの変更（本人のみ）

### 商品機能

- **商品一覧** — トップページに全商品を新着順で表示
- **商品詳細** — 画像、価格、送料、商品説明、カテゴリ・商品状態・発送元・発送日数を表示
- **商品出品** — 画像・商品名・説明・カテゴリ・状態・送料・発送元・発送日数・価格を入力して出品
- **出品時の利益計算** — 価格入力時に販売手数料（10%）と販売利益を JavaScript でリアルタイム表示
- **商品編集 / 削除** — 出品者本人のみ可能（売り切れ前のみ）
- **Sold Out 表示** — 購入済み商品に「Sold Out!!」を表示

### 購入機能

- **購入画面** — 配送先情報（郵便番号、都道府県、市区町村、番地、建物名、電話番号）を入力
- **クレジットカード決済** — PayJP による決済処理
- **購入制限** — 出品者本人および売り切れ商品は購入不可

## オリジナル実装

テックキャンプの要件以外に、以下の改善を行いました。

- **画像プレビュー機能** — 商品出品時に JavaScript でアップロード画像をプレビュー表示
- **日本語化** — `rails-i18n` を用いてエラーメッセージ等を日本語対応

## テスト用アカウント

### 出品者

| 項目 | 値 |
|------|-----|
| メールアドレス | shuppin@a.jp |
| パスワード | shuppin1 |

### 購入者

| 項目 | 値 |
|------|-----|
| メールアドレス | kounyuu@a.jp |
| パスワード | kounyuu1 |

### 購入用カード情報（PayJP テストカード）

| 項目 | 値 |
|------|-----|
| 番号 | 4242424242424242 |
| 期限 | 12/23 |
| セキュリティコード | 123 |

## 環境変数

### ローカル開発

`~/.zshrc` に以下の環境変数を設定しています。

```bash
# Basic認証
export BASIC_AUTH_USER=admin
export BASIC_AUTH_PASSWORD=2222

# PayJP（決済）
export PAYJP_PUBLIC_KEY=pk_test_xxxxxxxx
export PAYJP_SECRET_KEY=sk_test_xxxxxxxx

# AWS S3（画像アップロード）
export AWS_ACCESS_KEY_ID=xxxxxxxx
export AWS_SECRET_ACCESS_KEY=xxxxxxxx
```

設定後、反映するためにターミナルを再起動するか、以下を実行してください。

```bash
source ~/.zshrc
```

| 変数名 | 用途 |
|--------|------|
| `BASIC_AUTH_USER` / `BASIC_AUTH_PASSWORD` | アプリ全体の Basic 認証 |
| `PAYJP_PUBLIC_KEY` / `PAYJP_SECRET_KEY` | クレジットカード決済（PayJP ダッシュボードから取得） |
| `AWS_ACCESS_KEY_ID` / `AWS_SECRET_ACCESS_KEY` | 商品画像の S3 アップロード |

### 本番（Render）

Render の Environment に以下を設定します。

| 変数名 | 用途 |
|--------|------|
| `RAILS_ENV` | `production` |
| `RAILS_MASTER_KEY` | `config/master.key` の内容 |
| `RAILS_SERVE_STATIC_FILES` | `true` |
| `DATABASE_URL` | Neon の PostgreSQL 接続 URL |
| `BASIC_AUTH_USER` / `BASIC_AUTH_PASSWORD` | Basic 認証 |
| `PAYJP_PUBLIC_KEY` / `PAYJP_SECRET_KEY` | 決済 |
| `AWS_ACCESS_KEY_ID` / `AWS_SECRET_ACCESS_KEY` | 画像アップロード（S3） |

## ローカル環境での起動

```bash
# Ruby バージョン（rbenv 使用時）
rbenv install -s 3.1.4
rbenv local 3.1.4

# 依存関係のインストール
bundle install
yarn install

# DB作成・マイグレーション（MySQL）
rails db:create db:schema:load

# サーバー起動
rails s
```

http://localhost:3000 にアクセスしてください。Basic 認証は `~/.zshrc` に設定した ID / Pass を入力します。

## 本番デプロイ（Render + Neon）

```
GitHub → Render（Web サービス）
              ├─ DATABASE_URL → Neon（PostgreSQL）
              └─ AWS キー     → S3（商品画像）
```

| 項目 | 設定値 |
|------|--------|
| Node.js | 20.19.0（`.node-version` で指定） |
| Build Command | `./bin/render-build.sh` |
| Start Command | `bundle exec puma -C config/puma.rb` |

`bin/render-build.sh` 実行時に `db:migrate` が走り、Neon 上にテーブルが作成されます。コード変更後は GitHub へ push すると Render が自動デプロイします（Auto-Deploy が ON の場合）。

**補足**

- ローカルは MySQL、本番は PostgreSQL という構成です
- Render の無料 PostgreSQL は 30 日で失効するため、本番 DB には Neon を使用しています
- Render は Ruby 3.1 以上が必要なため、Ruby 3.1.4 / Rails 6.1 に更新済みです

## DB設計

### users テーブル

| Column              | Type   | Options                  |
| ------------------  | ------ | ------------------------ |
| nickname            | string | null: false              |
| email               | string | null: false,unique: true |
| encrypted_password  | string | null: false              |
| last_name           | string | null: false              |
| first_name          | string | null: false              |
| last_name_katakana  | string | null: false              |
| first_name_katakana | string | null: false              |
| birthday            | date   | null: false              |

#### Association

- has_many :items
- has_many :orders

### items テーブル

| Column        | Type       | Options                        |
| ------------- |----------- | ------------------------------ |
| name          | string     | null: false                    |
| price         | integer    | null: false                    |
| content       | text       | null: false                    |
| category_id   | integer    | null: false                    |
| condition_id  | integer    | null: false                    |
| fee_id        | integer    | null: false                    |
| prefecture_id | integer    | null: false                    |
| ship_day_id   | integer    | null: false                    |
| user          | references | null: false, foreign_key: true |

#### Association

- belong_to :user
- has_one :order
- belongs_to_active_hash :category
- belongs_to_active_hash :condition
- belongs_to_active_hash :fee
- belongs_to_active_hash :ship_days

### orders テーブル

| Column  | Type       | Options                         |
| ------- |----------- | ------------------------------- |
| item    | references | null: false  foreign_key: true  |
| user    | references | null: false, foreign_key: true  |

#### Association

- has_one :address
- belongs_to :user
- belongs_to :item

### addresses テーブル

| Column        | Type       | Options                        |
|-------------- | ---------- | ------------------------------ |
| postal_code   | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| street        | string     | null: false                    |
| house_number  | string     | null: false                    |
| building_name | string     |                                |
| phone_number  | string     | null: false                    |
| order         | references | null: false, foreign_key: true |

#### Association

- belongs_to :order
- belongs_to_active_hash :prefecture
