// FIXME: Tell people that this is a manifest file, real code should go into discrete files
// FIXME: Tell people how Sprockets and CoffeeScript works
//
//= require jquery
//= require jquery_ujs
//= require_tree .
function loadToColorBox(divn,divw,divh,myurl) {
      $(divn).html('<p class="colorbox_loading_text"><img src="/assets/colorbox/loading.gif" alt="Loading" /><span>Loading...</span></p>');
      $.fn.colorbox({inline:true, href:divn, width:divw, onComplete:function(){
        // Load
        $.ajax({
          type: "GET",
          url: myurl,
          success: function(html) {
            $(divn).html(html);
            $.fn.colorbox.resize();
          },
          error: function(XMLHttpRequest, textStatus) {
            alert("Ooops! Something unexpected happened."); 
            //XMLHttpRequest.status + ": " + XMLHttpRequest.statusText
            $.fn.colorbox.close();
          }
        });      
      }});
    }
    