require 'open-uri'
require 'json'

YeBay.controllers :page do
  get :index, :map => "/", :cache => true  do
    expires_in 300
    @items = []
    t = Time.new
    to = t.strftime("%d-%m-%Y")
    from = (t - (2*7*24*60*60)).strftime("%d-%m-%Y")
    json = ::JSON.parse(open("http://myshakespeare.worldshakespearefestival.org.uk/api/?dateRange=#{from},#{to}").read)
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
