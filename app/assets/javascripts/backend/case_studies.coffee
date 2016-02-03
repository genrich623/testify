# Copy to clipboard behaviour
$ ->
  $('#tileToClipboard').click () ->
    $('#tile_code').select()
    # copy
    try
      successful = document.execCommand('copy')
      msg = if successful then 'successful' else 'unsuccessful'
      console.log 'Copying text command was ' + msg
    catch err
      console.log 'Oops, unable to copy'
    # clear selection
    if window.getSelection
      if window.getSelection().empty
        # Chrome
        window.getSelection().empty()
      else if window.getSelection().removeAllRanges
        # Firefox
        window.getSelection().removeAllRanges()
      document.selection.empty()