assert = chai.assert

describe 'deck', ->
  deck = null
  hand = null
  dealerHand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()
    dealerHand = deck.dealDealer()
  
  describe 'dealPlayer', ->
    it 'should deal two cards from deck', ->
      assert.strictEqual deck.length, 48
      assert.strictEqual hand.length, 2
      hand = deck.dealPlayer()
      assert.strictEqual deck.length, 46
      assert.strictEqual hand.length, 2
      
  describe 'dealDealer', ->
    it 'should deal two cards from deck', ->
      assert.strictEqual deck.length, 48
      assert.strictEqual dealerHand.length, 2
      dealerHand = deck.dealDealer()
      assert.strictEqual deck.length, 46
      assert.strictEqual dealerHand.length, 2

  describe 'hit', ->
    it 'should give the last card from the deck', ->
      assert.strictEqual deck.length, 48
      assert.strictEqual deck.last(), hand.hit()
      assert.strictEqual deck.length, 47
    return
  return
    
