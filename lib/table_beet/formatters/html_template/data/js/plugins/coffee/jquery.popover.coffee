###
 *
 *  jQuery Popovers by Gary Hepting - https://github.com/ghepting/jquery-popovers
 *  
 *  Open source under the BSD License. 
 *
 *  Copyright © 2013 Gary Hepting. All rights reserved.
 *
###

(($) ->
  $.fn.popover = (options) ->
    defaults =
      hover: false        # show popovers on hover
      click: true         # show popovers on click
      resize: true        # resize popovers on window resize/orientation change
      scroll: true        # reposition popovers on scroll
      topOffset: 0        # top offset (accomodate for fixed navigation, etc.)
      delay: 500          # delay before hiding (ms)
      speed: 100          # animation speed (ms)

    options = $.extend(defaults, options)

    popover = $('#popover')         # popover element
    delayHide = ''                  # delay
    delayAdjust = ''                # delay
    trigger = ''                    # trigger element
    
    # get element position relative to the viewport
    getElementPosition = (el) ->
      offset = el.offset()
      win = $(window)
      top: top = offset.top - win.scrollTop()
      left: left = offset.left - win.scrollLeft()
      bottom: bottom = win.height() - top - el.outerHeight()
      right: right = win.width() - left - el.outerWidth()

    resetPopover = (resize) ->
      popover.css
        top: 'auto'
        right: 'auto'
        bottom: 'auto'
        left: 'auto'
      if resize
        popover.css
          width: 'auto'
      popover.removeClass('top')
      popover.removeClass('right')
      popover.removeClass('bottom')
      popover.removeClass('left')

    setPosition = (trigger, skipAnimation, resize) ->
      if trigger
        if resize
          resetPopover(true)
        else
          resetPopover()
        # get trigger element coordinates
        coords = getElementPosition(trigger)
        # popover dimensions
        if popover.outerWidth() > ($(window).width() - 20)
          popover.css('width',$(window).width() - 20)
        # adjust max width of popover
        popover.css('max-width', 
          Math.min(
            ($(window).width()-parseInt($('body').css('padding-left'))-parseInt($('body').css('padding-right'))),
            parseInt(popover.css('max-width'))
          )
        )
        width = popover.outerWidth()
        height = popover.outerHeight()
        # horizontal positioning
        attrs = {}
        if coords.left <= coords.right        # default position
          popover.addClass('left')
          attrs.left = coords.left
        else                                  # pin from right side
          popover.addClass('right')
          attrs.right = coords.right
        # veritcal positioning
        if (coords.top-options.topOffset) > (height+20) # top positioned popover
          popover.addClass('top')
          attrs.top = trigger.offset().top - height - 20
        else # bottom positioned popover
          popover.addClass('bottom')
          attrs.top = trigger.offset().top + 15
        popover.css attrs
        # compensate for adjustment normally made by animation in init_popover()
        if skipAnimation
          popover.css
            top: '+=10'

    closePopover = ->
      $('.popover-trigger').removeClass('popover-trigger')
      popover.removeClass('sticky').remove()

    showPopover = (e) ->
      trigger = $(e.target)       # trigger element
      if !trigger.hasClass('popover-trigger') 
        closePopover()              # close popover
        trigger.addClass('popover-trigger')
      # set popover content
      tip = $('#'+trigger.attr('data-content')).html()
      popover = $("<div id=\"popover\"></div>") # create popover DOM element
      return false  if not tip or tip is ""
      # remove title to avoid overlapping default tooltips
      trigger.removeAttr "title"
      # add popover element to DOM
      popover.css("opacity", 0).html(tip).appendTo "body"
      # initialize popover
      setPosition(trigger)
      popover.animate
        top: "+=10"
        opacity: 1
      , options.speed

      # popover click
      popover.bind "click", (e) ->
        if(e.target.tagName != 'a')
          popover.addClass('sticky')
          e.stopPropagation()
          e.preventDefault()
          false

      # close button click
      popover.find('.close').bind "click", (e) ->
        $('.popover-trigger').removeClass('popover-trigger')
        popover.removeClass('sticky').remove()
        e.stopPropagation()
        e.preventDefault()
        false

      # hover into the popover
      popover.bind
        mouseenter: ->
          # cancel closing popover
          clearTimeout(delayHide)
        mouseleave: ->
          if(!popover.hasClass('sticky'))
            # close popover on a delay if it's not sticky
            delayHide = setTimeout (->
              $('.popover-trigger').removeClass('popover-trigger')
              popover.removeClass('sticky').remove()
            ), 500


    @each ->
      $this = $(this)

      if options.hover
        # hover on trigger element
        $this.bind
          mouseenter: (e) ->
            trigger = $(e.target)
            clearTimeout(delayHide)     # cancel delayed close
            if(!$this.hasClass('popover-trigger') && !popover.hasClass('sticky'))
              showPopover(e)            # show popover
          mouseleave: ->
            if(!popover.hasClass('sticky'))
              # delay closing popover
              delayHide = setTimeout ->
                closePopover()          #close popover
              , options.delay

      if options.click
        # click trigger element
        $this.bind "click", (e) ->
          trigger = $(e.target)
          if(!trigger.hasClass('popover-trigger'))
            closePopover()            #close popover
            showPopover(e)            # show popover
          popover.addClass('sticky')  # make popover sticky
          e.preventDefault()
          e.stopPropagation()
          false

      if options.resize
        # handle viewport resize
        $(window).resize ->
          clearTimeout(delayAdjust)   # cancel delayed adjustment
          # attempt to wait until user finishes resizing the window
          delayAdjust = setTimeout ->
            setPosition(trigger, true, true)
          , 100

      if options.scroll
        # handle window scroll
        $(window).scroll ->
          setPosition(trigger, true)

      # close popover on body click
      $('html, body').bind "click", (e) ->
        $('.popover-trigger').removeClass('popover-trigger')
        popover.removeClass('sticky').remove()

      

) jQuery