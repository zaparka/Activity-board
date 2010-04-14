/*!
 * JavaScript Document for Activity board
 * Autor: Petr Zaparka petr@zaparka.cz
 * sed libraries: jquery.js
 */

function Activity() {
};

Activity.prototype = {

  loadService: function(service_name) {
    this.ajax_call('post', service_name, {}, function(response){
      if(response.length > 0)
        $('#'+service_name).html(response);
      else
        $('#'+service_name).html('<span class="error">Server did\'t respond!</span>')
    }, function(){
        $('#'+service_name).html('<span class="error">Server did\'t respond!</span>')
    });
  },

  ajax_call: function( type, url, data, on_success, on_error) {
    $.ajax({
      type: type,
      url: url,
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
});