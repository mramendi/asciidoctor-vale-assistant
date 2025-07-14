# asciidoctor-vale-assistant

Gemini-based assistant for fixing issues in AsciiDoc files flagged by [asciidoctor-dita-vale](https://github.com/jhradilek/asciidoctor-dita-vale).

You can use the assistant on any AsciiDoc file and its Vale report, and the assistant will offer explanations and suggest corrections. If you are working on fixing your files to ensure they are ready for DITA conversion, use the assistant as a "first line of support", before seeking help from the conversion team.

(You can also read the [fixing-instructions-AI.md](assistant/fixing-instructions-AI.md) file and use the instructions yourself, of course. The file is optimized for AI but still human-readable)

The assistant works as a "Gem", a custom instance of Gemini. Unfortunately, Gemini does not seem to offer a feature to share Gems with other users yet. Therefore, you must re-create the Gem as described here.

The Gem does not update automatically, so you might want to occasionally update the source files and then delete and re-create your Gem.

The procedures were tested on an enterprise Google account that includes paid Gemini Web.

## Re-creating the Gem

1. Clone this repository and change into its directory. Alternatively, if you already cloned this repository before, change to its directory and run `git pull`.
1. Run the following commands:

    ```terminal
    cd assistant
    ```

    ```terminal
    ./get-files.sh
    ```

    The script downloads additional files for your Gem.

1. Open [Gemini](https://gemini.google.com)
1. Click **Explore Gems**, then click the **+New Gem** button.
![New Gem window](create-new-gem.png)
1. In the **Name** field, specify `Asciidoctor Vale correction`.
1. Under **Knowledge**, click the `+` button.
1. In the file selection dialog, navigate to the `assistant` subdirectory of this repository, and then select all the displayed files _except_ `gem-prompt.md`, `get-files.sh`, and `.gitignore`.
![Selecting files](select-files.png)
1. Click **Open** to upload the files.
1. Open the `gem-prompt.md` file in a text editor, for example:

    ```terminal
    gedit gem-prompt.md
    ```

1. Select the entire content of the file and copy it into the clipboard, then paste into the **Instructions** field of the gem. ![Completed Gem window](completed-gem.png)

1. Click **Save**. The Gem now appears in your Gemini navigation menu.

## Getting assistance with a file

Use this tool to get assistance on a single file. The assistant does not currently support working with many files at once.

We use `module.adoc` as the example name for your Asciidoc file.

1. Configure Vale as described in the documentation for [asciidoctor-dita-vale](https://github.com/jhradilek/asciidoctor-dita-vale).
1. Run Vale for the file, and save the output with a `.txt` extension because Gemini does not support `.adoc`:

    ```terminal
    vale module.adoc > module.vale.txt
    ```

1. Run the `nl` utility to add line numbers to the file:

    ```terminal
    nl -ba module.adoc > module.adoc.numbered.txt
    ```

1. Open [Gemini](https://gemini.google.com).
1. In the Gems section of the Gemini navigation panel, select the **Asciidoctor vale correction** gem.
1. In the prompt window, use the `+` button to upload the Vale output file (`module.vale.txt`) and the numbered version of the original file (`module.adoc.numbered.txt`).
1. Enter a brief prompt, for example, `Let's Go!`, and then press Enter.
The system outputs explanations and suggestions for the issues in your input.
1. If the assistant proposes that you split the module, enter an additional prompt, such as `Split this content into multiple modules`, to have the assistant generate the modules and snippet to include them in the assembly. **You must verify that the new content matches the content of the existing module**.
1. Start a new thread with the Gem to work on another file.

## Reporting issues

If you report issues, please include both files that you uploaded to the Gem and also the thread log.

1. To get a thread log, click the **Share** button under the last response in the thread, and select **Export to Docs**.![Share](sharebutton.png).
1. Go to [Google Docs](http://docs.google.com) to find the log as a Google Doc.
1. In the **General access** section of the **Share** menu for the Google Doc, select "Red Hat" so anyone with the link can view the document, then copy and send the link with the issue.
