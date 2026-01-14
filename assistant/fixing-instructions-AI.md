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

The five standard XML entity references (`&amp;`, `&lt;`, `&gt;`, `&apos;`, `&quot;`) are supported. Do not replace them.


## AttributeReference

**AI action plan**
**Group**
* The issue is an information message, not requiring a fix. it informs the user that there is an atteibute reference, such as `{attribute}`, in the text.

**Detail**

The user must discuss with the conversion team which of the attribuets in the document are to be resolved (changed to normal text) in the conversion and whoch of the attributes must refer to DITA shared content.

## AuthorLine

**AI action plan**
* Add a blank line after the document title.

**Detail**

In an Asciidoc file, there must be a blank line between a document title (top-level section heading) and the text that follows it. Asciidoc ingterprets a non-blank line immediately following a document title as the author line. The DITA conversion process does not support author lines.

In modular documentation, real author lines are never used. So the issue means that the writer did not add a blabnk line after the document title. To fix the issue, add this blank line. 

## DocumentId

**AI action plan**
* Add a `[id=...]` statement immediately before the section heading
* Ask the user to ensure that the ID is unique

**Detail**

Every module or assembly in Asciidoc modular documentation must have an `id` attribute set. This setting must come immediately before the section heading (document title) at the start of the module, for example:

```
[id="sample-module"]
= Sample module
```

If this ID setting is not present, Vale reports the `DocumentId` issue.

To fix the problem, add the setting of the `id` attribute immediately before the section heading at the start of the file.

The user must ensure that this heading is unique, that is, that no other module or assembly in the same document has this same `id` value.

## DocumentTitle

**AI action plan**
* Add a document title, that is, a first-level section heading (such as `= Title`) at the start of the module or assembly file, after the setting of the `id` attribute
* Ensure that the title reflects the content of the file. Ask the user to verify.
* Alternatively the user can change the content type to `SNIPPET` to avoid this issue.


**Detail**

Every module or assembly file in Asciidoc modular documentation must have a document title, which is a first-level section heading, at the very start of the file, after the `id` attribute is set. For example:

```
[id="sample-module"]
= Sample module
```

If this document title is not present, Vale reports the `DocumentTitle` issue.

To fix the problem, add the title (first-level section heading, starting with a single `=` marker) immediately after the setting of the `id` attribute. Ensure the title reflects the contenf of the documemnt. The user must verify that the title is appropriate.

If the file is in fact a snippet, that is, it is intended for inclusion inside modules, a title is not required. In this case, the user must add a `_mod-doc-content-type: SNIPPET` definition at the start of the file.


## ShortDescription

**AI action plan**
* If the module starts with a paragraph that summarizes the purpose of the module, add a `[role="_abstract"]` block attribute line before this paragraph
* Otherwise, suggest adding a new summarizing paragraph at the start of the module, using a `[role="_abstract"]` block attribute. Draft this paragraph based on the module.

**Detail**

For high-quality conversion to DITA, every module or assembly file must have a short description. A short description is a single paragraph summarizing the purpose of the file. It must immediately follow the title (section heading) and it must have a `[role="_abstract"]` block attribute. For example:

```
[id="sample-procedure"]
= Sample procedure

[role="_abstract"]
To configure the system, provide the necessary data in the *System configuration* dialog.
```

If this short description is not present, Vale reports the `ShortDescription` issue.

Sometimes, a short description paragraph already exists at the start of the file. In this case, add a `[role="_abstract"]` block attribute immediately before the paragraph.

Otherwise, suggest a new short description paragraph with this block attribute.


## ExampleBlock

**AI action plan**
* Analyse the example block and convert to normal text or a code block as appropriate
* If the preceding text does not mention an example, add a part such as "as in the following example". as appropriate, maintaining text flow
* If the example block title contains information absent in the preceding text, add this information to the text, maintaining text flow

**Detail**

Example blocks in the main body can usually be converted to normal text or, when they represent code or commands, to code blocks. If the preceding text does not make it clear that an example comes next, modify the preceding text to explain it, for example, by adding `See the following example:`

