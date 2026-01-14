# TLM Styles (SCSS)

Shared SCSS for consistent styling across Teaching & Learning Materials. This repo is designed to be used as a **git submodule** in course repositories and layered into Quarto’s theming pipeline.

Supported outputs:

-   Quarto websites (HTML)
-   Reveal.js presentations
-   HTML handouts / browser-based PDFs

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

## Undoing Accidental Edits in a Submodule (Course Repos)

**When to do this**

-   You accidentally edited files inside `tlm-styles/` while working in a course repository.
-   You have not committed or pushed those changes.
-   All edits to shared styles should be made in the `tlm-styles` repo itself, not in course repos.

**How to undo the edits**

From the **course repository** (e.g. `biol-275`) in RStudio, open the **Terminal** tab and run:

``` bash
git -C tlm-styles restore .
git -C tlm-styles clean -fd
```

## Quarto Integration

### Theme order (course repos)

Brand tokens are layered automatically when `brand:` is set in `_quarto.yml`, so **do not** list `brand` in the theme list. A typical course repo theme order is:

1. `default`
2. `tlm-styles/tlm-theme.scss`
3. `styles.scss` (course-specific overrides)

### Website (`_quarto.yml`)

``` yaml
brand: _brand.yml

format:
  html:
    theme:
      - default
      - tlm-styles/tlm-theme.scss
      - styles.scss
    include-in-header:
      - text: |
          <link rel="stylesheet" href="https://use.typekit.net/tag1lvz.css">
```

### Reveal.js (`.qmd`)

``` yaml
format:
  revealjs:
    theme:
      - default
      - tlm-styles/tlm-theme.scss
      - styles.scss
    include-in-header:
      - text: |
          <link rel="stylesheet" href="https://use.typekit.net/tag1lvz.css">
```

Export to PDF via the browser with **Background graphics** enabled. The shared print rules in `tlm-theme.scss` control pagination and print layout for Reveal.js.

> Note: SCSS affects HTML-based outputs. For native DOCX or LaTeX-PDF, use `reference.docx` and LaTeX templates respectively.

## Brand Integration

Quarto supports a `_brand.yml` file at the root of each **course repository**. That file declares branding tokens (logos, fonts, colors). In this repo, `_brand.yml` is the shared brand file that course repos should point to via their `brand:` setting (it includes logo definitions and commented starter palettes/typography).

**Layering model (top to bottom):**

1. **Quarto base theme** (e.g., `default`)
2. **Brand tokens** from the course repo’s `_brand.yml` (automatically layered by Quarto)
3. **Shared TLM theme** (`tlm-styles/tlm-theme.scss` from this repo)
4. **Course-specific overrides** (`styles.scss` in the course repo)

**Where things live**

-   **Fonts**: declared in the course repo’s `_brand.yml` under `typography`. Load Adobe Fonts (or other web fonts) via `include-in-header` in the course repo.
-   **Colors**: declared in the course repo’s `_brand.yml` under `color` (palette, foreground/background, primary/secondary, etc.).
-   **Shared layout & component rules**: live in `tlm-styles/tlm-theme.scss`.
-   **Course-specific tweaks**: live in the course repo’s `styles.scss`.

## SCSS Usage Guide

This repo currently exposes a **single theme file**: `tlm-theme.scss`. It uses Quarto’s SCSS regions so it can be safely layered with other themes.

### `tlm-theme.scss` structure

-   `/*-- scss:defaults --*/` defines tokens (colors, fonts, spacing).
-   `/*-- scss:mixins --*/` defines reusable mixins for text and headings.
-   `/*-- scss:rules --*/` contains the actual rules for body text, headings, links, navbar/footer, Reveal.js typography, and print tweaks.

### Editing guidance

-   Put **design tokens** (fonts, colors, spacing defaults) in `scss:defaults`.
-   Put **reusable patterns** in `scss:mixins`.
-   Put **styles** in `scss:rules`, and keep them output-agnostic unless they must be specific to a format (e.g., Reveal.js or print).

## HTML → PDF Guidance

-   Pagination and margins come from `@media print` in `tlm-theme.scss`.
-   Use utility classes in your QMD body:
    -   `<div class="page-break"></div>` to force a new page (if your course-level `styles.scss` defines it).
    -   Add `class: handout` to the top-level document container if you want handout-specific width rules (if defined in your course-level `styles.scss`).
-   In Chrome/Edge Print dialog: enable **Background graphics**, set **Scale 100%**, choose **Margins: Default** (or Custom if your course styles define margins).

## Conventions

-   Keep `tlm-theme.scss` self-contained and organized by Quarto SCSS regions.
-   Rely on `_brand.yml` for branding tokens; don’t hard-code course-specific fonts/colors in shared styles.
-   Do not commit licensed font files. Use system fonts or licensed hosting.

## Testing the Styles

A `tests/` folder contains minimal Quarto files for each output type (website, handout, presentation). These are for verifying that the SCSS compiles correctly and styles render as expected.

### Run the tests in RStudio

1.  In the **Files** pane, open one of the test files (e.g., `tests/wesite-test.qmd`).
2.  Click the **Render** button at the top of the editor.
3.  If the output opens in the RStudio Viewer pane, click the **Show in new window** button to expand it in your default web browser.

### What to check

-   **Website test** → look at headings, tables, callouts, etc. in the browser.
-   **Handout test** → open in the browser, then go to **Print → Save as PDF**. Make sure **Background graphics** is enabled so styles are preserved. Check margins, page breaks, and print layout.
-   **Presentation test** → check slide formatting in the browser. Use **Print → Save as PDF** to verify PDF export matches slide design.

### Notes

-   Only the `.qmd` sources are versioned. Rendered `.html` and `.pdf` files in `tests/` are ignored by `.gitignore`.
-   Update these tests when you add new style tokens or major structural changes to ensure consistency across outputs.

## Repository Layout (current)

```
_brand.yml           # example brand config (logos + starter palette/typography)
_quarto.yml          # local demo config (for testing)
logos/               # brand assets referenced by _brand.yml
tests/               # minimal .qmd files for verifying styles
tlm-theme.scss       # shared Quarto theme (this repo’s primary asset)
LICENSE
README.md
```

## License

MIT. See `LICENSE`.
