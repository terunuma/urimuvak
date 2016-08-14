# TODO:
#   Yahoo ファイナンスからスクレイピング
#     http://stocks.finance.yahoo.co.jp/stocks/search/?s=%(terms)s&p=%(page)s&ei=UTF-8
#   Nomura
#     http://quote.nomura.co.jp/nomura/cgi-bin/parser.pl?QCODE=1&TEMPLATE=nomura_tp_kabu_01

require 'fileutils'

# URLにアクセスするためのライブラリの読み込み
require 'open-uri'
# Nokogiriライブラリの読み込み
require 'nokogiri'


class MainClass
	# ---
	def scrapeOnePage
		q_code = 1

		# スクレイピング先のURL
		url = "http://quote.nomura.co.jp/nomura/cgi-bin/parser.pl?QCODE=#{q_code}&TEMPLATE=nomura_tp_kabu_01"

		stock_html_filename = self.getFilepathWithMkdirP(self.getStockFilename(q_code))

		if File.exist?(stock_html_filename) then
			html = File.read(stock_html_filename)
		else
			charset = nil
			html = open(url) do |f|
				charset = f.charset # 文字種別を取得
				f.read # htmlを読み込んで変数htmlに渡す
			end

			File.write(stock_html_filename, html)
		end

		# htmlをパース(解析)してオブジェクトを生成
		doc = Nokogiri::HTML.parse(html, nil, charset)

		# タイトルを表示
		p doc.title
	end

	# ---
	def getFilepathWithMkdirP(filepath)
		parent_dir = File.dirname(filepath)
		FileUtils.mkdir_p(parent_dir) unless File.exist?(parent_dir)
		return filepath
	end

	# ---
	def getStockFilename(q_code)
		stocks_dir = File.expand_path(File.dirname(__FILE__)) + '/data/stocks/'
		return stocks_dir + q_code.to_s
	end
end

mainClass = MainClass.new()
mainClass.scrapeOnePage()
