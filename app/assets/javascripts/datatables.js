//= require jquery.dataTables
//= require dataTables.buttons
//= require dataTables.buttons
//= require dataTables.responsive
//= require responsive.bootstrap
//= require dataTables.colVis
//= require buttons.colVis
//  require buttons.bootstrap
//= require DT_bootstrap
//= require jquery.highlight
//
// Pipelining function for DataTables. To be used to the `ajax` option of DataTables
//
$.fn.dataTable.pipeline = function ( opts ) {
    // Configuration options
    var conf = $.extend( {
        pages: 5,     // number of pages to cache
        url: '',      // script url
        data: null,   // function or object with parameters to send to the server
                      // matching how `ajax.data` works in DataTables
        method: 'GET' // Ajax HTTP method
    }, opts );
 
    // Private variables for storing the cache
    var cacheLower = -1;
    var cacheUpper = null;
    var cacheLastRequest = null;
    var cacheLastJson = null;
 
    return function ( request, drawCallback, settings ) {
        var ajax          = false;
        var requestStart  = request.start;
        var drawStart     = request.start;
        var requestLength = request.length;
        var requestEnd    = requestStart + requestLength;
         
        if ( settings.clearCache ) {
            // API requested that the cache be cleared
            ajax = true;
            settings.clearCache = false;
        }
        else if ( cacheLower < 0 || requestStart < cacheLower || requestEnd > cacheUpper || requestLength == -1) {
            // outside cached data - need to make a request
            ajax = true;
        }
        else if ( JSON.stringify( request.order )   !== JSON.stringify( cacheLastRequest.order ) ||
                  JSON.stringify( request.columns ) !== JSON.stringify( cacheLastRequest.columns ) ||
                  JSON.stringify( request.search )  !== JSON.stringify( cacheLastRequest.search )
        ) {
            // properties changed (ordering, columns, searching)
            ajax = true;
        }
         
        // Store the request for checking next time around
        cacheLastRequest = $.extend( true, {}, request );
 
        if ( ajax ) {
            // Need data from the server
            if (requestLength != -1){
                if ( requestStart < cacheLower ) {
                    requestStart = requestStart - (requestLength*(conf.pages-1));
     
                    if ( requestStart < 0) {
                        requestStart = 0;
                    }
                }
                cacheLower = requestStart;
                cacheUpper = requestStart + (requestLength * conf.pages);
            } else {
                requestStart = 0;
                cacheLower = 0;
                cacheUpper = 0;
            }
            request.start = requestStart;
            request.length = requestLength == -1 ? -1 : requestLength*conf.pages;
 
            // Provide the same `data` options as DataTables.
            if ( $.isFunction ( conf.data ) ) {
                // As a function it is executed with the data object as an arg
                // for manipulation. If an object is returned, it is used as the
                // data object to submit
                var d = conf.data( request );
                if ( d ) {
                    $.extend( request, d );
                }
            }
            else if ( $.isPlainObject( conf.data ) ) {
                // As an object, the data given extends the default
                $.extend( request, conf.data );
            }
 
            settings.jqXHR = $.ajax( {
                "type":     conf.method,
                "url":      conf.url,
                "data":     request,
                "dataType": "json",
                "cache":    false,
                "success":  function ( json ) {
                    if (requestLength != -1){
                        cacheLastJson = $.extend(true, {}, json);
                        if ( cacheLower != drawStart ) {
                            json.data.splice( 0, drawStart-cacheLower );
                        }
                        json.data.splice( requestLength, json.data.length );
                    }
                    drawCallback( json );
                }
            } );
        }
        else {
            json = $.extend( true, {}, cacheLastJson );
            json.draw = request.draw; // Update the echo for each response
            json.data.splice( 0, requestStart-cacheLower );
            json.data.splice( requestLength, json.data.length );
 
            drawCallback(json);
        }
    }
};
 
// Register an API method that will empty the pipelined data, forcing an Ajax
// fetch on the next draw (i.e. `table.clearPipeline().draw()`)
$.fn.dataTable.Api.register( 'clearPipeline()', function () {
    return this.iterator( 'table', function ( settings ) {
        settings.clearCache = true;
    } );
} );
 
 $.fn.dataTable.ext.errMode = 'none';

