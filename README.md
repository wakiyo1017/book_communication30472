# README

## アプリケーション名
- Book Communication

## アプリケーション概要
- 読んだ本の写真や感想の投稿、それに対してのコメントの投稿

## URL

## テスト用アカウント
  

## 利用方法
- 自分が読んだ本の感想や写真を保存しておく、読書感想文の本棚的なものとして。
- その本を読んだ人の感想を見ることができる。

## 目指した課題解決
- 読書が好きな子供と読書が好きでは無い親が、本をきっかけとしてコミュニケーションが取れる要素にしたい。

## 洗い出した要件
https://docs.google.com/spreadsheets/d/1QNqEMtP_gxc4itBlkSxD0Petkh9GIGX_eke-WWHlqD8/edit#gid=282075926
## 実装した機能についての説明
マイページ・マイページでの投稿一覧表示・book詳細ページ・book詳細ページでのコメント投稿機能
## 実装予定の機能

## データベース設計
## booksモデル
| Column     | Type       | Options            |
| ---------- | ---------- | ------------------ |
| title      | string     | null: false        |
| author     | string     | null: false        |
| impression | text       | null: false        |
| user       | references | foreign_key: true  |

### Association
- has_many :comments
- belongs_to :user

## usersテーブル
| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| name     | string | null: false |
| email    | string | null: false |
| password | string | null: false |

### Association
- has_many :books
- has_many :comments

## commentsテーブル
| Column | Type       | Options           |
| ------ | ---------- | ----------------- |
| text   | text       | null: false       |
| user   | references | foreign_key: true |
| book   | references | foreign_key: true |

### Association
- belongs_to :user
- belongs_to :books

## 開発環境

