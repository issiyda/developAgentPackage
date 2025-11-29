---
name: creating-skills
description: Claude Codeのskillを作成するための包括的な知識を提供します。skill構造、メタデータ定義、ベストプラクティス、デザインパターン、テスト方法などを含みます。skill作成、カスタムskill、スキル開発に関連するタスクで使用してください。
---

# Claude Code Skill作成ガイド

このskillは、エージェントがClaude Codeの新しいskillを作成するための完全なナレッジを提供します。

## Skillの基本概念

Skillは専門知識を発見可能な機能にパッケージ化したモジュール式の機能です。**重要**: スキルはモデル呼び出しであり、Claudeはリクエストと説明に基づいて自律的にいつスキルを使用するかを決定します。

## ファイル構造

### 必須構造
```
skill-name/
├── SKILL.md（必須・メイン指示）
├── reference.md（オプション・参照資料）
├── examples.md（オプション・使用例）
└── scripts/（オプション・実行可能スクリプト）
```

### 配置場所
- **プロジェクトskill**: `.claude/skills/skill-name/`（チームで共有）
- **個人用skill**: `~/.claude/skills/skill-name/`（個人使用）

## メタデータ定義

SKILL.mdの先頭にYAML frontmatterで定義：

```yaml
---
name: skill-name-format
description: Brief description (max 1024 chars)
allowed-tools: Tool1, Tool2, Tool3
---
```

### 命名規則（name）
- **形式**: 小文字、数字、ハイフンのみ
- **最大**: 64文字
- **推奨**: 動名詞形（verb + -ing）を使用
- **良い例**: `processing-pdfs`, `analyzing-spreadsheets`, `creating-skills`
- **悪い例**: `helper`, `utils`, `do-stuff`

### 説明（description）
- **最大**: 1024文字
- **形式**: 三人称で記述（システムプロンプトに注入されるため）
- **含めるべき内容**:
  1. スキルが何をするか
  2. いつ使用するか
  3. ユーザーが言及する可能性のあるキーワード
- **良い例**: "Extract text and tables from PDF files. Use when processing PDFs, analyzing documents, or extracting data from PDF reports."
- **悪い例**: "Helps with data processing"（曖昧すぎる）

### ツール制限（allowed-tools）
特定のツールのみにアクセスを制限する場合に指定（オプション）

## コア設計原則

### 1. 簡潔性の重要性
**"The context window is a public good"**
- SKILL.mdは500行以下に保つ
- 読み込まれた時点で全トークンが会話履歴と競合
- 不要な説明は避ける

### 2. プログレッシブディスクロージャ
- 詳細情報は別ファイルに分離
- **重要**: 参照は1段階のみ（`reference.md`のような深いネスト参照は避ける）
- 長い参照ファイル（100行以上）には目次を含める

### 3. 自由度の設定
タスクの複雑さに応じて指示の具体性を調整：

- **高度な自由度**（テキスト指示）: 複数のアプローチが有効な場合
- **中程度の自由度**（疑似コード）: 推奨パターンが存在する場合
- **低度の自由度**（具体的スクリプト）: エラーが発生しやすい場合

### 4. "Solve, don't punt"
- スクリプトはエラー処理を明示的に実装
- Claudeに判断を委ねない
- 検証とフィードバックループを含める

## 実装パターン

### テンプレートの提供
- 厳密な要件: 完全なテンプレートを提供
- 柔軟な状況: 調整可能なテンプレートを使用

### 検証プロセス
フィードバックループを含める：
```
1. 実行 → 2. 検証 → 3. エラー修正 → 4. 再実行
```

### スクリプトの扱い

実行可能スクリプトを含める場合：

1. **パッケージ依存関係を明記**:
```bash
# Required packages
pip install pdfplumber pandas
npm install lodash axios
```

2. **実行意図を明確に**:
- 実行: "Run `scripts/analyze_form.py`"
- 参照: "See `scripts/validate.py` for validation logic"

3. **ファイルパスはフォワードスラッシュ使用**:
- 正: `scripts/helper.py`
- 誤: `scripts\helper.py`

## アンチパターン

以下を避けてください：

❌ Windows形式パス（`\`） → Unix形式（`/`）を常に使用
❌ 時間依存情報 → 必要な場合は「Old patterns」セクションに
❌ 過剰なオプション → デフォルトを提供、代替案は明確に
❌ 魔法の定数 → すべての数値を正当化
❌ 曖昧な説明 → 具体的なユースケースとキーワードを含める
❌ 深いネスト参照 → 1段階のみ

## テストと評価

### 評価駆動開発プロセス
1. ギャップを特定
2. 評価を作成（最低3シナリオ）
3. ベースラインを確立
4. 最小限の指示を記述
5. 反復改善

### マルチモデルテスト
- Haiku、Sonnet、Opusすべてでテスト
- Opusで機能する説明がHaikuでは不十分な場合がある

## デプロイ前チェックリスト

新しいskillを作成したら、以下を確認：

- [ ] 説明は具体的で、キーワードを含む
- [ ] SKILL.md本体が500行以下
- [ ] ファイル参照は1段階深まで
- [ ] 最低3つの評価シナリオを作成
- [ ] Haiku/Sonnet/Opusでテスト
- [ ] エラーハンドリングが明示的
- [ ] 検証/フィードバックループを含む
- [ ] すべてのスクリプトパスがフォワードスラッシュ
- [ ] 必要なパッケージ依存関係を記載

## Skill作成の実践例

詳細な実装例とテンプレートについては、`examples.md`を参照してください。

## 使用方法

このskillが読み込まれると、あなたは以下のことができるようになります：
1. 適切なskill構造を設計する
2. 効果的なメタデータを記述する
3. ベストプラクティスに従った実装を行う
4. 適切なテストと検証を実施する

詳細な参照情報については `reference.md` を確認してください。
