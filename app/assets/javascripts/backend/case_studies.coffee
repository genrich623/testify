$ ->
  code_shown = false
  btn = $('#generate-code')
  code = $('#code').hide()
  btn.click (e) ->
    slide = if code_shown then 'slideUp' else 'slideDown'
    code[slide]()
    code_shown = !code_shown
    e.preventDefault()
