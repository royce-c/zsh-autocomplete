#!/bin/zsh
() {
  zmodload -F zsh/parameter p:funcfiletrace p:functions

  # Workaround for https://github.com/zdharma/zinit/issues/366
  # NOTE: Needs to come before _everything_ else!
  [[ -v functions[.zinit-shade-off] ]] &&
      .zinit-shade-off "${___mode:-load}"
  [[ -v functions[.zinit-tmp-subst-off] ]] &&
      .zinit-tmp-subst-off "${___mode:-load}"

  zmodload zsh/param/private
  setopt completeinword NO_flowcontrol NO_listbeep NO_singlelinezle
  typeset -ga _autocomplete__funcfiletrace=( $funcfiletrace )

  local basedir=${${(%):-%x}:P:h}
  hash -d autocomplete=$basedir zsh-autocomplete=$basedir
  builtin autoload +X -Uz ~autocomplete/Functions/**/.autocomplete:*~*.zwc(D-:)
  .autocomplete:__main__ "$@"
}
