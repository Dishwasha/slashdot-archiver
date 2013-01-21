(function() {
  function updateArticle(article) {
    var id = window.location.href.split('/').slice(-1)[0];
    console.log('Processing ' + id + ':');
    $.ajax({
      contentType: 'application/json; charset=utf-8',
      crossDomain: true,
      data: JSON.stringify(article),
      dataType: 'json',
      success: function(data) {
        console.log(article['title'] + ' was successfully updated.');
      },
      type: 'PUT',
      url: 'http://localhost:3000/articles/' + id
    });
  }

  updateArticle({})
})();
