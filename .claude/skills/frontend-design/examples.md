# フロントエンドデザイン実装例

このドキュメントは、frontend-designスキルを使用した具体的な実装例を提供します。

## 目次

1. [ミニマリスト：ポートフォリオサイト](#例1-ミニマリストポートフォリオサイト)
2. [マキシマリスト：イベントランディングページ](#例2-マキシマリストイベントランディングページ)
3. [ブルータリスト：デザインスタジオ](#例3-ブルータリストデザインスタジオ)
4. [React コンポーネント例](#react-コンポーネント例)

---

## 例1: ミニマリスト・ポートフォリオサイト

### デザインコンセプト
- **トーン**: 洗練されたミニマリズム
- **特徴**: 豊富なネガティブスペース、タイポグラフィ重視、微妙なアニメーション
- **フォント**: Cormorant（見出し）× DM Sans（本文）
- **カラー**: モノクロ + 単一アクセント

### HTML/CSS 実装

```html
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Portfolio</title>
  <link href="https://fonts.googleapis.com/css2?family=Cormorant:wght@300;500;700&family=DM+Sans:wght@400;500&display=swap" rel="stylesheet">
  <style>
    :root {
      --color-bg: #fafafa;
      --color-text: #1a1a1a;
      --color-accent: #ff006e;
      --font-display: 'Cormorant', serif;
      --font-body: 'DM Sans', sans-serif;
      --ease: cubic-bezier(0.65, 0, 0.35, 1);
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: var(--font-body);
      background: var(--color-bg);
      color: var(--color-text);
      line-height: 1.6;
      overflow-x: hidden;
    }

    .container {
      max-width: 1000px;
      margin: 0 auto;
      padding: 0 2rem;
    }

    /* ヘッダー */
    header {
      padding: 4rem 0;
      border-bottom: 1px solid rgba(26, 26, 26, 0.1);
    }

    nav {
      display: flex;
      justify-content: space-between;
      align-items: center;
      animation: fadeInDown 0.8s var(--ease);
    }

    .logo {
      font-family: var(--font-display);
      font-size: 1.5rem;
      font-weight: 700;
      letter-spacing: 0.02em;
    }

    .nav-links {
      display: flex;
      gap: 3rem;
      list-style: none;
    }

    .nav-links a {
      color: var(--color-text);
      text-decoration: none;
      font-size: 0.875rem;
      text-transform: uppercase;
      letter-spacing: 0.1em;
      transition: color 0.3s var(--ease);
    }

    .nav-links a:hover {
      color: var(--color-accent);
    }

    /* ヒーローセクション */
    .hero {
      padding: 12rem 0;
      text-align: center;
    }

    .hero-title {
      font-family: var(--font-display);
      font-size: clamp(3rem, 8vw, 8rem);
      font-weight: 300;
      line-height: 1.1;
      margin-bottom: 2rem;
      animation: fadeInUp 0.8s var(--ease) 0.2s both;
    }

    .hero-subtitle {
      font-size: 1.125rem;
      color: rgba(26, 26, 26, 0.6);
      max-width: 600px;
      margin: 0 auto 3rem;
      animation: fadeInUp 0.8s var(--ease) 0.4s both;
    }

    .hero-accent {
      color: var(--color-accent);
      font-style: italic;
    }

    /* プロジェクトグリッド */
    .projects {
      padding: 8rem 0;
    }

    .project-grid {
      display: grid;
      gap: 8rem;
    }

    .project {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 4rem;
      align-items: center;
      opacity: 0;
      transform: translateY(40px);
      animation: fadeInUp 0.8s var(--ease) forwards;
    }

    .project:nth-child(1) { animation-delay: 0.1s; }
    .project:nth-child(2) { animation-delay: 0.2s; }
    .project:nth-child(3) { animation-delay: 0.3s; }

    .project:nth-child(even) {
      direction: rtl;
    }

    .project:nth-child(even) > * {
      direction: ltr;
    }

    .project-image {
      width: 100%;
      aspect-ratio: 4/3;
      background: linear-gradient(135deg, #f5f5f5, #e5e5e5);
      border-radius: 4px;
      overflow: hidden;
      transition: transform 0.5s var(--ease);
    }

    .project:hover .project-image {
      transform: scale(1.02);
    }

    .project-info h3 {
      font-family: var(--font-display);
      font-size: 2.5rem;
      font-weight: 500;
      margin-bottom: 1rem;
    }

    .project-info p {
      color: rgba(26, 26, 26, 0.7);
      margin-bottom: 2rem;
    }

    .project-link {
      display: inline-block;
      color: var(--color-text);
      text-decoration: none;
      font-size: 0.875rem;
      text-transform: uppercase;
      letter-spacing: 0.1em;
      padding-bottom: 0.25rem;
      border-bottom: 2px solid var(--color-accent);
      transition: transform 0.3s var(--ease);
    }

    .project-link:hover {
      transform: translateX(4px);
    }

    /* アニメーション */
    @keyframes fadeInUp {
      from {
        opacity: 0;
        transform: translateY(40px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    @keyframes fadeInDown {
      from {
        opacity: 0;
        transform: translateY(-20px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    /* レスポンシブ */
    @media (max-width: 768px) {
      .nav-links {
        gap: 1.5rem;
      }

      .hero {
        padding: 8rem 0;
      }

      .project,
      .project:nth-child(even) {
        grid-template-columns: 1fr;
        direction: ltr;
      }
    }
  </style>
</head>
<body>
  <div class="container">
    <header>
      <nav>
        <div class="logo">Studio</div>
        <ul class="nav-links">
          <li><a href="#work">Work</a></li>
          <li><a href="#about">About</a></li>
          <li><a href="#contact">Contact</a></li>
        </ul>
      </nav>
    </header>

    <section class="hero">
      <h1 class="hero-title">
        Crafting Digital<br>
        <span class="hero-accent">Experiences</span>
      </h1>
      <p class="hero-subtitle">
        A design studio focused on creating meaningful and memorable interfaces
        that connect people with products they love.
      </p>
    </section>

    <section class="projects">
      <div class="project-grid">
        <article class="project">
          <div class="project-image"></div>
          <div class="project-info">
            <h3>Project One</h3>
            <p>A minimalist approach to e-commerce, focusing on the product and removing all distractions.</p>
            <a href="#" class="project-link">View Project →</a>
          </div>
        </article>

        <article class="project">
          <div class="project-image"></div>
          <div class="project-info">
            <h3>Project Two</h3>
            <p>Reimagining the museum experience through interactive digital installations.</p>
            <a href="#" class="project-link">View Project →</a>
          </div>
        </article>

        <article class="project">
          <div class="project-image"></div>
          <div class="project-info">
            <h3>Project Three</h3>
            <p>A meditation app that uses generative art and ambient sound for relaxation.</p>
            <a href="#" class="project-link">View Project →</a>
          </div>
        </article>
      </div>
    </section>
  </div>
</body>
</html>
```

---

## 例2: マキシマリスト・イベントランディングページ

### デザインコンセプト
- **トーン**: エネルギッシュなマキシマリズム
- **特徴**: ビビッドカラー、複雑なアニメーション、レイヤー効果
- **フォント**: Unbounded（見出し）× Public Sans（本文）
- **カラー**: グラデーションメッシュ + 複数アクセント

### HTML/CSS 実装

```html
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Event 2025</title>
  <link href="https://fonts.googleapis.com/css2?family=Unbounded:wght@400;700;900&family=Public+Sans:wght@400;600&display=swap" rel="stylesheet">
  <style>
    :root {
      --color-bg: #0a0a0a;
      --color-text: #fafafa;
      --color-pink: #ff006e;
      --color-purple: #8338ec;
      --color-blue: #3a86ff;
      --color-yellow: #ffbe0b;
      --font-display: 'Unbounded', sans-serif;
      --font-body: 'Public Sans', sans-serif;
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: var(--font-body);
      background: var(--color-bg);
      color: var(--color-text);
      overflow-x: hidden;
    }

    /* 背景エフェクト */
    .background-gradient {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      z-index: -1;
      opacity: 0.4;
      animation: gradientShift 10s ease infinite;
    }

    @keyframes gradientShift {
      0%, 100% {
        background: radial-gradient(at 20% 30%, var(--color-pink) 0px, transparent 50%),
                    radial-gradient(at 80% 70%, var(--color-purple) 0px, transparent 50%),
                    radial-gradient(at 50% 50%, var(--color-blue) 0px, transparent 50%);
      }
      50% {
        background: radial-gradient(at 80% 30%, var(--color-purple) 0px, transparent 50%),
                    radial-gradient(at 20% 70%, var(--color-blue) 0px, transparent 50%),
                    radial-gradient(at 50% 50%, var(--color-pink) 0px, transparent 50%);
      }
    }

    /* グリッドオーバーレイ */
    .grid-overlay {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-image:
        linear-gradient(rgba(255, 255, 255, 0.03) 1px, transparent 1px),
        linear-gradient(90deg, rgba(255, 255, 255, 0.03) 1px, transparent 1px);
      background-size: 50px 50px;
      z-index: -1;
      animation: gridMove 20s linear infinite;
    }

    @keyframes gridMove {
      0% { transform: translate(0, 0); }
      100% { transform: translate(50px, 50px); }
    }

    .container {
      max-width: 1400px;
      margin: 0 auto;
      padding: 0 2rem;
      position: relative;
    }

    /* ヘッダー */
    header {
      padding: 2rem 0;
      display: flex;
      justify-content: space-between;
      align-items: center;
      animation: slideInDown 0.8s cubic-bezier(0.68, -0.55, 0.265, 1.55);
    }

    .logo {
      font-family: var(--font-display);
      font-size: 1.5rem;
      font-weight: 900;
      background: linear-gradient(135deg, var(--color-pink), var(--color-purple), var(--color-blue));
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
    }

    .cta-button {
      padding: 1rem 2rem;
      background: var(--color-pink);
      color: var(--color-text);
      text-decoration: none;
      font-weight: 600;
      border-radius: 50px;
      position: relative;
      overflow: hidden;
      transition: transform 0.3s ease;
    }

    .cta-button::before {
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

    .cta-button:hover::before {
      width: 300px;
      height: 300px;
    }

    .cta-button:hover {
      transform: scale(1.05);
    }

    /* ヒーロー */
    .hero {
      padding: 8rem 0;
      text-align: center;
      position: relative;
    }

    .hero-title {
      font-family: var(--font-display);
      font-size: clamp(3rem, 10vw, 10rem);
      font-weight: 900;
      line-height: 0.9;
      margin-bottom: 2rem;
      animation: glitchIn 1s cubic-bezier(0.68, -0.55, 0.265, 1.55) 0.3s both;
    }

    .hero-title span {
      display: inline-block;
      animation: float 3s ease-in-out infinite;
    }

    .hero-title span:nth-child(1) {
      color: var(--color-pink);
      animation-delay: 0s;
    }
    .hero-title span:nth-child(2) {
      color: var(--color-purple);
      animation-delay: 0.1s;
    }
    .hero-title span:nth-child(3) {
      color: var(--color-blue);
      animation-delay: 0.2s;
    }
    .hero-title span:nth-child(4) {
      color: var(--color-yellow);
      animation-delay: 0.3s;
    }

    @keyframes float {
      0%, 100% { transform: translateY(0); }
      50% { transform: translateY(-10px); }
    }

    .hero-date {
      font-size: 2rem;
      font-weight: 600;
      margin-bottom: 1rem;
      opacity: 0;
      animation: fadeIn 1s ease 0.8s both;
    }

    .hero-location {
      font-size: 1.25rem;
      color: rgba(250, 250, 250, 0.7);
      margin-bottom: 3rem;
      opacity: 0;
      animation: fadeIn 1s ease 1s both;
    }

    /* フローティング要素 */
    .floating-shapes {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      pointer-events: none;
      overflow: hidden;
    }

    .shape {
      position: absolute;
      opacity: 0.6;
      animation: floatAround 20s infinite ease-in-out;
    }

    .shape:nth-child(1) {
      width: 100px;
      height: 100px;
      background: var(--color-pink);
      border-radius: 50%;
      top: 20%;
      left: 10%;
      animation-delay: 0s;
    }

    .shape:nth-child(2) {
      width: 150px;
      height: 150px;
      background: var(--color-blue);
      border-radius: 30%;
      top: 60%;
      left: 70%;
      animation-delay: 2s;
    }

    .shape:nth-child(3) {
      width: 80px;
      height: 80px;
      background: var(--color-yellow);
      transform: rotate(45deg);
      top: 40%;
      left: 80%;
      animation-delay: 4s;
    }

    @keyframes floatAround {
      0%, 100% { transform: translate(0, 0) rotate(0deg); }
      25% { transform: translate(20px, -20px) rotate(90deg); }
      50% { transform: translate(-20px, 20px) rotate(180deg); }
      75% { transform: translate(20px, 20px) rotate(270deg); }
    }

    /* 情報セクション */
    .info-grid {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 2rem;
      padding: 4rem 0;
    }

    .info-card {
      background: rgba(255, 255, 255, 0.05);
      backdrop-filter: blur(10px);
      padding: 3rem 2rem;
      border-radius: 20px;
      border: 2px solid rgba(255, 255, 255, 0.1);
      transition: all 0.3s ease;
      animation: slideInUp 0.8s ease both;
    }

    .info-card:nth-child(1) { animation-delay: 0.2s; border-color: var(--color-pink); }
    .info-card:nth-child(2) { animation-delay: 0.4s; border-color: var(--color-purple); }
    .info-card:nth-child(3) { animation-delay: 0.6s; border-color: var(--color-blue); }

    .info-card:hover {
      transform: translateY(-10px) rotate(2deg);
      box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
    }

    .info-card h3 {
      font-family: var(--font-display);
      font-size: 2rem;
      margin-bottom: 1rem;
    }

    /* アニメーション */
    @keyframes slideInDown {
      from {
        opacity: 0;
        transform: translateY(-50px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    @keyframes slideInUp {
      from {
        opacity: 0;
        transform: translateY(50px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    @keyframes glitchIn {
      0% {
        opacity: 0;
        transform: scale(0.8) skew(5deg);
      }
      100% {
        opacity: 1;
        transform: scale(1) skew(0deg);
      }
    }

    @keyframes fadeIn {
      from { opacity: 0; }
      to { opacity: 1; }
    }

    /* レスポンシブ */
    @media (max-width: 768px) {
      .info-grid {
        grid-template-columns: 1fr;
      }

      .hero {
        padding: 4rem 0;
      }
    }
  </style>
</head>
<body>
  <div class="background-gradient"></div>
  <div class="grid-overlay"></div>

  <div class="container">
    <header>
      <div class="logo">FEST 2025</div>
      <a href="#" class="cta-button">チケット購入</a>
    </header>

    <section class="hero">
      <div class="floating-shapes">
        <div class="shape"></div>
        <div class="shape"></div>
        <div class="shape"></div>
      </div>

      <h1 class="hero-title">
        <span>M</span><span>U</span><span>S</span><span>I</span><span>C</span>
      </h1>
      <div class="hero-date">2025年8月15-16日</div>
      <div class="hero-location">東京ビッグサイト</div>
      <a href="#" class="cta-button">今すぐ参加</a>
    </section>

    <section class="info-grid">
      <div class="info-card">
        <h3>50+ Artists</h3>
        <p>世界中から集結したトップアーティストによる圧倒的なパフォーマンス</p>
      </div>
      <div class="info-card">
        <h3>3 Stages</h3>
        <p>メインステージ、アンビエント、アンダーグラウンドの3つのステージ</p>
      </div>
      <div class="info-card">
        <h3>24 Hours</h3>
        <p>昼夜を問わず続く音楽と光の祭典</p>
      </div>
    </section>
  </div>
</body>
</html>
```

---

## 例3: ブルータリスト・デザインスタジオ

### デザインコンセプト
- **トーン**: 生々しいブルータリズム
- **特徴**: 粗い要素、タイポグラフィの実験、機能重視
- **フォント**: Courier New（モノスペース）× Arial（本文）
- **カラー**: 黒＋白＋赤アクセント

### HTML/CSS 実装

```html
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>STUDIO//RAW</title>
  <style>
    :root {
      --color-bg: #ffffff;
      --color-text: #000000;
      --color-accent: #ff0000;
      --font-mono: 'Courier New', monospace;
      --font-sans: Arial, sans-serif;
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: var(--font-sans);
      background: var(--color-bg);
      color: var(--color-text);
      line-height: 1.4;
      cursor: crosshair;
    }

    /* グリッド背景 */
    body::before {
      content: '';
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-image:
        linear-gradient(#000 1px, transparent 1px),
        linear-gradient(90deg, #000 1px, transparent 1px);
      background-size: 20px 20px;
      opacity: 0.05;
      z-index: -1;
    }

    .container {
      max-width: 1200px;
      margin: 0 auto;
      padding: 2rem;
    }

    /* ヘッダー */
    header {
      border: 3px solid var(--color-text);
      padding: 2rem;
      margin-bottom: 3rem;
      position: relative;
    }

    header::after {
      content: '[ACTIVE]';
      position: absolute;
      top: -12px;
      right: 20px;
      background: var(--color-bg);
      padding: 0 10px;
      font-family: var(--font-mono);
      font-size: 0.75rem;
      color: var(--color-accent);
    }

    .logo {
      font-family: var(--font-mono);
      font-size: 2rem;
      font-weight: bold;
      letter-spacing: 0.1em;
      text-transform: uppercase;
    }

    nav {
      margin-top: 1rem;
      display: flex;
      gap: 2rem;
    }

    nav a {
      color: var(--color-text);
      text-decoration: none;
      font-family: var(--font-mono);
      font-size: 0.875rem;
      text-transform: uppercase;
      border-bottom: 2px solid transparent;
      transition: border-color 0.2s;
    }

    nav a:hover {
      border-bottom-color: var(--color-accent);
    }

    /* メインコンテンツ */
    .hero {
      margin-bottom: 4rem;
    }

    .hero-title {
      font-family: var(--font-mono);
      font-size: clamp(2rem, 6vw, 6rem);
      line-height: 1;
      margin-bottom: 2rem;
      text-transform: uppercase;
      position: relative;
    }

    .hero-title::before {
      content: '>';
      color: var(--color-accent);
      margin-right: 1rem;
    }

    .hero-description {
      font-size: 1.125rem;
      max-width: 600px;
      border-left: 3px solid var(--color-accent);
      padding-left: 2rem;
      margin-bottom: 2rem;
    }

    .stats {
      display: flex;
      gap: 3rem;
      margin-top: 3rem;
    }

    .stat {
      border: 2px solid var(--color-text);
      padding: 1.5rem;
      min-width: 150px;
      position: relative;
    }

    .stat::before {
      content: attr(data-label);
      position: absolute;
      top: -12px;
      left: 10px;
      background: var(--color-bg);
      padding: 0 10px;
      font-family: var(--font-mono);
      font-size: 0.75rem;
    }

    .stat-value {
      font-family: var(--font-mono);
      font-size: 3rem;
      font-weight: bold;
      line-height: 1;
    }

    /* プロジェクトリスト */
    .projects {
      margin-top: 4rem;
    }

    .section-title {
      font-family: var(--font-mono);
      font-size: 1.5rem;
      text-transform: uppercase;
      margin-bottom: 2rem;
      padding-bottom: 0.5rem;
      border-bottom: 3px solid var(--color-text);
    }

    .project-list {
      list-style: none;
    }

    .project-item {
      border: 2px solid var(--color-text);
      margin-bottom: 1rem;
      transition: all 0.2s;
    }

    .project-item:hover {
      background: var(--color-text);
      color: var(--color-bg);
      transform: translateX(10px);
    }

    .project-link {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 2rem;
      color: inherit;
      text-decoration: none;
    }

    .project-name {
      font-family: var(--font-mono);
      font-size: 1.5rem;
      text-transform: uppercase;
    }

    .project-year {
      font-family: var(--font-mono);
      font-size: 1rem;
    }

    /* マーキー */
    .marquee {
      margin: 4rem 0;
      border-top: 3px solid var(--color-text);
      border-bottom: 3px solid var(--color-text);
      padding: 1rem 0;
      overflow: hidden;
      position: relative;
    }

    .marquee-content {
      display: flex;
      animation: marquee 20s linear infinite;
      white-space: nowrap;
    }

    .marquee-text {
      font-family: var(--font-mono);
      font-size: 2rem;
      text-transform: uppercase;
      padding: 0 2rem;
    }

    @keyframes marquee {
      0% { transform: translateX(0); }
      100% { transform: translateX(-50%); }
    }

    /* レスポンシブ */
    @media (max-width: 768px) {
      .stats {
        flex-direction: column;
        gap: 1rem;
      }

      .stat {
        min-width: auto;
      }

      nav {
        flex-direction: column;
        gap: 0.5rem;
      }
    }
  </style>
</head>
<body>
  <div class="container">
    <header>
      <div class="logo">STUDIO//RAW</div>
      <nav>
        <a href="#">[WORK]</a>
        <a href="#">[ABOUT]</a>
        <a href="#">[CONTACT]</a>
      </nav>
    </header>

    <section class="hero">
      <h1 class="hero-title">
        WE BUILD<br>
        RAW DIGITAL<br>
        PRODUCTS
      </h1>
      <p class="hero-description">
        無駄を削ぎ落とし、機能と美学の本質に迫る。
        ブルータルでありながら機能的、シンプルでありながら強力なデジタル体験を創造します。
      </p>

      <div class="stats">
        <div class="stat" data-label="PROJECTS">
          <div class="stat-value">47</div>
        </div>
        <div class="stat" data-label="CLIENTS">
          <div class="stat-value">23</div>
        </div>
        <div class="stat" data-label="YEARS">
          <div class="stat-value">08</div>
        </div>
      </div>
    </section>

    <div class="marquee">
      <div class="marquee-content">
        <span class="marquee-text">— DESIGN • DEVELOP • DEPLOY —</span>
        <span class="marquee-text">— DESIGN • DEVELOP • DEPLOY —</span>
        <span class="marquee-text">— DESIGN • DEVELOP • DEPLOY —</span>
      </div>
    </div>

    <section class="projects">
      <h2 class="section-title">[SELECTED WORK]</h2>
      <ul class="project-list">
        <li class="project-item">
          <a href="#" class="project-link">
            <span class="project-name">E-COMMERCE PLATFORM</span>
            <span class="project-year">[2024]</span>
          </a>
        </li>
        <li class="project-item">
          <a href="#" class="project-link">
            <span class="project-name">BRAND IDENTITY SYSTEM</span>
            <span class="project-year">[2024]</span>
          </a>
        </li>
        <li class="project-item">
          <a href="#" class="project-link">
            <span class="project-name">DATA VISUALIZATION TOOL</span>
            <span class="project-year">[2023]</span>
          </a>
        </li>
        <li class="project-item">
          <a href="#" class="project-link">
            <span class="project-name">MOBILE APPLICATION</span>
            <span class="project-year">[2023]</span>
          </a>
        </li>
      </ul>
    </section>
  </div>
</body>
</html>
```

---

## React コンポーネント例

### Framer Motion を使用したアニメーションカード

```jsx
import { motion } from 'framer-motion';
import { useState } from 'react';

const AnimatedCard = ({ title, description, image }) => {
  const [isHovered, setIsHovered] = useState(false);

  return (
    <motion.div
      className="card"
      initial={{ opacity: 0, y: 50 }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true }}
      transition={{ duration: 0.6, ease: [0.65, 0, 0.35, 1] }}
      onHoverStart={() => setIsHovered(true)}
      onHoverEnd={() => setIsHovered(false)}
      style={{
        position: 'relative',
        overflow: 'hidden',
        borderRadius: '12px',
        cursor: 'pointer'
      }}
    >
      <motion.div
        className="card-image"
        animate={{
          scale: isHovered ? 1.1 : 1,
          filter: isHovered ? 'brightness(0.7)' : 'brightness(1)'
        }}
        transition={{ duration: 0.4 }}
      >
        <img src={image} alt={title} />
      </motion.div>

      <motion.div
        className="card-content"
        animate={{
          y: isHovered ? -20 : 0
        }}
        transition={{ duration: 0.3 }}
      >
        <h3>{title}</h3>
        <motion.p
          initial={{ opacity: 0, height: 0 }}
          animate={{
            opacity: isHovered ? 1 : 0,
            height: isHovered ? 'auto' : 0
          }}
          transition={{ duration: 0.3 }}
        >
          {description}
        </motion.p>
      </motion.div>

      <motion.div
        className="card-overlay"
        initial={{ scaleX: 0 }}
        animate={{ scaleX: isHovered ? 1 : 0 }}
        transition={{ duration: 0.4 }}
        style={{
          position: 'absolute',
          top: 0,
          left: 0,
          width: '100%',
          height: '100%',
          background: 'linear-gradient(135deg, #ff006e, #8338ec)',
          transformOrigin: 'left',
          opacity: 0.3
        }}
      />
    </motion.div>
  );
};

export default AnimatedCard;
```

### スタガーアニメーションリスト

```jsx
import { motion } from 'framer-motion';

const containerVariants = {
  hidden: { opacity: 0 },
  show: {
    opacity: 1,
    transition: {
      staggerChildren: 0.1,
      delayChildren: 0.3
    }
  }
};

const itemVariants = {
  hidden: { opacity: 0, x: -20 },
  show: {
    opacity: 1,
    x: 0,
    transition: {
      duration: 0.5,
      ease: [0.65, 0, 0.35, 1]
    }
  }
};

const StaggeredList = ({ items }) => {
  return (
    <motion.ul
      variants={containerVariants}
      initial="hidden"
      animate="show"
      style={{
        listStyle: 'none',
        padding: 0
      }}
    >
      {items.map((item, index) => (
        <motion.li
          key={index}
          variants={itemVariants}
          whileHover={{
            x: 10,
            transition: { duration: 0.2 }
          }}
          style={{
            padding: '1rem',
            marginBottom: '0.5rem',
            background: 'rgba(255, 255, 255, 0.05)',
            borderRadius: '8px',
            cursor: 'pointer'
          }}
        >
          {item}
        </motion.li>
      ))}
    </motion.ul>
  );
};

export default StaggeredList;
```

### スクロールトリガーアニメーション

```jsx
import { motion, useScroll, useTransform } from 'framer-motion';
import { useRef } from 'react';

const ParallaxSection = ({ children }) => {
  const ref = useRef(null);
  const { scrollYProgress } = useScroll({
    target: ref,
    offset: ['start end', 'end start']
  });

  const y = useTransform(scrollYProgress, [0, 1], [100, -100]);
  const opacity = useTransform(scrollYProgress, [0, 0.3, 0.7, 1], [0, 1, 1, 0]);
  const scale = useTransform(scrollYProgress, [0, 0.5, 1], [0.8, 1, 0.8]);

  return (
    <motion.div
      ref={ref}
      style={{
        y,
        opacity,
        scale,
        minHeight: '100vh',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center'
      }}
    >
      {children}
    </motion.div>
  );
};

export default ParallaxSection;
```

---

## 使用時のヒント

1. **デザインコンセプトを明確に**: 実装前に美的方向性を決定
2. **一貫性を保つ**: CSS変数を使用してデザイントークンを管理
3. **パフォーマンスを考慮**: `will-change`や`transform`を使用してGPUアクセラレーションを活用
4. **レスポンシブ対応**: モバイルファーストアプローチで実装
5. **アクセシビリティ**: `prefers-reduced-motion`などのユーザー設定を尊重

これらの例を参考に、プロジェクトのコンテキストに合わせてカスタマイズしてください。
