#!/bin/zsh
CACHE=/tmp/claude_5h_usage.cache
MAXAGE=120

if [[ -f "$CACHE" ]] && (( $(date +%s) - $(stat -f %m "$CACHE") < MAXAGE )); then
  cat "$CACHE"
  exit
fi

TOKEN=$(security find-generic-password -s 'Claude Code-credentials' -w 2>/dev/null | jq -r '.claudeAiOauth.accessToken // empty' 2>/dev/null)
[[ -z "$TOKEN" ]] && { echo "–"; exit; }

RESP=$(curl -s --max-time 3 "https://api.anthropic.com/api/oauth/usage" \
  -H "Authorization: Bearer $TOKEN" \
  -H "anthropic-beta: oauth-2025-04-20")
PCT=$(echo "$RESP" | jq -r '.five_hour.utilization // empty' 2>/dev/null)

if [[ -z "$PCT" ]]; then
  [[ -f "$CACHE" ]] && cat "$CACHE" || echo "–"
  exit
fi

OUT=$(printf "%.0f%%" "$PCT")
echo "$OUT" > "$CACHE"
echo "$OUT"
