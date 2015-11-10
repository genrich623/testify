# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require trumbowyg.min
#= require ace/ace
#= require ace/mode-html
#= require ace/theme-monokai
#= require_tree .


$ ->
  $('.flashes .alert').each ->
    # 3 seconds
    $(this).fadeTo(3000, 500).slideUp(500, => $(this).alert('close'))

  $('.trumbowyg').trumbowyg()

  JavaScriptMode = ace.require("ace/mode/javascript").Mode;
  $('.ace-html').each ->
    textarea = $(this).hide()

    div = $('<div></div>').html(textarea.html(  )).insertAfter(textarea)

    editor = ace.edit(div[0])
    editor.setTheme(ace.require("ace/theme/monokai"))
    editor.setOptions
      maxLines: 15
      minLines: 10
      fontSize: "14pt"
    editor.session.setMode(new JavaScriptMode())

    textarea.closest('form').submit =>
      textarea.val(editor.getSession().getValue())
