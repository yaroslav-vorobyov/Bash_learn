#!/usr/bin/env bash
# 
# add to ~/.bashrc :
# echo 'source ~/.scripts/addons/tmux.sh' >> ~/.bashrc
# 
## tmux-bash-completion in bash (keywords + options)
## https://github.com/tomeon/tmux-bash-completion


_tmux () {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local prev="${COMP_WORDS[COMP_CWORD-1]}"

    local -a return_trap=()
    read -r -a _ _ return_trap < <(builtin trap -p return)

    # Get rid of trailing signal name
    return_trap=("${return_trap[@]:0:$(( ${#return_trap[@]} - 2 ))}")
    trap "${return_trap[@]:-:}; unset -f _tmux::lscm _tmux::check_flags &>/dev/null; trap '${return_trap[@]:--}' return" return

    local -a tmux_flags=(
        -2
        -C
        -c:
        -f:
        -L:
        -l
        -S:
        -u
        -v
        -V
    )

    _tmux::lscm () {
        local wanted_cmd="$1"
        shift

        local cmd alias
        local -a lscm_output=()
        while read -ra lscm_output; do
            set -- "${lscm_output[@]}"
            # The full command name is the first field in each line of lscm
            cmd="$1"
            shift

            # tmux aliases are surrounded with parentheses
            if [[ "$1" == '('*')' ]]; then
                alias="${1//[()]/}"
                shift
            fi

            # If no command is sought, echo the command and its alias and
            # return without processing the command's options
            if [[ -z $wanted_cmd ]]; then
                echo "$cmd" "$alias"
                continue
            # If a command was specified and it does not match the current
            # command, skip to the next iteration
            elif [[ "$wanted_cmd" != "$cmd" ]] && [[ "$wanted_cmd" != "$alias" ]]; then
                continue
            fi

            # Now process any flags
            local optv opt
            while (( $# )); do
                opt="$1"
                # All options are surrounded with square brackets and begin
                # with a single dash
                if [[ "$opt" != '[-'* ]]; then
                    shift
                # If $opt doesn't end with a square bracket, it takes an
                # argument
                elif [[ "$opt" != *']' ]]; then
                    # Trim the opening bracket and append a colon to indicate
                    # that this option takes an argument
                    optv+=("${opt#[}:")

                    # Remove both the option and the argument from $@
                    shift 2
                else
                    # Remove opening bracket and all dashes.  Safe because all
                    # tmux options are single letters (i.e., no --long-options)
                    opt="${opt#[}"
                    opt="${opt//-/}"

                    # Some options are pipe-delimited
                    opt="${opt//|/}"

                    # Process each character separately
                    local flag
                    while read -r -n 1 flag; do
                        [[ -z "$flag" ]] && continue
                        optv+=("-$flag")
                    done <<<"${opt%]}"

                    shift
                fi
            done

            echo "${optv[@]}"
            break
        done < <(command tmux lscm)

        unset -f "${FUNCNAME[0]}"

        return 0
    }

    # If a flag ends with ':', the user must provide an argument.  Signal that
    # no completion should occur by returning 1.
    _tmux::check_flags () {
        local prev="$1"
        shift

        if [[ "$prev" == -* ]]; then
            local flag trimmed
            for flag in "$@"; do
                trimmed="${flag%:}"
                if [[ "$prev" == "$trimmed" ]] && (( ${#trimmed} < ${#flag} )); then
                    return 1
                fi
            done
        fi

        unset -f "${FUNCNAME[0]}"

        return 0
    }

    # Scan existing argument list for non-flag options
    if (( COMP_CWORD > 0 )); then
        local cmd=''
        local -i comp_iword=1
        local maybe_cmd="${COMP_WORDS[comp_iword]}"

        while (( comp_iword < COMP_CWORD )); do
            if [[ "$maybe_cmd" != -* ]]; then
                cmd="$maybe_cmd"
                break
            fi
            ((comp_iword++))
            maybe_cmd="${COMP_WORDS[comp_iword]}"
        done
    fi

    # If we haven't seen a command yet, provide completion based only on
    # commands and flags to tmux itself.
    if [[ -z "$cmd" ]]; then
        if ! _tmux::check_flags "$prev" "${tmux_flags[@]}"; then
            return 1
        fi

        COMPREPLY=($(compgen -W "$(_tmux::lscm) ${tmux_flags[*]//:/}" -- "${cur}"))
    else
        local -a optv
        optv=($(_tmux::lscm "$cmd"))

        if ! _tmux::check_flags "$prev" "${optv[@]}"; then
            return 1
        fi

        COMPREPLY=($(compgen -W "${optv[*]//:/}" -- "${cur}"))
    fi

    return 0
}

complete -F _tmux tmux