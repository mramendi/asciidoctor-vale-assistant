# Actions and explanations for fixing some errors and warnings

This file provides AI actions and explanations for fixing certain Vale issues (errors and warnings), in addition to the general explanations in [README.md](README.md). This file is intended for AI assistants.

For every issue, you must provide the user with an explanation and a suggested fix. Your primary goal is to follow the **AI Action plan** listed under each issue type. Use the corresponding **Detail** section and its examples to understand the nuance of the task, to generate the user-facing explanation, and to correctly format your code suggestions.

If the **AI Action plan** includes the keyword **Group**, you should list all issues of that type together under a single heading. Otherwise, list every issue separately unless a single fix resolves multiple, adjacent issues.

When a particular issue is not listed in this file, use the [README.md](README.md) file and your general knowledge to work out the best possible explanation and fix.

## EntityReference

**AI action plan**
**Group**
* If there are few (5 or less) unsupported entity references, replace them with AsciiDoc attributes to the best of your knowledge
* In all cases display an explanation to the user, importantly including the links provided

**Detail**

Replace the unsupported entity reference(s) with a [built-in AsciiDoc attributes](https://docs.asciidoctor.org/asciidoc/latest/attributes/character-replacement-ref/) or, when possible, just normal characters (such as `&` or `<`).

If your files have many unsupported entity references, consider using the [AsciiDoc DITA Toolkit](https://github.com/rheslop/asciidoc-dita-toolkit/tree/main) to replace them in all the files at once.

## ExampleBlock

**AI action plan**
* Analyse the example block and convert to normal text or a code block as appropriate
* If the preceding text does not mention an example, add a part such as "as in the following example". as appropriate, maintaining text flow
* If the example block title contains information absent in the preceding text, add this information to the text, maintaining text flow

**Detail**

Example blocks in the main body can usually be converted to normal text or, when they represent code or commands, to code blocks. If the preceding text does not make it clear that an example comes next, modify the preceding text to explain it, for example, by adding `See the following example:`

Note that block titles in example blocks must also be removed. Often, the block title is redundant (such as `Example of` following by a restatement of the previous paragraph). If the block title contains additional relevant information, add this information into the preceding text.

## NestedSection

**AI action plan**
* Determine if the file is an assembly. A `:_mod-docs-content-type: assembly` definition means the file is an assembly. If no `_mod-docs-content-type` attribute is defined, the file is likely an assembly if it has "assembly" in its name and/or if it has several `include:` directives that include a `[leveloffset=...]` setting.
* If the file IS an assembly, check if the `:_mod-docs-content-type: assembly` definition is in the file, if it is not, recommend adding it. No other change to an assembly is required for this issue.
* If the file IS NOT an assembly, recommend splitting subsections into separate modules.

**Detail**

If the AsciiDoc file is an assembly, this limitation does not apply. An assembly file often, but not always, has `assembly` in its name. To comply with the templates, it must have a `:_mod-docs-content-type: assembly` attribute definition at the start of the file. If the `NestedSection` error is reported for an assembly, ensure that the `:_mod-docs-content-type: assembly` attribute definition is present.

AsciiDoc files which are not assemblies are normally modules. If a module contains headings of level 3 or deeper (so with the AsciiDoc prefix of `===` or more), you must break the file into several modules. Typically, you will need to move sections of the file (level 2 headings, `==` Asciidoc prefix) into their own modules.

Do not add any `include` statements or references (`xref:`, `link:`, `<<...>>` ) to modules. Instead, add the new modules to the assembly file in which the existing module is included.

If you are advising the breakup of modules and outputting the content of any new modules, provide a snippet that the user will paste into the assembly. This snippet must include both the original (now modified) module and any new modules created. On an assembly, every `include:` statement for a module must have a [leveloffset=+N] setting. If a new module must become a subsection of another module, use the [leveloffset=+N] setting to implement this, for example:

```
include:modules/head_module.adoc[leveloffset=+1]
include:modules/subsection_module.adoc[leveloffset=+2]
```

When breaking a module into several modules, ensure that every module has the correct content type and complies with the template for this content type. For more information, see the `content-types.md` file.

## TaskSection

**AI action plan**
* Determine if the subheading should have been a block title, using the list of supported block titles for procedures. If this is true, suggest changing to block title.
* Otherwise, suggest splitting the subsections into separate modules.

**Detail**

In a task topic (content type `procedure`) no subsections nor subheadings are allowed.

Sometimes, they result from a formatting error when a subheading (for example, `== Procedure`) appears instead of a block title (`.Procedure`). This can happen only for block titles listed as supported in the [template for procedures](TEMPLATE_PROCEDURE_doing-one-procedure.adoc) (however, also check for typos in the section names, for example, `== Proedure` should still be replaced with `.Procedure`).

In all other cases, split the subsections off into separate modules.

Do not add any `include` statements or references (`xref:`, `link:`, `<<...>>` ) to modules. Instead, add the new modules to the assembly file in which the existing module is included.

If you are advising the breakup of modules and outputting the content of any new modules, provide a snippet that the user will paste into the assembly. This snippet must include both the original (now modified) module and any new modules created. On an assembly, every `include:` statement for a module must have a [leveloffset=+N] setting. If a new module must become a subsection of another module, use the [leveloffset=+N] setting to implement this, for example:

```
include:modules/head_module.adoc[leveloffset=+1]
include:modules/subsection_module.adoc[leveloffset=+2]
```

When breaking a module into several modules, ensure that every module has the correct content type and complies with the template for this content type. For more information, see the `content-types.md` file. Subsections of a procedure module are often _but not always_ procedures.

## AdmonitionTitle

**AI action plan**
* Determine if the admonition title can be removed without affecting the information in the document. If so, suggest removing it.
* Otherwise, suggest a version of the admonition without the title but with the same information worked into the admonition itself.

**Detail**

Sometimes, an admonition title can be removed without affecting document usability, as in the following example:

Failure:

```
[NOTE]
.Consideration for system updates
====
A system update sometimes requires a reboot. Make sure all important tasks can shut down gracefully.
====
```

Corrected:

```
[NOTE]
====
A system update sometimes requires a reboot. Make sure all important tasks can shut down gracefully.
====
```

At other times, you need to work the content of the title into the admonition text, as in the following example:

Failure:

```
[IMPORTANT]
.Caring for floppy disks
====
* Put 5 inch floppies in sleeves at all times when they are not in use
* Never expose floppies to direct sublight
* Keep all floppies far away from magnets
====
```

Corrected:

```
[IMPORTANT]
====
Take the following steps to care for floppy disks:
* Put 5 inch floppies in sleeves at all times when they are not in use
* Never expose floppies to direct sublight
* Keep all floppies far away from magnets
====
```

## BlockTitle

**AI action plan**

Determine if the module is a procedure. A procedure has a `:_mod-docs-content-type: procedure` definition close to the start of the file.

Then work through several possibilities:

* **If the specific block title is `.Procedure` and the module's content type is NOT `procedure`**, always complete the following action: analyze the entire module and suggest either converting the module to a procedure or splitting the procedure part into another module. **In this specific case do not proceed to other rules.**
* If the module's content type is not `procedure` and the block title is one of block titles supported for procedure elements according to the [template for procedures](TEMPLATE_PROCEDURE_doing-one-procedure.adoc), analyze the entire module to see if the module or a part of it is a procedure. If it is, suggest either converting the module to a procedure or splitting the procedure part into another module.
* If several block titles in succession represent a list, change to an unordered list or description list. **However, if `.Procedure` is one of the block titles in the sequence, do not apply this fix to the `.Procedure` block title. Use the specific rule for the `.Procedure` block title.** You can still apply the list fix to other block titles.
* If the module is not a procedure and the block title is where a subheading should logically be: if this would be a second level subheading (`==`), suggest converting the block title to a subheading. Otherwise, suggest splitting the module.
* If the module is a procedure and the block title is where a subheading should logically be: suggest splitting the module.
* If the block title is used as the heading to a block, typically a code block, reword the heading to add it into the normal text preceding the block, preserving the flow of text and of any AsciiDoc framing. In particular, if the text adds a paragraph and the block is in a list, you must use the `+` sign on its own line to join the block to the list.  

**Detail**

Block titles (`.Block title` in AsciiDoc) are widely used (and abused) for many different cases in existing documentation. Carefully review the context of the block title (sometimes a considerable number of lines before and after it) to work out its meaning, and then adjust the text to represent the meaning without a block title.

There are several typical situations. If none of the situations fit, work out other ways of representing the content.

**While one can replicate a block title by using a paragraph in bold, this is NOT a recommended solution, as it creates nonstandard presentation.**

### Procedure element

A concept or reference module might contain block titles supported for procedure elements according to the [template for procedures](TEMPLATE_PROCEDURE_doing-one-procedure.adoc)

In this case, consider if the module should be converted to a procedure or, alternatively, a procedure subsection should be split off into a separate module. If the block title `.Procedure` is present, this conclusion is a certainty. In other cases, it may or may not be true, depending on whether the content of the module (or the content of a subsection) is logically a procedure, that is, it describes a specific action by the user.

If you suggest splitting the procedure subsection into a separate module and then the user asks you to output the split module, make sure to review the context before the procedure heading. Some text before the procedure heading can be the explanation for the procedure. In this case, move this explanation into the new procedure module, alongside the procedure information itself.

** DO NOT** add any `include` statements or references (`xref:`, `link:`, `<<...>>` ) to modules. Instead, **add the new modules to the assembly file in which the existing module is included** and provide the assembly snippet with the module text.

If you are advising the breakup of modules and outputting the content of any new modules, provide a snippet that the user will paste into the assembly. This snippet must include both the original (now modified) module and any new modules created. On an assembly, every `include:` statement for a module must have a [leveloffset=+N] setting. If a new module must become a subsection of another module, use the [leveloffset=+N] setting to implement this, for example:

```
include:modules/head_module.adoc[leveloffset=+1]
include:modules/subsection_module.adoc[leveloffset=+2]
```

When you identify content to be split into a new module based on a procedure element block heading, you must treat the entire logical section it belongs to as the content to be moved. This includes any introductory paragraphs leading up to the content, the content itself (such as a `.Procedure` block), and any associated admonitions or examples. The goal is to move the complete, self-contained topic into the new file.

### Unordered list or description list

Sometimes several block titles in succession represent several options. In this case, use either an [unordered list](https://docs.asciidoctor.org/asciidoc/latest/lists/unordered/) or, if the entries are short, a [description list](https://docs.asciidoctor.org/asciidoc/latest/lists/description/). Do not use bold formatting (`*bold*`) to replicate the "visual effect" of the block titles, because bold formatting is normally used for UI elements.

Failure:

```
To resolve this error, use one of the following workarounds based on your {PlatformName} version:

.For {PlatformName} {PlatformVers}:

Specify the optional key/value pair as `model_verify_ssl=true` in the model secret to connect to an {ibmwatsonxcodeassistant} model. For details about the procedure, see xref:create-connection-secrets_configuring-lightspeed-onpremise[Creating connection secrets].

.For {PlatformName} 2.4:

You can disable the SSL protection between the model server and the Ansible Lightspeed service. For example, you can disable the SSL protection when you are on a testing environment. To disable the SSL protection, you must add the following extra setting in the {LightspeedShortName} Custom Resource Definition (CRD) YAML file under the `spec:` section:
----
extra_settings:
    - setting: ANSIBLE_AI_MODEL_MESH_API_VERIFY_SSL
      value: false
----
```

Correction:

```
To resolve this error, use one of the following workarounds based on your {PlatformName} version:

* For {PlatformName} {PlatformVers}, specify the optional key/value pair as `model_verify_ssl=true` in the model secret to connect to an {ibmwatsonxcodeassistant} model. For details about the procedure, see xref:create-connection-secrets_configuring-lightspeed-onpremise[Creating connection secrets].

* For {PlatformName} 2.4, you can disable the SSL protection between the model server and the Ansible Lightspeed service. For example, you can disable the SSL protection when you are on a testing environment. To disable the SSL protection, you must add the following extra setting in the {LightspeedShortName} Custom Resource Definition (CRD) YAML file under the `spec:` section:
+
----
extra_settings:
    - setting: ANSIBLE_AI_MODEL_MESH_API_VERIFY_SSL
      value: false
----
```

(Note the added `+` to ensure that the code block stays at the same indentation as the list element before it)

**CAUTION**: in some cases, after a few block titles that logically form a list, a block title appears to which another case applies. You need to detect such cases and not just add every block title to a list if some fit a list pattern. In particular, a `.Procedure` block title always denotes a procedure block.

### Subheading

Sometimes a block title is present where a subheading should be used. Remember, however, that no subheadings of more than the second level (`==` prefix) are permitted. If the block title should logically become a third-level subheading (`===` prefix), you need to split the module into several modules. If the module is a procedure, no subheadings are permitted at all, so split the module.

Do not add any `include` statements or references (`xref:`, `link:`, `<<...>>` ) to modules. Instead, add the new modules to the assembly file in which the existing module is included.

If you are advising the breakup of modules and outputting the content of any new modules, provide a snippet that the user will paste into the assembly. This snippet must include both the original (now modified) module and any new modules created. On an assembly, every `include:` statement for a module must have a [leveloffset=+N] setting. If a new module must become a subsection of another module, use the [leveloffset=+N] setting to implement this, for example:

```
include:modules/head_module.adoc[leveloffset=+1]
include:modules/subsection_module.adoc[leveloffset=+2]
```

When breaking a module into several modules, ensure that every module has the correct content type and complies with the template for this content type. For more information, see the `content-types.md` file.

### Proper block heading

Sometimes a block title is literally the heading to a block, typically a code block. In this case, reword the heading into normal text, as in the following example:

Failure:

```
Use the `ls` command to list files. You can provide a wildcard to list only the files that fit this wildcard.

.Example command
----
$ ls f*
----

.Example output
----
file1  file2
----
```

Correction:

```
Use the `ls` command to list files. You can provide a wildcard to listy only the files that fit this wildcard, as in the following example:

----
$ ls f*
----

The output of this command is:

----
file1  file2
----
```

If this case happens inside some AsciiDoc structure, make sure to keep that structure intact. In particular, a block with a title can happen inside a list. If your rewording becomes a new paragraph, you must use the `+` sign on its own line to join the block to the list, as in the following example:

Failure:

```
. Optional: Add any of the following parameters to the `ls` command:
+
|===
|Parameter |Description

|`-l`
|Use a long listing format

|`-i`
|Print the index number of each file

|<wildcard>
|List only files fitting the wildcard

|===
+
.Example `ls` command using parameters
----
ls -l *.adoc
----
```

Correction:

```
. Optional: Add any of the following parameters to the `ls` command:
+
|===
|Parameter |Description

|`-l`
|Use a long listing format

|`-i`
|Print the index number of each file

|<wildcard>
|List only files fitting the wildcard

|===
+
The following example of an `ls` command uses parameters:
+
----
ls -l *.adoc
----
```

## ContentType

**AI action plan**

* In all cases display an explanation, critically including the link to the [AsciiDoc DITA Toolkit](https://github.com/rheslop/asciidoc-dita-toolkit/tree/main).

* Attempt to determine and suggest the content type based on the `content-types.md` file. If you can determine it, add the content type definition at the start of the file.

* If the meaning of the text leads to a content type of `procedure`, you must **immediately and in the same response** perform a full structural validation of the file against the [procedure template](TEMPLATE_PROCEDURE_doing-one-procedure.adoc.txt). **Proactively identify and suggest fixes for any structural issues (such as potential `TaskStep` or `TaskSection` violations), even if they were not reported in the initial Vale report.** Modify the content as necessary to ensure full compliance with the template and combine all fixes into a single response. If you must generate an introduction from scratch because one is missing, describe what the user will accomplish and do not use self-referential phrases like "This procedure describes...".

**Detail**

Every AsciiDoc assembly or module must have a content type, defined as the `_mod-docs-content-type` attribute close to the start of the file, ideally on the first line. See the `content-types.md` file for details.

When choosing a content type for the file, consider the information that is in the file.

If the content type is `procedure`, you must also edit the file to ensure it fits the [procedure template](TEMPLATE_PROCEDURE_doing-one-procedure.adoc.txt). In particular:

* No subheadings or subsections are allowed
* Only the listed set of block titles is allowed
* The `.Procedure` block title is mandatory
* The text from the `.Procedure` block title to the next block title or to the end of the file must be a single AsciiDoc list of steps (ordered list or, if there is only a single step or the user needs to pick one of several steps, unordered list). If there is a list of steps and then some additional text after it, insert a suitable supported block title, such as `.Verification` or `Result`, before this additional text.

For working out content types for your files, especially if you need to determine content type for many files at once, consider using the [AsciiDoc DITA Toolkit](https://github.com/rheslop/asciidoc-dita-toolkit/tree/main) .

## CrossReference

**AI action plan**
**Group**
* Display an explanation, critically including the links to suggested utilities
* Do not suggest fixes

**Detail**


It is usually not possible to work out the correct cross-reference by looking just at the content of one file. (The only exception is if the reference is to an ID defined in the file itself).

Do not remove cross-references (`xref:` or `<< ... >>` markup) because of this warning. There are two suggested solutions, and both must be carried out for an entire documentation set as opposed to a single module:

* You can use the [mod-docs-cross-reference script](https://github.com/rheslop/asciidoc-dita-toolkit/blob/main/asciidoc_dita_toolkit/asciidoc_dita/plugins/mod-docs-cross-reference.py) to fix all the cross-references in a doc set, then run Vale again to ensure no unsupported cross-references remain.

* You can ignore the warnings, complete the conversion to DITA, and then use the [fix-dita-links](https://github.com/jhradilek/fix-dita-links) script to change the links into the correct format after the conversion.

If you are an AI handling the `CrossReference` warning, list all the instances of this warning in a file together, provide this explanation **necessarily including the _links_ to the suggested solutions**, and do not recommend any other action for this warning.

## LineBreak

**AI action plan**
* Locate the affected `+` character and analyse the context. Pay attention to whether the `+` character is within an AsciiDoc structure, such as a list or table.
* If the `+` character is within a **table**, remove the `+`, replace it with a blank line, and add an `a` prefix operator to the cell.
* Otherwise, if the `+` is at the end of a line **within a list** and the following text is a distinct block (like a code block, table, or admonition), move the `+` to its own line to attach the block to the list item.
* Otherwise, if the `+` is at the end of a line and the following text is a distinct block but you are **NOT within a list**, remove the `+` and replace it with a single blank line to create a paragraph break.
* **Otherwise, if the `+` is at the end of a line and is followed by text (not a block):**
    * First, determine if the following text can be logically and grammatically joined to the preceding sentence.
    * If it can be joined (for example, if it's a short clarifying phrase), then remove the `+` character and join the content into a single paragraph.
    * If it cannot be joined, remove the `+` and replace it with a single blank line to create two separate paragraphs.
* Otherwise, if the `+` is on its **own line but has incorrect spacing** (e.g., extra blank lines or comments around it), fix the spacing by removing the extra lines/comments.
* If complicated formatting is involved and an uncertainty remains, consider using an Asciidoc open block (bounded by `--` lines at the start and end) where possible..


**Detail**

This warning appears when the AsciiDoc `+` special character is used the wrong way.

Only one way of using the `+` special character is supported in the conversion process: inside a list, the `+` character can be placed on a separate line to ensure that the next paragraph is in the same list element as the previous paragraph. This notation is often used with code blocks.

The following example is _correct_:

```
You can use several commands:

* The `ls` command displays a list of files.
+
The `-l` option enables a long list format, which includes the access permissions and sizes of the files, as in the following example:
+
[source, terminal]
----
$ ls -l
----
```

Other uses of the `+` character as a special "line break" character cause the `LineBreak` warning and you must fix them. If you don't fix them, the DITA output might be wrongly formatted and/or contain a literal `+`. Several typical cases are outlined below.

Note: if you need a really complicated list element with elements such as paragraphs and code blocks, sometimes it is genuinely hard to ensure the correct formatting in AsciiDoc by precise use of the `+` character. An alternative is the use of an [open block](https://docs.asciidoctor.org/asciidoc/latest/blocks/open-blocks/), denoted by `--` characters on separate lines. The first paragraph of a list cannot be a part of an open block, so you still must have a `+` on a separate line under it, followed by the open block. The following example is _correct_ and the second element of the list includes three paragraphs:

```
. element one

. element two
+
--
continued

continued again
--

. element three

. element four
```

### + sign at the end of the line

Sometimes a `+` character as a line break is used at the end of the line.

In some of these cases the line break is unnecessary for the context. In these cases simply remove the `+` character. A line break is often unnecessary if the following text is a short, simple clarifying phrase, such as an example, that can be joined directly to the preceding sentence. An example of removing the line break:

Failure:

```
.. Click the *Edit* icon beside the pod and select *Create New Pod*. +
A new pod gets created.
```

Correction:

```
.. Click the *Edit* icon beside the pod and select *Create New Pod*.
A new pod gets created.
```
(Note: while you can keep the regular line break for source readability purposes, there is no line break in the output).

In other cases, the line break is necessary, for example, a code block follows. If the line break is necessary and the line is a part of a list, move the `+` sign to a separate line, as in the following example:

Failure:

```
. Run the following command:+
----
ls
----
```

Correction:

```
. Run the following command:
+
----
ls
----
```

If the line break is necessary and the line is not a part of a list, remove the + sign and add an empty line to ensure a paragraph break, as in the following example:

Failure:

```
Consider the following command: +
----
ls
----
```

Correction:

```
Consider the following command:

----
ls
----
```

### + sign on its own line, but with interruptions before or after it

Sometimes the `+` character is used to join paragraphs into a list element and is correctly placed on its own line, but there is an empty line or a comment before or after the `+` character.

To resolve the problem, remove the empty line or comment before or after the `+` character, as in the following example:

Failure:

```
. Run the following command:
+
// the command block
----
ls
----
```

Correction:

```
. Run the following command:
+
----
ls
----
```

### + sign inside a table

Sometimes, the `+` sign is used to enforce a line break in the  content of a table cell. In this case, remove the `+` sign and add an [`a` prefix operator](https://docs.asciidoctor.org/asciidoc/latest/tables/format-cell-content/#a-operator) to the table cell, as in the following example:

Failure:

```
|===
|Task | Command

| List files | `ls`
+
`ls -l` for a long list

|===
```

Correction:

```
|===
|Task | Command

| List files a| `ls`

`ls -l` for a long list

|===
```

## TaskStep

**AI action plan**
* Analyse the content from this line to the next block title, for example, `.Results`, or to the end of the file if there is no following block title. You must understand if it is still a part of the procedure, and if so, how to join it into the ordered or unordered list of steps.
* If the content continues the list but has one or several line breaks that cause the issue, fix the AsciiDoc list by using the `+` line break symbol on its own line  
* If some of the content has conceptual subtitles, for example using bold text, and lists actions under them, convert these subtitles into an unordered list of substeps, or an ordered list if they have numbers.
* If the content continues the procedure conceptually but is not formatted into steps or substeps, attempt to reformat is into steps and substeps as necessary, and ensure they are joined to the existing ordered or unordered AsciiDoc list of steps. You can use the `+` line break symbol on its own line and the AsciiDoc open block, denoted by `--` lines, to ensure correct AsciiDoc as necessary.
* After joining the content into the single list of steps, you MUST check if the resulting list has only one top-level step. If it does, you must make that list unordered (using `*`) to comply with the procedure template.
* If the content does not continue the procedure conceptually, use one of the supported block titles, as defined in [the procedure template](TEMPLATE_PROCEDURE_doing-one-procedure.adoc.txt), to separate the content from the procedure steps.

**Details**

Under the `.Procedure` block heading, the procedure template allows only a single AsciiDoc list (ordered or unordered). This warning is reported where this list is broken and some other content, and not the next block title, follows.

Importantly, for this warning you must analyze the entire remaining part of the procedure block (until the next block title or the end of the file) and not just this one line. If you fix only this line, there might be other breaks under it, which Vale did not catch because it only reports this warning once for a procedure block.

Make sure the resulting content complies with [the procedure template](TEMPLATE_PROCEDURE_doing-one-procedure.adoc.txt). Make any changes necessary to ensure compliance. In particular, if the main list of steps contains only one top-level step, make it an unnumbered list (`*`) to comply with the template.

In most cases, the following content is still a part of the procedure conceptually, but incorrect formatting breaks the list.

In the simple case the list is continued but is accidentally broken in one or several places, as in the following example:

Failure:

```
. Run the following command:
----
ls
----
. Review the output, for example:
----
file1     file2
----
. Review every listed file.
```

Correction:

```
. Run the following command:
+
----
ls
----
. Review the output.
+
----
file1     file2
----
. Review every listed file.
```

Sometimes, some of the remaining content uses conceptual subtitles, for example, lines formatted in bold (`*Subtitle*`), to denote branches in the procedure. In this case, convert these branches to an unordered list of substeps. Alternatively, if the subtitles are numbered, use an ordered list of substeps. Make sure the list of substeps is correctly joined to a step in the main list. The following example shows this case.

Failure:

```
. Wash your animal.
. Give the medicine tablet to your animal, depending on the kind of animal:

*Procedure for dogs*

.. Roll the medicine tablet into a piece of ham.
.. Offer the piece of ham to the dog.

*Procedure for cats*

.. Put on scratch-resistant clothing and bite-resistant gloves
.. Hold the cat firmly
.. Open the cat's mouth and place the tablet as deep as you can
.. Hold the cat's mouth closed until the tablet appears to be ingested
.. Hope for the best

. Comfort your animal.
```

Correction:

```
. Wash your animal.
. Give the medicine tablet to your animal, depending on the kind of animal:
** Procedure for dogs:
... Roll the medicine tablet into a piece of ham.
... Offer the piece of ham to the dog.
** Procedure for cats:
... Put on scratch-resistant clothing and bite-resistant gloves
... Hold the cat firmly
... Open the cat's mouth and place the tablet as deep as you can
... Hold the cat's mouth closed until the tablet appears to be ingested
... Hope for the best
. Comfort your animal.
```

In some other cases, the text still continues the procedure conceptually, but is formatted in some novel way. Use your best judgement to reformat the content into steps and substeps, and make sure to join them to the single list of steps.

There are also cases when the the procedure is actually completed and there is a "postfix" that should really be a result, example, and so on. In this case, add the fitting block title from those supported for procedures according to [the procedure template](TEMPLATE_PROCEDURE_doing-one-procedure.adoc.txt) and, if necessary to avoid duplication, reword the text, as in the following example:

Failure:

```
. Use the `ls` command to list the files.
. For every file that must be backed up, use the `cp <filename> /media/backup` command.

After this procedure, your files are backed up.
```

Correction:

```
. Use the `ls` command to list the files.
. For every file that must be backed up, use the `cp <filename> /media/backup` command.

.Result

Your files are backed up.
```
