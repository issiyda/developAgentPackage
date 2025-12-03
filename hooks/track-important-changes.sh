#!/bin/bash
# プロジェクトの重要な変更を追跡するhook
# tool:Write や tool:Edit のフックとして動作します

# 変更履歴を記録するファイル
CHANGELOG_FILE="CHANGELOG_INTERNAL.md"

# 重要なファイルのパターン(正規表現)
IMPORTANT_PATTERNS=(
  "package\.json"
  "tsconfig\.json"
  "\.claude/.*"
  "CLAUDE\.md"
  "README\.md"
  "\.config\."
  "agents/.*metadata\.json"
  "skills/.*metadata\.json"
  "/src/.*\.ts$"
  "/lib/.*\.ts$"
)

# フックの引数を取得
TOOL_NAME="$1"
FILE_PATH="$2"

# ファイルパスが空の場合は何もしない
if [ -z "$FILE_PATH" ]; then
  exit 0
fi

# 重要なファイルかどうかをチェック
is_important=false
for pattern in "${IMPORTANT_PATTERNS[@]}"; do
  if echo "$FILE_PATH" | grep -qE "$pattern"; then
    is_important=true
    break
  fi
done

# 重要なファイルでない場合は何もしない
if [ "$is_important" = false ]; then
  exit 0
fi

# 変更履歴ファイルが存在しない場合は作成
if [ ! -f "$CHANGELOG_FILE" ]; then
  cat > "$CHANGELOG_FILE" << 'EOF'
# プロジェクト変更履歴（内部用）

このファイルはプロジェクトの重要な変更を自動的に記録します。

---

EOF
fi

# 現在の日時を取得
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# 変更内容を追記
{
  echo ""
  echo "## [$TIMESTAMP] $TOOL_NAME"
  echo ""
  echo "**ファイル:** \`$FILE_PATH\`"
  echo ""
  echo "---"
  echo ""
} >> "$CHANGELOG_FILE"

# 成功メッセージ（オプション）
# echo "✓ 変更を記録しました: $FILE_PATH"

exit 0
