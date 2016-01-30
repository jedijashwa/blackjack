class window.Deck extends Backbone.Collection
  model: Card

  initialize: (array)->
    if Array.isArray array then @add _.shuffle array
    else @add _([0...52]).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)
    @on 'remove', (->
      if @length is 0 then @trigger 'empty'
      return), @
    return


  dealPlayer: -> new Hand [@pop(), @pop()], @

  dealDealer: -> new Hand [@pop().flip(), @pop()], @, true 
  
  