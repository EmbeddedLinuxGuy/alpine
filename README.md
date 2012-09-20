Alpine
======

v 0.2, 19 Sep 2012

Alpine takes a plain text file as input, such as UTF-8 ebooks from
Gutenberg, plus accompanying images or tables, and generates a
ready-to-print PDF booklet (4-up US Letter size, 4 1/4" x 5 1/2"). It
uses PDFLaTeX for typesetting, and PDF::Reuse for N-up
bookletizing. Currently supported texts are:

* Individual books (e.g. the Book of Daniel) from the King James Bible (via Gutenberg.org)

* Individual stories from "The Book of Wonder" by Dunsany (via Gutenberg.org)

* Chapters from Dostoevsky's "Demons" (via Gutenberg.org)

* Chapters from "Dictatorship vs. Democracy" by Trotsky (via Gutenberg.org)

* Chapters from the Dhammapada translated by Mueller (via Wikisource.org)

* User-written org-mode files augmented with TeX markup (tables and lists)

To test:

    cd test
    ./runtests


To run:

    alpine daniel < kjv.txt > daniel.tex

    # Custom document including tables and lists
    alpine - < vandals.org > vandals.tex

    alpine gnoles < book-of-wonder.txt > gnoles.tex

    # Demons Part I chapter I
    alpine introductory 1 1  < demons.txt > demons-1.tex

    # Trotsky chapter 1
    alpine 1 < trotsky.txt > trotsky-1.tex

    alpine 1 < dhammapada.txt > dhammapada-1.tex

Then:

    pdflatex file.tex
    pdf-assemble file.pdf outside.pdf outside
    pdf-assemble file.pdf inside.pdf inside

Note: pdf-assemble may require hand-editing depending on the number of pages in the document.

To do: wrap in a web UI which generates booklets based on form input.
