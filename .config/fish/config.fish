set -x EDITOR vim

# Navigation
function ..    ; cd .. ; end
function ...   ; cd ../.. ; end

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
