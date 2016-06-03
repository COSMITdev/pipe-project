BasecampClone.Flash =
  init: ->
    setTimeout( ->
      $('.flash').slideDown()
    , 100)
    if $('.flash').length > 0
      setTimeout( ->
        $('.flash').slideUp()
      , 8000)
    $(document).one 'click', ->
      $('.flash').slideUp()
