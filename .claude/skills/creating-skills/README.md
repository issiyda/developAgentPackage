# Creating Skills - Claude Code Skill作成支援

このskillは、Claude Codeの新しいskillを作成するための包括的な知識とガイダンスを提供します。

## 概要

`creating-skills` skillを使用することで、エージェントは以下のことができるようになります：

- ✅ Claude Code skillの正しい構造を理解する
- ✅ 効果的なメタデータ（name、description）を定義する
- ✅ ベストプラクティスに従った実装を行う
- ✅ 適切なテストと検証を実施する
- ✅ 実践的な例から学ぶ

## ファイル構成

```
creating-skills/
├── SKILL.md          # メインのskill定義と指示
├── reference.md      # 詳細な技術リファレンス
├── examples.md       # 実践的な使用例とテンプレート
└── README.md         # このファイル
```

## 使い方

### 自動起動

このskillは、以下のようなリクエストで自動的に起動します：

```
"新しいskillを作成したい"
"PDF処理のskillを作りたい"
"skillの作り方を教えて"
"カスタムskillを開発したい"
```

キーワード: skill作成、カスタムskill、スキル開発、creating skills

### 手動での参照

特定の情報が必要な場合は、直接ファイルを参照できます：

```bash
# メインガイドを読む
cat .claude/skills/creating-skills/SKILL.md

# 詳細なリファレンスを確認
cat .claude/skills/creating-skills/reference.md

# 実践例を見る
cat .claude/skills/creating-skills/examples.md
```

## 提供される知識

### 1. 基本概念（SKILL.md）
- Skillとは何か
- ファイル構造の基本
- メタデータ定義の方法
- コア設計原則
- デプロイ前チェックリスト

### 2. 詳細リファレンス（reference.md）
- メタデータの完全仕様
- 命名規則とベストプラクティス
- ファイル構造パターン（4種類）
- 説明文の書き方
- 指示の具体性レベル（3段階）
- スクリプト統合のベストプラクティス
- エラーハンドリング戦略
- テストと評価方法
- 共通パターン集

### 3. 実践例（examples.md）
以下の4つの完全な実装例：
1. シンプルなテキスト処理skill（markdown分析）
2. データ分析skill（CSV処理、スクリプト付き）
3. コード生成skill（API endpoint、テンプレート付き）
4. ドキュメント処理skill（複数形式対応、複雑な例）

## 学べる主要トピック

### メタデータ定義
- `name`: 命名規則（動名詞形推奨）
- `description`: 効果的な説明の書き方
- `allowed-tools`: ツールアクセス制御

### 設計原則
- **簡潔性**: "The context window is a public good"
- **プログレッシブディスクロージャ**: 段階的な情報提供
- **自由度の設定**: タスクに応じた指示の具体性
- **"Solve, don't punt"**: 自己完結型のエラー処理

### ファイル構造パターン
1. シンプルskill（単一ファイル）
2. 標準skill（参照資料付き）
3. 実行可能skill（スクリプト付き）
4. テンプレートskill（テンプレート付き）

### ベストプラクティス
- Unix形式のパス使用（`/`）
- 三人称での記述
- 明示的なエラーハンドリング
- マルチモデルテスト（Haiku/Sonnet/Opus）
- 評価駆動開発

## 使用例

### 例1: 新しいskillのアイデアから始める

```
ユーザー: "GraphQL APIのクエリを生成するskillを作りたい"

エージェント: [creating-skills skillが起動]
1. 要件を整理
2. 適切な構造を提案（テンプレートskillパターン）
3. メタデータを定義
4. 実装指示を記述
5. テストシナリオを作成
```

### 例2: 既存skillの改善

```
ユーザー: "既存のPDF処理skillを改善したい"

エージェント: [creating-skills skillが起動]
1. reference.mdからベストプラクティスを確認
2. デプロイ前チェックリストで現状を評価
3. 改善点を特定
4. 具体的な改善策を提案
```

### 例3: スクリプト統合の学習

```
ユーザー: "Pythonスクリプトを含むskillの作り方を教えて"

エージェント: [creating-skills skillが起動]
1. examples.mdから実践例（CSV分析skill）を参照
2. スクリプト統合のベストプラクティスを説明
3. エラーハンドリングパターンを提示
4. 依存関係の管理方法を説明
```

## チェックリスト

このskillを使って新しいskillを作成する際は、以下を確認してください：

- [ ] 説明は具体的で、キーワードを含む
- [ ] SKILL.md本体が500行以下
- [ ] ファイル参照は1段階深まで
- [ ] 最低3つの評価シナリオを作成
- [ ] Haiku/Sonnet/Opusでテスト
- [ ] エラーハンドリングが明示的
- [ ] 検証/フィードバックループを含む
- [ ] すべてのスクリプトパスがフォワードスラッシュ
- [ ] 必要なパッケージ依存関係を記載

## トラブルシューティング

### Skillが起動しない
- descriptionにキーワードが含まれているか確認
- ユーザーのリクエストとdescriptionの関連性を確認

### 指示が曖昧
- reference.mdの「指示の具体性レベル」を参照
- タスクの性質に応じて適切なレベルを選択

### エラーハンドリングが不十分
- reference.mdの「エラーハンドリング」セクションを参照
- "Solve, don't punt"原則を適用

## 参考リンク

公式ドキュメント:
- [Claude Code Skills公式ドキュメント](https://code.claude.com/docs/ja/skills)
- [Agent Skills Best Practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices)

## バージョン情報

- 作成日: 2025-11-29
- ベース情報: Claude Code公式ドキュメント + Agent Skills Best Practices

## ライセンス

このskillはプロジェクト内で自由に使用・改変できます。