Note that block titles in example blocks must also be removed. Often, the block title is redundant (such as `Example of` following by a restatement of the previous paragraph). If the block title contains additional relevant information, add this information into the preceding text.

## TaskExample

**AI action plan**
* Analyse the extra example blocks, including any example blocks within the steps of the procedure, and convert to normal text or code blocks as appropriate. Ensure that any blocks or any additional paragraphs in steps are added to the list items using the `+` joiner line.
* If the content is actually a code block but the `====` delimiter is used, change it to the correct `----` delimiter at both the start and the end of the block. if it is a part of a procedure step, ensure it is joined to the step using the `+` joiner.
* If the preceding text does not mention an example, add a part such as "as in the following example". as appropriate, maintaining text flow
* If the example block title contains information absent in the preceding text, add this information to the text, maintaining text flow

**Detail**

Only one example block can be present in a procedure. Moreover, this example block must not be a part of a step. 

Example blocks in steps body can usually be converted to normal text or, when they represent code or commands, to code blocks. Beacuse a step is always a list item, text paragraphs or code blocks must be joined to the list item using the `+` joiner.  If the preceding text does not make it clear that an example comes next, modify the preceding text to explain it, for example, by adding `See the following example:`

Sometimes the intended type is a code block but the `====` delimiter is used instead of the correct `----` delimiter. In this case, change the delimited at both the start and the end of the block.

Note that block titles in example blocks must also be removed. Often, the block title is redundant (such as `Example of` following by a restatement of the previous paragraph). If the block title contains additional relevant information, add this information into the preceding text.


## NestedSection

**AI action plan**
* Determine if the file is an assembly. A `:_mod-docs-content-type: ASSEMBLY` definition means the file is an assembly. If no `_mod-docs-content-type` attribute is defined, the file is likely an assembly if it has "assembly" in its name and/or if it has several `include:` directives that include a `[leveloffset=...]` setting.
* If the file IS an assembly, check if the `:_mod-docs-content-type: ASSEMBLY` definition is in the file, if it is not, recommend adding it. Also, if there are subsections in the assembly text marked with a third level heading (`===`) or a higher level heading, recommend that the user consider either flattening the structure or splitting the assembly. As an AI, **do not suggest specific candidate text for splitting** in the case of assemblies, because conceptual information in assemblies normally requires manual review for rerganizing it.
* If the file IS NOT an assembly, recommend splitting subsections into separate modules.

**Detail**

If the AsciiDoc file is an assembly, this limitation applies only to text present in the assembly itself and not to modules included in the assembly. An assembly file often, but not always, has `assembly` in its name. To comply with the templates, it must have a `:_mod-docs-content-type: ASSEMBLY` attribute definition at the start of the file.

If the `NestedSection` error is reported for an assembly, ensure that the `:_mod-docs-content-type: ASSEMBLY` attribute definition is present. Then recomment **manual** review, in order to either flatten the structure to limit it to second-level headings or else to split the assembly. This decision must be made by the writer, because it involves a wider context than just the assembly file.

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


## TaskContents

**AI action plan**
* Determine if the "Procedure" heading exists as a subsection heading instead of a block title. If this is true, suggest changing to block title.
* Otherwise, determine if the text contains a list of procedural steps (or a clear single procedural step). If this is true, suggest adding a `.Procedure` block titme. If the list is not properly formatted as a list, suggest formatting it as a list; if there is a single step, suggest formating it as an uniordered list with a single item.
* Otherwise, suggest rewriting the module as a procedure.

**Detail**

According to the [template for procedures](TEMPLATE_PROCEDURE_doing-one-procedure.adoc), a task topic (content type `procedure`) must include a `.Procedure` block title. Immediately after this block title, the module must contain a list of steps. The `TaskContents` Vale issue means that no `.Procedure` block title was found.

Sometimes, "Procedure" is mistakenly included as a section heading (for example, `== Procedure`) instead of a block title (`.Procedure`). In this case, suggest replacing it with `.Procedure`. Also check for typos in the section name, for example, `== Proedure` should still be replaced with `.Procedure`).

