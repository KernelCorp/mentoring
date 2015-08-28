
$(document).ready ->
  Dropzone.autoDiscover = false;

  dropzone = new Dropzone '.dropzone',
    maxFilesize: 16
    paramName: 'photo[image]'
    addRemoveLinks: false
    dictDefaultMessage: 'Перетащите сюда файл для загрузки в альбом'

  dropzone.on 'success' , (file) ->
    this.removeFile file
    location.reload true
