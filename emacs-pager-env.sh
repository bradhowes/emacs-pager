# Configuration snippet for a Bash shell running as an Emacs sub-process
# Expects Emacs to set TERM env variable to be "emacs" or "dumb"
# Add to your own ${HOME}/.bashrc or ${HOME}/.zshrc or whatever else.

export LESS="-XF"
export PAGER="less ${LESS}"

case "${TERM}" in
    xterm*|rxvt|vt100|screen-*)
    ;;

    emacs|dumb)
        export TERM=xterm-256color
        export CLICOLOR=yes
        export EDITOR=emacsclient
        export PAGER="${HOME}/bin/emacs-pager"
        function man
        {
            # On macOS just ask Emacs to render man page.
            if [[ "$(uname)" = "Darwin" ]]; then
                emacsclient --eval "(manual-entry \"${@}\")"
            else
                command man -Tutf8 ${@} | ${PAGER}
            fi
        }
        ;;
esac

export MANPAGER="${PAGER}"
export GIT_PAGER="${PAGER}"
