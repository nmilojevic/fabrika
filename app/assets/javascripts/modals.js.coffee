# app/assets/javascripts/modals.js.coffee

  modal_holder_selector = '#modal-holder'
  modal_selector = '.modal'

  $(document).on 'click', 'a[data-modal]', ->
    location = $(this).attr('href')
    #Load modal dialog from server
    $.get location, (data)->
      $(modal_holder_selector).html(data).
      find(modal_selector).modal()
    false

  $(document).on 'ajax:success',
    'form[data-modal]', (event, data, status, xhr)->
      url = xhr.getResponseHeader('Location')
      msg = xhr.getResponseHeader('X-Message')
      type = xhr.getResponseHeader('X-Message-Type')
      if url
        # Redirect to url
        #window.location = url
        $('.modal-backdrop').remove()
        $(document).trigger("add-alerts", [
            {
              'message': decodeURIComponent(escape(msg)),
              'priority': 'success'
            }
          ])
        $('.admin-table').DataTable().draw()
      else
        # Remove old modal backdrop
        $('.modal-backdrop').remove()

        # Replace old modal with new one
        $(modal_holder_selector).html(data).
        find(modal_selector).modal()

      false