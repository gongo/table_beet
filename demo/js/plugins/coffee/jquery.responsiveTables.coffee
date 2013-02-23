###
 *
 *  jQuery ResponsiveTables by Gary Hepting - https://github.com/ghepting/responsiveTables
 *  
 *  Open source under the BSD License. 
 *
 *  Copyright © 2013 Gary Hepting. All rights reserved.
 *
###

(($) ->
  elems = []
  $.fn.responsiveTable = (options) ->
    settings =
      compressor: options.compressor or 10
      minSize: options.minSize or Number.NEGATIVE_INFINITY
      maxSize: options.maxSize or Number.POSITIVE_INFINITY
      padding: 2
      height: "auto" # '100%' will fit tables (and containers) to viewport height as well
      adjust_parents: true # if height specified, force parent elements to be height 100%
    
    @each ->
      elem = $(this)
      elem.attr('data-compression',settings.compressor)
      elem.attr('data-min',settings.minSize)
      elem.attr('data-max',settings.maxSize)
      elem.attr('data-padding',settings.padding)
      # count columns
      columns = $("tr", elem).first().children("th, td").length
      # count rows
      rows = $("tr", elem).length
      unless settings.height is "auto"
        # set height of table
        $this.css "height", settings.height
        # set height of each parent of table
        if settings.adjust_parents
          $this.parents().each ->
            $(this).css "height", "100%"
      # set column widths
      $("tr th, tr td", elem).css "width", Math.floor(100 / columns) + "%"
      # set row heights
      $("tr th, tr td", elem).css "height", Math.floor(100 / rows) + "%"
      # set cell font sizes
      fontSize = Math.floor(Math.max(Math.min((elem.width() / (settings.compressor)), parseFloat(settings.maxSize)), parseFloat(settings.minSize)))
      $("tr th, tr td", elem).css "font-size", fontSize + "px"
      # 
      elems.push elem

  $(window).on "resize", ->
    $(elems).each ->
      elem = $(this)
      # set cell font sizes
      fontSize = Math.floor(Math.max(Math.min((elem.width() / (elem.attr('data-compression'))), parseFloat(elem.attr('data-max'))), parseFloat(elem.attr('data-min'))))
      $("tr th, tr td", elem).css "font-size", fontSize + "px"

) jQuery