If no procedure heading can be found, analyse the text of the module. Several possibilioties exist.

Does the module have a list of procedural steps? For example:

```
= Completing the task

. Step one
. Step two

```

In this case, suggest adding a `.Procedure` block title before the list. If the list starts immediately after the section heading, remind the user to ass a short description before the `.Procedure` block title.

Does the module have a clear single procedural step? For example:

```
= Completing the task

To complete this task, run the `cat a | grep x` command.

```

In this case, suggest adding a `.Procedure` block title before the step and making the step into a single-item unordered list. If the single step starts immediately after the section heading, remind the user to ass a short description before the `.Procedure` block title.

In other cases, the module must be rewritten as a procedure. Suggest a rewrite if you can, but the user must verify any changes.

Sometimes, changing the content type to reference or concept is more appropriate. However, if the module describes steps that a user must take, changing the content type is not a good solution.


## TaskDuplicate

**AI action plan**
* Determine which of the block titles in the procedure module are seen as duplicates. Most commonly, `.Verification` and `.Result` (or `.Results`) are both present. Merge the contents under both titles, so that only one of the titles is used in the document.

**Detail**

The following block titles in a procedure module are mapped to different DITA elements. Only one of the titles for each element is allowed in a procedure module. 
* `.Prerequisite`, `.Prerequisites`
* `.Procedure` 
* `.Verification`, `.Result`, `.Results`
* `.Troubleshooting`, `.Troubleshooting step`, `.Troubleshooting steps`
* `.Next step`, `.Next steps`

If more than one title of the same group is present, the `TaskDuplicate` Vale issue is raised. In this case, merge the text under the duplicate block titles and use only one of the block titles.

Most commonly, the same procedure module contains the the `.Verification` and `.Result` (or `.Results`) block titles.


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

Determine if the module is a procedure. A procedure has a `:_mod-docs-content-type: PROCEDURE` definition close to the start of the file.

Then work through several possibilities:

* **If the specific block title is `.Procedure` and the module's content type is NOT `procedure`**, always complete the following action: analyze the entire module and suggest either converting the module to a procedure or splitting the procedure part into another module. **In this specific case do not proceed to other rules.**
* If the module's content type is not `procedure` and the block title is one of block titles supported for procedure elements according to the [template for procedures](TEMPLATE_PROCEDURE_doing-one-procedure.adoc), analyze the entire module to see if the module or a part of it is a procedure. If it is, suggest either converting the module to a procedure or splitting the procedure part into another module.
* If the block title is `.Example` or `.Examples` and it is the onl;y block of this type in a module (or `Example of something` when the module containt only one example like that), change the content under this title into a single AsciiDoc `[example]` block. The block title `.Example` is supported when it covers a single example block. **You must not add more than one example block per file. Also, an example block must not be a part of a list, for example, it must not be joined to a list using a + sign. If you need to handle multiple examples, reword the headings as in the "heading to a block" option**.
* If several block titles in succession represent a list, change to an unordered list or description list. **However, if `.Procedure` is one of the block titles in the sequence, do not apply this fix to the `.Procedure` block title. Use the specific rule for the `.Procedure` block title.** You can still apply the list fix to other block titles.
* If the module is not a procedure and the block title is where a subheading should logically be: if this would be a second level subheading (`==`), suggest converting the block title to a subheading. Otherwise, suggest splitting the module.
* If the module is a procedure and the block title is where a subheading should logically be: suggest splitting the module.
* If the block title is used as the heading to a block, typically a code block, reword the heading to add it into the normal text preceding the block, preserving the flow of text and of any AsciiDoc framing. In particular, if the text adds a paragraph and the block is in a list, you must use the `+` sign on its own line to join the block to the list. When rewording, remember the "Following rule". Do not remove any example content.

**Detail**

Block titles (`.Block title` in AsciiDoc) are widely used (and abused) for many different cases in existing documentation. However, for DITA conversion, block titles are supported only if they are attached to tables, images (`image::`), and example blocks (`[example]`). Block titles for other cases, including paragraphs and code blocks, are not supported for DITA conversion, and such use of block titles triggers the `BlockTitle` Vale issue.

