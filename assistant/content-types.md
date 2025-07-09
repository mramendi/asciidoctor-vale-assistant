# Content types

An AsciiDoc file that is tested using Vale is typically either an assembly or a module. Both assemblies and modules must have a defined _content type_ to fit the templates and to be ready for DITA conversion. The content type must be defined as the `_mod-docs-content-type` attribute close to the start of the file, ideally on the first line (possibly excluding comment lines).

| Content Type | DITA Equivalent | Primary Purpose | Key Structural Rule |
| :--- | :--- | :--- | :--- |
| `assembly` | (map) | To organize and structure modules. | Can include other files with `leveloffset`. |
| `concept` | `concept` | To explain background information ("what" and "why"). | Allows one level of subsections (`==`). |
| `reference` | `reference` | To provide quick-lookup data (lists, tables, APIs). | Allows one level of subsections (`==`). |
| `procedure` | `task` | To give step-by-step instructions ("how-to"). | **Strict structure.** No subsections allowed. |


The content type of an assembly is always `assembly`. For modules, three content types are available:

* `concept`
* `reference`
* `procedure`

## assembly

For an assembly, the content type is always `assembly`:

```
:_mod-docs-content-type: assembly
```

An assembly's primary role is to include and structure modules. While it can contain its own content, most content is normally in the included modules. An assembly file can be identified by one or more of the following:
* The `:_mod-docs-content-type: assembly` attribute is defined.
* The file contains `include::` directives, especially those using the `[leveloffset=+N]` attribute to create nested subsections.
* The filename often, but not always, contains the word "assembly".

There is a [template for assemblies](TEMPLATE_ASSEMBLY_a-collection-of-modules.adoc.txt), but its parts are mostly optional, so non-conformance is usually not an issue.

Assemblies use the `[leveloffset=+N]` setting to nest include modules, for example:

```
include:modules/head_module.adoc[leveloffset=+1]
include:modules/subsection_module.adoc[leveloffset=+2]
```

In this example, the content of `subsection_module.adoc` appears as a subsection under the content of `head_module.adoc`.

## concept

A concept module gives users descriptions and explanations needed to understand and use a product.

* **Telltale Signs:** The content is dominated by explanatory paragraphs that answer "what" or "why" questions. It provides background and definitions.

One level of subsections (level 2 headings, `==` prefix) is allowed, but a concept should usually have a simple structure.

There is a [template for concepts](TEMPLATE_CONCEPT_concept-explanation.adoc.txt), but it is not strict. As long as no third-level subheadings (`===`) are present, it is usually not an issue.

The content type definition must be present close to the start of the file, ideally on the first line:

```
:_mod-docs-content-type: concept
```

## reference

A reference module provides data that users might want to look up, such as lists, tables, or API information.
* **Telltale Signs:** The content is dominated by lists, tables, API definitions, or parameter descriptions. It can read like a fact sheet or a dictionary.

One level of subsections (level 2 headings, `==` prefix) is allowed.

There is a [template for references](TEMPLATE_REFERENCE_reference-material.adoc.txt), but it is not strict. As long as no third-level subheadings (`===`) are present, it is usually not an issue.

The content type definition must be present close to the start of the file, ideally on the first line:

```
:_mod-docs-content-type: reference
```


## procedure


A procedure module provides step-by-step instructions that enable a user to perform a task.
* **Telltale Signs:** The content contains numbered lists with action-oriented verbs (e.g., *Click*, *Type*, *Run*, *Verify*). It describes a sequence of steps to achieve a goal.

A procedure module has a **strict structure** defined by its [template](TEMPLATE_PROCEDURE_doing-one-procedure.adoc.txt). No subheadings or subsections are allowed. Every procedure module must strictly comply with the template to enable DITA conversion.

To denote the structural parts of a procedure, a procedure module uses block titles (`.Block title` AsciiDoc markup). The template defines the complete list of block titles that are permitted in procedures and the strict structure of each part. Notably, the entire content under `.Procedure` must be a single ordered or unordered list.

The content type definition must be present close to the start of the file, ideally on the first line:

```
:_mod-docs-content-type: procedure
```

If the content of a module is factually a procedure but cannot be rewritten in time, a **last resort** is to mark the module as a `reference`. This decision should not be taken lightly.
