require 'sinatra'
require 'date'
require 'icalendar'
require 'net/https'


get '/' do
  is_it_shabbos_yet
end

helpers do
  def is_it_shabbos_yet
    @shabbos = get_shabbos(11211)
    @today = DateTime.now
#    @is_it = "Nope shabbos: "+ @shabbos.to_s + " and now it's: " + @today.to_s
    @is_it = "Nope" 
#    @today = @shabbos + 1
    if @today > @shabbos
      @is_it = "Yep. Shabbos started at " + @shabbos.hour.modulo(12).to_s + ":" + @shabbos.min.to_s + " pm"
    end
    haml :index    
  end 

  def get_shabbos(zipcode)
    shabbos_ical_url = URI.parse('http://www.chabad.org/calendar/candlelighting/candlelighting.ics_cdo/z/' + zipcode.to_s + '/weeks/')
    shabbos_ical = Net::HTTP.get(shabbos_ical_url)
    shabbos_ical.slice!(/CHARSET:utf-8\r\n/)
    shabbos_ical = Icalendar.parse(shabbos_ical)
    shabbos = shabbos_ical.first.events.first.dtstart
  end

end
