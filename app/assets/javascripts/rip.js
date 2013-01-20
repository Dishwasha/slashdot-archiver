(function() {
  var pages = {
    '1998': 16,
    '1999': 21,
    '2000': 26,
    '2001': 27,
    '2002': 35,
    '2003': 42,
    '2004': 45,
    '2005': 42,
    '2006': 44,
    '2007': 35,
    '2008': 34,
    '2009': 34,
    '2010': 33,
    '2011': 34,
    '2012': 35,
    '2013': 2
  };

  var current_page = $.trim($('#archpagin > span.active').text()); 
  var current_year = $.trim($('ul#story_archive_opts_year li.active a').text());

  function collectArticles() {
    var articles = {};

    var firehose = $('#firehose');
    var container = $(firehose.find('nav.abdb')[0]).parent();
    var links = container.children('a');

    for(var i=links.length - 1; i>-1; i--) {
      article = $(links[i]);
      date = $.trim($(article.prevAll('nav')[0]).find('.archive_breaks.before > span').text());
      if(typeof articles[date] === 'undefined') {
        articles[date] = [];
      }

      articles[date].push({
        title: $.trim(article.text()),
        link: 'http:' + $.trim(article.attr('href'))
      });
    }

    return articles;
  }

  function postSuccess() {
    var articles = this;
    var success = true;
    $.each(articles, function(date, articleset) {
      $.each(articleset, function(index, article) {
        if(article['success'] != true) {
          success = false;
        }
      });
    });
    if(success) {
      $('body').append('<div id="success"></div>');
    } else {
      setTimeout((function() { postSuccess.call(articles)}), 500);
    }
  }

  function postArticles(date, articleset) {
    console.log('Processing ' + date + ':');
    $.each(articleset, function(index, article) {
      $.ajax({
        contentType: 'application/json; charset=utf-8',
        crossDomain: true,
        data: JSON.stringify({
          article: {
            title: article['title'],
            link: article['link'],
            published_on: date
          }
        }),
        dataType: 'json',
        success: function(data) {
          if(data['article']['title'] == article['title']) {
            article['success'] = true;
            console.log(data['article']['title'] + ' was successful.');
          }
        },
        type: 'POST',
        url: 'http://localhost:3000/articles'
      });
    });
  }

  var articles = collectArticles();
  $.each(articles, postArticles);
  setTimeout((function() { postSuccess.call(articles)}), 500);
})();
