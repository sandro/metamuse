# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{metamuse}
  s.version = "0.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Sandro Turriate"]
  s.date = %q{2009-08-16}
  s.email = %q{sandro.turriate@gmail.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "History",
     "MIT_LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "lib/array_ext.rb",
     "lib/arrayish.rb",
     "lib/hash_ext.rb",
     "lib/httparty_ext.rb",
     "lib/metamuse.rb",
     "lib/metamuse/album.rb",
     "lib/metamuse/artist.rb",
     "lib/metamuse/association.rb",
     "lib/metamuse/collection.rb",
     "lib/metamuse/instance_initialize.rb",
     "lib/metamuse/services.rb",
     "lib/metamuse/services/echonest.rb",
     "lib/metamuse/services/freebase.rb",
     "lib/metamuse/services/lastfm.rb",
     "lib/metamuse/services/lastfm/artist.rb",
     "lib/metamuse/services/lastfm/image.rb",
     "lib/metamuse/services/music_brainz.rb",
     "lib/metamuse/track.rb",
     "lib/object_ext.rb",
     "metamuse.gemspec",
     "script/console",
     "spec/fake_object.rb",
     "spec/fake_object_spec.rb",
     "spec/hash_ext_spec.rb",
     "spec/metamuse/album_spec.rb",
     "spec/metamuse/artist_spec.rb",
     "spec/metamuse/association_spec.rb",
     "spec/metamuse/collection_spec.rb",
     "spec/metamuse/services/echonest_spec.rb",
     "spec/metamuse/services/freebase_spec.rb",
     "spec/metamuse/services/lastfm/artist_spec.rb",
     "spec/metamuse/services/lastfm/image_spec.rb",
     "spec/metamuse/services/lastfm_spec.rb",
     "spec/metamuse/services/music_brainz_spec.rb",
     "spec/metamuse_spec.rb",
     "spec/spec_helper.rb",
     "spec/web_fixtures/GET_musicbrainz.org-ws-1-release-bb32aa1d-f37b-4134-8c0e-b43b7a6dab85_b976ba7.fixture",
     "spec/web_fixtures/GET_ws.audioscrobbler.com-2.0_857b5b7.fixture",
     "spec/web_fixtures/GET_www.freebase.com-api-service-mqlread_60ee2bd.fixture",
     "spec/web_fixtures/GET_www.freebase.com-api-service-mqlread_b8b2565.fixture"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/sandro/metamuse}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Search for music metadata}
  s.test_files = [
    "spec/fake_object.rb",
     "spec/fake_object_spec.rb",
     "spec/hash_ext_spec.rb",
     "spec/metamuse/album_spec.rb",
     "spec/metamuse/artist_spec.rb",
     "spec/metamuse/association_spec.rb",
     "spec/metamuse/collection_spec.rb",
     "spec/metamuse/services/echonest_spec.rb",
     "spec/metamuse/services/freebase_spec.rb",
     "spec/metamuse/services/lastfm/artist_spec.rb",
     "spec/metamuse/services/lastfm/image_spec.rb",
     "spec/metamuse/services/lastfm_spec.rb",
     "spec/metamuse/services/music_brainz_spec.rb",
     "spec/metamuse_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
