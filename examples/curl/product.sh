#!/usr/bin/env bash
# MediaMarkt Product API – cURL example
# Usage: PILOTERR_API_KEY=your-key ./product.sh
set -euo pipefail

curl -sS -G "https://api.piloterr.com/v2/mediamarkt/product" \
  -H "x-api-key: ${PILOTERR_API_KEY}" \
  --data-urlencode query=https://www.mediamarkt.ch/fr/product/_apple-iphone-15-2203371.html
