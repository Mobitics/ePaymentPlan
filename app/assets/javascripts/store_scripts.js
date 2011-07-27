// JavaScript Document
 
    $(document).ready(
      function() {
        
        $('div.form-help p').hide();
              $('input').hover(
            function() {
                var matchingExplanationClass = $(this).attr('class');
                $('p.'+matchingExplanationClass).toggle();
            }
        );
      }
      );