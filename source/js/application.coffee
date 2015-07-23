#= require jquery/jquery
#= require retina.js/src/retina.js
#= require vex/coffee/vex
#= require vex/coffee/vex.dialog
#= require tether/dist/js/tether
#= require_tree .


$ ->
  vex.defaultOptions.className = 'vex-theme-integros'

  $('.btn-get-access').on 'click', ->
    vex.open
      showCloseButton: true
      content: $('.b-signin-modal').html()
    false

  $(document).on 'click', '.b-signin__success-close', (e)->
    e.preventDefault();
    vex.close()

  Loader =
    show: ->
      vex.showLoading()
      $('.b-signin').addClass('b-signin--loading')
      $('.vex .b-signin__btn-submit').prop('disabled', true)
    hide: ->
      vex.hideLoading()
      $('.b-signin').removeClass('b-signin--loading')
      $('.vex .b-signin__btn-submit').prop('disabled', false)

  $(document).on 'click', '.b-signin__btn-submit', (e)->
    e.preventDefault();
    form = $(this).closest('form')

    Loader.show();

    $.post 'https://api.integros.com/early_access', form.serialize(), (response)=>
      Loader.hide();

      if response.success
        form.hide()
        form.siblings('.b-signin__success').show()
      else
        form.find('.b-signin__form-element').removeClass('b-signin__form-element__error')
        form.find('.b-signin__error').hide()

        $.each response.errors, (k, v)->
          block = form.find('.b-signin__form-element-' + k)
          block.addClass('b-signin__form-element__error')

          block.find('.b-signin__error').html(v).show()
