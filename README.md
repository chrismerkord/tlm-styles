# TLM Styles (SCSS)

Shared SCSS for consistent styling across Teaching & Learning Materials:

-   Websites (Quarto HTML)
-   Reveal.js presentations
-   HTML handouts

## Repository Layout

```         
_core.scss                 # base elements, utilities
_mixins.scss               # reusable mixins
_print.scss                # print rules for HTML→PDF
_variables.scss            # colors, typography, spacing tokens
handouts.scss
presentations.scss
websites.scss
styles.scss                # single entrypoint that uses/forwards the above
tests/                     # minimal .qmd files for verifying styles
  handout-test.qmd
  presentations-test.qmd
  website-test.qmd
LICENSE
README.md
```

## Adding the submodule (first time only)

-   Do this once in each course repository where you want to use the shared styles. Open the **course repo** in RStudio, then in the **Terminal** tab run:

    ```         
    git submodule add https://github.com/chrismerkord/tlm-styles.git tlm-styles
    ```

-   Then stage and commit the changes to `.gitmodules` and the submodule pointer using the **Git** tab.

## Initializing after cloning a repo with submodules

-   When you (or anyone else) clone a course repo that already contains the `tlm-styles` submodule, run this once in the **Terminal** tab before using the repo:

    ```         
    git submodule update --init --recursive
    ```

-   This pulls down the actual submodule contents into the `tlm-styles` folder. Without this step, the folder will exist but be empty.

## Updating the submodule to the latest styles

-   Whenever you want to bring in new commits from `tlm-styles` (for example, after you update the style repo itself), run:

    ```         
    git submodule update --remote --merge tlm-styles
    ```

-   Then stage and commit the updated submodule pointer with the **Git** tab.

## SCSS Usage Guide

This repo follows a modular SCSS structure. Each file has a specific purpose:

-   **`_variables.scss`**\
    Define design tokens only:

    -   Colors (`--brand-blue`, `--accent-green`)
    -   Font stacks (`$body-font`, `$heading-font`)
    -   Spacing scale (`$space-sm`, `$space-lg`)
    -   Breakpoints, z-index layers, etc.

    No selectors or styles here—just reusable values.

-   **`_mixins.scss`**\
    Define reusable patterns:

    -   Media query helpers
    -   Functions for color manipulation
    -   Utility mixins (clearfix, text truncation, etc.)

    Keep logic here, not raw styles.

-   **`_core.scss`**\
    Base element resets and defaults:

    -   Normalize for `html`, `body`, `p`, `h1–h6`, `a`, `ul/ol`, `table`
    -   Global rules (font-size, line-height, default link color)
    -   Utility classes that apply site-wide (`.hidden`, `.no-print`, etc.)

-   **Main document type files** (`websites.scss`, `handouts.scss`, `revealjs-presentations.scss`)\
    Build on top of core, variables, and mixins:

    -   Layout rules (max widths, margins)
    -   Component styling (callouts, navbars, figures)
    -   Context-specific overrides (print rules in handouts, slide scaling in presentations)

    These files should always start with:

    ``` scss
    @use "./variables" as *;
    @use "./mixins" as *;
    @use "./core";
    ```

-   **`styles.scss`**

    -   The single entrypoint. This pulls together variables, mixins, core, and each main document type. Quarto points to this file.

-   **Rule of thumb:**

    -   *Tokens* go in `_variables.scss`

    -   *Logic* goes in `_mixins.scss`

    -   *Defaults* go in `_core.scss`

    -   *Actual design decisions per output type* go in the main files (`websites.scss`, `handouts.scss`, `revealjs-presentations.scss`)

## Brand Integration

Quarto supports a `_brand.yml` file placed in the root of each course repository. This file declares high-level design tokens such as font families and color palette. It is the correct place to define which Adobe Fonts to use (e.g., Source Serif 4 for body, Source Sans 3 for headings, Source Code Pro for code) and base colors (text, background, accents).

The `tlm-styles` SCSS repo does not hard-code fonts or brand colors. Instead, it provides the layout, spacing, and component styling that apply consistently across all outputs. When Quarto renders, values from `_brand.yml` flow into the SCSS tokens (`$body-font`, `$heading-font`, `$code-font`, `$brand-*` colors) so each course can customize its branding while still benefiting from the shared styling system.

In practice:

-   Add `_brand.yml` to each course repo alongside `_quarto.yml`.
-   Configure fonts and colors in `_brand.yml`.
-   Keep structure, spacing, and component rules in `tlm-styles`.

This separation ensures that shared SCSS logic is reusable across courses, while branding can be customized per course.

## Quarto Integration

-   **Website** (`_quarto.yml`):

    ``` yaml
    format:
      html:
        css: tlm-styles/styles.scss
    ```

-   **Reveal.js** (`.qmd`):

    ``` yaml
    format:
      revealjs:
        css: tlm-styles/styles.scss
        pdf: true
    ```

-   **HTML Docs** (`.qmd`):

    ``` yaml
    format:
      html:
        css: tlm-styles/styles.scss
    ```

Export to PDF via the browser with **Background graphics** enabled. The shared `_print.scss` controls pagination and print layout.

> Note: SCSS affects HTML-based outputs. For native DOCX or LaTeX-PDF, use `reference.docx` and LaTeX templates respectively.

## HTML → PDF Guidance

-   Pagination and margins come from `_print.scss` (`@page` and `@media print`).
-   Use utility classes in your QMD body:
    -   `<div class="page-break"></div>` to force a new page.
    -   Add `class: handout` to the top-level document container if you want the handout width rules.
-   In Chrome/Edge Print dialog: enable **Background graphics**, set **Scale 100%**, choose **Margins: Default** (or Custom if `_print.scss` margins differ).

## Conventions

-   Import order: `variables` → `mixins` → `core` → targets → `_print.scss`.
-   Only reference tokens defined in `_variables.scss` inside targets.
-   Do not commit licensed font files. Use system fonts or licensed hosting.

## Testing the Styles

A `tests/` folder contains minimal Quarto files for each output type (website, handout, presentation). These are for verifying that the SCSS compiles correctly and styles render as expected.

### Run the tests in RStudio

1.  In the **Files** pane, open one of the test files (e.g., `tests/website-test.qmd`).
2.  Click the **Render** button at the top of the editor.
3.  If the output opens in the RStudio Viewer pane, click the **Show in new window** button to expand it in your default web browser.

### What to check

-   **Website test** → look at headings, tables, callouts, etc. in the browser.
-   **Handout test** → open in the browser, then go to **Print → Save as PDF**. Make sure **Background graphics** is enabled so styles are preserved. Check margins, page breaks, and print layout from `_print.scss`.
-   **Presentations test** → check slide formatting in the browser. Use **Print → Save as PDF** to verify PDF export matches slide design.

### Notes

-   Only the `.qmd` sources are versioned. Rendered `.html` and `.pdf` files in `tests/` are ignored by `.gitignore`.
-   Update these tests when you add new style tokens or major structural changes to ensure consistency across outputs.

## License

MIT. See `LICENSE`.
