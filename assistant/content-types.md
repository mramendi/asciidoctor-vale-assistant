# Content types

An AsciiDoc file that is tested using Vale is typically either an assembly, a module, or a snippet. Assemblies, modules, and snippets must have a defined _content type_ to fit the templates and to be ready for DITA conversion. The content type must be defined as the `_mod-docs-content-type` attribute close to the start of the file, ideally on the first line (possibly excluding comment lines).

The value of the `_mod-docs-content-type` attribute is not case-sensitive, but for consistency, when recommending a new `_mod-docs-content-type` value, use UPPERCASE: `CONCEPT`, `PROCEDURE`, `REFERENCE`, `ASSEMBLY`, `SNIPPET`.

Instead of `_mod_docs_content_type`, some files can contain one of the older-version attributes with the same values and meaning: `_content_type` or `_module_type`. Never recommend these attributes for new addition, but if one of these attributes already exists, you do not need to replace it with `_mod_docs_content_type`.

| Content Type | DITA Equivalent | Primary Purpose | Key Structural Rule |
| :--- | :--- | :--- | :--- |
| `ASSEMBLY` | (map+`concept`) | To organize and structure modules and to provide conceptual information applying to them. | Can include other files with `leveloffset`. |
| `CONCEPT` | `concept` | To explain background information ("what" and "why"). | Allows one level of subsections (`==`). |
| `REFERENCE` | `reference` | To provide quick-lookup data (lists, tables, APIs). | Allows one level of subsections (`==`). |
| `PROCEDURE` | `task` | To give step-by-step instructions ("how-to"). | **Strict structure.** No subsections allowed. |
| `SNIPPET` | (conref) | A text to be included in various modules. | No template. |


The content type of an assembly is always `ASSEMBLY`. For modules, three content types are available:

* `CONCEPT`
* `REFERENCE`
* `PROCEDURE`

Another supported `_mod-docs-content-type` value is `SNIPPET`. It is reserved for files that are neither assemblies nor modules, but are included in different modules using `include::` directives.

## ASSEMBLY

For an assembly, the content type is always `ASSEMBLY`:

```
:_mod-docs-content-type: ASSEMBLY
```

An assembly's primary role is to include and structure modules. It also provides conceptual content explaining the use case and prerequisites applying to the included modules. This conceptual content is converted to a `concept` module in the DITA conversion process.

An assembly file can be identified by one or more of the following:
* The `:_mod-docs-content-type: ASSEMBLY` attribute is defined.
* The file contains `include::` directives, especially those using the `[leveloffset=+N]` attribute to create nested subsections.
* The filename often, but not always, contains the word "assembly".

There is a [template for assemblies](TEMPLATE_ASSEMBLY_a-collection-of-modules.adoc.txt), but its parts are mostly optional, so non-conformance is usually not an issue.

Assemblies use the `[leveloffset=+N]` setting to nest include modules, for example:

```
include:modules/head_module.adoc[leveloffset=+1]
include:modules/subsection_module.adoc[leveloffset=+2]
```

In this example, the content of `subsection_module.adoc` appears as a subsection under the content of `head_module.adoc`.

## CONCEPT

A concept module gives users descriptions and explanations needed to understand and use a product.

* **Telltale Signs:** The content is dominated by explanatory paragraphs that answer "what" or "why" questions. It provides background and definitions.

One level of subsections (level 2 headings, `==` prefix) is allowed, but a concept should usually have a simple structure.

There is a [template for concepts](TEMPLATE_CONCEPT_concept-explanation.adoc.txt), but it is not strict. As long as no third-level subheadings (`===`) are present, it is usually not an issue.

The content type definition must be present close to the start of the file, ideally on the first line:

```
:_mod-docs-content-type: CONCEPT
```

## REFERENCE

A reference module provides data that users might want to look up, such as lists, tables, or API information.
* **Telltale Signs:** The content is dominated by lists, tables, API definitions, or parameter descriptions. It can read like a fact sheet or a dictionary.

One level of subsections (level 2 headings, `==` prefix) is allowed.

There is a [template for references](TEMPLATE_REFERENCE_reference-material.adoc.txt), but it is not strict. As long as no third-level subheadings (`===`) are present, it is usually not an issue.

The content type definition must be present close to the start of the file, ideally on the first line:

```
:_mod-docs-content-type: REFERENCE
```

## PROCEDURE

A procedure module provides step-by-step instructions that enable a user to perform a task.
* **Telltale Signs:** The content contains numbered lists with action-oriented verbs (e.g., *Click*, *Type*, *Run*, *Verify*). It describes a sequence of steps to achieve a goal.

A procedure module has a **strict structure** defined by its [template](TEMPLATE_PROCEDURE_doing-one-procedure.adoc.txt). No subheadings or subsections are allowed. Every procedure module must strictly comply with the template to enable DITA conversion.

To denote the structural parts of a procedure, a procedure module uses block titles (`.Block title` AsciiDoc markup). The template defines the complete list of block titles that are permitted in procedures and the strict structure of each part. Notably, the entire content under `.Procedure` must be a single ordered or unordered list.

The content type definition must be present close to the start of the file, ideally on the first line:

```
:_mod-docs-content-type: PROCEDURE
```

If the content of a module is factually a procedure but cannot be rewritten in time, a **last resort** is to mark the module as a `reference`. This decision should not be taken lightly.
