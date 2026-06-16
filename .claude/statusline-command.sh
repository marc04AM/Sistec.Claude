#!/usr/bin/env bash
# Claude Code status line:  dir   branch   model   effort   [ctx bar] NN%
# Nerd Font glyphs + ANSI color. Reads session JSON from stdin.

input=$(cat)

# ---- data ------------------------------------------------------------------
model=$(printf '%s' "$input" | jq -r '.model.display_name // empty')
cdir=$(printf '%s' "$input"  | jq -r '.workspace.current_dir // .cwd // empty')
used=$(printf '%s' "$input"  | jq -r '.context_window.used_percentage // empty')
effort=$(printf '%s' "$input" | jq -r '.effort.level // empty')

# basename of current dir (handle both / and \ separators)
dir_name="${cdir//\\//}"; dir_name="${dir_name%/}"; dir_name="${dir_name##*/}"
[ -z "$dir_name" ] && dir_name="$cdir"

# git branch + dirty flag
branch=$(GIT_OPTIONAL_LOCKS=0 git -C "$cdir" rev-parse --abbrev-ref HEAD 2>/dev/null)
if [ -n "$branch" ]; then
    [ -n "$(GIT_OPTIONAL_LOCKS=0 git -C "$cdir" status --porcelain 2>/dev/null)" ] && branch="${branch} *"
fi

# ---- glyphs (Nerd Font) ----------------------------------------------------
I_DIR=$''      # folder open
I_GIT=$''      # git branch
I_MODEL=$''    # gears
I_EFFORT=$''   # bolt
I_CTX=$''      # bar chart
PL=$''         # powerline thin separator
BLK=$'█'        # full block
SHD=$'░'        # light shade

# ---- colors ----------------------------------------------------------------
e=$'\033'
RESET="$e[0m"; DIM="$e[2m"
BLUE="$e[38;5;75m"; MAG="$e[38;5;176m"; CYAN="$e[38;5;80m"
GREEN="$e[38;5;114m"; YELLOW="$e[38;5;221m"; RED="$e[38;5;203m"; GRAY="$e[38;5;245m"

# ---- context bar -----------------------------------------------------------
ctx=""
if [ -n "$used" ]; then
    pct=${used%.*}; [ -z "$pct" ] && pct=0
    (( pct < 0 )) && pct=0; (( pct > 100 )) && pct=100
    width=10; filled=$(( pct * width / 100 ))
    (( filled > width )) && filled=$width
    empty=$(( width - filled ))
    bar=""
    for ((i=0; i<filled; i++)); do bar+="$BLK"; done
    for ((i=0; i<empty;  i++)); do bar+="$SHD"; done
    if   (( pct >= 80 )); then c="$RED"
    elif (( pct >= 50 )); then c="$YELLOW"
    else                       c="$GREEN"; fi
    ctx="${GRAY}${I_CTX}${RESET} ${c}${bar} ${pct}%${RESET}"
fi

# ---- assemble --------------------------------------------------------------
parts=()
[ -n "$dir_name" ] && parts+=("${BLUE}${I_DIR} ${dir_name}${RESET}")
[ -n "$branch" ]   && parts+=("${MAG}${I_GIT} ${branch}${RESET}")
[ -n "$model" ]    && parts+=("${CYAN}${I_MODEL} ${model}${RESET}")
[ -n "$effort" ]   && parts+=("${YELLOW}${I_EFFORT} ${effort}${RESET}")
[ -n "$ctx" ]      && parts+=("$ctx")

sep=" ${DIM}${GRAY}${PL}${RESET} "
out="Sistec.Claude V3"
for i in "${!parts[@]}"; do
    (( i > 0 )) && out+="$sep"
    out+="${parts[$i]}"
done
out+=""
printf '%s' "$out"
