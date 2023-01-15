#!/bin/sh

## Script for Preview In Termial File Manager

pygmentize_fn(){
   lexer=$(pygmentize -N "$1")
   if [[ $lexer != text ]]; then
	   pygmentize -O style="emacs" -l "$lexer" "$1"
   else
	   pygmentize -O style="emacs" -g "$1"
   fi
}

case "$1" in
    *.tar*) tar tf "$1";;
    *.zip) unzip -l "$1";;
    *.rar) unrar l "$1";;
    *.7z) 7z l "$1";;
    *.pdf) pdftotext "$1" -;;
    *) pygmentize_fn "$1" || true;;
esac
