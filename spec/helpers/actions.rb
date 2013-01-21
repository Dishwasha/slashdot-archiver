module Actions
  def load_page year='', num=1
    visit("http://slashdot.org/archive.pl?op=bytime&keyword=&year=#{year}&page=#{num}")
  end

  def load_script script, opts={}
    params = opts.map do |key, value|
      "#{key}=#{value}"
    end.join("&")

    page.execute_script("document.getElementsByTagName('body')[0].appendChild(document.createElement('script')).setAttribute('src', 'http://localhost:3000/assets/#{script}?#{params}');")
  end

  def load_rip
    page.execute_script("document.getElementsByTagName('body')[0].appendChild(document.createElement('script')).setAttribute('src', 'http://localhost:3000/assets/rip.js');")
  end

  def load_article
    page.execute_script("document.getElementsByTagName('body')[0].appendChild(document.createElement('script')).setAttribute('src', 'http://localhost:3000/assets/article.js');")
  end
end
