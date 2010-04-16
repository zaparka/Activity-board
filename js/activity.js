/*!
 * JavaScript Document for Activity board
 * Autor: Petr Zaparka petr@zaparka.cz
 * sed libraries: jquery.js
 */

function Activity() {
};

Activity.prototype = {

  loadService: function(service_name, reload) {
    $("#"+service_name).html('<img src="img/loader.gif" alt="Loading ..." class="loader" />');
    var params = {}

    if(reload)
      params = 'reload=1'

    this.ajax_call(service_name, params, function(response){
      if(response.length > 0)
        $('#'+service_name).html(response);
      else
        $('#'+service_name).html('<span class="error">Server did\'t respond!</span>')
    }, function(){
        $('#'+service_name).html('<span class="error">Server did\'t respond!</span>')
    });
  },

  ajax_call: function(service, data, on_success, on_error) {
    $.ajax({
      type: 'post',
      url: service,
      dataType: 'html',
      data: data,
      success: on_success,
      error: on_error
    });
  }
}

$(document).ready(function () {
  activity = new Activity();

  activity.loadService('delicious');
  activity.loadService('twitter');
  activity.loadService('github');

  $('h2 span').click(function(event){
    var service_name = $(event.target).parent().next().attr('id');
    activity.loadService(service_name, 1);
  });
});