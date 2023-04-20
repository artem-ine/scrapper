require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'watir' # to load additional values if needed


# opening and reading the webpage
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

# array of hashes:
def build_array(currencies, prices)
  currencies_and_prices = currencies.map.with_index do |currency, i|
    {currency.text => prices[i].text}
  end
  return currencies_and_prices
end


currencies_and_prices = build_array(currencies, prices)
p currencies_and_prices


=begin 

TO LOAD ADDITIONAL VALUES:

browser = Watir::Browser.new
browser.goto('https://coinmarketcap.com/all/views/all/')
sleep(30) # wait for page to load

doc = Nokogiri::HTML(browser.html)

currencies = doc.css('a.cmc-table__column-name--name')

code
browser.close

=end