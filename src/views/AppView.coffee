class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()

  initialize: ->
    @render()
    @model.on 'bust', (->
      alert 'bust'
      @reset()
      ), @
    @model.on 'dealerBust', (->
      alert 'dealer bust'
      @reset()
      ), @
    @model.on 'win', (->
      alert 'you win'
      @reset()
      ), @
    @model.on 'lose', (->
      alert 'you lose'
      @reset()
      ), @
    @model.on 'push', (->
      alert 'push'
      @reset()
      ), @
      
  reset: ->
    this.model.newRound()
    this.render()

  render: ->
    @$el.addClass 'table-container'
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el