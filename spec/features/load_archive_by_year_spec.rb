require 'spec_helper'

describe "loading slashdot archive by year", :js => true do
  before(:all) do
    @years = {
      '1998' => 16,
      '1999' => 21,
      '2000' => 26,
      '2001' => 27,
      '2002' => 35,
      '2003' => 42,
      '2004' => 45,
      '2005' => 42,
      '2006' => 44,
      '2007' => 35,
      '2008' => 34,
      '2009' => 34,
      '2010' => 33,
      '2011' => 34,
      '2012' => 35,
      '2013' => 2
    }
  end

  it "1998" do
    load_year '1998'
  end
end

def load_year year
  last_page = @years[year]
  (1..last_page).to_a.reverse.each do |current_page|
    load_page year, current_page
    load_rip
    success = false
    timeout 360 do
      success = find('#success') rescue Exception
    end
    success.should be_true
  end
end
