---
name: report-generator
description: Build management reports from business data, background documents, and management notes, then convert confirmed report content into a shareable HTML report. Use when the user wants a data insight report, operations review, leadership review, monthly/quarterly/half-year/year-end report, or HTML visual report, especially when the workflow should include clarification of terminology and data scope, generation of data_insights.md, generation of report.md, visual HTML design, asset validation, and flat ZIP packaging.
---

# Report Generator

Use this skill to turn uploaded data, business background, management notes, and review materials into a confirmed report workflow:

```text
materials -> clarification -> data_insights.md -> confirmed report.md -> HTML report -> validated flat ZIP
```

The skill does not impose a fixed report template, fixed data dimensions, or fixed visual style. It imposes a disciplined workflow: understand context, confirm ambiguity, generate, validate, and only then package.

## Load Order

Read only the files needed for the current phase:

- Data analysis phase: read `agents/data-insight-agent.md`, `references/company-background.md`, `references/terminology-confirmation.md`, and `references/quality-checklist.md`.
- Report writing phase: read `agents/manager-report-agent.md`, `references/company-background.md`, `references/terminology-confirmation.md`, `references/quality-checklist.md`, and `references/pitfalls.md`.
- HTML design phase: read `agents/html-report-designer-agent.md`, `references/quality-checklist.md`, and `references/pitfalls.md`.
- Packaging phase: use `scripts/package_flat_html.ps1` and, when needed, `scripts/validate_report_assets.ps1`.

If multi-agent tools are available, the three phase files can be assigned to separate agents. If multi-agent tools are unavailable, execute the phases sequentially in the main agent while following the same phase boundaries.

## Required Workflow

1. Identify the report scenario: report type, user role, audience, time range, and expected output.
2. Read the available source materials and company/job background.
3. Before generating final content, produce a clarification list for ambiguous terminology, data scope, missing files, special cases, and requested structure.
4. Wait for user confirmation when ambiguity could change analysis, wording, or management judgment.
5. Generate `data_insights.md` only after data scope and terminology are sufficiently clear.
6. Generate `report.md` only after the user confirms the desired report flow and tone.
7. Generate HTML only after `report.md` is confirmed.
8. Before HTML design, verify that image generation is available. Image generation is required for visual sticker/background creation; if unavailable, stop and ask the user to enable or install it unless the user explicitly approves a no-imagegen fallback.
9. Validate data consistency, wording suitability, layout readability, local assets, and packaging before final delivery.
10. Package the final HTML as a flat ZIP: the HTML file must be at the ZIP root beside `assets/`, so recipients can unzip and open the HTML directly.

## Fixed Brand Asset

Use `assets/logo.png` as the default 51Talk brand logo when no other logo is supplied. Do not alter the logo.

## Phase Outputs

Default artifact names:

```text
data_insights.md
report.md
report.html
assets/
report_final.zip
```

Use the user's preferred filenames if specified.

## Image Generation Requirement

The HTML report designer phase requires image generation when the design calls for generated backgrounds, stickers, cover art, or visual accents.

- Check whether image generation is available before beginning visual production.
- If available, generated stickers must be transparent-background PNG files.
- Generated images must be saved under `assets/generated/`.
- HTML must reference local generated assets, not external links.
- If image generation is unavailable, stop and ask the user to enable or install it. Do not silently downgrade to CSS-only visuals unless the user explicitly approves.

## Final Validation

Before claiming completion, apply the relevant checklist in `references/quality-checklist.md`.

For final ZIP delivery, ensure:

- HTML opens from the ZIP root after extraction.
- All referenced local assets are included.
- No external images, fonts, scripts, or CDN dependencies are required unless the user explicitly requested them.
- No internal production notes remain in the report.
- The HTML reflects the confirmed `report.md` and does not add unconfirmed claims.
