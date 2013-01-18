require 'spec_helper'

describe "loading slashdot archive", :js => true do
  it "has a Chronological Order" do
    visit("http://slashdot.org/archive.pl?op=bytime")
    find('ul#story_archive_opts > li.active > a').has_content?('Chronological Order')
  end

  it "can load javascript" do
    visit("http://slashdot.org/archive.pl?op=bytime")
    page.execute_script("document.getElementsByTagName('body')[0].appendChild(document.createElement('script')).setAttribute('src', 'http://localhost:3000/assets/test.js');")
    find("#success")
  end
end
