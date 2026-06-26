# Report Generator Skill

`report-generator` is a Codex Skill for turning business data, management notes, and background documents into a confirmed report workflow:

```text
data and materials
-> data_insights.md
-> report.md
-> visual HTML report
-> shareable flat ZIP
```

It is designed for management reporting scenarios such as data insight reports, operations reviews, leadership reviews, monthly reports, quarterly reports, half-year reviews, and year-end summaries.

## What This Skill Does

- Reads data files, business context, management notes, and review materials.
- Asks clarification questions before analysis when terms, metrics, scope, or data versions may affect the result.
- Produces a structured `data_insights.md`.
- Combines confirmed data insights with management documents to produce `report.md`.
- Converts the confirmed report into a polished HTML report.
- Uses the fixed 51Talk logo in `assets/logo.png` by default.
- Requires image generation when the report design needs generated backgrounds, transparent PNG stickers, or visual accents.
- Validates data consistency, wording suitability, layout readability, and local asset references.
- Packages the final result as a flat ZIP so recipients can unzip and directly open the HTML file.

## Three-Agent Workflow

### 1. Data Insight Agent

Creates `data_insights.md` from uploaded data and background materials.

It does not force every report to use the same dimensions. Instead, it confirms the user's role, report goal, data scope, terminology, and required metrics before deciding what to analyze.

### 2. Manager Report Agent

Creates `report.md` from confirmed data insights, management notes, reflection documents, and business background.

It does not force a fixed report structure. It first confirms the report flow, audience, tone, and boundaries, then turns the materials into a management-ready report.

### 3. HTML Report Designer Agent

Creates the final HTML report from the confirmed `report.md`.

It confirms visual direction before design, checks whether image generation is available, creates local visual assets when needed, and packages the final report for sharing.

## Skill Structure

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

## Installation

Install this repository as a Codex Skill from:

```text
https://github.com/TedTie/report_analysis_to_html
```

If installing manually, place the repository folder under your Codex skills directory so that `SKILL.md` is at the skill root.

## Example Prompts

```text
Use $report-generator to analyze these sales data files and management notes. Do not generate the final report until you have asked me about unclear terms and data scope.
```

```text
Use $report-generator to create a quarterly operations review. First produce data_insights.md, then wait for my confirmation before writing report.md.
```

```text
Use $report-generator to turn my confirmed report.md into a visual HTML report. Ask me about visual style before designing.
```

## Image Generation Requirement

The HTML report design phase expects image generation to be available when generated visual assets are needed.

- Transparent stickers must be generated as transparent-background PNG files.
- Generated assets should be saved under `assets/generated/`.
- The HTML report must reference local assets.
- If image generation is unavailable, the Skill should stop and ask the user to enable or install it, unless the user explicitly approves a no-imagegen fallback.

## Output Artifacts

Default output files:

```text
data_insights.md
report.md
report.html
assets/
report_final.zip
```

The final ZIP should be flat:

```text
report.html
assets/
```

This allows recipients to unzip the package and open the HTML file directly.

## Design Philosophy

This Skill does not copy one fixed report template. It preserves a reusable workflow:

```text
clarify -> analyze -> confirm -> write -> confirm -> design -> validate -> package
```

The goal is to help different managers, sales leaders, operations teams, and review owners create reports that are accurate, readable, visually polished, and grounded in their actual data and management context.
