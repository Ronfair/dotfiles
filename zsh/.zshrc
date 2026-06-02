# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /usr/share/cachyos-zsh-config/cachyos-config.zsh
source ~/.config/zsh/.zsh-ai.zsh
export EDITOR=nvim

alias update='paru'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

proj() {
    BASE_DIR="$HOME/Projects"

    if [ -z "$1" ]; then
        echo "Usage: proj <folder>"
        return 1
    fi

    matches=($BASE_DIR/**/$1(N))

    if [ ${#matches[@]} -eq 0 ]; then
        echo "No matching folder found"
        return 1
    elif [ ${#matches[@]} -gt 1 ]; then
        echo "Multiple matches found:"
        printf '%s\n' "${matches[@]}"
        return 1
    fi

    cd "$matches[1]" || return

    # Auto-activate venv
    if [ -f "venv/bin/activate" ]; then
        source venv/bin/activate
        echo "Activated venv"
    elif [ -f ".venv/bin/activate" ]; then
        source .venv/bin/activate
        echo "Activated .venv"
    fi
}
