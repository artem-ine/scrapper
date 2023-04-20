require_relative '../lib/dark_trader.rb'

require 'nokogiri'
require 'open-uri'

describe 'get_currency_prices' do

  begin
    doc = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))
   rescue => e
    puts "Error loading page: #{e.message}"
    exit
  end

  #getting the currencies
  def get_currencies(doc)
    return currencies = doc.css('a.cmc-table__column-name--name')
    if currencies.empty?
      puts "No currencies found"
      exit
    end
  # currencies.each do |currency|
  #   puts currency.text
  # end  
  end

  currencies = get_currencies(doc)

  # getting the prices
  def get_prices(doc)
    return prices = doc.css('span.sc-edc9a476-0')
    if prices.empty?
      puts "No currencies found"
      exit
    end
    # prices.each do |price|
    #   puts price.text
    # end
  end

  prices = get_prices(doc)
  
  it 'returns an array of hashes containing currency names and prices' do
    expect(build_array(currencies, prices)).to be_an(Array)
    expect(build_array(currencies, prices)).not_to be_empty
    expect(build_array(currencies, prices).first).to be_a(Hash)
    expect(build_array(currencies, prices).first).to have_key('Bitcoin')
    expect(build_array(currencies, prices).first['Bitcoin']).to match(/\d{1,3}(,\d{3})*\.\d{2}/)
  end
end
