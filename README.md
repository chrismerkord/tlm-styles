# TLM Styles (SCSS)

Shared SCSS for consistent styling across Teaching & Learning Materials:

-   Websites (Quarto HTML)
-   Reveal.js presentations
-   HTML handouts

## Repository Layout

```         
_core.scss                 # base elements, utilities
_mixins.scss               # reusable mixins
_variables.scss            # colors, typography, spacing tokens
revealjs-presentations.scss
websites.scss
handouts.scss
_print.scss                # print rules for HTML→PDF
styles.scss                # single entrypoint that uses/forwards the above
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

## License

MIT. See `LICENSE`.
