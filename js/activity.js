/*!
 * JavaScript Document for Activity board
 * Autor: Petr Zaparka petr@zaparka.cz
 * sed libraries: jquery.js
 */

function Activity() {
};

Activity.prototype = {

  loadDelicious: function() {
    this.ajax_call('post', 'delicious',{},function(response){
      if(response.length > 0)
        $('#delicious').html(response);
      else
        $('#delicious').html('<span class="error">Server don\'t response !</span>')
    });
  },
  
  loadTwitter: function() {
    this.ajax_call('post', 'twitter',{},function(response){
      if(response.length > 0)
        $('#twitter').html(response);
      else
        $('#twitter').html('<span class="error">Server don\'t response !</span>')
    });
  },

  ajax_call: function( type, url, data, on_success_method ) {
    $.ajax({
      type: type,
      url: url,
      dataType: 'html',
      data: data,
      success: on_success_method,
      complete: function(){
        $( 'img.loading' ).hide();
      }
    });
  }
}

$(document).ready(function () {
  activity = new Activity();
  
  activity.loadDelicious();
  activity.loadTwitter();
});