Carefully review the context of the block title (sometimes a considerable number of lines before and after it) to work out its meaning, and then adjust the text to represent the meaning without a block title.

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

### Example

The block title `.Example` or `.Examples` covers an example subsection that is actually supported in DITA, if this is the only example subsection in the file. However, for the conversion to work, this subsection must be a single `[example]` block. In this case, convert the content to an `[example]` block and use the `.Example` block title for this block.

Failure:

```
.Examples

The following example pipeline run references a remote pipeline from a catalog:

[source,yaml]
----
apiVersion: tekton.dev/v1
kind: PipelineRun
metadata:
  name: hub-pipeline-reference-demo
spec:
  pipelineRef:
    resolver: hub
    params:
# ...
----

The following example pipeline references a remote task from a catalog:

[source,yaml]
----
apiVersion: tekton.dev/v1
kind: Pipeline
metadata:
  name: pipeline-with-hub-task-reference-demo
spec:
  tasks:
  # ...
----
```

Correction:

```
.Example
[example]
====
The following example pipeline run references a remote pipeline from a catalog:

[source,yaml]
----
apiVersion: tekton.dev/v1
kind: PipelineRun
metadata:
  name: hub-pipeline-reference-demo
spec:
  pipelineRef:
    resolver: hub
    params:
# ...
----

The following example pipeline references a remote task from a catalog:

[source,yaml]
----
apiVersion: tekton.dev/v1
kind: Pipeline
metadata:
  name: pipeline-with-hub-task-reference-demo
spec:
  tasks:
  # ...
----
====
```

Failure: (the module has a single block like this)

```
.Example {pac} pipeline run definition
[source,yaml]
----
apiVersion: tekton.dev/v1
kind: PipelineRun
metadata:
  name: maven-build
annotations:
  pipelinesascode.tekton.dev/task: "[git-clone]"
  # ...
```

Correction:

```
.Example
[example]
====
The following example shows a {pac} pipeline run definition:

[source,yaml]
----
apiVersion: tekton.dev/v1
kind: PipelineRun
metadata:
  name: maven-build
annotations:
  pipelinesascode.tekton.dev/task: "[git-clone]"
  # ...
====
```

**You must not add more than one example block per file. Also, an example block must not be a part of a list, for example, it must not be joined to a list using a + sign. If you need to handle multiple examples, reword the headings as in the "heading to a block" option**.

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

Sometimes a block title is literally the heading to a block, typically a code block. In this case, reword the heading into normal text, as in the following example. **When rewording, you MUST strictly adhere to the "Following rule" defined in your main prompt.** Do not remove any example content.

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

* If the meaning of the text leads to a content type of `PROCEDURE`, you must **immediately and in the same response** perform a full structural validation of the file against the [procedure template](TEMPLATE_PROCEDURE_doing-one-procedure.adoc.txt). **Proactively identify and suggest fixes for any structural issues (such as potential `TaskStep` or `TaskSection` violations), even if they were not reported in the initial Vale report.** Modify the content as necessary to ensure full compliance with the template and combine all fixes into a single response. If you must generate an introduction from scratch because one is missing, describe what the user will accomplish and do not use self-referential phrases like "This procedure describes...".

**Detail**

Every AsciiDoc assembly or module must have a content type, defined as the `_mod-docs-content-type` attribute close to the start of the file, ideally on the first line. See the `content-types.md` file for details. The value of the `_mod-docs-content-type` attribute is not case-sensitive, but for consistency, when recommending a new `_mod-docs-content-type` value, use UPPERCASE: `CONCEPT`, `PROCEDURE`, `REFERENCE`, `ASSEMBLY`.

Another supported `_mod-docs-content-type` value is `SNIPPET`. It is reserved for files that are neither assemblies nor modules, but contain reusable text that is included in different modules using `include::` directives. As an AI, if you suspect the file might be a snippet, point out this possibility to the user. In this case, the user must make the decision whether it is a snippet, because you cannot work this fact out confidently from the content of just one file.

