# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get 'playerHand' 
      .on 'done', (-> 
        @get 'dealerHand'
          .finish()
        @gameEnd()
        return
        ), @
    @get 'playerHand'
      .on 'hit', (->
        if @get 'playerHand'
          .minScore() > 21 then @trigger 'bust'
        return
      ), @
    return
  
  gameEnd: ->
    if @get 'dealerHand' 
      .minScore() > 21 then @trigger 'dealerBust'      
    if @get 'playerHand' 
      .bestScore() > @get 'dealerHand' 
        .bestScore() then @trigger 'win' else @trigger 'lose'
    return

    
    
    