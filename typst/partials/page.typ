// Customization of Quarto's built-in Typst page.typ partial.
//
// Copy of Quarto 1.10's built-in Typst page.typ partial, with the 
// intentional modification described below.
//
// Intentional difference:
// - Omits Quarto's conditional page-background logo block.
// - This prevents the brand's small logo from being automatically placed
//   in the upper-left corner of every Typst page.
// - TLM page layouts manage document logos explicitly instead.
//
// When upgrading Quarto, compare this file against Quarto's current
// share/formats/typst/pandoc/quarto/page.typ and incorporate upstream
// changes while preserving the omission above.

#set page(
  paper: $if(papersize)$"$papersize$"$else$"us-letter"$endif$,
$if(margin-geometry)$
  // Margins handled by marginalia.setup below
$elseif(margin)$
  margin: ($for(margin/pairs)$$margin.key$: $margin.value$,$endfor$),
$else$
  margin: (x: 1.25in, y: 1.25in),
$endif$
  numbering: $if(page-numbering)$"$page-numbering$"$else$none$endif$,
  columns: $if(columns)$$columns$$else$1$endif$,
)
$if(margin-geometry)$
// Configure marginalia page geometry (functions defined in definitions.typ)
#show: marginalia.setup.with(
  inner: (
    far: $margin-geometry.inner.far$,
    width: $margin-geometry.inner.width$,
    sep: $margin-geometry.inner.separation$,
  ),
  outer: (
    far: $margin-geometry.outer.far$,
    width: $margin-geometry.outer.width$,
    sep: $margin-geometry.outer.separation$,
  ),
  top: $if(margin.top)$$margin.top$$else$1.25in$endif$,
  bottom: $if(margin.bottom)$$margin.bottom$$else$1.25in$endif$,
  book: false,
  clearance: $margin-geometry.clearance$,
)
$endif$