Instead of `_mod_docs_content_type`, some files can contain one of the older-version attributes with the same values and meaning: `_content_type` or `_module_type`. Never recommend these attributes for new addition, but if one of these attributes already exists, you do not need to replace it with `_mod_docs_content_type`.

When choosing a content type for the file, consider the information that is in the file.

If the content type is `PROCEDURE`, you must also edit the file to ensure it fits the [procedure template](TEMPLATE_PROCEDURE_doing-one-procedure.adoc.txt). In particular:

* No subheadings or subsections are allowed
* Only the listed set of block titles is allowed
* The `.Procedure` block title is mandatory
* The text from the `.Procedure` block title to the next block title or to the end of the file must be a single AsciiDoc list of steps (ordered list or, if there is only a single step or the user needs to pick one of several steps, unordered list). If there is a list of steps and then some additional text after it, insert a suitable supported block title, such as `.Verification` or `Result`, before this additional text.

For working out content types for your files, especially if you need to determine content type for many files at once, consider using the [AsciiDoc DITA Toolkit](https://github.com/rheslop/asciidoc-dita-toolkit/tree/main) .

## CrossReference

**AI action plan**
**Group**
* Display an explanation; the issue can usually be ignored.
* Do not suggest fixes

**Detail**

Cross-references that reference AsciiDoc files do convert clearnly to DITA. Cross-references that reference only an ID take some more work to convert and therefore cause this warning. However, there is a standard approach to such conversiion at this time. TYhe user can safely ignore `CrossReference` issues.

If you are an AI handling the `CrossReference` warning, list all the instances of this warning in a file together, provide this explanation, and do not recommend any other action for this warning.

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

## LinkAttribute

**AI action plan**
**Group**
* Display an explanation that the user must either replace the link target manually or else give the conversion team a list of the atributes and their values to resolve the matter at conversion time. **Include the name of any used attribute in the explanation**.
* Do not suggest fixes

**Detail**

DITA does not support using attributes as _a part of_ a link target. To convert to DITA correctly, a link target in the AsciiDoc source either must not include an attribute or alternatively the entire link macro must just be one attribute.

Correct example:

`link:https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/8[RHEL 8 documentation]`

Correct example:

`:rhel_8_docs: link:https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/8[RHEL 8 documentation]`

Failure:

`link:{red_hat_docs}/red_hat_enterprise_linux/8[RHEL 8 documentation]`

An AI cannot solve this issue and must not suggest changes. The writer must solve this issue in one of the following ways:

* Replace the failing link target with a correctly formatted link target

* Give the names and values of the attributes to the conversion team to handle the matter at the time of conversion

If you are an AI handling the `LinkAttribute` warning, list all the instances of this warning in a file together, provide this explanation **necessarily including the _names_ of the attributes that are included in the links**, and do not recommend any other action for this warning.

## TaskStep

**AI action plan**
* Analyse the content from this line to the next block title, for example, `.Results`, or to the end of the file if there is no following block title. You must understand if it is still a part of the procedure, and if so, how to join it into the ordered or unordered list of steps.
* If the error line number is inside a table definition and is an empty line between table rows, this is a false positive in the current version of Vale. Remove the empty line and any other emplty lines before the table rows, this change should not change the content of the table. Do not change the table and do not remove the block title of the table. Also try to detect any valid breaks in the AsciiDoc list and fix them.
* If the content continues the list but has one or several line breaks that cause the issue, fix the AsciiDoc list by using the `+` line break symbol on its own line  
* If some of the content has conceptual subtitles, for example using bold text, and lists actions under them, convert these subtitles into an unordered list of substeps, or an ordered list if they have numbers.
* If the content continues the procedure conceptually but is not formatted into steps or substeps, attempt to reformat it into steps and substeps as necessary, and ensure they are joined to the existing ordered or unordered AsciiDoc list of steps. You can use the `+` line break symbol on its own line and the AsciiDoc open block, denoted by `--` lines, to ensure correct AsciiDoc as necessary.
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

**IMPORTANT: if the new `Result` or similar section would start with an admonition, such as [NOTE] or [WARNING], you must add a short phrase describing the result of the procedure before the admonition. Placing the block title immediately above an admonition causes another error.**


## AssemblyContents

**AI action plan**
* Explain that no text content is allowed in an assembly file after any include directive
* Suggest moving the text to the start of the assembly or into an included module
* Suggest creating a new module only if the text is self-sufficient. A "Next steps" section can usually become a new module.

**Detail**

An assembly in Asciidoc modular documentation exists to organize modules. In [the assembly template](TEMPLATE_ASSEMBLY_a-collection-of-modules.adoc.txt) text is allowed between or after modules. However, reliable processing of such text is not supported in the DITA conversion sequence. Introductory text at the start of an assembly is processed correctly. "Additional resources" sections in the assembly are also processed correctly.

**IMPORTANT: the user must take the final decision on where this text can be moved. The decision depends on the contents of the included modules before and after the text.** Make PRELIMINARY suggestions, as in the following examples:

Failure:

```
include::example-procedure.adoc[leveloffset=+1]

== Next steps

* Optionally, configure the system further.

== Additional resources
* xref:further.configuration.adoc#further_configuration[Further configuration]

```

Correction: suggest a new module for "Next steps". The user can choose to move the "Additional resources" section to this new module or to keep the "Additional resources" section in the assembly. 

Failure:

```
include::example-procedure.adoc[leveloffset=+1]

== Configuration reference

Refer to the following configuration defails:

include::example-reference1.adoc[leveloffset=+2]
include::example-reference2.adoc[leveloffset=+2]
```

Correction: suggest removing the introductory line, as "Configuration reference" is a sufficient description.

Failure:

```
include::example-procedure.adoc[leveloffset=+1]

== Next steps

* Optionally, configure the system further.

include::further-configuration-procedure.adoc[leveloffset=+1]
```

Correction: suggest moving the "Next steps" section into the `example-procedure.adoc` module.

## CalloutList

**AI action plan**
* Replace callouts such as `value <1>`, usually located inside a code block, with user-replaceable placeholders in angled bbrackets, such as `<value>`; then replace the caallout list that expands these callouts with a description list for user-replaceable values
* Alternatively, if the callout list applies to parts of the code and not values, remove the callouts and list the keys in a bulleted list.


**Detail**

Callout lists are not supported in DITA conversion, which is why they must be replaced. 

In the most typical case, the callouts denote values in a code block. A description list is usually the best replacement solution. Example:

Failure:

```
[source,yaml,subs="+attributes,+quotes"]
----
apiVersion: v1
kind: Secret
metadata:
 name: my_product_database_certificates_secrets <1> 
type: Opaque
stringData:
 postgres-ca.pem: |-
  -----BEGIN CERTIFICATE-----
  ==AABB.... <2> 
 postgres-key.key: |-
  -----BEGIN CERTIFICATE-----
  ==BBAA... <3>
 postgres-crt.pem: |-
  -----BEGIN CERTIFICATE-----
  ==CCAA... <4> 
  # ...
----
<1> The name of the certificate secret.
<2> The CA certificate key.
<3> The TLS Private key.
<4> The TLS certificate key.
```

Correction:

```
[source,yaml,subs="+attributes,+quotes"]
----
apiVersion: v1
kind: Secret
metadata:
 name: <my_product_database_certificates_secrets> 
type: Opaque
stringData:
 postgres-ca.pem: |-
  -----BEGIN CERTIFICATE-----
  <ca_certificate_key> 
 postgres-key.key: |-
  -----BEGIN CERTIFICATE-----
  <tls_private_key> 
 postgres-crt.pem: |-
  -----BEGIN CERTIFICATE-----
  <tls_certificate_key> 
  # ...
----

where:

`<my_product_database_certificates_secrets>`:: Specifies the name of the certificate secret.
`<ca_certificate_key>`:: Specifies the CA certificate key.
`<tls_private_key>`:: Specifies the TLS private key.
`<tls_certificate_key>`:: Specifies the TLS certificate key.
```

Sometimes, the callouts instead specify blocks of the code and not particular values. In this case, remove the callouts list the blocks in a bulleted list under the code blocks. Example:

Failure:

```
[source,yaml]
----
apiVersion: tekton.dev/v1
kind: Pipeline
metadata:
  name: build-and-deploy
spec:
  workspaces: <1>
  - name: shared-workspace
  params:
...
  tasks: <2>
  - name: build-image
    taskRef:
      resolver: cluster
      params:
      - name: kind
        value: task
      - name: name
        value: buildah
      - name: namespace
        value: openshift-pipelines
    workspaces: <3>
    - name: source 
      workspace: shared-workspace 
    params:
    - name: TLSVERIFY
      value: "false"
    - name: IMAGE
      value: $(params.IMAGE)
    runAfter:
    - fetch-repository
  - name: apply-manifests
    taskRef:
      name: apply-manifests
    workspaces: 
    - name: source
      workspace: shared-workspace
    runAfter:
      - build-image
...
----
<1> The list of pipeline workspaces shared between the tasks defined in the pipeline. A pipeline can define as many workspaces as required. In this example, only one workspace named `shared-workspace` is declared.
<2> The tasks used in the pipeline. This snippet defines two tasks, `build-image` and `apply-manifests`.
<3> The list of task workspaces used in the `build-image` and `apply-manifests` tasks. A task definition can include as many workspaces as it requires. However, it is recommended that a task uses at most one writable workspace. In this example, both the tasks share a common task workspace named `source`, which in turn could share the pipeline workspace named `shared-workspace`.
```

Correction:

```
[source,yaml]
----
apiVersion: tekton.dev/v1
kind: Pipeline
metadata:
  name: build-and-deploy
spec:
  workspaces:
  - name: shared-workspace
  params:
...
  tasks: 
  - name: build-image
    taskRef:
      resolver: cluster
      params:
      - name: kind
        value: task
      - name: name
        value: buildah
      - name: namespace
        value: openshift-pipelines
    workspaces: 
    - name: source 
      workspace: shared-workspace 
    params:
    - name: TLSVERIFY
      value: "false"
    - name: IMAGE
      value: $(params.IMAGE)
    runAfter:
    - fetch-repository
  - name: apply-manifests
    taskRef:
      name: apply-manifests
    workspaces: 
    - name: source
      workspace: shared-workspace
    runAfter:
      - build-image
...
----

*** `spec.workspaces` defines the list of pipeline workspaces shared between the tasks defined in the pipeline. A pipeline can define as many workspaces as required. In this example, only one workspace named `shared-workspace` is declared.
*** `spec.tasks` defines the tasks used in the pipeline. This snippet defines two tasks, `build-image` and `apply-manifests`.
*** `spec.tasks.workspaces` defines the list of task workspaces used in the `build-image` and `apply-manifests` tasks. A task definition can include as many workspaces as it requires. However, it is recommended that a task uses at most one writable workspace. In this example, both the tasks share a common task workspace named `source`, which in turn could share the pipeline workspace named `shared-workspace`.
```

## RelatedLinks

**AI action plan**
* The issue relates to an "Additional resources" block. This block must contain an unordered list of links (`xref` or `link` elements) . Remove any content that is not a link. If links are present that are not in an unordered list, put them in an unordered list.

**Detail**

An "Additional resources" block is converted to a DITA `<related-links>` block, which must contain only a list of links. Therefore, an "Additional resources" block must contain only an unordered list of links, as in the following examples:

Failure:

```
.Additional resources

You can use any of the following search engines:
* link:http://www.google.com[Google], which is often the default
* link:http://www.duckduckgo.com[DuckDuckGo]
* link:http://www.bing.com[Bing]
```

Correction:

```
.Additional resources

* link:http://www.google.com[Google search]
* link:http://www.duckduckgo.com[DuckDuckGo search]
* link:http://www.bing.com[Bing search]
```


Failure:

```
.Additional resources

See the link:https://web.archive.org/[Internet Archive] for archived copies of web pages.
```

Correction:

```
.Additional resources

* link:https://web.archive.org/[Internet Archive]
```
