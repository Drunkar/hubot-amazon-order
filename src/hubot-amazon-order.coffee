# Description:
#   Order item on amazon.co.jp via https://github.com/jsoizo/amazon-jp-auto-orderer.
#
# Configuration:
#   HUBOT_AMAZON_LAMBDA_API_URL - amazon order lambda api url.
#   HUBOT_AMAZON_LAMBDA_API_KEY -
#   HUBOT_AMAZON_ITEM_JSON - example: '{"コーヒー": "https://www.amazon.co.jp/dp/B006LEBM5Q", "歯ブラシ": "https://www.amazon.co.jp/dp/B00APTB104"}'
#
# Commands:
#   hubot amazon|ama|buy <itemName>
#   hubot amazon|ama|buy <amazonItemUrl>


AMAZON_LAMBDA_API_URL = process.env.HUBOT_AMAZON_LAMBDA_API_URL
AMAZON_LAMBDA_API_KEY = process.env.HUBOT_AMAZON_LAMBDA_API_KEY
AMAZON_ITEM = JSON.parse(process.env.HUBOT_AMAZON_ITEM_JSON ? "{}")


module.exports = (robot) ->

    robot.respond /amazon|ama|buy (.*)$/i, (msg) ->

        query = msg.match[1]
        if isUrl(query)
          itemUrl = query
        else if query in AMAZON_ITEM
          itemUrl = AMAZON_ITEM[query]
        else
          itemUrl = null
          message = "登録されてないアイテムか、無効なURLじゃないかなっ？"

        if itemUrl
          message = "注文したよ！"
          data =
            itemName: "url"
            itemUrl: itemUrl
          robot.http(AMAZON_LAMBDA_API_URL)
            .header("x-api-key", AMAZON_LAMBDA_API_KEY)
            .post(data) (err, res, body) ->
              if err
                message = "エラーっぽい"

        msg.send message


isUrl = (str) ->
  pattern = new RegExp('^(https?:\\/\\/)?' + '((([a-z\\d]([a-z\\d-]*[a-z\\d])*)\\.)+[a-z]{2,}|' + '((\\d{1,3}\\.){3}\\d{1,3}))' + '(\\:\\d+)?(\\/[-a-z\\d%_.~+]*)*' + '(\\?[;&a-z\\d%_.~+=-]*)?' + '(\\#[-a-z\\d_]*)?$', 'i')
  if !pattern.test(str)
    false
  else
    true
