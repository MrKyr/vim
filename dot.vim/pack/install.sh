#!/usr/bin/env bash
#
# (ↄ) Copyleft 2019 Kyriakos Bellios <kyr_AT_designisdesign_DOT_eu>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# version 2, as published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License version 2 for more details.
#
# You should have received a copy of the GNU General Public License
# version 2 along with this program; if not, write to the Free
# Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
# MA 02110-1301, USA.
#
# This file lives in ~/.vim/pack/install.sh
# Remember to add executable: chmod +x ~/.vim/pack/install.sh
#
# Create new folder in ~/.vim/pack that contains a start folder and cd into it.
#
# Arguments:
#   package_group, a string folder name to create and change into.
#
# Examples:
#   set_group syntax-highlighting
#
function set_group () {
  package_group=$1
  path="$HOME/.vim/pack/$package_group/start"
  mkdir -p "$path"
  cd "$path" || exit
}
# Clone or update a git repo in the current directory.
#
# Arguments:
#   repo_url, a URL to the git repo.
#
# Examples:
#   package https://github.com/tpope/vim-endwise.git
#
function package () {
  repo_url=$1
  expected_repo=$(basename "$repo_url" .git)
  if [ -d "$expected_repo" ]; then
    cd "$expected_repo" || exit
    result=$(git pull --force)
    echo "$expected_repo: $result"
  else
    echo "$expected_repo: Installing..."
    git clone -q "$repo_url"
  fi
}
(
set_group snippets
package https://github.com/tomtom/tlib_vim.git &
package https://github.com/MarcWeber/vim-addon-mw-utils.git &
package https://github.com/garbas/vim-snipmate.git &
package https://github.com/honza/vim-snippets.git &
wait
) &
(
set_group markdown
package https://github.com/vimwiki/vimwiki.git &
package https://github.com/pbrisbin/vim-mkdir.git &
package https://github.com/jkramer/vim-checkbox.git &
# package https://github.com/iamcco/markdown-preview.vim.git &

package https://github.com/neoclide/vim-node-rpc.git &
package https://github.com/iamcco/markdown-preview.nvim.git &
# package https://github.com/MrKyr/markdown-preview.vim.git &
wait
) &
(
set_group airline
package https://github.com/vim-airline/vim-airline.git &
package https://github.com/vim-airline/vim-airline-themes.git &
wait
) &
(
set_group development
package https://github.com/vim-scripts/indentpython.git &
) &
(
set_group themes
package https://github.com/cormacrelf/vim-colors-github.git &
wait
) &
(
set_group syntax
package https://github.com/morhetz/gruvbox.git &
package https://github.com/mityu/vim-applescript.git &
package https://github.com/jwalton512/vim-blade.git &
package https://github.com/mzlogin/vim-markdown-toc.git &
wait
) &
(
set_group utils
package https://github.com/tpope/vim-fugitive.git &
package https://github.com/ledger/vim-ledger.git &
package https://github.com/justmao945/vim-clang.git &
package https://github.com/tpope/vim-commentary.git &
wait
) &
wait
