class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '<%= rankName %> of <%= suitName %>'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'
    console.log @model.get 'suitName'
    if (@model.get 'suitName') is 'Diamonds' and @model.get 'revealed' then @$el.addClass 'red'
    if (@model.get 'suitName') is 'Hearts' and @model.get 'revealed' then @$el.addClass 'red'
    return
      




