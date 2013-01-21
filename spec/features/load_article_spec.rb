require 'spec_helper'

describe "loading slashdot article", :js => true do
  it "loads an article" do
    article = Article.search do
      filter :missing, {field: 'metadata', existence: true, null_value: true}
    end.first

    visit article.link
    load_article
  end
end