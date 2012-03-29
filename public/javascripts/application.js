// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){
  $('input.datepicker').datepicker();
  
  $('#questions').sortable({
    axis: 'y',
    dropOnEmpty: false,
    handle: '.handle',
    cursor: 'crosshair',
    items: 'li',
    opacity: 0.4,
    scroll: true,
    update: function(){
      $.ajax({
        type: 'post',
        data: $('#questions').sortable('serialize'),
        dataType: 'script',
        complete: function(request){
          $('#questions').effect('highlight');
        },
        url: '/questions/sort'})
      }
  });
  
  $('#stories').sortable({
    axis: 'y',
    dropOnEmpty: false,
    handle: '.handle',
    cursor: 'crosshair',
    items: 'li',
    opacity: 0.4,
    scroll: true,
    update: function(){
      $.ajax({
        type: 'post',
        data: $('#stories').sortable('serialize'),
        dataType: 'script',
        complete: function(request){
          $('#stories').effect('highlight');
        },
        url: '/stories/sort'})
      }
  });
});

