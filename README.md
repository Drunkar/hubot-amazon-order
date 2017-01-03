# Hubot Amazon Order

Order item on amazon.co.jp via https://github.com/jsoizo/amazon-jp-auto-orderer.

## config

```
export HUBOT_AMAZON_LAMBDA_API_URL="XXXXXXX"
export HUBOT_AMAZON_LAMBDA_API_KEY="XXXXXXX"
export HUBOT_AMAZON_ITEM_JSON='{"コーヒー": "https://www.amazon.co.jp/dp/B006LEBM5Q", "歯ブラシ": "https://www.amazon.co.jp/dp/B00APTB104"}'
```

## usage

```
hubot amazon|ama|buy <itemName>
hubot amazon|ama|buy <amazonItemUrl>
```

<itemName> should be defined as a key in HUBOT_AMAZON_ITEM_JSON.
