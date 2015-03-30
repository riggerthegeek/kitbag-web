'use strict'

angular.module 'kitbagApp'

.config (schemaFormDecoratorsProvider) ->

  base = 'views/forms/'

  schemaFormDecoratorsProvider.createDecorator 'kitbag',
    textarea: base + 'textarea.html',
    select: base + 'select.html',
    checkbox: base + 'checkbox.html',
    checkboxes: base + 'checkboxes.html',
    number: base + 'default.html',
    submit: base + 'submit.html',
    button: base + 'submit.html',
    text: base + 'default.html',
    date: base + 'default.html',
    password: base + 'default.html',
    datepicker: base + 'datepicker.html',
    input: base + 'default.html',
    radios: base + 'radios.html',
    'radios-inline': base + 'radios-inline.html',
    radiobuttons: base + 'radio-buttons.html',
  , [
      (form) ->

        form.ngModelOptions = {
          updateOn: 'submit'
        }

        return
    ]
