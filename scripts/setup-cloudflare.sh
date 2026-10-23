#!/usr/bin/env bash
# Chạy một lần: tạo project Pages "phoido", gắn domain phoido.danhthanh.dev, tạo DNS CNAME.
# Cần: CLOUDFLARE_API_TOKEN (Account: Cloudflare Pages Edit + Zone: DNS Edit), CLOUDFLARE_ACCOUNT_ID, CLOUDFLARE_ZONE_ID
set -euo pipefail
: "${CLOUDFLARE_API_TOKEN:?missing}" "${CLOUDFLARE_ACCOUNT_ID:?missing}" "${CLOUDFLARE_ZONE_ID:?missing}"
API=https://api.cloudflare.com/client/v4
H=(-H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" -H "Content-Type: application/json")
PROJECT=phoido
DOMAIN=phoido.danhthanh.dev

call() { # $1=đường dẫn API, $2=JSON body
  local out
  out=$(curl -sS -X POST "${H[@]}" "$API$1" --data "$2")
  echo "$1 -> $(echo "$out" | jq -c '{success, errors: [(.errors // [])[].message]}')"
  echo "$out" | jq -e '.success or ((.errors // []) | map(.message) | join(" ") | test("already|exist"; "i"))' >/dev/null \
    || { echo "Lỗi ở bước $1"; exit 1; }
}

call "/accounts/$CLOUDFLARE_ACCOUNT_ID/pages/projects" "{\"name\":\"$PROJECT\",\"production_branch\":\"main\"}"
SUB=$(curl -sS "${H[@]}" "$API/accounts/$CLOUDFLARE_ACCOUNT_ID/pages/projects/$PROJECT" | jq -r '.result.subdomain')
[ -n "$SUB" ] && [ "$SUB" != "null" ] || { echo "Không đọc được subdomain của project"; exit 1; }
call "/accounts/$CLOUDFLARE_ACCOUNT_ID/pages/projects/$PROJECT/domains" "{\"name\":\"$DOMAIN\"}"
call "/zones/$CLOUDFLARE_ZONE_ID/dns_records" "{\"type\":\"CNAME\",\"name\":\"phoido\",\"content\":\"$SUB\",\"proxied\":true,\"ttl\":1}"
echo "Xong. Chạy workflow Deploy rồi mở https://$DOMAIN"
