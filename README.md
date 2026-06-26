# Report Generator Skill / 报告生成器 Skill

`report-generator` is a Codex Skill for turning business data, management notes, and background documents into a confirmed report workflow.

`report-generator` 是一个 Codex Skill，用于把业务数据、管理动作文档、背景资料和复盘材料，整理成数据洞察、正式报告，并进一步制作成可分享的 HTML 可视化报告。

```text
data and materials / 数据与资料
-> data_insights.md / 数据洞察.md
-> report.md / 报告.md
-> visual HTML report / 可视化 HTML 报告
-> shareable flat ZIP / 可直接打开的分享压缩包
```

It is designed for management reporting scenarios such as data insight reports, operations reviews, leadership reviews, monthly reports, quarterly reports, half-year reviews, and year-end summaries.

适用场景包括：数据洞察报告、运营复盘、管理述职、月报、季报、半年总结、年终总结，以及需要转换成 HTML 的可视化报告。

## What This Skill Does / 这个 Skill 能做什么

- Reads data files, business context, management notes, and review materials.
- 读取数据文件、业务背景、管理动作文档和复盘材料。

- Asks clarification questions before analysis when terms, metrics, scope, or data versions may affect the result.
- 当业务词汇、指标口径、分析范围或数据版本可能影响结果时，先提问确认，再继续分析。

- Produces a structured `data_insights.md`.
- 输出结构化的 `data_insights.md` / `数据洞察.md`。

- Combines confirmed data insights with management documents to produce `report.md`.
- 结合已确认的数据洞察和管理文档，输出 `report.md` / `报告.md`。

- Converts the confirmed report into a polished HTML report.
- 将确认后的报告转换成排版清晰、适合分享的 HTML 报告。

- Uses the fixed 51Talk logo in `assets/logo.png` by default.
- 默认使用 `assets/logo.png` 中的 51Talk logo。

- Requires image generation when the report design needs generated backgrounds, transparent PNG stickers, or visual accents.
- 当报告设计需要生成背景图、透明 PNG 贴纸或视觉点缀时，要求当前环境可使用 image generation。

- Validates data consistency, wording suitability, layout readability, and local asset references.
- 检查数据一致性、文案正式度、排版可读性和本地资源引用是否完整。

- Packages the final result as a flat ZIP so recipients can unzip and directly open the HTML file.
- 最终打包为扁平结构 zip，接收者解压后可以直接双击 HTML 打开。

## Three-Agent Workflow / 三 Agent 工作流程

### 1. Data Insight Agent / 数据洞察 Agent

Creates `data_insights.md` from uploaded data and background materials.

根据上传的数据和背景资料，生成 `data_insights.md` / `数据洞察.md`。

It does not force every report to use the same dimensions. Instead, it confirms the user's role, report goal, data scope, terminology, and required metrics before deciding what to analyze.

它不会强制每份报告都使用同一套分析维度，而是先确认使用者身份、报告目标、数据范围、业务词汇和需要关注的指标，再决定如何分析。

### 2. Manager Report Agent / 管理者报告 Agent

Creates `report.md` from confirmed data insights, management notes, reflection documents, and business background.

根据已确认的数据洞察、管理动作文档、复盘材料和业务背景，生成 `report.md` / `报告.md`。

It does not force a fixed report structure. It first confirms the report flow, audience, tone, and boundaries, then turns the materials into a management-ready report.

它不会强制固定报告结构，而是先确认报告流程、汇报对象、表达口吻和内容边界，再整理成适合管理汇报的报告。

### 3. HTML Report Designer Agent / HTML 报告设计师 Agent

Creates the final HTML report from the confirmed `report.md`.

根据已确认的 `report.md` / `报告.md` 制作最终 HTML 报告。

It confirms visual direction before design, checks whether image generation is available, creates local visual assets when needed, and packages the final report for sharing.

它会先确认视觉方向，再检查 image generation 是否可用；如有需要，会生成本地视觉素材，并最终打包成可分享文件。

