assert = chai.assert

describe "app", ->
  app = null
  deck = null
  dealerHand = null
  discard = null
  hand = null
  
  beforeEach ->
    app = new App()
    deck = app.get 'deck'
    hand = app.get 'playerHand'
    dealerHand = app.get 'dealerHand'
    discard = app.get 'discard'
  
  describe "initialize", ->
    it 'should have a deck of 48 cards', ->
      assert.strictEqual deck.length, 48
    it 'should have an empty discard pile', ->
      assert.strictEqual discard.length, 0
    describe 'player', ->
      it 'player should have two cards', ->
        assert.strictEqual hand.length, 2
      it 'both of players cards should be revealed', ->
        assert.isTrue (hand.at 0) .get 'revealed'
        assert.isTrue (hand.at 1) .get 'revealed'
    describe 'dealer', ->
      it 'dealer should have two cards', ->
        assert.strictEqual dealerHand.length, 2
      it 'dealer\'s first card should be concealed', ->
        assert.isFalse (dealerHand.at 0) .get 'revealed'
      it 'dealer\'s second card should be revealed', ->
        assert.isTrue (dealerHand.at 1) .get 'revealed'
        
  describe 'newRound', ->
    it 'should create new deck when called without enough cards to deal', ->
      app.set 'deck', new Deck [deck.pop(), deck.pop()]
      deck = app.get 'deck'
      assert.strictEqual deck.length, 2
      app.newRound()
      deck = app.get 'deck'
      assert.strictEqual deck.length, 48
  
  describe 'discard', ->
    it 'should add played cards to the discard pile', ->
      hand.hit()
      app.discard()
      assert.strictEqual discard.length, 5
      
  
describe "app view", ->