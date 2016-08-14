# TODO:
#   Yahoo ファイナンスからスクレイピング
#     http://stocks.finance.yahoo.co.jp/stocks/search/?s=%(terms)s&p=%(page)s&ei=UTF-8
#   Nomura
#     http://quote.nomura.co.jp/nomura/cgi-bin/parser.pl?QCODE=1&TEMPLATE=nomura_tp_kabu_01

# URLにアクセスするためのライブラリの読み込み
require 'open-uri'
# Nokogiriライブラリの読み込み
require 'nokogiri'


class MainClass
	def scrapeOnePage
		# スクレイピング先のURL
		url = 'http://quote.nomura.co.jp/nomura/cgi-bin/parser.pl?QCODE=1&TEMPLATE=nomura_tp_kabu_01'

		charset = nil
		html = open(url) do |f|
		  charset = f.charset # 文字種別を取得
		  f.read # htmlを読み込んで変数htmlに渡す
		end

		# htmlをパース(解析)してオブジェクトを生成
		doc = Nokogiri::HTML.parse(html, nil, charset)

		# タイトルを表示
		p doc.title

	end
end

mainClass = MainClass.new()
mainClass.scrapeOnePage()
