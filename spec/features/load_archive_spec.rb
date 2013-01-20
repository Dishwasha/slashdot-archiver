require 'spec_helper'

describe "loading slashdot archive", :js => true do
  it "has a Chronological Order" do
    load_page
    find('ul#story_archive_opts > li.active > a').has_content?('Chronological Order')
  end

  it "can load javascript" do
    load_page
    load_script('test.js');
    find("#success")
  end
end
