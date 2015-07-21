$ ->
  menu = $('.b-header__menu')
  menuToggle = $('.b-header__menu-toggle')
  WINDOW_CHANGE_EVENT = ('onorientationchange' in window) ? 'orientationchange':'resize'

  toggleMenu = ->
    menu.toggleClass('b-header__menu--open')

  closeMenu = ->
    if menu.hasClass('b-header__menu--open')
      toggleMenu()

  menuToggle.on 'click', (e)-> toggleMenu()

  window.addEventListener(WINDOW_CHANGE_EVENT, closeMenu)
