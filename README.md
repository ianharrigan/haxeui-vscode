# HaxeUI support for Visual Studio Code

[![Build Status](https://travis-ci.org/haxeui/haxeui-vscode.svg?branch=master)](https://travis-ci.org/haxeui/haxeui-vscode)
[![Code Climate](https://codeclimate.com/github/haxeui/haxeui-vscode/badges/gpa.svg)](https://codeclimate.com/github/haxeui/haxeui-vscode)
[![Issue Count](https://codeclimate.com/github/haxeui/haxeui-vscode/badges/issue_count.svg)](https://codeclimate.com/github/haxeui/haxeui-vscode)

This is a work in progress extension for [Visual Studio Code](https://code.visualstudio.com) that adds support for the [HaxeUI](https://github.com/haxeui/haxeui-core) library.

## Dependencies

You must have [haxeui-core](https://github.com/haxeui/haxeui-core), [haxeui-blank](https://github.com/haxeui/haxeui-blank) and [hscript](https://lib.haxe.org/p/hscript) installed.

Each [backend](https://github.com/haxeui/haxeui-core#backends) requires its library.

## Features

* Project initialization. Backend support:
  * [x] html5
  * [ ] openfl
  * [ ] flambe
  * [ ] pixijs
  * [ ] nme
  * [ ] luxe
  * [ ] hxwidgets
  * [ ] xwt
* Preview of a UI file
  ![demo](demo.gif)

## Planned features

* Live preview
* UI builder
* CSS and UI file completion, highlighting, and diagnostics
