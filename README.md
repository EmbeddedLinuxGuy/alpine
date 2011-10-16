Alpine
======

A document formatting system by Jesse Zbikowski

v 0.1, 15 Oct 2011

This program takes a plain text file along with accompanying images or
tables, and generates a ready-to-print PDF booklet. Currently
supported texts are:

* User-written org-mode files augmented with TeX

* Books of the King James Bible from Gutenberg.org (e.g. the Book of
  Daniel)

* Chapters of Dostoevsky's "Demons" from Gutenberg.org

* "The Book of Wonder" by Dunsany, from Gutenberg.org

To run:

    alpine daniel < kjv.txt > daniel.tex

    alpine - < vandals.org > vandals.tex

    alpine gnoles < book-of-wonder.txt < gnoles.tex

    alpine introductory 1 1  < demons.txt > demons-1.tex

Then:

    pdflatex infile.tex
    pdf-assemble infile.pdf outfile.pdf

