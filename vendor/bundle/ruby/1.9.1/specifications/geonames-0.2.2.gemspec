# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{geonames}
  s.version = "0.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Adam Wisniewski"]
  s.date = %q{2008-01-09}
  s.email = %q{adamw@tbcn.ca}
  s.extra_rdoc_files = ["README"]
  s.files = ["geonames-0.2.2.gem", "geonames.gemspec", "lib", "lib/address.rb", "lib/country_subdivision.rb", "lib/geonames.rb", "lib/intersection.rb", "lib/main.rb", "lib/postal_code.rb", "lib/postal_code_search_criteria.rb", "lib/Rakefile.rb", "lib/timezone.rb", "lib/toponym.rb", "lib/toponym_search_criteria.rb", "lib/toponym_search_result.rb", "lib/web_service.rb", "lib/wikipedia_article.rb", "nbproject", "nbproject/private", "nbproject/private/private.properties", "nbproject/private/private.xml", "nbproject/private/profiler", "nbproject/project.properties", "nbproject/project.xml", "README", "test"]
  s.homepage = %q{http://www.tbcn.ca/ruby_geonames}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.5.2}
  s.summary = %q{Ruby library for Geonames Web Services (http://www.geonames.org/export/)}

  if s.respond_to? :specification_version then
    s.specification_version = 2

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
