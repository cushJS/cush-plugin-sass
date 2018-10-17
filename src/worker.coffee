lexer = require 'sass-lexer'

enabled = Symbol 'sass:enabled'

tokenizer = (opts) ->
  toks = lexer opts.css
  atrule: 'atrule'
  evalStrings: false
  getLength: (prev) -> prev[2]
  importWord: 'import'
  nextToken: -> toks.next()
  semi: false

module.exports = ->
  @transform '.sass', (asset, pack) ->
    asset.ext = '.css'
    if !pack[enabled]
      pack[enabled] = true
      pack.tokenize = tokenizer
    return
