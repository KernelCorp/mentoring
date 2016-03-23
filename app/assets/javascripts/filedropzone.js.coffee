class @Filedropzone
  constructor: (selector) ->
    $(document).ready ->
      Dropzone.autoDiscover = false

      dropzone = new Dropzone selector,
        maxFilesize: 16
        paramName: 'photo[image]'
        addRemoveLinks: false
        acceptedFiles: 'image/*'
        dictDefaultMessage: 'Перетащите сюда файл для загрузки в альбом'

      dropzone.on 'success', (file) ->
        this.removeFile file

      dropzone.on 'queuecomplete', ->
        location.reload true
