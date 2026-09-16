// -----------------------------------------------------------------------------
// page-layout-header.typ
//
// Quarto metadata adapter for the shared page-layout() function.
//
// This file is loaded with include-in-header after page-layout.typ. It applies
// page-layout() to the document body and maps document-level Quarto metadata to
// the corresponding layout arguments:
//
//   short-title      -> short-title
//   course-label     -> course-label
//   document-context -> document-context
//   footer-logo      -> logo
//
// This keeps document-specific values in QMD metadata while keeping the Typst
// layout implementation centralized in page-layout.typ.
//
// See page-layout.typ for the required Quarto configuration and descriptions of
// the resulting header and footer.
// -----------------------------------------------------------------------------

#show: body => page-layout(
  body,
  short-title: "{{< meta short-title >}}",
  course-label: "{{< meta course-label >}}",
  document-context: "{{< meta document-context >}}",
  logo: "{{< meta footer-logo >}}",
)