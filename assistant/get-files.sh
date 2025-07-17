curl -O https://raw.githubusercontent.com/jhradilek/asciidoctor-dita-vale/refs/heads/main/README.md
curl -O https://raw.githubusercontent.com/redhat-documentation/modular-docs/refs/heads/main/modular-docs-manual/files/TEMPLATE_ASSEMBLY_a-collection-of-modules.adoc
curl -O https://raw.githubusercontent.com/redhat-documentation/modular-docs/refs/heads/main/modular-docs-manual/files/TEMPLATE_CONCEPT_concept-explanation.adoc
curl -O https://raw.githubusercontent.com/redhat-documentation/modular-docs/refs/heads/main/modular-docs-manual/files/TEMPLATE_PROCEDURE_doing-one-procedure.adoc
curl -O https://raw.githubusercontent.com/redhat-documentation/modular-docs/refs/heads/main/modular-docs-manual/files/TEMPLATE_REFERENCE_reference-material.adoc
for i in TEMPLATE*.adoc ; do mv $i $i.txt ; done
