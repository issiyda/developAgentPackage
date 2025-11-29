# Claude Code Skill作成 - 詳細リファレンス

## 目次
1. [メタデータ仕様](#メタデータ仕様)
2. [ファイル構造パターン](#ファイル構造パターン)
3. [説明文の書き方](#説明文の書き方)
4. [指示の具体性レベル](#指示の具体性レベル)
5. [スクリプト統合](#スクリプト統合)
6. [エラーハンドリング](#エラーハンドリング)
7. [テスト戦略](#テスト戦略)
8. [共通パターン集](#共通パターン集)

## メタデータ仕様

### name フィールド
技術仕様:
- 正規表現: `^[a-z0-9-]+$`
- 最小長: 1文字
- 最大長: 64文字
- 推奨: 3-30文字

命名のベストプラクティス:
```yaml
# 推奨: 動名詞形（-ing形）
processing-pdfs          # ✓ 明確で具体的
analyzing-spreadsheets   # ✓ アクションが明確
creating-reports         # ✓ 目的が明確

# 非推奨: 曖昧または汎用的
helper                   # ✗ 何をヘルプするか不明
utils                    # ✗ ユーティリティの種類が不明
data-processor           # △ 処理内容が不明確
```

### description フィールド
構成要素:
1. **機能説明** (What): スキルが実行する具体的なアクション
2. **使用タイミング** (When): どのような状況で使用するか
3. **キーワード** (Keywords): ユーザーが言及する可能性のある用語

テンプレート:
```
[動詞] [対象] from [ソース]. Use when [状況], [状況], or [状況].
```

実例:
```yaml
# 良い例
description: "Extract text, tables, and images from PDF files. Use when processing PDFs, analyzing documents, extracting data from reports, or converting PDF content to structured formats."

# 改善が必要な例
description: "Helps with PDFs"  # ✗ 曖昧、キーワード不足

# 改善版
description: "Parse and extract structured data from PDF forms and documents. Use when processing PDF forms, extracting invoice data, analyzing medical records, or converting PDF tables to CSV."
```

### allowed-tools フィールド
ツールアクセス制御:
```yaml
# すべてのツールへのアクセス（デフォルト）
allowed-tools: "*"

# 特定のツールのみ許可
allowed-tools: "Bash, Read, Write, Grep"

# ファイル操作のみ
allowed-tools: "Read, Write, Edit, Glob"

# Webアクセスのみ
allowed-tools: "WebFetch, WebSearch"
```

## ファイル構造パターン

### パターン1: シンプルskill（単一ファイル）
```
simple-skill/
└── SKILL.md (200行未満)
```
用途: 直接的な指示のみで完結するskill

### パターン2: 標準skill（参照資料付き）
```
standard-skill/
├── SKILL.md (メイン指示)
├── reference.md (技術詳細)
└── examples.md (使用例)
```
用途: 詳細な情報が必要だが、スクリプトは不要

### パターン3: 実行可能skill（スクリプト付き）
```
executable-skill/
├── SKILL.md
├── reference.md
├── examples.md
└── scripts/
    ├── main.py
    ├── helper.py
    └── README.md
```
用途: 複雑なロジックや外部ツールが必要

### パターン4: テンプレートskill
```
template-skill/
├── SKILL.md
├── reference.md
├── templates/
│   ├── basic-template.txt
│   ├── advanced-template.txt
│   └── config-template.json
└── examples.md
```
用途: ファイル生成や設定が中心

## 説明文の書き方

### 三人称記述の重要性
システムプロンプトに注入されるため、一貫した三人称記述が必須:

```markdown
# 正しい記述（三人称）
このskillはPDFファイルからテキストを抽出します。
Use this skill to process PDF documents.
Extract data by running the provided script.

# 誤った記述（一人称・二人称）
私はPDFファイルを処理します。        # ✗
あなたがPDFを処理したい時に使います。  # ✗
```

### 具体性のスペクトラム

曖昧 ←→ 具体的

```yaml
# レベル1: 曖昧（避けるべき）
description: "Helps with data"

# レベル2: やや曖昧
description: "Process data files"

# レベル3: 適度に具体的
description: "Parse CSV and JSON files to extract structured data"

# レベル4: 非常に具体的（推奨）
description: "Parse CSV, JSON, and Excel files to extract tabular data, validate schemas, and convert between formats. Use when importing data, validating file formats, or transforming datasets."
```

## 指示の具体性レベル

### レベル1: 高度な自由度（テキスト指示）

使用ケース:
- 複数の有効なアプローチが存在
- 創造性が必要
- コンテキスト依存の判断が必要

例:
```markdown
## Instructions

Analyze the provided text and identify key themes. Consider:
- Recurring concepts and ideas
- Sentiment and tone
- Contextual relationships
- Logical structure

Adapt your analysis approach based on the text type (technical, narrative, etc.).
```

### レベル2: 中程度の自由度（疑似コード）

使用ケース:
- 推奨パターンが存在
- 段階的なプロセス
- ある程度の柔軟性が必要

例:
```markdown
## Instructions

Process the document in the following steps:

1. Load and validate the input file
   - Check file exists and is readable
   - Validate file format matches expected type

2. Extract content
   - For PDF: use text extraction with layout preservation
   - For images: apply OCR with language detection

3. Structure the data
   - Identify headers, tables, and body text
   - Maintain hierarchical relationships

4. Validate and format output
   - Ensure completeness
   - Apply requested format (JSON, CSV, etc.)
```

### レベル3: 低度な自由度（具体的スクリプト）

使用ケース:
- エラーが発生しやすい
- 厳密な順序が必要
- 外部ツールとの連携

例:
```markdown
## Instructions

Execute the following process using the provided script:

1. Run the validation script:
```bash
python scripts/validate_input.py --file <input> --schema schemas/expected.json
```

2. If validation passes, process the data:
```bash
python scripts/process.py --input <input> --output <output> --format json
```

3. Verify the output:
```bash
python scripts/verify_output.py --file <output>
```

If any step fails, check the error logs in `logs/` directory and refer to `reference.md` for troubleshooting.
```

## スクリプト統合

### スクリプト記述のベストプラクティス

1. **明示的なエラーハンドリング**
```python
# 悪い例: エラーを投げるだけ
def process_file(path):
    with open(path) as f:
        return f.read()

# 良い例: 明示的なエラーメッセージと対処
def process_file(path):
    """
    ファイルを処理します。

    Returns:
        tuple: (success: bool, data: str, error: str)
    """
    if not os.path.exists(path):
        return False, None, f"File not found: {path}"

    if not os.access(path, os.R_OK):
        return False, None, f"File not readable: {path}"

    try:
        with open(path, 'r', encoding='utf-8') as f:
            data = f.read()
        return True, data, None
    except UnicodeDecodeError:
        return False, None, f"File encoding error. Try binary mode."
    except Exception as e:
        return False, None, f"Unexpected error: {str(e)}"
```

2. **依存関係の明示**
```markdown
## Required Dependencies

Install the following packages before using this skill:

```bash
# Python dependencies
pip install pdfplumber==0.9.0 pandas>=1.5.0 pillow

# System dependencies (macOS)
brew install poppler tesseract

# System dependencies (Ubuntu)
sudo apt-get install poppler-utils tesseract-ocr
```

Version notes:
- pdfplumber 0.9.0+ required for table detection
- pandas 1.5.0+ required for nullable types
```

3. **検証とフィードバック**
```python
def process_with_validation(input_data):
    """検証とフィードバックループ付きの処理"""

    # 1. 事前検証
    is_valid, errors = validate_input(input_data)
    if not is_valid:
        return {
            'success': False,
            'stage': 'validation',
            'errors': errors,
            'suggestion': 'Check input format against schema'
        }

    # 2. 処理実行
    result = perform_processing(input_data)

    # 3. 事後検証
    is_valid, errors = validate_output(result)
    if not is_valid:
        return {
            'success': False,
            'stage': 'output_validation',
            'errors': errors,
            'suggestion': 'Processing completed but output invalid'
        }

    return {
        'success': True,
        'data': result,
        'metadata': get_processing_metadata()
    }
```

## エラーハンドリング

### "Solve, don't punt" 原則

Claudeに判断を委ねない、自己完結型のエラー処理:

```python
# 悪い例: Claudeに判断を委ねる
def download_file(url):
    response = requests.get(url)
    return response.content  # エラー時は例外を投げるだけ

# 良い例: 自動リトライとフォールバック
def download_file(url, max_retries=3):
    """
    ファイルをダウンロード（自動リトライ付き）
    """
    for attempt in range(max_retries):
        try:
            response = requests.get(url, timeout=10)

            if response.status_code == 200:
                return True, response.content, None

            elif response.status_code == 404:
                return False, None, "File not found (404)"

            elif response.status_code >= 500:
                if attempt < max_retries - 1:
                    time.sleep(2 ** attempt)  # Exponential backoff
                    continue
                return False, None, f"Server error ({response.status_code})"

        except requests.Timeout:
            if attempt < max_retries - 1:
                continue
            return False, None, "Connection timeout after retries"

        except requests.ConnectionError:
            return False, None, "Network connection failed"

    return False, None, "Max retries exceeded"
```

### エラーメッセージのガイドライン

効果的なエラーメッセージの構造:
1. **何が**起こったか（問題の説明）
2. **なぜ**起こったか（原因）
3. **どうすれば**解決できるか（解決策）

```python
# 悪い例
raise ValueError("Invalid input")

# 良い例
raise ValueError(
    "Invalid input format: expected JSON object with 'name' and 'age' fields.\n"
    "Cause: Missing required field 'age'.\n"
    "Solution: Add 'age' field as integer, e.g., {'name': 'John', 'age': 30}"
)
```

## テスト戦略

### 評価駆動開発プロセス

1. **ギャップ特定**
```markdown
## Known Gaps
- PDFファイルからの表抽出精度が低い
- 画像埋め込みPDFの処理が不完全
- 大容量ファイル（100MB+）でメモリエラー
```

2. **評価シナリオ作成**（最低3つ）
```markdown
## Test Scenarios

### Scenario 1: Simple text PDF
Input: single-page text-only PDF
Expected: 100% text extraction accuracy
Success criteria: All text extracted, formatting preserved

### Scenario 2: Complex table PDF
Input: multi-page PDF with tables and charts
Expected: Tables extracted as structured data (CSV/JSON)
Success criteria: >95% table cell accuracy

### Scenario 3: Scanned PDF (OCR required)
Input: scanned document PDF
Expected: Text extracted via OCR
Success criteria: >90% text accuracy, language auto-detected
```

3. **ベースライン確立**
```bash
# Run baseline tests
python tests/run_evaluation.py --baseline

# Results:
# Scenario 1: 98% (Pass)
# Scenario 2: 87% (Fail - below 95%)
# Scenario 3: 92% (Pass)
```

4. **反復改善**
```markdown
## Iteration 1 Improvements
- Added advanced table detection algorithm
- Improved cell boundary recognition

## Iteration 2 Results
- Scenario 2: 96% (Pass)
```

### マルチモデルテスト

異なるモデルでの検証:
```markdown
## Model Testing Results

### Haiku
- Fast execution
- Requires very explicit instructions
- Best for: simple, well-defined tasks
- Test result: 3/5 scenarios passed

### Sonnet
- Balanced performance
- Handles moderate complexity
- Best for: standard workflows
- Test result: 5/5 scenarios passed

### Opus
- Best comprehension
- Handles ambiguity well
- Best for: complex, creative tasks
- Test result: 5/5 scenarios passed

## Optimization
Added more explicit instructions for Haiku:
- Detailed step-by-step process
- Reduced ambiguity in language
- Haiku retest: 5/5 scenarios passed
```

## 共通パターン集

### パターン1: データ処理skill

```markdown
---
name: processing-data-format
description: Process [FORMAT] files to extract, validate, and transform data. Use when working with [FORMAT] files, converting data formats, or validating [FORMAT] schemas.
---

# [Format] Data Processing

## Instructions

Process [FORMAT] files in the following steps:

1. **Load and Validate**
   - Verify file format
   - Check schema compliance
   - Report validation errors with line numbers

2. **Extract Data**
   - Parse structure
   - Handle encoding issues
   - Preserve data types

3. **Transform**
   - Apply requested transformations
   - Maintain data integrity
   - Validate output

4. **Output**
   - Format as requested (JSON, CSV, etc.)
   - Include metadata
   - Provide summary statistics

## Error Handling
[Specific error scenarios and solutions]

## Examples
See `examples.md` for usage examples.
```

### パターン2: 分析skill

```markdown
---
name: analyzing-aspect
description: Analyze [SUBJECT] to identify [ASPECTS]. Use when examining [SUBJECT], evaluating [METRICS], or generating [INSIGHTS].
---

# [Subject] Analysis

## Instructions

Perform comprehensive analysis:

1. **Data Collection**
   - Gather relevant data points
   - Validate data quality
   - Identify gaps

2. **Analysis**
   - Apply [METHODOLOGY]
   - Calculate [METRICS]
   - Identify patterns

3. **Insights**
   - Synthesize findings
   - Provide recommendations
   - Highlight risks/opportunities

4. **Reporting**
   - Structure findings clearly
   - Include visualizations
   - Provide actionable conclusions

## Analysis Framework
[Specific framework or methodology]
```

### パターン3: 生成skill

```markdown
---
name: creating-artifact
description: Create [ARTIFACT] from [SOURCE]. Use when generating [ARTIFACT], building [OUTPUT], or converting [SOURCE] to [ARTIFACT].
---

# [Artifact] Creation

## Instructions

Generate high-quality [ARTIFACT]:

1. **Requirements Analysis**
   - Understand specifications
   - Identify constraints
   - Clarify ambiguities

2. **Design**
   - Plan structure
   - Choose appropriate patterns
   - Consider scalability

3. **Implementation**
   - Follow best practices
   - Use provided templates
   - Maintain consistency

4. **Validation**
   - Verify completeness
   - Check quality
   - Test functionality

## Templates
See `templates/` directory for starting points.

## Quality Checklist
- [ ] Meets all requirements
- [ ] Follows conventions
- [ ] Properly documented
- [ ] Tested and validated
```

## まとめ

効果的なskill作成のキーポイント:

1. **明確な目的**: 何を、いつ、どのように使用するかを明確に
2. **適切な自由度**: タスクの性質に応じた指示の具体性
3. **堅牢なエラー処理**: "Solve, don't punt"
4. **段階的な情報提供**: プログレッシブディスクロージャ
5. **徹底的なテスト**: 複数モデル、複数シナリオ

このリファレンスを参照しながら、SKILL.mdの指示に従ってskillを作成してください。
