//= require jquery/jquery
//= require velocity

// IE Detected
var IE = (function() {
    if (document.documentMode) {
        return document.documentMode;
    } else {
        for (var i = 7; i > 4; i--) {
            var div = document.createElement("div");

            div.innerHTML = "<!--[if IE " + i + "]><span></span><![endif]-->";

            if (div.getElementsByTagName("span").length) {
                div = null;

                return i;
            }
        }
    }

    if (/Edge\/[0-9]./i.test(navigator.userAgent)){
       return 12;
    }

    return undefined;
})();

function in_modalUpdate(){
  $('.modal-dialog .modal').each(function(){
    var $this = $(this),
        marginTop = ($(window).height() / 2) - ($this.outerHeight() / 2);
    $this.css('marginTop', marginTop > 30 ? marginTop : '');
  });
}

function in_init() {
  // Text in textarea
  $(document).on('change', '[data-auto-height="true"]', function(){
    if($(this).val()){
      $(this).css('height', '118px');
    } else {
      $(this).css('height', '');
    }
  });

  $(window).on('resize',function(){
    in_modalUpdate();
  });

  // ###################################################
  // ################ Contact us form ##################
  // ###################################################

  $('[data-modal]').on('click', function(){

    var $dialog = $('<div class="modal-dialog"><div class="modal">' + $($(this).data('modal')).html() + '</div></div>');

    var $modal = $('.modal', $dialog);

    $dialog.on('open', function(){
      $('body').addClass('modal-open');

      in_modalUpdate();

      $dialog.focus();
      $modal.focus();

      $dialog.addClass('modal-dialog-show');
    });

    $dialog.on('close', function(){
      $dialog.removeClass('modal-dialog-show');

      setTimeout(function(){
        $dialog.remove();
        $('body').removeClass('modal-open');
      }, 400);
    });

    $dialog.on('click', function(e){
      if ($(e.target).is($dialog)){
        $dialog.trigger('close');
        return false;
      }
    });

    $('[data-modal-action="close"]', $dialog).on('click',function(){
      $dialog.trigger('close');
      return false;
    });

    $('body').append($dialog);
    $dialog.trigger('open');
  });

  // ###################################################
  // ############## Get early access form ##############
  // ###################################################

  $(document).on('cap-show', '.modal', function(){
    $(this).find('.modal-cap').addClass('cap-show');
  });

  $(document).on('cap-hide', '.modal', function(){
    $(this).find('.modal-cap').removeClass('cap-show');
  });

  // $(document).on('click', '.modal .modal-cap', function(){
  //   $(this).trigger('cap-hide');
  // });

  $('a.link-scroll').on('click', function (e) {
    e.preventDefault();
    $('#scroll').stop().animate({
  	  scrollTop: $('#scroll').scrollTop() + $($(this).attr('href')).offset().top
    }, 600);
  });

  $(document).on('click', '#early-access-submit, #contact-us-submit', function(e){
    e.preventDefault();

    var form = $(this).closest('form');
    var modal = $(this).closest('.modal');
    var _this = $(this);

    _this.closest('.button-toggle').toggleClass('button-toggle-2');

    $.post(form.get(0).action, form.serialize(), function(response) {
      if (response.success) {
        modal.trigger('cap-show');
      } else {
        _this.closest('.button-toggle').toggleClass('button-toggle-2');

        form.find('.form-group').removeClass('has-error');
        form.find('.form-label-after').remove();

        $.each(response.errors, function(k, v) {
          var block = form.find('[name=registration\\[' + k + '\\]]');
          var errorBlock = $('<div class="form-label-after">' + v + '</div>');

          block.closest('.form-group').addClass('has-error');
          block.after(errorBlock);
        });
      }
    });
  });

  // $(document).on('click', '.test-cap', function(){
  //   $(this).parents('.modal').trigger('cap-show');
  // });
}

function in_ie_fix(){
  if (!IE) {
    return;
  }

  var progress = {
    duration: 1000,
    easing: [.66, .01, .26, .99]
  };

  $("#harmonic_image1")
      .delay(1000)
      .velocity({translateX: "-115px", translateY: "74px"}, progress);
  $("#harmonic_image2_path")
      .delay(1000)
      .velocity({translateX: "-115px", translateY: "75px"}, progress);
  $("#harmonic_image3")
      .delay(1000)
      .velocity({translateX: "114px", translateY: "-80px"}, progress);
  $("#harmonic_image3_path")
      .delay(1000)
      .velocity({translateX: "-114px", translateY: "80px"}, {
        duration: progress.duration,
        easing: progress.easing,
        progress: function (elements, complete, remaining, start, tweenValue) {
          var img = document.getElementById('harmonic_image3');
          var parent = img.parentNode;
          parent.removeChild(img);
          parent.appendChild(img);
        }
      });
}

$(document).ready(function () {
  in_init();
  in_ie_fix();
});
