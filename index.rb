require 'sinatra'
require 'date'
require 'icalendar'
require 'net/https'


get '/' do
  is_it_shabbos_yet
end

helpers do
  def is_it_shabbos_yet
    @shabbos_event = get_shabbos(11211)
    @shabbos_start = @shabbos_event.first.events.first.dtstart
    @shabbos_end = @shabbos_event.first.events.first.dtend
    @today = DateTime.now
    @location = "Williamsburg, Brooklyn"

    if @today.cwday == 5 && @today > @shabbos_start
      @is_it = "Yep. Shabbos started at " + @shabbos_start.hour.modulo(12).to_s + ":" + @shabbos_start.min.to_s + " pm on Friday and ends at " + @shabbos_end.hour.modulo(12).to_s + ":" + @shabbos_end.min.to_s + " tomorrow in " + @location
    elsif @today.cwday == 5 && @today < @shabbos_start
      @is_it = "Not yet. Shabbos starts at " + @shabbos_start.hour.modulo(12).to_s + ":" + @shabbos.min.to_s + " pm in " + @location
    elsif @today.cwday == 6 && @today < @shabbos_end
      @is_it = "Yep. Shabbos ends at " + @shabbos_end.hour.modulo(12).to_s + ":" + @shabbos_end.min.to_s + " pm in " + @location
    elsif @today.cwday == 6 && @today > @shabbos_end
      @is_it = "Nope. Shabbos ended at " + @shabbos_end.hour.modulo(12).to_s + ":" + @shabbos_end.min.to_s + " pm in " + @location
    else
      @is_it = "Nope."
    end
    haml :index    
  end 

  def get_shabbos(zipcode)
    shabbos_ical_url = URI.parse('http://www.chabad.org/calendar/candlelighting/candlelighting.ics_cdo/z/' + zipcode.to_s + '/weeks/')
    shabbos_ical = Net::HTTP.get(shabbos_ical_url)
    shabbos_ical.slice!(/CHARSET:utf-8\r\n/)
    shabbos_ical = Icalendar.parse(shabbos_ical)
  end

end
