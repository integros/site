$ ->
  menu = $('.b-header__menu')
  menuToggle = $('.b-header__menu-toggle')
  WINDOW_CHANGE_EVENT = ('onorientationchange' in window) ? 'orientationchange':'resize'

  toggleHorizontal = ->
    # menu.toggleClass('b-header__menu--horizontal')
    # [].forEach.call(
    #   document.getElementById('menu').querySelectorAll('.custom-can-transform'),
    #   function(el){
    #       el.classList.toggle('pure-menu-horizontal');
    #   }
    # );

  toggleMenu = ->
    # set timeout so that the panel has a chance to roll up
    # before the menu switches states
    # if menu.hasClass('open')
    #   setTimeout(toggleHorizontal, 500)
    # else
    #   toggleHorizontal()

    menu.toggleClass('b-header__menu--open')
    # document.getElementById('toggle').classList.toggle('x');

  closeMenu = ->
    if menu.hasClass('b-header__menu--open')
      toggleMenu()


  menuToggle.on 'click', (e)-> toggleMenu()

  window.addEventListener(WINDOW_CHANGE_EVENT, closeMenu)
