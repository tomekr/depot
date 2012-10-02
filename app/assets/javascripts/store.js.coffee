# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# The first thing we want to do is to define a function that executes on page
# load. That’s what the first line of this script does: it defines a function
# using the -> operator and passes it to a function named $ which, as
# previously discussed, is aliased to jQuery. That’s all it takes to get jQuery
# to schedule the execution of these scripts when the page completes loading.
$ ->
  # Finds all images that are immediate children of elements that are defined
  # with class="entry", which themselves are descendants of an element with
  # class="store". 
  $('.store .entry > img').click ->
    # Processes that click event. It starts with the element on which the event
    # occurred, namely this. It then proceeds to find the parent element, which
    # will be the div that specifies class="entry". Within that element we find
    # the submit button, and we proceed to click it.
    $(this).parent().find(':submit').click()
