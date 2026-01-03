# pdf-creator

Creates a PDF documents from [DocBook](https://docbook.org/) XML.

## Description

This project is a Maven POM that generates PDF documents processing DocBook XML files using XSLT.

## Usage

The project can be easily run inside a Docker container using the `run.sh` Bash script.

Place your DocBook XML files in the `src/docbkx` folder.

If needed, customize the PDFs output format by editing `src/docbkx/focbook-fo.xsl`.
