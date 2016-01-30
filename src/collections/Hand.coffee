class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())
    @trigger 'hit'
    @last()
    
  stand: ->
    @trigger 'done'
    return
    
  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]
    
  finish: ->
    if @isDealer
      @at(0)
        .flip()
      while @scores()[0] < 17 and not (@scores()[1] >= 17 and @scores()[1] <= 21)
        @hit()
        console.log @scores()

    return

  bestScore: ->
    if @scores()[1] <= 21 then @scores()[1] else @scores()[0]
