#!/bin/bash
shopt -s extglob
# Claude Code status line, one line: context % with tokens, a bar and a mood face, prompt cache
# countdown and hit %; the 5-hour and 7-day usage limits with reset times sit at the right edge.
# The last cache miss cause shows for 10 minutes after a miss. Claude Code passes the session JSON on stdin.

# "|" not tab: read collapses consecutive tabs, which would shift fields when one is empty.
IFS='|' read -r ctx eighths tok cache hit miss h5 h5_reset d7 d7_reset < <(jq -r '
def short: if . >= 1000000 then "\(. / 100000 | floor / 10)M" else "\(. / 1000 | round)k" end;
.context_window as $cw | .prompt_cache as $pc |
[
  ($cw.used_percentage // 0 | floor),
  # Bar fill in eighths of a cell, 5 cells
  (if ($cw.context_window_size // 0) > 0 then ($cw.total_input_tokens // 0) * 40 / $cw.context_window_size | floor else 0 end),
  ($cw.total_input_tokens // 0 | short),
  # Cache: empty when caching is off or not seen yet, else expiry epoch when warm, else "cold"
  (if $pc == null or ($pc.caching_observed | not) then "" elif $pc.warm and $pc.expires_at then $pc.expires_at else "cold" end),
  ($pc.hit_ratio // "" | if . == "" then . else . * 100 | floor end),
  # Last miss cause, short form (tools, system, ttl, server), for 10 minutes after the miss
  (if $pc.last_miss_cause and $pc.last_miss_at and (now - $pc.last_miss_at) < 600
   then $pc.last_miss_cause.causes | map(if startswith("likely") then "server" else split("_")[0] end) | join(",")
   else "" end),
  (.rate_limits.five_hour.used_percentage // "" | if . == "" then . else floor end),
  .rate_limits.five_hour.resets_at // "",
  (.rate_limits.seven_day.used_percentage // "" | if . == "" then . else floor end),
  .rate_limits.seven_day.resets_at // ""
] | map(tostring) | join("|")')

# Green under 50 %, yellow under 80 %, red from 80 %
color() {
  if (( $1 >= 80 )); then printf '\033[31m'; elif (( $1 >= 50 )); then printf '\033[33m'; else printf '\033[32m'; fi
}
red=$'\033[31m' yellow=$'\033[33m' green=$'\033[32m' reset=$'\033[0m'

# Eighth blocks on a dark track, so a partly filled cell still reads as a bar
parts=(' ' ▏ ▎ ▍ ▌ ▋ ▊ ▉)
bar=""
for i in {0..4}; do
  cell=$(( eighths - i * 8 ))
  if (( cell >= 8 )); then bar+="█"; elif (( cell > 0 )); then bar+="${parts[cell]}"; else bar+=" "; fi
done

if (( ctx >= 90 )); then face='(×_×)'; elif (( ctx >= 80 )); then face='(°_°;)'
elif (( ctx >= 50 )); then face='(•_•)'; else face='(•‿•)'; fi

line="$(color "$ctx")${ctx}% ${tok} "$'\033[48;5;237m'"${bar}${reset} $(color "$ctx")${face}${reset}"

if [[ $cache == cold ]]; then
  line+="  ❄"
elif [[ -n $cache ]]; then
  mins=$(( (cache - EPOCHSECONDS + 59) / 60 ))
  if (( mins <= 0 )); then line+="  ❄"
  else
    # Red under 5 minutes left, yellow under 15
    if (( mins < 5 )); then c=$red; elif (( mins < 15 )); then c=$yellow; else c=$green; fi
    line+="  🔥${c}${mins}m${reset}"
  fi
fi
# Cache hit %: green from 80 %, yellow under 80 %, red under 50 %
if [[ -n $hit ]]; then
  if (( hit < 50 )); then c=$red; elif (( hit < 80 )); then c=$yellow; else c=$green; fi
  line+=" ${c}${hit}%${reset}"
fi
[[ -n $miss ]] && line+=" ${yellow}⚠${miss}${reset}"

# Usage limits only exist for Claude subscriptions, not API-key sessions
right=""
if [[ -n $h5 ]]; then
  right+="$(color "$h5")5h ${h5}%${reset}"
  [[ -n $h5_reset ]] && right+=" ↻$(date -d "@$h5_reset" +%H:%M)"
  if [[ -n $d7 ]]; then
    right+="  $(color "$d7")7d ${d7}%${reset}"
    [[ -n $d7_reset ]] && right+=" ↻$(date -d "@$d7_reset" '+%a %H:%M')"
  fi
fi

# Display width: drop colour codes; 🔥 takes two columns
width() {
  local s=${1//$'\033['*([0-9;])m/}
  local wide=${s//[^🔥]/}
  echo $(( ${#s} + ${#wide} ))
}
# Claude Code indents the line by 2 and cuts it with … past COLUMNS - 4, so pad the right part
# to that edge. When both halves don't fit (phone), two spaces; the reset times get cut first.
if [[ -n $right ]]; then
  pad=$(( ${COLUMNS:-80} - 4 - $(width "$line") - $(width "$right") ))
  (( pad < 2 )) && pad=2
  printf -v gap '%*s' "$pad" ''
  line+="$gap$right"
fi
printf '%s\n' "$line"
