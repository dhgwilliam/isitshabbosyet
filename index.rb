require 'sinatra'
require 'date'
require 'icalendar'
require 'net/https'
require 'json'

get '/' do
  is_it_shabbos_yet(get_shabbos(11211))
  haml :index    
end

get '/zipcode/:zipcode' do
  content_type :json
  is_it_shabbos_yet(get_shabbos(params[:zipcode]))
  { :h1 => @is_it, :h2 => @why, :zipcode => params[:zipcode] }.to_json
end

get '/style.css' do
  sass :style.css
end

helpers do
  def is_it_shabbos_yet(shabbos_ical_parsed)
    @shabbos_event = shabbos_ical_parsed
    @shabbos_start = @shabbos_event.first.events.first.dtstart
    @shabbos_end = @shabbos_event.first.events.first.dtend
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
      @why = "Shabbos starts at " + @shabbos_start.hour.modulo(12).to_s + ":" + @shabbos_start.min.to_s.rjust(2, '0') + " pm in " + @location
#      @why = ""
    end
  end 

  def get_shabbos(zipcode)
    shabbos_ical_url = URI.parse('http://www.chabad.org/calendar/candlelighting/candlelighting.ics_cdo/z/' + zipcode.to_s + '/weeks/')
    shabbos_ical = Net::HTTP.get(shabbos_ical_url)
    shabbos_ical.slice!(/CHARSET:utf-8\r\n/)
    shabbos_ical = Icalendar.parse(shabbos_ical)
  end

end