function createTableOptions(table_selector) {
  table_selector = typeof table_selector !== 'undefined' ? table_selector : '.table';
  aoColumns = [];
  $(table_selector+':first').find('th').each(function(index, el) {
    aoColumns.push({ "bSortable": ($(el).text() != 'Actions')});
  });

  var displayLength = 25;
  if($('#display_length').length == 1)
    displayLength = $('#display_length').val();

  return {
    "aLengthMenu": [
    [10, 25, 50, -1],
    [10, 25, 50, "All"] // change per page values here
    ],
    "aoColumns": aoColumns,
    "oLanguage": {
      "sLengthMenu": "_MENU_ " + $('#model_name').val() + " per page",
      "oPaginate": {
        "sPrevious": "Prev",
        "sNext": "Next"
      }
    },
    "aaSorting" : [
        [aoColumns.length - 2, "desc"]
    ],
    // set the initial value
    "iDisplayLength": displayLength,
    "bProcessing": true,
    "bAutoWidth": false,
    "bServerSide": true,
   // "ajax":
    "ajax": {
                'url':  $(table_selector).data('source'),
                'type': 'get',
                'dataType': "json",
                'error': function(xhr, status, error) {
                    console.log(xhr.responseJSON.error);
                    console.error(xhr.responseJSON.error);
                    $("#table-loading").hide();
                    //window.location.reload();
                }
            },
   // "ajax":  $('.table').data('source'),
    "sDom" : "<'admin-page-header clear'<'manage_user-id left'><'right'f>r>t<'row table-footer'<'col-md-4'l><'col-md-4' <'text-center'i>><'col-md-4'p>>",
    "sPaginationType": "bootstrap",
    "fnDrawCallback" : function(sSearch) {
        var search = sSearch.oPreviousSearch.sSearch;
        $(table_selector + ' tbody tr').each(function() {

          if($(this).text().indexOf(search) != -1) {
            $(this).unhighlight();
            $(this).highlight(search);
          }
        })
        }
    }

}

var DELAYED_LOADING_MS = 100;
var DataTableDefaultHandler = {}

DataTableDefaultHandler.processing = function( e, settings, processing ) {
    if (processing){
        $('.dataTables_processing').hide();
        clearTimeout($(this).data('delayedLoading'))
        $(this).data('delayedLoading', createDelayedLoading($(this).data('loading')));
    } else {
        clearTimeout($(this).data('delayedLoading'))
        $(this).data('loading').hide();
    }
}

DataTableDefaultHandler.init = function() {
    $(this).trigger('initdone');
    clearTimeout($(this).data('delayedLoading'))
    $(this).data('loading').hide();
}

DataTableDefaultHandler.draw = function() {
    $(this).show();
    clearTimeout($(this).data('delayedLoading'))
    $(this).data('loading').hide();
}

function createDelayedLoading(loading) {
  var delayedLoading = setTimeout(function () {
    $(loading).show();
  }, DELAYED_LOADING_MS);
  return delayedLoading;
}

function createDataTable(tableOptions, loading, table_selector){
  var dataTable;
    table_selector = typeof table_selector !== 'undefined' ? table_selector : '.table';
    loading = typeof loading !== 'undefined' ? loading : "#table-loading";
    dataTable = $(table_selector).on( 'error.dt', function ( e, settings, techNote, message ) {
        $('#error-title').text("Data problem");
        $('#error-message').html('We are experiencing some issues with populating your table. Please try again later. If the problem persists, contact Frame support (support@fra.me).');
        $('#error-modal').modal('show');
        console.error( 'An error has been reported by DataTables: ', message );
    } ).dataTable(tableOptions);
    setupTableVisuals();
    $('.dataTables_processing').hide();
    $(table_selector).data('loading', $(loading));
    //$(table_selector).data('delayedLoading', createDelayedLoading(loading));
    $(table_selector).show();
    $(table_selector).on( 'init.dt', DataTableDefaultHandler.init );
    $(table_selector).on( 'draw.dt', DataTableDefaultHandler.draw );
    $(table_selector).on( 'processing.dt', DataTableDefaultHandler.processing );

    // $('select.breathe').dropkick({
    //     mobile: true
    // });
    $('select.breathe').click(function(e){
      e.preventDefault();
      return false;
    });
    return dataTable;

}

function setupTableVisuals() {
  $('.dataTables_filter label')
    .contents()
    .filter(function() {
      return this.nodeType == 3; //Node.TEXT_NODE
    }).remove();

  $('.dataTables_filter input').addClass("m-wrap medium"); // modify table search input
  $('.table-footer select').addClass('breathe');
}
