#!/bin/bash
# 開発中の問題解決や知見を自動的に蓄積するhook
# UserPromptSubmitフックとして動作し、ユーザーの入力内容を分析します

KNOWLEDGE_FILE="knowledge/develop-project.md"
TEMP_FILE="/tmp/claude-code-knowledge-$$"

# 引数からユーザーのプロンプトを取得
USER_PROMPT="$1"

# ユーザープロンプトが空の場合は何もしない
if [ -z "$USER_PROMPT" ]; then
  exit 0
fi

# 問題解決や修正依頼に関連するキーワードをチェック
is_relevant=false
KEYWORDS=(
  "エラー"
  "バグ"
  "修正"
  "直し"
  "問題"
  "うまくいかない"
  "動かない"
  "失敗"
  "できない"
  "詰まっ"
  "解決"
  "対処"
  "fix"
  "error"
  "bug"
  "issue"
  "problem"
  "broken"
  "doesn't work"
  "not working"
  "failed"
)

for keyword in "${KEYWORDS[@]}"; do
  if echo "$USER_PROMPT" | grep -qi "$keyword"; then
    is_relevant=true
    break
  fi
done

# 関連するキーワードがない場合は何もしない
if [ "$is_relevant" = false ]; then
  exit 0
fi

# knowledgeディレクトリが存在しない場合は作成
mkdir -p knowledge

# ナレッジファイルが存在しない場合は作成
if [ ! -f "$KNOWLEDGE_FILE" ]; then
  cat > "$KNOWLEDGE_FILE" << 'EOF'
# 開発プロジェクト知識ベース

このファイルは開発中に遭遇した問題と解決策を自動的に記録します。

## 目的
- 実装で詰まった時の解決策を蓄積
- 同じ問題の再発を防ぐ
- チーム内での知見共有

---

EOF
fi

# 現在の日時を取得
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# プロンプトを一時ファイルに保存（LLMでの分析用）
echo "$USER_PROMPT" > "$TEMP_FILE"

# ナレッジエントリーのテンプレートを追記
{
  echo ""
  echo "## [$TIMESTAMP] 開発タスク記録"
  echo ""
  echo "### ユーザーリクエスト"
  echo "\`\`\`"
  echo "$USER_PROMPT"
  echo "\`\`\`"
  echo ""
  echo "### 状況"
  echo "<!-- このセクションは後で手動で埋めるか、Claude Codeが自動的に補完します -->"
  echo ""
  echo "### 解決策"
  echo "<!-- 問題の解決方法、実装の詳細、学んだことなど -->"
  echo ""
  echo "### 参考リンク"
  echo "<!-- 関連するドキュメント、Stack Overflow、GitHubイシューなど -->"
  echo ""
  echo "---"
  echo ""
} >> "$KNOWLEDGE_FILE"

# 一時ファイルを削除
rm -f "$TEMP_FILE"

exit 0
