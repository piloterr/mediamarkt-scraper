<p align="center">
  <a href="https://www.piloterr.com"><img src="images/banner.png" alt="MediaMarkt Scraper API by Piloterr – scrape MediaMarkt data as JSON" width="100%"></a>
</p>

# MediaMarkt Scraper API

[![Discord](https://img.shields.io/badge/Discord-Join%20the%20community-5865F2?logo=discord&logoColor=white)](https://discord.gg/CFj3ph8aHU) [![Get API key](https://img.shields.io/badge/Piloterr-Get%20a%20free%20API%20key-111827)](https://app.piloterr.com) [![API docs](https://img.shields.io/badge/Docs-OpenAPI-0EA5E9)](https://app.piloterr.com/openapi) [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

The **Piloterr MediaMarkt Scraper API** lets you extract public data from MediaMarkt as **clean, structured JSON** — no proxies, headless browsers or HTML parsing to maintain. Endpoints available in production:

- **MediaMarkt Product API** — Read one MediaMarkt product by id or product URL, in the region you choose.
- **MediaMarkt Search API** — Search a MediaMarkt shop by keyword.

Use it for price monitoring, assortment tracking, competitor analysis, product research or catalog enrichment.

| Endpoint | Path | Credits | What you get |
|---|---|---|---|
| [MediaMarkt Product API](#mediamarkt-product-api) | `/v2/mediamarkt/product` | 2 | Read one MediaMarkt product by id or product URL, in the region you choose. You get price, currency, EAN, and availability. |
| [MediaMarkt Search API](#mediamarkt-search-api) | `/v2/mediamarkt/search` | 2 | Search a MediaMarkt shop by keyword. Set region for Switzerland, Germany, Austria, and the other MediaMarktSaturn countries, then page the results. |

## Table of contents

- [How it works](#how-it-works)
- [MediaMarkt Product API](#mediamarkt-product-api)
- [MediaMarkt Search API](#mediamarkt-search-api)
- [Code examples in other languages](#code-examples-in-other-languages)
- [Practical use cases](#practical-use-cases)
- [Why Piloterr?](#why-piloterr)
- [FAQ](#faq)
- [Related scrapers](#related-scrapers)
- [Support](#support)

## How it works

1. **Create a free Piloterr account** and copy your API key from the [dashboard](https://app.piloterr.com).
2. **Send a `GET` (or `POST`) request** to `https://api.piloterr.com/v2/...` with the header `x-api-key: YOUR_API_KEY`.
3. **Receive structured JSON** — Piloterr handles rendering, proxies, retries and parsing.

```bash
export PILOTERR_API_KEY="your-api-key"
pip install requests        # Python
# TypeScript: Node.js 18+ (native fetch), run with `npx tsx file.ts`
```

> Every endpoint accepts both `GET` (query string) and `POST` (JSON body with the same fields).

## MediaMarkt Product API

Read one MediaMarkt product by id or product URL, in the region you choose. You get price, currency, EAN, and availability.

`GET | POST https://api.piloterr.com/v2/mediamarkt/product` · **2 credits per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Product URL or article id. ``` https://www.mediamarkt.ch/fr/product/_apple-iphone-15-2203371.html ``` |
| `region` | string | — | Shop code when query is an article id. Example: ch-fr. Default ch-fr. |
| `return_page_source` | boolean | — | When true, return raw HTML as {"result": "..."}. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/mediamarkt/product",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "https://www.mediamarkt.ch/fr/product/_apple-iphone-15-2203371.html",
    },
    timeout=60,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type MediamarktProduct = {
  id?: string;
  ean?: string;
  sku?: string;
  url?: string;
  name?: string;
  brand?: string;
  image?: string;
  price?: number;
  locale?: string;
  rating?: number;
  region?: string;
  currency?: string;
  vat_rate?: number;
  condition?: string;
  price_note?: string;
  availability?: string;
  energy_class?: string;
  review_count?: number;
  price_display?: string;
  shipping_cost?: number;
  specifications?: {
    name?: string;
    group?: string;
    value?: string;
  }[];
};

const params = new URLSearchParams({
  "query": "https://www.mediamarkt.ch/fr/product/_apple-iphone-15-2203371.html",
});

const response = await fetch(`https://api.piloterr.com/v2/mediamarkt/product?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as MediamarktProduct;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/mediamarkt/product
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "https://www.mediamarkt.ch/fr/product/_apple-iphone-15-2203371.html"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "id": "2203371",
  "ean": "0195949036064",
  "sku": "2203371",
  "url": "https://www.mediamarkt.ch/fr/product/_apple-iphone-15-2203371.html",
  "name": "APPLE iPhone 15 128 GB Black Dual SIM",
  "brand": "APPLE",
  "image": "https://assets.mmsrg.com/isr/166325/c1/-/ASSET_MMS_118271101",
  "price": 629,
  "locale": "fr-CH",
  "rating": 4.69,
  "region": "ch-fr",
  "currency": "CHF",
  "vat_rate": 0.08,
  "condition": "new",
  "price_note": "TVA incluse sans frais d'envoi",
  "availability": "available",
  "energy_class": "B",
  "review_count": 391,
  "price_display": "CHF 629.00",
  "shipping_cost": 0,
  "specifications": [
    {
      "name": "Type de produit",
      "group": "Caractéristiques techniques",
      "value": "Smartphone"
    },
    {
      "name": "Système d'exploitation",
      "group": "Caractéristiques techniques",
      "value": "iOS"
    }
  ]
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `id` | string |  |
| `ean` | string |  |
| `sku` | string |  |
| `url` | string |  |
| `name` | string |  |
| `brand` | string |  |
| `image` | string |  |
| `price` | integer |  |
| `locale` | string |  |
| `rating` | number |  |
| `region` | string |  |
| `currency` | string |  |
| `vat_rate` | number |  |
| `condition` | string |  |
| `price_note` | string |  |
| `availability` | string |  |
| `energy_class` | string |  |
| `review_count` | integer |  |
| `price_display` | string |  |
| `shipping_cost` | integer |  |
| `specifications[]` | object[] |  |
| `specifications[].name` | string |  |
| `specifications[].group` | string |  |
| `specifications[].value` | string |  |

## MediaMarkt Search API

Search a MediaMarkt shop by keyword. Set region for Switzerland, Germany, Austria, and the other MediaMarktSaturn countries, then page the results.

`GET | POST https://api.piloterr.com/v2/mediamarkt/search` · **2 credits per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Keyword or MediaMarkt URL. Example: iphone |
| `region` | string | — | Shop code. Example: ch-fr or de. Default ch-fr. Ignored when query is a full URL. |
| `page` | number | — | Page number from 1. Example: 1 |
| `return_page_source` | boolean | — | When true, return raw HTML as {"result": "..."}. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/mediamarkt/search",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "iphone",
    },
    timeout=60,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type MediamarktSearch = {
  results?: {
    id?: string;
    ean?: string;
    url?: string;
    name?: string;
    brand?: string;
    image?: string;
    price?: number;
    locale?: string;
    rating?: number;
    region?: string;
    currency?: string;
    availability?: string;
    energy_class?: string;
    review_count?: number;
    price_display?: string;
    shipping_cost?: number;
    is_marketplace?: boolean;
  }[];
  pagination?: {
    next?: string;
    page?: number;
    per_page?: number;
    total_pages?: number;
    total_results?: number;
  };
};

const params = new URLSearchParams({
  "query": "iphone",
});

const response = await fetch(`https://api.piloterr.com/v2/mediamarkt/search?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as MediamarktSearch;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/mediamarkt/search
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "iphone"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "results": [
    {
      "id": "2203371",
      "ean": "0195949036064",
      "url": "https://www.mediamarkt.ch/fr/product/_apple-iphone-15-2203371.html",
      "name": "APPLE iPhone 15 128 GB Black Dual SIM",
      "brand": "APPLE",
      "image": "https://assets.mmsrg.com/isr/166325/c1/-/ASSET_MMS_118271101",
      "price": 629,
      "locale": "fr-CH",
      "rating": 4.69,
      "region": "ch-fr",
      "currency": "CHF",
      "availability": "available",
      "energy_class": "B",
      "review_count": 391,
      "price_display": "CHF 629.00",
      "shipping_cost": 0,
      "is_marketplace": false
    }
  ],
  "pagination": {
    "next": "https://www.mediamarkt.ch/fr/category/apple-iphones-789083.html?page=2",
    "page": 1,
    "per_page": 12,
    "total_pages": 43,
    "total_results": 511
  }
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `results[]` | object[] |  |
| `results[].id` | string |  |
| `results[].ean` | string |  |
| `results[].url` | string |  |
| `results[].name` | string |  |
| `results[].brand` | string |  |
| `results[].image` | string |  |
| `results[].price` | integer |  |
| `results[].locale` | string |  |
| `results[].rating` | number |  |
| `results[].region` | string |  |
| `results[].currency` | string |  |
| `results[].availability` | string |  |
| `results[].energy_class` | string |  |
| `results[].review_count` | integer |  |
| `results[].price_display` | string |  |
| `results[].shipping_cost` | integer |  |
| `results[].is_marketplace` | boolean |  |
| `pagination` | object |  |
| `pagination.next` | string |  |
| `pagination.page` | integer |  |
| `pagination.per_page` | integer |  |
| `pagination.total_pages` | integer |  |
| `pagination.total_results` | integer |  |

## Code examples in other languages

Ready-to-run examples live in the [`examples/`](examples) folder. Each one reads your key from the `PILOTERR_API_KEY` environment variable.

| Language | Product | Search |
|---|---|---|
| cURL (Bash) | [`product`](examples/curl/product.sh) | [`search`](examples/curl/search.sh) |
| PHP | [`product`](examples/php/product.php) | [`search`](examples/php/search.php) |
| C# | [`product`](examples/csharp/Product.cs) | [`search`](examples/csharp/Search.cs) |
| Go | [`product`](examples/go/product.go) | [`search`](examples/go/search.go) |
| Java | [`product`](examples/java/ProductExample.java) | [`search`](examples/java/SearchExample.java) |
| Ruby | [`product`](examples/ruby/product.rb) | [`search`](examples/ruby/search.rb) |
| Node.js | [`product`](examples/nodejs/product.mjs) | [`search`](examples/nodejs/search.mjs) |

## Practical use cases

- **Price monitoring** — Track prices, promotions and availability over time to react to competitors.
- **Assortment & catalog tracking** — Follow new products, delisted items and category changes.
- **Competitor analysis** — Benchmark ranges, brands and positioning across retailers.
- **Product research** — Spot best-sellers and trends from search results.
- **Catalog enrichment** — Pull titles, images and attributes into your PIM or marketplace listings.

## Why Piloterr?

- **No infrastructure** — no proxies, headless browsers or CAPTCHA solving to run yourself.
- **Structured JSON** — stable, documented fields instead of brittle HTML selectors.
- **Pay per request** — transparent credit cost per endpoint, failed requests are retried for you.
- **One API key, hundreds of sources** — MediaMarkt plus many other e-commerce, search and company data endpoints in the [Piloterr library](https://www.piloterr.com/library).
- **Any language** — plain HTTPS + JSON, with examples for Python, TypeScript, cURL, PHP, C#, Go, Java, Ruby and Node.js.

## FAQ

### Is it legal to scrape MediaMarkt?

Collecting publicly available data is generally allowed in many jurisdictions, but rules depend on your country, the data you collect and how you use it. Avoid personal data unless you have a lawful basis, respect the website's terms where they apply, and get legal advice for your specific use case. This is not legal advice.

### Do I need proxies or a headless browser?

No. Piloterr handles rendering, proxy rotation and retries on its side. You only send an HTTPS request with your `x-api-key` header and receive JSON.

### How much does a request cost?

Credits per call: `/v2/mediamarkt/product` **2**, `/v2/mediamarkt/search` **2**. See the [Piloterr website](https://www.piloterr.com) for plans.

### What data does the MediaMarkt API return?

Each endpoint returns structured JSON: **MediaMarkt Product** — `id`, `ean`, `sku`, `url`, `name`, `brand`; **MediaMarkt Search** — `results[]`, `results[].id`, `results[].ean`, `results[].url`, `results[].name`, `results[].brand`.

### How do I paginate MediaMarkt results?

Use the `page` parameter and keep requesting while the response indicates more results.

### Can I target a specific country or language?

Yes, use `region` — see the parameter tables above for accepted values.

### Can I get the raw HTML instead of JSON?

Yes. Set `return_page_source=true` and the response becomes `{"result": "..."}` with the page source.

### Which languages are supported?

Any language that can make an HTTP request. This README shows Python and TypeScript; the [`examples/`](examples) folder contains cURL, PHP, C#, Go, Java, Ruby and Node.js.

## Related scrapers

- [About You Scraper API](https://github.com/piloterr/aboutyou-scraper)
- [Action Scraper API](https://github.com/piloterr/action-scraper)
- [Aldi Scraper API](https://github.com/piloterr/aldi-scraper)
- [Alibaba Scraper API](https://github.com/piloterr/alibaba-scraper)
- [AliExpress Scraper API](https://github.com/piloterr/aliexpress-scraper)
- [Allegro Scraper API](https://github.com/piloterr/allegro-scraper)
- [All Piloterr scrapers on GitHub](https://github.com/piloterr)

## Support

- 💬 Join the [Piloterr Discord](https://discord.gg/CFj3ph8aHU) to ask questions and share what you build.
- 📚 Browse the [API reference (OpenAPI)](https://app.piloterr.com/openapi) and the [Piloterr library](https://www.piloterr.com/library).
- 🔑 [Get your API key](https://app.piloterr.com).

---

<p align="center">
  <a href="https://www.piloterr.com">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="images/logo-dark.svg">
      <img src="images/logo.svg" alt="Piloterr" height="32">
    </picture>
  </a>
  <br>
  <sub>Built by <a href="https://www.piloterr.com">Piloterr</a> — web scraping APIs for e-commerce, search, real estate and more, one API key.</sub>
</p>

<sub>MediaMarkt is a trademark of its respective owner. This repository is not affiliated with or endorsed by MediaMarkt. Examples are released under the MIT license.</sub>
