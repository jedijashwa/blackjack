assert = chai.assert

describe "deck constructor", ->

  it "should create a card collection", ->
    collection = new Deck()
    assert.strictEqual collection.length, 52
  it "should create a card collection from an array of cards", ->
    collection = new Deck()
    array = [collection.pop(), collection.pop()]
    collection2 = new Deck array
    assert.strictEqual collection2.length, 2

    
