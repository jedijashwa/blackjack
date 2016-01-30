# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'discard', []
    @set 'playerHand', new Hand
    @set 'dealerHand', new Hand
    @get 'deck' 
      .on 'empty', (->
        console.log 'empty'
        @set 'deck', new Deck @get 'discard'
        return), @
    @newRound()
    return
  
  gameEnd: ->
    dealer = @get 'dealerHand' 
      .bestScore()
    player = @get 'playerHand' 
      .bestScore()
    if player > 21 then @trigger 'bust'
    else if dealer > 21 then @trigger 'dealerBust'      
    else if player > dealer then @trigger 'win' 
    else if dealer is player then @trigger 'push' 
    else @trigger 'lose'
    return

  newRound: ->
    @discard()
    if @get 'deck'
      .length < 4 then @set 'deck', new Deck()
    @set 'playerHand', (@get 'deck'
      .dealPlayer())
    @set 'dealerHand', (@get 'deck'
      .dealDealer())
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
          .minScore() > 21 then @gameEnd()
        return
      ), @    
    return
    
  discard: ->
    @get 'playerHand'
      .map ((card)-> 
        @get 'discard'
          .push(card)
        return).bind @
    @get 'dealerHand'
      .map ((card)-> 
        @get 'discard'
          .push(card)
        return).bind @
    