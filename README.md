# Teaching and Learning Materials SCSS Repository

This repository contains SCSS styles for creating consistent designs across teaching and learning materials (TLMs), including:

-   **Word Documents**
-   **Reveal.js Presentations**
-   **Websites**

## **Repository Structure**

``` plaintext
/scss
  |_ _variables.scss           # Global variables like colors, fonts, and spacing
  |_ _mixins.scss              # Reusable SCSS mixins for styles
  |_ _core.scss                # Core styles shared across all document types
  |_ word-documents.scss       # Styles specific to Word documents
  |_ websites.scss             # Styles specific to websites
  |_ revealjs-presentations.scss # Styles specific to presentations
  |_ styles.scss               # Main file importing all SCSS files
  |_ README.md                 # Repository documentation
  |_ LICENSE                  # MIT License for the repository
```

## **How to Use This Repository with Git Submodules**

To use these styles across different repositories, follow these steps:

### **1. Add the Repository as a Submodule**

``` bash
git submodule add https://github.com/chrismerkord/tlm-styles.git
```

### **2. Clone the Repository with Submodules**

When cloning a repository that includes this one as a submodule, run:

``` bash
git clone --recurse-submodules https://github.com/your-username/your-repository.git
```

### **3. Update the Submodule**

When changes are made to this repository, update the submodule using:

``` bash
cd your-repository
git submodule update --remote --merge
```

### **4. Reference SCSS Files in Your Project**

Use the `styles.scss` file in your build process or as part of your Quarto, Reveal.js, or static site generator configuration.

Example `quarto.yml` configuration:

``` yaml
format:
  html:
    css: tlm-styles/scss/styles.scss
```

------------------------------------------------------------------------

This repository is licensed under the MIT License. See the `LICENSE` file for details.

Let me know if you need additional configuration examples or more detailed setup instructions!
