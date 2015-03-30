'use strict'

angular.module 'kitbagApp'
.directive 'kbBreadcrumbs', ->

  template = '<ui-breadcrumbs'
  template += ' displayname-property="data.pageTitle"'
  template += ' template-url="views/directives/breadcrumbs.html">'
  template += '</ui-breadcrumbs>'

  {

    template: template

  }
