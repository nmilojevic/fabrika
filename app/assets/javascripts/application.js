// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap
//= require moment
//= require momentjs-rs
//= require bootstrap-datetimepicker
//= require bootstrap-multiselect
//= require jquery.bsAlerts.min
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery.fancybox
//= require turbolinks
//= require bootstrap-dialog.min
 


$(function(){

  /*** CONFIRM MODAL OVERRIDE ***/
  //override the use of js alert on confirms
  //requires bootstrap3-dialog from https://github.com/nakupanda/bootstrap3-dialog


  $.rails.allowAction = function(link){
    if( !link.is('[data-confirm]') )
      return true;
    BootstrapDialog.show({
      type: BootstrapDialog.TYPE_DANGER,
      title: 'Confirm',
      message: link.attr('data-confirm'),
      buttons: [{
        label: 'Accept',
        cssClass: 'btn-primary',
        action: function(dialogRef){
          link.removeAttr('data-confirm');
          link.trigger('click.rails');
          dialogRef.close();
        }
      }, {
        label: 'Cancel',
        action: function(dialogRef){
          dialogRef.close();
        }
      }]
    });
    return false; // always stops the action since code runs asynchronously
  };

  //Other global javascript stuffs
  //...

});