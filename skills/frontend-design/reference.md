# フロントエンドデザイン詳細リファレンス

このドキュメントは、frontend-designスキルの詳細なガイドラインと実装パターンを提供します。

## 目次

1. [デザイン原則](#デザイン原則)
2. [タイポグラフィ詳細](#タイポグラフィ詳細)
3. [カラーシステム](#カラーシステム)
4. [アニメーションとモーション](#アニメーションとモーション)
5. [レイアウトパターン](#レイアウトパターン)
6. [視覚効果](#視覚効果)
7. [技術的実装](#技術的実装)

## デザイン原則

### 意図性の重要性

すべてのデザイン決定は明確な意図を持つべきです：
- **ミニマリズム**: 削ぎ落とすことで本質を強調
- **マキシマリズム**: 豊富な要素で体験を豊かに
- どちらも有効 - 重要なのは一貫性と目的

### コンテキスト駆動デザイン

デザインは常にコンテキストに適合すべき：
- **ユーザー層**: 技術者向け vs 一般消費者向け
- **業界**: 金融（堅実）vs クリエイティブ（実験的）
- **目的**: 情報提供 vs エンターテイメント vs ツール

### 記憶に残る要素

各デザインには「記憶のフック」が必要：
- ユニークなナビゲーションパターン
- 特徴的なカラーパレット
- 印象的なタイポグラフィ
- 驚きのインタラクション

## タイポグラフィ詳細

### フォント選択の戦略

#### 避けるべきフォント（一般的すぎる）
- Inter / Roboto / Arial / Helvetica
- システムフォント（-apple-system, BlinkMacSystemFont）
- Google Fonts の上位 10 件

#### 推奨フォントカテゴリ

**1. ディスプレイフォント（見出し用）**
```
エディトリアル/洗練:
- Playfair Display
- Cormorant
- Spectral
- Libre Baskerville

モダン/幾何学:
- Syne
- Cabinet Grotesk
- Clash Display
- General Sans

個性的/実験的:
- Unbounded
- Fraunces
- Recursive
- DM Serif Display
```

**2. ボディフォント（本文用）**
```
セリフ:
- Crimson Text
- Lora
- Source Serif Pro
- IBM Plex Serif

サンセリフ:
- Public Sans
- DM Sans
- Manrope
- Outfit
```

### タイポグラフィスケール

目的に応じたスケール設定：

**ミニマリスト/洗練**
```css
:root {
  --font-size-xs: 0.75rem;   /* 12px */
  --font-size-sm: 0.875rem;  /* 14px */
  --font-size-base: 1rem;    /* 16px */
  --font-size-lg: 1.125rem;  /* 18px */
  --font-size-xl: 1.5rem;    /* 24px */
  --font-size-2xl: 2rem;     /* 32px */
  --font-size-3xl: 3rem;     /* 48px */
}
```

**マキシマリスト/インパクト**
```css
:root {
  --font-size-xs: 0.875rem;  /* 14px */
  --font-size-sm: 1rem;      /* 16px */
  --font-size-base: 1.125rem;/* 18px */
  --font-size-lg: 1.5rem;    /* 24px */
  --font-size-xl: 2.5rem;    /* 40px */
  --font-size-2xl: 4rem;     /* 64px */
  --font-size-3xl: 6rem;     /* 96px */
}
```

## カラーシステム

### 避けるべきカラーパターン

❌ 白背景 + 紫/青グラデーション（AI風）
❌ Material Design のデフォルトパレット
❌ 均等に分散された 5-6 色のパレット

### 効果的なカラー戦略

#### パターン 1: 支配的な色 + アクセント
```css
:root {
  /* 支配的な色 (70-80%) */
  --color-dominant: #1a1a1a;
  --color-dominant-light: #2a2a2a;
  --color-dominant-dark: #0a0a0a;

  /* アクセント色 (10-20%) */
  --color-accent: #ff6b35;
  --color-accent-hover: #ff8555;

  /* ニュートラル (10%) */
  --color-neutral: #f5f5f5;
}
```

#### パターン 2: モノクロ + 単一カラー
```css
:root {
  /* モノクロベース */
  --color-black: #0d0d0d;
  --color-gray-dark: #2d2d2d;
  --color-gray: #8d8d8d;
  --color-gray-light: #e5e5e5;
  --color-white: #fafafa;

  /* 単一アクセント */
  --color-highlight: #00ff88;
}
```

#### パターン 3: デュオトーン
```css
:root {
  /* 2色のみで構成 */
  --color-primary: #ff006e;
  --color-primary-light: #ff4d91;
  --color-primary-dark: #cc0058;

  --color-secondary: #8338ec;
  --color-secondary-light: #a366ff;
  --color-secondary-dark: #6a2dc3;
}
```

### カラーコンテキスト

**業界別推奨パレット**

```
技術/SaaS:
- ダーク + ネオングリーン
- モノクロ + エレクトリックブルー

クリエイティブ/デザイン:
- パステル + ディープトーン
- ビビッド + ブラック

金融/企業:
- ネイビー + ゴールド
- チャコール + ミントグリーン

ヘルス/ウェルネス:
- アースカラー + オーガニックグリーン
- ソフトブルー + ウォームベージュ
```

## アニメーションとモーション

### CSS アニメーション原則

#### 1. イージング関数
```css
:root {
  /* 標準的な動き */
  --ease-out: cubic-bezier(0.33, 1, 0.68, 1);
  --ease-in: cubic-bezier(0.32, 0, 0.67, 0);
  --ease-in-out: cubic-bezier(0.65, 0, 0.35, 1);

  /* カスタム（個性的） */
  --ease-bounce: cubic-bezier(0.68, -0.55, 0.265, 1.55);
  --ease-smooth: cubic-bezier(0.4, 0.0, 0.2, 1);
}
```

#### 2. タイミング
```css
:root {
  --duration-fast: 150ms;
  --duration-base: 300ms;
  --duration-slow: 500ms;
  --duration-slower: 800ms;
}
```

### アニメーションパターン

#### パターン 1: ページロード時のシーケンス
```css
/* 時間差で表示 */
.hero-title {
  animation: fadeInUp 0.8s var(--ease-out) forwards;
}

.hero-subtitle {
  animation: fadeInUp 0.8s var(--ease-out) 0.2s forwards;
  opacity: 0;
}

.hero-cta {
  animation: fadeInUp 0.8s var(--ease-out) 0.4s forwards;
  opacity: 0;
}

@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
```

#### パターン 2: ホバーエフェクト
```css
/* 予期しないホバー */
.card {
  transition: transform 0.3s var(--ease-out);
}

.card:hover {
  transform: translateY(-8px) rotate(2deg);
}

/* 背景効果 */
.button {
  position: relative;
  overflow: hidden;
}

.button::before {
  content: '';
  position: absolute;
  top: 50%;
  left: 50%;
  width: 0;
  height: 0;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.3);
  transform: translate(-50%, -50%);
  transition: width 0.6s, height 0.6s;
}

.button:hover::before {
  width: 300px;
  height: 300px;
}
```

### React でのアニメーション

Framer Motion 使用例：

```jsx
import { motion } from 'framer-motion';

// スタガーアニメーション
const container = {
  hidden: { opacity: 0 },
  show: {
    opacity: 1,
    transition: {
      staggerChildren: 0.1
    }
  }
};

const item = {
  hidden: { opacity: 0, y: 20 },
  show: { opacity: 1, y: 0 }
};

function Component() {
  return (
    <motion.div variants={container} initial="hidden" animate="show">
      <motion.div variants={item}>Item 1</motion.div>
      <motion.div variants={item}>Item 2</motion.div>
      <motion.div variants={item}>Item 3</motion.div>
    </motion.div>
  );
}
```

## レイアウトパターン

### 避けるべきレイアウト

❌ センター配置の対称グリッド
❌ 標準的な 12 カラムグリッド
❌ ボックス内のボックスパターン

### 革新的なレイアウト

#### パターン 1: 非対称グリッド
```css
.grid {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 2rem;
}

.grid-item:nth-child(2) {
  grid-row: span 2;
}
```

#### パターン 2: オーバーラップ
```css
.overlap-container {
  display: grid;
  grid-template-columns: 1fr 1fr;
}

.overlap-item-1 {
  grid-column: 1;
  grid-row: 1;
  z-index: 2;
}

.overlap-item-2 {
  grid-column: 1 / 3;
  grid-row: 1;
  z-index: 1;
  transform: translateX(20%);
}
```

#### パターン 3: 斜めレイアウト
```css
.diagonal-section {
  transform: skewY(-3deg);
  padding: 8rem 0;
}

.diagonal-section > * {
  transform: skewY(3deg);
}
```

## 視覚効果

### 背景パターン

#### 1. グラデーションメッシュ
```css
.gradient-mesh {
  background:
    radial-gradient(at 20% 30%, #ff006e 0px, transparent 50%),
    radial-gradient(at 80% 70%, #8338ec 0px, transparent 50%),
    radial-gradient(at 50% 50%, #3a86ff 0px, transparent 50%);
  background-color: #000;
}
```

#### 2. ノイズテクスチャ
```css
.noise-texture {
  background-image:
    url("data:image/svg+xml,%3Csvg viewBox='0 0 400 400' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noiseFilter'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='4' numOctaves='3' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noiseFilter)'/%3E%3C/svg%3E");
  opacity: 0.05;
}
```

#### 3. 幾何学パターン
```css
.geometric-pattern {
  background-image:
    linear-gradient(30deg, #f5f5f5 12%, transparent 12.5%, transparent 87%, #f5f5f5 87.5%, #f5f5f5),
    linear-gradient(150deg, #f5f5f5 12%, transparent 12.5%, transparent 87%, #f5f5f5 87.5%, #f5f5f5);
  background-size: 80px 80px;
}
```

### 視覚効果要素

#### グラスモーフィズム
```css
.glass {
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.37);
}
```

#### ニューモーフィズム
```css
.neumorphic {
  background: #e0e5ec;
  box-shadow:
    9px 9px 16px rgba(163, 177, 198, 0.6),
    -9px -9px 16px rgba(255, 255, 255, 0.5);
  border-radius: 20px;
}
```

## 技術的実装

### CSS 変数システム

完全なデザインシステム例：

```css
:root {
  /* カラー */
  --color-bg: #0a0a0a;
  --color-text: #fafafa;
  --color-accent: #ff006e;

  /* タイポグラフィ */
  --font-display: 'Syne', sans-serif;
  --font-body: 'DM Sans', sans-serif;
  --font-size-base: 16px;

  /* スペーシング */
  --space-xs: 0.5rem;
  --space-sm: 1rem;
  --space-md: 2rem;
  --space-lg: 4rem;
  --space-xl: 8rem;

  /* アニメーション */
  --ease: cubic-bezier(0.65, 0, 0.35, 1);
  --duration: 0.3s;

  /* レイアウト */
  --container-width: 1200px;
  --border-radius: 8px;
}
```

### レスポンシブデザイン

モバイルファーストアプローチ：

```css
/* モバイル（デフォルト） */
.container {
  padding: 1rem;
}

/* タブレット */
@media (min-width: 768px) {
  .container {
    padding: 2rem;
  }
}

/* デスクトップ */
@media (min-width: 1024px) {
  .container {
    padding: 4rem;
    max-width: var(--container-width);
    margin: 0 auto;
  }
}
```

### パフォーマンス最適化

```css
/* GPU アクセラレーション */
.animated-element {
  will-change: transform;
  transform: translateZ(0);
}

/* アニメーションの最適化 */
@media (prefers-reduced-motion: reduce) {
  * {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
  }
}
```

## 実装チェックリスト

実装前に確認：

- [ ] 明確な美的方向性が決定されている
- [ ] ユニークなフォントペアが選択されている
- [ ] 一貫性のあるカラーシステムが定義されている
- [ ] CSS 変数でデザイントークンが設定されている
- [ ] アニメーションが意図的に配置されている
- [ ] レスポンシブデザインが考慮されている
- [ ] パフォーマンスが最適化されている
- [ ] アクセシビリティが確保されている

実装後に確認：

- [ ] デザインは記憶に残るか
- [ ] 一般的なAI美学を避けているか
- [ ] コンテキストに適合しているか
- [ ] 技術的に正しく実装されているか
