set -x EDITOR vim
set -x RBENV_ROOT /usr/local/var/rbenv


# Paths
test -d /usr/local/share/npm/bin ; and set PATH /usr/local/share/npm/bin $PATH
test -d /usr/local/sbin          ; and set PATH /usr/local/sbin $PATH
test -d /usr/local/bin           ; and set PATH /usr/local/bin $PATH

# Navigation
function c     ; cd $argv; and ls -al; end
function ..    ; c .. ; end
function ...   ; c ../.. ; end

alias tree "tree -I 'node_modules|.git' -P '*|.*' -a"



# Utilities
function g; hub $argv ; end


function fish_prompt
  git_branch

  set_color normal
  printf '%s ' (prompt_pwd)

  set_color white
  printf '[%s' $git_branch
  if test $git_dirty_count -gt 0
    printf ':'
    set_color red
    printf $git_dirty_count
    set_color white
  end
  printf ']'
  set_color normal
  printf ' » '
end

# rbenv
if test -d $RBENV_ROOT
  set PATH $RBENV_ROOT/bin $PATH
  set PATH $RBENV_ROOT/shims $PATH
  rbenv rehash >/dev/null ^&1
end

