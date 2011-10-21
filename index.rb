require 'date'
require 'icalendar'
require 'net/https'
require 'json'

before do 
  # Strip the last / from the path
  request.env['PATH_INFO'].gsub!(/\/$/, '')
end

get '/' do
  haml :index    
end

get '/latest_tweet' do
  content_type :json
  tweet_uri = URI.parse('http://search.twitter.com/search.json?q=from:dhgwilliam&page=1&rpp=1')
  tweet_json = Net::HTTP.get(tweet_uri)
  tweet_json = JSON.parse(tweet_json)
end

get '/zipcode/:zipcode' do
  content_type :json
  is_it_shabbos_yet(get_shabbos_hebcal(params[:zipcode]))
  { :h1 => @is_it, :h2 => @why, :zipcode => params[:zipcode] }.to_json
end

get '/parse/:zipcode' do
  content_type :json
  { :ics => get_shabbos(params[:zipcode]).inspect }.to_json
end

get '/hebcal/:zipcode' do
  get_shabbos_hebcal(params[:zipcode])
end

get '/style.css' do
  sass :style.css
end

helpers do
  def is_it_shabbos_yet(shabbos_ical_parsed)
    @shabbos_event = shabbos_ical_parsed
    @shabbos_start = @shabbos_event[0]
    @shabbos_end = @shabbos_event[1]
    @today = DateTime.now
    @location = params[:zipcode].to_s

    if @today.cwday == 5 && @today > @shabbos_start
      @is_it = "Yep."
      @why = "Shabbos started at " + @shabbos_start.hour.modulo(12).to_s + ":" + @shabbos_start.min.to_s.rjust(2, '0') + " pm on Friday and ends at " + @shabbos_end.hour.modulo(12).to_s + ":" + @shabbos_end.min.to_s.rjust(2, '0') + " tomorrow in " + @location
    elsif @today.cwday == 5 && @today < @shabbos_start
      @is_it = "Not yet."
      @why = "Shabbos starts at " + @shabbos_start.hour.modulo(12).to_s + ":" + @shabbos_start.min.to_s.rjust(2, '0') + " pm in " + @location
    elsif @today.cwday == 6 && @today < @shabbos_end
      @is_it = "Yep."
      @why = "Shabbos ends at " + @shabbos_end.hour.modulo(12).to_s + ":" + @shabbos_end.min.to_s.rjust(2, '0') + " pm in " + @location
    elsif @today.cwday == 6 && @today > @shabbos_end
      @is_it = "Nope."
      @why = "Shabbos ended at " + @shabbos_end.hour.modulo(12).to_s + ":" + @shabbos_end.min.to_s.rjust(2, '0') + " pm in " + @location
    else
      @is_it = "Nope."
      @why = "Shabbos starts at " + @shabbos_start.hour.modulo(12).to_s + ":" + @shabbos_start.min.to_s.rjust(2, '0') + " pm this Friday in " + @location
      #@why = ""
    end
  end 

  def get_shabbos(zipcode)
    shabbos_ical_url = URI.parse('http://www.chabad.org/calendar/candlelighting/candlelighting.ics_cdo/z/' + zipcode.to_s + '/weeks/')
    shabbos_ical = Net::HTTP.get(shabbos_ical_url)
    shabbos_ical.slice!(/CHARSET:utf-8\r\n/)
    shabbos_ical = Icalendar.parse(shabbos_ical)
  end

  def get_shabbos_hebcal(zipcode)
    today = DateTime.now
    date_array = Array.new
    hebcal_url = URI.parse('http://www.hebcal.com/hebcal/?v=1;cfg=json;year=' + today.year.to_s + ';month=' + today.month.to_s + ';c=on;zip=' + zipcode.to_s + '')
    hebcal_json = JSON.parse(Net::HTTP.get(hebcal_url))["items"]
    hebcal_json.each{ |x| date = x.fetch("date"); if Date.parse(date).yday >= today.yday then date_array.push(x) end }
    return [ DateTime.parse(date_array[0].fetch("date")), DateTime.parse(date_array[1].fetch("date"))]
  end

end
