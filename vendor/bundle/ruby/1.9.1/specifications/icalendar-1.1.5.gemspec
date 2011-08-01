# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{icalendar}
  s.version = "1.1.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Sean Dague"]
  s.date = %q{2010-06-21}
  s.description = %q{This is a Ruby library for dealing with iCalendar files.  Rather than
explaining myself, here is the introduction from RFC-2445, which
defines the format:

The use of calendaring and scheduling has grown considerably in the
last decade. Enterprise and inter-enterprise business has become
dependent on rapid scheduling of events and actions using this
information technology. However, the longer term growth of calendaring
and scheduling, is currently limited by the lack of Internet standards
for the message content types that are central to these knowledgeware
applications. This memo is intended to progress the level of
interoperability possible between dissimilar calendaring and
scheduling applications. This memo defines a MIME content type for
exchanging electronic calendaring and scheduling information. The
Internet Calendaring and Scheduling Core Object Specification, or
iCalendar, allows for the capture and exchange of information normally
stored within a calendaring and scheduling application; such as a
Personal Information Manager (PIM) or a Group Scheduling product. 

The iCalendar format is suitable as an exchange format between
applications or systems. The format is defined in terms of a MIME
content type. This will enable the object to be exchanged using
several transports, including but not limited to SMTP, HTTP, a file
system, desktop interactive protocols such as the use of a memory-
based clipboard or drag/drop interactions, point-to-point asynchronous
communication, wired-network transport, or some form of unwired
transport such as infrared might also be used.}
  s.email = ["sean@dague.net"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "PostInstall.txt", "website/index.txt", "README.rdoc"]
  s.files = ["COPYING", "GPL", "History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc", "Rakefile", "config/website.yml", "examples/create_cal.rb", "examples/parse_cal.rb", "examples/single_event.ics", "icalendar.gemspec", "lib/hash_attrs.rb", "lib/icalendar.rb", "lib/icalendar/base.rb", "lib/icalendar/calendar.rb", "lib/icalendar/component.rb", "lib/icalendar/component/alarm.rb", "lib/icalendar/component/event.rb", "lib/icalendar/component/freebusy.rb", "lib/icalendar/component/journal.rb", "lib/icalendar/component/timezone.rb", "lib/icalendar/component/todo.rb", "lib/icalendar/conversions.rb", "lib/icalendar/conversions.rb.orig", "lib/icalendar/helpers.rb", "lib/icalendar/parameter.rb", "lib/icalendar/parser.rb", "lib/icalendar/rrule.rb", "lib/icalendar/tzinfo.rb", "lib/meta.rb", "script/console", "script/destroy", "script/generate", "script/recur1.ics", "script/tryit.rb", "script/txt2html", "test.ical", "test.ics", "test.rb", "test/component/test_event.rb", "test/component/test_timezone.rb", "test/component/test_todo.rb", "test/fixtures/folding.ics", "test/fixtures/life.ics", "test/fixtures/simplecal.ics", "test/fixtures/single_event.ics", "test/interactive.rb", "test/read_write.rb", "test/test_calendar.rb", "test/test_component.rb", "test/test_conversions.rb", "test/test_helper.rb", "test/test_parameter.rb", "test/test_parser.rb", "test2.rb", "website/index.html", "website/index.txt", "website/javascripts/rounded_corners_lite.inc.js", "website/stylesheets/screen.css", "website/template.html.erb"]
  s.homepage = %q{http://github.com/sdague/icalendar}
  s.post_install_message = %q{PostInstall.txt}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{icalendar}
  s.rubygems_version = %q{1.5.2}
  s.summary = %q{This is a Ruby library for dealing with iCalendar files}
  s.test_files = ["test/test_parameter.rb", "test/test_conversions.rb", "test/test_parser.rb", "test/component/test_todo.rb", "test/component/test_timezone.rb", "test/component/test_event.rb", "test/test_helper.rb", "test/test_calendar.rb", "test/test_component.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rubyforge>, [">= 2.0.3"])
      s.add_development_dependency(%q<gemcutter>, [">= 0.3.0"])
      s.add_development_dependency(%q<hoe>, [">= 2.5.0"])
    else
      s.add_dependency(%q<rubyforge>, [">= 2.0.3"])
      s.add_dependency(%q<gemcutter>, [">= 0.3.0"])
      s.add_dependency(%q<hoe>, [">= 2.5.0"])
    end
  else
    s.add_dependency(%q<rubyforge>, [">= 2.0.3"])
    s.add_dependency(%q<gemcutter>, [">= 0.3.0"])
    s.add_dependency(%q<hoe>, [">= 2.5.0"])
  end
end
