
self = ->
  @merge 'exts', ['.sass']

  deps = @root.data.devDependencies
  if deps?['node-sass']
    sass = require @resolve('node_modules/node-sass')
    @hook 'bundle', (css, bundle) ->

      {css, map} = sass.renderSync
        data: css
        file: ''
        outFile: 'bundle.css'
        sourceMap: true
        omitSourceMapUrl: true
        indentedSyntax: true
        outputStyle: bundle.outputStyle or 'compressed'

      content: css.toString()
      map: JSON.parse map.toString()

self.worker = require.resolve './worker'

module.exports = self
