###
 *
 *  jQuery Tooltips by Gary Hepting - https://github.com/ghepting/jquery-tooltips
 *  
 *  Open source under the BSD License. 
 *
 *  Copyright © 2013 Gary Hepting. All rights reserved.
 *
###

(($) ->
  $.fn.tooltip = (options) ->
    defaults =
      topOffset: 0
      delay: 100                    # delay before showing (ms)
      speed: 100                    # animation speed (ms)

    options = $.extend(defaults, options)

    tooltip = $('#tooltip')         # tooltip element
    delayShow = ''                  # delayed open
    trigger = ''                    # store trigger
    
    getElementPosition = (el) ->    # get element position
      offset = el.offset()
      win = $(window)
      top: top = offset.top - win.scrollTop()
      left: left = offset.left - win.scrollLeft()
      bottom: bottom = win.height() - top - el.outerHeight()
      right: right = win.width() - left - el.outerWidth()

    setPosition = (trigger) ->
      # get trigger element coordinates
      coords = getElementPosition(trigger)
      # tooltip dimensions
      if tooltip.outerWidth() > ($(window).width() - 20)
        tooltip.css('width',$(window).width() - 20)
      attrs = {}
      # adjust max width of tooltip
      tooltip.css('max-width', 
        Math.min(
          ($(window).width()-parseInt($('body').css('padding-left'))-parseInt($('body').css('padding-right'))),
          parseInt(tooltip.css('max-width'))
        )
      )
      width = tooltip.outerWidth()
      height = tooltip.outerHeight()
      # horizontal positioning
      if coords.left <= coords.right        # default position
        tooltip.addClass('left')
        attrs.left = coords.left
      else                                  # pin from right side
        tooltip.addClass('right')
        attrs.right = coords.right
      # veritcal positioning
      if (coords.top-options.topOffset) > (height+20) # top positioned tooltip
        tooltip.addClass('top')
        attrs.top = (trigger.offset().top - height) - 20
      else # bottom positioned tooltip
        tooltip.addClass('bottom')
        attrs.top = trigger.offset().top + trigger.outerHeight() - 4
      tooltip.css attrs

    closetooltip = ->
      tooltip.stop().remove()                # remove tooltip
      $('[role=tooltip]').removeClass('on')

    showtooltip = (trigger) ->
      closetooltip()           # close tooltip
      clearTimeout(delayShow)         # cancel previous timeout
      delayShow = setTimeout ->
        if $('#tooltip').length != 1
          # destroy any lingering tooltips
          $('#tooltip').remove()
          # create tooltip DOM element
          tooltip = $("<div id=\"tooltip\"></div>")
          # add tooltip element to DOM
          tooltip.appendTo("body")
        # set tooltip text
        tooltip.css("opacity", 0).text(trigger.attr('data-title'))
        # initialize tooltip
        setPosition(trigger)
        trigger.addClass('on')
        tooltip.animate
          top: "+=10"
          opacity: 1
        , options.speed
      , options.delay

    @each ->
      $this = $(this)
      $this.attr('role','tooltip').attr('data-title',$this.attr('title'))
      $this.removeAttr "title"        # remove title attribute (disable browser tooltips)
      
    
    # focus behavior
    $('body').on(
      'focus', '[role=tooltip]', ->
        showtooltip($(this))
    ).on(
      'blur', '[role=tooltip]', ->
        clearTimeout(delayShow)
        closetooltip()
    ).on(
      'mouseenter', '[role=tooltip]:not(input,select,textarea)', ->
        showtooltip($(this))
    ).on(
      'mouseleave', '[role=tooltip]:not(input,select,textarea)', ->
        clearTimeout(delayShow)
        closetooltip()
    )

    $(window).on
      scroll: ->
        trigger = $('[role=tooltip].on')
        if trigger.length
          setPosition(trigger)
          $('#tooltip').css
            top: "+=10"

) jQuery