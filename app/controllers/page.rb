require 'open-uri'
require 'json'

YeBay.controllers :page do
  get :index, :map => "/" do
    @items = []
    json = ::JSON.parse(open("http://myshakespeare.worldshakespearefestival.org.uk/api/?dateRange=10-06-2012,17-06-2012").read)
    json.keys.each do |key|
      begin
        day = ::JSON.parse(json[key]) if json[key]
        day.select {|d| d["Publisher"] == "ebay" }.each {|item| @items << item} if day
      rescue
        # crappy json format
      end
    end
    render :index
  end
  
end
