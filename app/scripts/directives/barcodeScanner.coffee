'use strict'

###*
 # @ngdoc directive
 # @name kitbagApp.directive:barcodeScanner
 # @description
 # # barcodeScanner
###
angular.module 'kitbagApp'
.directive('kbBarcodeScanner', ($timeout) ->


  link: (scope, element, attrs) ->

    height = attrs.qrHeight || 240
    width = attrs.qrWidth || 360

    scannerConfig =
      audio: false
      video: true

    scope.supported = Modernizr.getusermedia

    if scope.supported

      localMediaStream = null

      # Build the video
      video = document.createElement 'video'
      video.setAttribute 'width', '100%'
      video.setAttribute 'style', 'max-width:' + width + 'px;max-height' + height + 'px'

      # Build the canvas
      canvas = document.createElement 'canvas'
      canvas.setAttribute 'id', 'qr-canvas'
      canvas.setAttribute 'width', width
      canvas.setAttribute 'height', height
      canvas.setAttribute 'style', 'display:none;'

      # Add to the element

      angular.element(element)
        .html video
        .append canvas

      context = canvas.getContext '2d'


      # Scan method
      scan = () ->
        if localMediaStream
          context.drawImage video, 0, 0, width, height

          try
            qrcode.decode()

          catch err
            scope.decodeError
              err: err

        # Rescan
        $timeout scan, 500


      successCallback = (stream) ->
        video.src =  window.URL.createObjectURL stream
        localMediaStream = stream
        video.play()

        # Do the first scan
        $timeout scan, 1000

      errCallback = (err) ->
        # Error in activating the video
        scope.videoError
          err: err


      scanner = Modernizr.prefixed 'getUserMedia', navigator

      scanner scannerConfig, successCallback, errCallback

      # Set up the callback to the success function
      qrcode.callback = (data) ->
        scope.success
          data: data

    else

      scope.videoError
        err: 'UNSUPPORTED_BROWSER'


  restrict: 'E'


  scope:
    decodeError: '&qrDecodeError'
    success: '&qrSuccess'
    videoError: '&qrVideoError'



  template: '<div class="barcode-scanner"></div>'


)
