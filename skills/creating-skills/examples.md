# Claude Code Skill作成 - 実践例集

このドキュメントでは、実際のskill作成の例を通じて、ベストプラクティスの適用方法を示します。

## 目次
1. [例1: シンプルなテキスト処理skill](#例1-シンプルなテキスト処理skill)
2. [例2: データ分析skill（スクリプト付き）](#例2-データ分析skillスクリプト付き)
3. [例3: コード生成skill（テンプレート付き）](#例3-コード生成skillテンプレート付き)
4. [例4: ドキュメント処理skill（複雑な例）](#例4-ドキュメント処理skill複雑な例)

---

## 例1: シンプルなテキスト処理skill

### ユースケース
マークダウンファイルの構造を分析し、目次を生成するskill

### ディレクトリ構造
```
analyzing-markdown/
├── SKILL.md
└── examples.md
```

### SKILL.md の完全な例

```markdown
---
name: analyzing-markdown
description: Analyze markdown files to extract structure, generate table of contents, validate links, and check formatting. Use when processing markdown documentation, generating TOCs, validating markdown files, or analyzing document structure.
allowed-tools: Read, Write, Grep, Glob
---

# Markdown Analysis Skill

このskillはマークダウンファイルを分析し、構造的な情報を抽出します。

## Instructions

マークダウンファイルを以下の手順で分析：

### 1. ファイル読み込み
- Read toolを使用してファイル内容を取得
- エンコーディングエラーを確認
- ファイルが空でないことを確認

### 2. 構造分析
以下を抽出：
- 見出し構造（H1-H6）
- リンク（内部/外部）
- コードブロック
- リスト（順序付き/順序なし）
- 画像参照

### 3. 目次生成（オプション）
見出し構造から目次を生成：
```markdown
## 目次
- [見出し1](#見出し1)
  - [サブ見出し1.1](#サブ見出し11)
  - [サブ見出し1.2](#サブ見出し12)
- [見出し2](#見出し2)
```

### 4. 検証
以下を確認：
- リンクの有効性（ファイル内リンク）
- 見出しレベルの連続性（H1→H3のスキップ検出）
- コードブロックの閉じタグ
- 画像ファイルの存在

### 5. レポート生成
以下を含むレポートを提供：
- ドキュメント統計（見出し数、リンク数など）
- 検証結果と警告
- 生成した目次
- 改善提案

## 出力形式

```markdown
# Markdown Analysis Report

## Document Statistics
- Total lines: [数]
- Headings: [H1数] / [H2数] / [H3数] ...
- Links: [内部リンク数] internal, [外部リンク数] external
- Code blocks: [数]
- Images: [数]

## Structure
[生成された目次]

## Validation Issues
[問題があれば列挙、なければ "No issues found"]

## Suggestions
[改善提案]
```

## 使用例

ユーザーが「README.mdを分析して目次を生成して」と依頼した場合：
1. README.mdを読み込む
2. 構造を分析
3. 目次を生成
4. 検証を実行
5. レポートを提示
6. 必要に応じて目次をファイルに書き込む

詳細な使用例は `examples.md` を参照してください。
```

### 使い方

このskillをプロジェクトに追加後、以下のようなリクエストで使用できます：

```
ユーザー: "docs/README.mdを分析して、目次を生成してください"
エージェント: [analyzing-markdownスキルが自動的に起動]
```

---

## 例2: データ分析skill（スクリプト付き）

### ユースケース
CSVファイルを分析し、統計情報と可視化を提供するskill

### ディレクトリ構造
```
analyzing-csv/
├── SKILL.md
├── reference.md
├── examples.md
└── scripts/
    ├── analyze.py
    ├── visualize.py
    └── requirements.txt
```

### SKILL.md

```markdown
---
name: analyzing-csv
description: Analyze CSV files to extract statistics, detect patterns, validate data quality, and generate visualizations. Use when processing CSV data, performing data analysis, validating datasets, or creating data reports.
---

# CSV Data Analysis Skill

CSVファイルの包括的な分析を実行します。

## Required Dependencies

このskillを使用する前に、以下をインストール：

```bash
pip install -r .claude/skills/analyzing-csv/scripts/requirements.txt
```

必要なパッケージ:
- pandas >= 1.5.0
- numpy >= 1.20.0
- matplotlib >= 3.5.0
- seaborn >= 0.11.0

## Instructions

### 1. 初期検証
```bash
python .claude/skills/analyzing-csv/scripts/analyze.py --validate <csv_file>
```

以下を確認：
- ファイル形式の正当性
- エンコーディング検出
- 区切り文字の検出（カンマ、タブ、セミコロン）
- ヘッダー行の存在

### 2. データ分析
```bash
python .claude/skills/analyzing-csv/scripts/analyze.py --analyze <csv_file> --output report.json
```

実行される分析：
- **基本統計**: 行数、列数、メモリ使用量
- **列分析**: データ型、欠損値、ユニーク値
- **数値列**: 平均、中央値、標準偏差、分位数
- **カテゴリ列**: 頻度分布、最頻値
- **データ品質**: 重複行、異常値、不整合

### 3. 可視化生成（オプション）
```bash
python .claude/skills/analyzing-csv/scripts/visualize.py --input <csv_file> --output charts/
```

生成される可視化：
- 数値列のヒストグラム
- カテゴリ列の棒グラフ
- 相関行列（数値列）
- 欠損値のヒートマップ

### 4. レポート提示

分析結果をユーザーに提示：
```markdown
# CSV Analysis Report: <filename>

## Dataset Overview
- Rows: [数]
- Columns: [数]
- Memory: [サイズ]MB
- Encoding: [エンコーディング]

## Column Summary
[各列の詳細]

## Data Quality
- Missing values: [割合]%
- Duplicate rows: [数]
- Potential issues: [問題があれば列挙]

## Key Insights
[重要な発見や異常値]

## Visualizations
[生成された画像へのリンク]
```

## エラーハンドリング

スクリプトは以下のエラーを自動処理：
- **エンコーディングエラー**: 複数のエンコーディングを試行（UTF-8, Latin-1, CP932）
- **区切り文字エラー**: 自動検出または手動指定
- **メモリエラー**: チャンク処理に自動切り替え（大容量ファイル）
- **データ型エラー**: 柔軟な型推論と変換

エラー発生時は詳細なログを `logs/analysis_error.log` に出力。

## 使用例

詳細は `examples.md` を参照。

## 技術詳細

`reference.md` にスクリプトの実装詳細とカスタマイズ方法を記載。
```

### scripts/analyze.py の例

```python
#!/usr/bin/env python3
"""
CSV分析スクリプト
"""
import sys
import json
import argparse
from pathlib import Path
import pandas as pd
import numpy as np

def detect_encoding(file_path):
    """ファイルのエンコーディングを検出"""
    encodings = ['utf-8', 'latin-1', 'cp932', 'shift-jis']

    for encoding in encodings:
        try:
            with open(file_path, 'r', encoding=encoding) as f:
                f.read()
            return encoding
        except UnicodeDecodeError:
            continue

    return None

def validate_csv(file_path):
    """CSV形式の検証"""
    encoding = detect_encoding(file_path)

    if not encoding:
        return {
            'valid': False,
            'error': 'Could not detect file encoding. Try UTF-8, Latin-1, or Shift-JIS.'
        }

    try:
        # 区切り文字の検出
        df = pd.read_csv(file_path, encoding=encoding, nrows=5)

        return {
            'valid': True,
            'encoding': encoding,
            'separator': ',',  # pandasが自動検出
            'has_header': True,
            'columns': list(df.columns),
            'sample_rows': len(df)
        }

    except Exception as e:
        return {
            'valid': False,
            'error': f'CSV parsing error: {str(e)}'
        }

def analyze_csv(file_path, output_path=None):
    """CSV の包括的分析"""

    # 検証
    validation = validate_csv(file_path)
    if not validation['valid']:
        return validation

    # データ読み込み
    encoding = validation['encoding']
    df = pd.read_csv(file_path, encoding=encoding)

    # 基本統計
    analysis = {
        'file': str(file_path),
        'encoding': encoding,
        'shape': {
            'rows': len(df),
            'columns': len(df.columns)
        },
        'memory_mb': df.memory_usage(deep=True).sum() / 1024 / 1024,
        'columns': {}
    }

    # 列ごとの分析
    for col in df.columns:
        col_analysis = {
            'dtype': str(df[col].dtype),
            'missing': int(df[col].isna().sum()),
            'missing_pct': float(df[col].isna().sum() / len(df) * 100),
            'unique': int(df[col].nunique())
        }

        # 数値列の統計
        if pd.api.types.is_numeric_dtype(df[col]):
            col_analysis['stats'] = {
                'mean': float(df[col].mean()),
                'median': float(df[col].median()),
                'std': float(df[col].std()),
                'min': float(df[col].min()),
                'max': float(df[col].max()),
                'q25': float(df[col].quantile(0.25)),
                'q75': float(df[col].quantile(0.75))
            }

            # 異常値検出（IQR法）
            Q1 = df[col].quantile(0.25)
            Q3 = df[col].quantile(0.75)
            IQR = Q3 - Q1
            outliers = df[(df[col] < Q1 - 1.5 * IQR) | (df[col] > Q3 + 1.5 * IQR)][col]
            col_analysis['outliers'] = int(len(outliers))

        # カテゴリ列の統計
        else:
            value_counts = df[col].value_counts()
            col_analysis['top_values'] = {
                str(k): int(v) for k, v in value_counts.head(5).items()
            }

        analysis['columns'][col] = col_analysis

    # データ品質
    analysis['quality'] = {
        'duplicate_rows': int(df.duplicated().sum()),
        'total_missing': int(df.isna().sum().sum()),
        'columns_with_missing': int((df.isna().sum() > 0).sum())
    }

    # 出力
    if output_path:
        with open(output_path, 'w', encoding='utf-8') as f:
            json.dump(analysis, f, indent=2, ensure_ascii=False)
        print(f"Analysis saved to: {output_path}")
    else:
        print(json.dumps(analysis, indent=2, ensure_ascii=False))

    return analysis

def main():
    parser = argparse.ArgumentParser(description='CSV Analysis Tool')
    parser.add_argument('--validate', type=str, help='Validate CSV file')
    parser.add_argument('--analyze', type=str, help='Analyze CSV file')
    parser.add_argument('--output', type=str, help='Output file for analysis results')

    args = parser.parse_args()

    if args.validate:
        result = validate_csv(args.validate)
        print(json.dumps(result, indent=2))
        sys.exit(0 if result['valid'] else 1)

    elif args.analyze:
        result = analyze_csv(args.analyze, args.output)
        if not result.get('valid', True):
            print(f"Error: {result.get('error')}", file=sys.stderr)
            sys.exit(1)
        sys.exit(0)

    else:
        parser.print_help()
        sys.exit(1)

if __name__ == '__main__':
    main()
```

### scripts/requirements.txt

```
pandas>=1.5.0
numpy>=1.20.0
matplotlib>=3.5.0
seaborn>=0.11.0
```

---

## 例3: コード生成skill（テンプレート付き）

### ユースケース
RESTful APIエンドポイントのボイラープレートコードを生成

### ディレクトリ構造
```
creating-api-endpoints/
├── SKILL.md
├── reference.md
├── examples.md
└── templates/
    ├── express-endpoint.js
    ├── fastapi-endpoint.py
    ├── flask-endpoint.py
    └── README.md
```

### SKILL.md

```markdown
---
name: creating-api-endpoints
description: Generate RESTful API endpoint boilerplate code for Express, FastAPI, Flask, and other frameworks. Use when creating API endpoints, building REST APIs, generating route handlers, or scaffolding API code.
---

# API Endpoint Generator Skill

RESTful APIエンドポイントのボイラープレートコードを生成します。

## Instructions

### 1. 要件の確認

以下を確認：
- フレームワーク（Express, FastAPI, Flask, etc.）
- エンドポイント仕様:
  - HTTPメソッド（GET, POST, PUT, DELETE, etc.）
  - パス（例: `/api/users/:id`）
  - リクエストボディスキーマ
  - レスポンス形式
  - 認証要件

### 2. テンプレート選択

利用可能なテンプレート:
- `templates/express-endpoint.js` - Node.js/Express
- `templates/fastapi-endpoint.py` - Python/FastAPI
- `templates/flask-endpoint.py` - Python/Flask

フレームワークに応じて適切なテンプレートを選択。

### 3. コード生成

テンプレートをベースに、以下をカスタマイズ：

**基本構造**:
```python
# FastAPI example
@app.get("/api/resource/{id}")
async def get_resource(id: int):
    """
    リソースを取得

    Args:
        id: リソースID

    Returns:
        Resource object

    Raises:
        HTTPException: リソースが見つからない場合
    """
    # Implementation
    pass
```

**含めるべき要素**:
- ルート定義とパラメータ
- リクエストバリデーション
- エラーハンドリング
- レスポンス形式
- ドキュメント（docstring/comments）
- 型ヒント（該当言語の場合）

### 4. ベストプラクティスの適用

以下を確保：
- [ ] 適切なHTTPステータスコード使用
- [ ] 入力バリデーション
- [ ] エラーハンドリング
- [ ] セキュリティ考慮（認証、認可、入力サニタイズ）
- [ ] ドキュメント記述
- [ ] 一貫した命名規則

### 5. テストコードの提案（オプション）

生成したエンドポイントの基本的なテストコードも提案：
```python
# pytest example
def test_get_resource():
    response = client.get("/api/resource/1")
    assert response.status_code == 200
    assert "id" in response.json()
```

## 出力形式

生成したコードは以下の構造で提示：

```markdown
# Generated API Endpoint

## Endpoint Specification
- Method: [GET/POST/etc.]
- Path: [/api/...]
- Description: [説明]

## Implementation

[生成されたコード]

## Usage Example

[curlまたはHTTPリクエスト例]

## Test Code

[テストコード]

## Security Considerations

[セキュリティ上の注意点]
```

## 使用例

詳細は `examples.md` を参照。

## カスタマイズ

テンプレートのカスタマイズ方法は `reference.md` を参照。
```

### templates/fastapi-endpoint.py

```python
"""
FastAPI Endpoint Template
"""
from fastapi import APIRouter, HTTPException, Depends, status
from pydantic import BaseModel, Field
from typing import Optional, List

router = APIRouter(prefix="/api/resource", tags=["resource"])

# リクエスト/レスポンスモデル
class ResourceCreate(BaseModel):
    """リソース作成リクエスト"""
    name: str = Field(..., min_length=1, max_length=100, description="リソース名")
    description: Optional[str] = Field(None, max_length=500, description="説明")

class ResourceResponse(BaseModel):
    """リソースレスポンス"""
    id: int = Field(..., description="リソースID")
    name: str = Field(..., description="リソース名")
    description: Optional[str] = Field(None, description="説明")
    created_at: str = Field(..., description="作成日時")

    class Config:
        schema_extra = {
            "example": {
                "id": 1,
                "name": "Example Resource",
                "description": "This is an example",
                "created_at": "2025-01-01T00:00:00Z"
            }
        }

# GET: 全件取得
@router.get(
    "/",
    response_model=List[ResourceResponse],
    summary="リソース一覧取得",
    description="すべてのリソースを取得します"
)
async def list_resources(
    skip: int = 0,
    limit: int = 100
):
    """
    リソース一覧を取得

    Args:
        skip: スキップする件数
        limit: 取得する最大件数

    Returns:
        リソースのリスト
    """
    # TODO: データベースクエリを実装
    return []

# GET: ID指定取得
@router.get(
    "/{resource_id}",
    response_model=ResourceResponse,
    summary="リソース取得",
    description="IDを指定してリソースを取得します",
    responses={
        404: {"description": "リソースが見つかりません"}
    }
)
async def get_resource(resource_id: int):
    """
    リソースを取得

    Args:
        resource_id: リソースID

    Returns:
        リソースオブジェクト

    Raises:
        HTTPException: リソースが見つからない場合
    """
    # TODO: データベースクエリを実装
    # resource = db.get_resource(resource_id)
    # if not resource:
    #     raise HTTPException(
    #         status_code=status.HTTP_404_NOT_FOUND,
    #         detail=f"Resource {resource_id} not found"
    #     )
    # return resource

    raise HTTPException(
        status_code=status.HTTP_404_NOT_FOUND,
        detail=f"Resource {resource_id} not found"
    )

# POST: 新規作成
@router.post(
    "/",
    response_model=ResourceResponse,
    status_code=status.HTTP_201_CREATED,
    summary="リソース作成",
    description="新しいリソースを作成します"
)
async def create_resource(resource: ResourceCreate):
    """
    リソースを作成

    Args:
        resource: リソース作成リクエスト

    Returns:
        作成されたリソース
    """
    # TODO: データベースへの挿入を実装
    # new_resource = db.create_resource(resource)
    # return new_resource

    return ResourceResponse(
        id=1,
        name=resource.name,
        description=resource.description,
        created_at="2025-01-01T00:00:00Z"
    )

# PUT: 更新
@router.put(
    "/{resource_id}",
    response_model=ResourceResponse,
    summary="リソース更新",
    description="既存のリソースを更新します",
    responses={
        404: {"description": "リソースが見つかりません"}
    }
)
async def update_resource(resource_id: int, resource: ResourceCreate):
    """
    リソースを更新

    Args:
        resource_id: リソースID
        resource: 更新データ

    Returns:
        更新されたリソース

    Raises:
        HTTPException: リソースが見つからない場合
    """
    # TODO: データベース更新を実装
    raise HTTPException(
        status_code=status.HTTP_404_NOT_FOUND,
        detail=f"Resource {resource_id} not found"
    )

# DELETE: 削除
@router.delete(
    "/{resource_id}",
    status_code=status.HTTP_204_NO_CONTENT,
    summary="リソース削除",
    description="リソースを削除します",
    responses={
        404: {"description": "リソースが見つかりません"}
    }
)
async def delete_resource(resource_id: int):
    """
    リソースを削除

    Args:
        resource_id: リソースID

    Raises:
        HTTPException: リソースが見つからない場合
    """
    # TODO: データベース削除を実装
    raise HTTPException(
        status_code=status.HTTP_404_NOT_FOUND,
        detail=f"Resource {resource_id} not found"
    )
```

---

## 例4: ドキュメント処理skill（複雑な例）

### ユースケース
PDF、Word、Excelなど複数形式のドキュメントからデータを抽出

### ディレクトリ構造
```
processing-documents/
├── SKILL.md
├── reference.md
├── examples.md
├── scripts/
│   ├── extract_pdf.py
│   ├── extract_docx.py
│   ├── extract_xlsx.py
│   ├── common.py
│   └── requirements.txt
└── templates/
    └── extraction_report.md
```

### SKILL.md（簡略版）

```markdown
---
name: processing-documents
description: Extract text, tables, images, and metadata from PDF, Word (DOCX), Excel (XLSX), and PowerPoint files. Use when extracting document content, processing office files, converting documents to structured data, or analyzing document structure.
---

# Document Processing Skill

複数形式のドキュメントから構造化データを抽出します。

## Supported Formats
- PDF (.pdf)
- Word (.docx)
- Excel (.xlsx, .xls)
- PowerPoint (.pptx)
- Text (.txt, .md)

## Required Dependencies

```bash
pip install -r .claude/skills/processing-documents/scripts/requirements.txt
```

## Instructions

### 1. 形式検出とバリデーション

```bash
python scripts/common.py --detect <file_path>
```

自動検出:
- ファイル拡張子
- MIMEタイプ
- ファイルマジックナンバー

### 2. 抽出処理

形式に応じた専用スクリプト実行:

**PDF処理**:
```bash
python scripts/extract_pdf.py --input <file> --output <output_dir>
```
抽出内容:
- テキスト（レイアウト保持）
- テーブル（CSV/JSON）
- 画像
- メタデータ（作成者、日時など）

**Word処理**:
```bash
python scripts/extract_docx.py --input <file> --output <output_dir>
```
抽出内容:
- 本文テキスト
- 見出し構造
- テーブル
- 画像
- コメントと変更履歴

**Excel処理**:
```bash
python scripts/extract_xlsx.py --input <file> --output <output_dir>
```
抽出内容:
- 全シートデータ（CSV/JSON）
- セル書式
- 数式
- グラフ画像

### 3. エラーハンドリング

各スクリプトは以下を自動処理:
- **暗号化ファイル**: パスワード要求または警告
- **破損ファイル**: 可能な範囲で部分抽出
- **大容量ファイル**: ストリーミング処理に自動切り替え
- **エンコーディング**: 自動検出と変換

### 4. 出力構造

```
output_dir/
├── text/
│   └── extracted.txt
├── tables/
│   ├── table_001.csv
│   └── table_002.json
├── images/
│   ├── image_001.png
│   └── image_002.jpg
├── metadata.json
└── report.md
```

### 5. レポート生成

`templates/extraction_report.md`を使用してレポート作成。

## 詳細

- 実装詳細: `reference.md`
- 使用例: `examples.md`
- スクリプトAPI: `scripts/README.md`
```

---

## Skill作成のワークフロー例

### ステップ1: 要件定義
```markdown
## 新しいskillのアイデア
- 目的: JSONスキーマからTypeScript型定義を生成
- 対象ユーザー: TypeScript開発者
- トリガーワード: "JSON schema", "TypeScript types", "generate types"
```

### ステップ2: 構造決定
```
generating-typescript-types/
├── SKILL.md (メイン)
├── examples.md (使用例)
└── templates/
    ├── basic-type.ts
    └── advanced-type.ts
```

### ステップ3: メタデータ定義
```yaml
---
name: generating-typescript-types
description: Generate TypeScript type definitions from JSON schemas. Use when creating TypeScript types, converting JSON schema to types, or scaffolding type definitions.
allowed-tools: Read, Write
---
```

### ステップ4: 指示の記述

具体性レベルを決定（この場合は中程度）:
```markdown
## Instructions

1. **JSON Schema読み込み**
   - ファイルまたは直接入力から取得
   - スキーマの妥当性を確認

2. **型定義生成**
   - プリミティブ型をマッピング
   - ネストされたオブジェクトを処理
   - 配列とオプショナルフィールドを処理

3. **出力**
   - 適切なTypeScript構文で出力
   - export文を含める
   - JSDocコメントを追加
```

### ステップ5: テストシナリオ作成
```markdown
## Test Scenarios

### Scenario 1: Simple schema
Input: {"type": "object", "properties": {"name": {"type": "string"}}}
Expected: interface with string property

### Scenario 2: Nested schema
Input: Complex nested objects
Expected: Properly nested TypeScript interfaces

### Scenario 3: Arrays and optionals
Input: Arrays and optional fields
Expected: Correct array types and optional markers (?)
```

### ステップ6: 反復改善
1. Haikuでテスト → 指示を明確化
2. Sonnetでテスト → エッジケースを追加
3. Opusでテスト → 最終検証

---

## まとめ

効果的なskill作成の鍵:

1. **明確な目的定義**: 何を、いつ、どのように
2. **適切な構造選択**: 複雑さに応じたファイル構成
3. **具体的な説明**: キーワードとユースケースを含める
4. **段階的指示**: タスクの性質に応じた自由度
5. **堅牢なエラー処理**: "Solve, don't punt"
6. **徹底的なテスト**: 複数モデル、複数シナリオ

これらの例を参考に、独自のskillを作成してください。