## Skill Structure / Skill 文件结构

```text
report_analysis_to_html/
├─ SKILL.md
├─ README.md
├─ agents/
│  ├─ data-insight-agent.md
│  ├─ manager-report-agent.md
│  ├─ html-report-designer-agent.md
│  └─ openai.yaml
├─ references/
│  ├─ company-background.md
│  ├─ terminology-confirmation.md
│  ├─ quality-checklist.md
│  └─ pitfalls.md
├─ assets/
│  └─ logo.png
└─ scripts/
   ├─ package_flat_html.ps1
   └─ validate_report_assets.ps1
```

## Installation / 安装方式

Install this repository as a Codex Skill from:

可以从以下 GitHub 仓库安装为 Codex Skill：

```text
https://github.com/TedTie/report_analysis_to_html
```

If installing manually, place the repository folder under your Codex skills directory so that `SKILL.md` is at the skill root.

如果手动安装，请将整个仓库文件夹放到 Codex skills 目录中，并确保 `SKILL.md` 位于 Skill 根目录。

## Example Prompts / 使用示例

```text
Use $report-generator to analyze these sales data files and management notes. Do not generate the final report until you have asked me about unclear terms and data scope.
```

```text
使用 $report-generator 帮我分析这些销售数据和管理动作文档。先问我不清楚的业务词和数据口径，不要直接生成最终报告。
```

```text
Use $report-generator to create a quarterly operations review. First produce data_insights.md, then wait for my confirmation before writing report.md.
```

```text
使用 $report-generator 做一份季度运营复盘。先输出 数据洞察.md，等我确认后再写 报告.md。
```

```text
Use $report-generator to turn my confirmed report.md into a visual HTML report. Ask me about visual style before designing.
```

```text
使用 $report-generator 把我确认后的 报告.md 转成 HTML 可视化报告。设计前先问我想要什么视觉风格。
```

## Image Generation Requirement / Image Generation 要求

The HTML report design phase expects image generation to be available when generated visual assets are needed.

当 HTML 报告需要生成背景图、透明贴纸或视觉素材时，需要当前环境可使用 image generation。

- Transparent stickers must be generated as transparent-background PNG files.
- 透明贴纸必须生成为透明背景 PNG。

- Generated assets should be saved under `assets/generated/`.
- 生成素材应保存到 `assets/generated/`。

- The HTML report must reference local assets.
- HTML 报告必须引用本地资源。

- If image generation is unavailable, the Skill should stop and ask the user to enable or install it, unless the user explicitly approves a no-imagegen fallback.
- 如果 image generation 不可用，Skill 应暂停并提示使用者启用或安装；除非使用者明确同意，否则不应自动降级为无 imagegen 版本。

## Output Artifacts / 输出文件

Default output files:

默认输出文件：

```text
data_insights.md / 数据洞察.md
report.md / 报告.md
report.html
assets/
report_final.zip
```

The final ZIP should be flat:

最终 zip 应使用扁平结构：

```text
report.html
assets/
```

This allows recipients to unzip the package and open the HTML file directly.

这样接收者解压后可以直接双击 HTML 文件打开，不需要进入多层文件夹寻找。

## Design Philosophy / 设计理念

This Skill does not copy one fixed report template. It preserves a reusable workflow:

这个 Skill 不复制某一个固定报告模板，而是保留一套可复用的报告生产流程：

```text
clarify -> analyze -> confirm -> write -> confirm -> design -> validate -> package
确认问题 -> 分析数据 -> 用户确认 -> 撰写报告 -> 用户确认 -> 设计HTML -> 校验 -> 打包
```

The goal is to help different managers, sales leaders, operations teams, and review owners create reports that are accurate, readable, visually polished, and grounded in their actual data and management context.

目标是帮助不同管理者、销售负责人、运营团队和复盘负责人，制作准确、清晰、视觉专业，并且真正基于数据和管理背景的报告。
