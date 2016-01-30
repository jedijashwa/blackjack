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
    dealer = @get 'dealerHand' 
      .minScore()
    player = @get 'playerHand' 
      .minScore()
    if dealer > 21 then @trigger 'dealerBust'      
    if player > dealer then @trigger 'win' else if dealer is player then @trigger 'push' else @trigger 'lose'
    return

  newRound: ->
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    