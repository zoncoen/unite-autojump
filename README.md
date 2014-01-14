# unite-autojump

A Unite.vim plugin to change the current working directory with autojump.

## Requirements

- [unite.vim](https://github.com/Shougo/unite.vim)
- [autojump](https://github.com/joelthelion/autojump)

## Installation

**With [NeoBundle](https://github.com/Shougo/neobundle.vim):**

    NeoBundle 'zoncoen/unite-autojump'

## Usage

To change the current working directory with autojump.

    :Unite autojump

## Examples

A simple mapping that will configure `:j` to change the current working directory with autojump:

    nnoremap :j <ESC>:Unite autojump<CR>

## License

This software is released under the MIT License.
