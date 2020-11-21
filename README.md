Simple APIの代替APIのようなもの。

使い方は簡単。keywordクエリつけてindexにGETリクエストするだけ。

エラーは、

"/"の場合(クエリなし): "We need keyword after '/?keyword=' . For example: https://wikipedia-api-net.herokuapp.com/?keyword=Ruby"

"/aaa"の場合(404): "We need keyword after '/?keyword=' . For example: https://wikipedia-api-net.herokuapp.com/?keyword=Ruby"

"/?keywoooood=Ruby"の場合(クエリの不備): "We need keyword after '/?keyword=' . For example: https://wikipedia-api-net.herokuapp.com/?keyword=Ruby"

"/?keywood=ああああああああああ"の場合(検索結果なし): ""(空で返す)

基本的に "We need keyword after '/?keyword=' . For example: https://wikipedia-api-net.herokuapp.com/?keyword=Ruby" と言われたら何かしら不備があると思ってください。

だからちゃんと、

"/?keyword=Ruby"のようにリクエスト飛ばしましょう。
