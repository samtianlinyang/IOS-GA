import Foundation
import UIKit

enum Action {
    case hit, stand, split, doubleOrHit, doubleOrStand, over
    
    func getAction() -> String {
        switch self {
        case .hit: return "hit"
        case .stand: return "stand"
        case .split: return "split"
        case .doubleOrHit: return "Double or Hit"
        case .doubleOrStand: return "Doble or Stand"
        case.over: return "you are over"
        }
    }
    
    func getActionBackgroundColor() -> UIColor {
        switch self {
        case .hit: return UIColor.greenColor()
        case .stand: return UIColor.redColor()
        case .split: return UIColor.greenColor()
        case .doubleOrHit: return UIColor.greenColor()
        case .doubleOrStand: return UIColor.redColor()
        case.over: return UIColor.redColor()
        }
    }
    
}



struct CardCombo : Hashable{
    let dealerCard : Int
    let playerCard : Int
    
    var hashValue: Int {
        return dealerCard.hashValue ^ playerCard.hashValue
    }
}

func ==(lhs: CardCombo, rhs: CardCombo) -> Bool {
    return lhs.dealerCard == rhs.dealerCard && lhs.playerCard == rhs.playerCard
}


enum Soft17 {
    case dealerStands, dealerHits
}

enum Decks {
    case one, two, fourOrMore
}

enum DoubleAfterSplit {
    case yesSplit, noSplit
}

enum Surrender {
    case surrenderNotAllowed, surrenderAllowedWithAnyDealerUpCard, surrenderAllowedOnADealer2to10
}

enum DealerPeek {
    case dealerPeaks, noPeekEuropeanStyle
}

var decksSelection: Decks?
var soft17Selection: Soft17?
var doubleAfterSplitSelection: DoubleAfterSplit = .yesSplit
var surrenderSelection: Surrender = .surrenderNotAllowed
var dealerPeekSelection: DealerPeek = .dealerPeaks





class StateOfCard {
    var soft17: Soft17
    var decks: Decks
    var doubleAfterSplit: DoubleAfterSplit
    var surrender: Surrender
    var dealerPeek: DealerPeek
    var dealerCard: Int
    var myFirstCard: Int
    var mySecondCard: Int
    var myThirdCard: Int
    var myFourthCard: Int
    
    init(soft17: Soft17, decks: Decks, doubleAfterSplit: DoubleAfterSplit, surrender: Surrender, daelerPeek: DealerPeek, dealerCard:Int, myFirstCard:Int, mySecondCard:Int, myThirdCard:Int, myFourthCard:Int) {
        self.soft17 = soft17
        self.decks = decks
        self.doubleAfterSplit = doubleAfterSplit
        self.surrender = surrender
        self.dealerPeek = daelerPeek
        self.dealerCard = dealerCard
        self.myFirstCard = myFirstCard
        self.mySecondCard = mySecondCard
        self.myThirdCard = myThirdCard
        self.myFourthCard = myFourthCard
    }
    
    func strategyCalculator() -> Action {
        var dealerTotal: Int!
        var playerTotal: Int!
        var playerTotalWithAces: Int?
        
        var strategy : [CardCombo:Action] = [:]
        
        dealerTotal = dealerCard
        
        playerTotal = myFirstCard + mySecondCard + myThirdCard + myFourthCard
        
        
        if myFirstCard == 11 || mySecondCard == 11 || myThirdCard == 11 || myFourthCard == 11 {
            playerTotalWithAces = myFirstCard + mySecondCard + myThirdCard + myFourthCard
            
            let array : [Int] = [myFirstCard, mySecondCard, myThirdCard, myFourthCard]
            var counts:[Int:Int] = [:]
            for item in array {
                counts[item] = (counts[item] ?? 0) + 1}
            var i = counts[11]!
            while i > 0 {
                if playerTotalWithAces > 21 {
                    playerTotalWithAces = playerTotalWithAces! - 10}
                i = i - 1
            }
        }
        
        
        if decks == .fourOrMore && soft17 == .dealerStands && doubleAfterSplit == .yesSplit && surrender == .surrenderNotAllowed && dealerPeek == .dealerPeaks {
        
        if myFirstCard == mySecondCard && myThirdCard == 0 && myFourthCard == 0 {
            
            strategy[CardCombo(dealerCard: 2,playerCard: 4)] = Action.split
            strategy[CardCombo(dealerCard: 3,playerCard: 4)] = Action.split
            strategy[CardCombo(dealerCard: 4,playerCard: 4)] = Action.split
            strategy[CardCombo(dealerCard: 5,playerCard: 4)] = Action.split
            strategy[CardCombo(dealerCard: 6,playerCard: 4)] = Action.split
            strategy[CardCombo(dealerCard: 7,playerCard: 4)] = Action.split
            strategy[CardCombo(dealerCard: 8,playerCard: 4)] = Action.hit
            strategy[CardCombo(dealerCard: 9,playerCard: 4)] = Action.hit
            strategy[CardCombo(dealerCard: 10,playerCard: 4)] = Action.hit
            strategy[CardCombo(dealerCard: 11,playerCard: 4)] = Action.hit
            
            strategy[CardCombo(dealerCard: 2,playerCard: 6)] = Action.split
            strategy[CardCombo(dealerCard: 3,playerCard: 6)] = Action.split
            strategy[CardCombo(dealerCard: 4,playerCard: 6)] = Action.split
            strategy[CardCombo(dealerCard: 5,playerCard: 6)] = Action.split
            strategy[CardCombo(dealerCard: 6,playerCard: 6)] = Action.split
            strategy[CardCombo(dealerCard: 7,playerCard: 6)] = Action.split
            strategy[CardCombo(dealerCard: 8,playerCard: 6)] = Action.hit
            strategy[CardCombo(dealerCard: 9,playerCard: 6)] = Action.hit
            strategy[CardCombo(dealerCard: 10,playerCard: 6)] = Action.hit
            strategy[CardCombo(dealerCard: 11,playerCard: 6)] = Action.hit
            
            strategy[CardCombo(dealerCard: 2,playerCard: 8)] = Action.hit
            strategy[CardCombo(dealerCard: 3,playerCard: 8)] = Action.hit
            strategy[CardCombo(dealerCard: 4,playerCard: 8)] = Action.hit
            strategy[CardCombo(dealerCard: 5,playerCard: 8)] = Action.split
            strategy[CardCombo(dealerCard: 6,playerCard: 8)] = Action.split
            strategy[CardCombo(dealerCard: 7,playerCard: 8)] = Action.hit
            strategy[CardCombo(dealerCard: 8,playerCard: 8)] = Action.hit
            strategy[CardCombo(dealerCard: 9,playerCard: 8)] = Action.hit
            strategy[CardCombo(dealerCard: 10,playerCard: 8)] = Action.hit
            strategy[CardCombo(dealerCard: 11,playerCard: 8)] = Action.hit
            
            strategy[CardCombo(dealerCard: 2,playerCard: 10)] = Action.doubleOrHit
            strategy[CardCombo(dealerCard: 3,playerCard: 10)] = Action.doubleOrHit
            strategy[CardCombo(dealerCard: 4,playerCard: 10)] = Action.doubleOrHit
            strategy[CardCombo(dealerCard: 5,playerCard: 10)] = Action.doubleOrHit
            strategy[CardCombo(dealerCard: 6,playerCard: 10)] = Action.doubleOrHit
            strategy[CardCombo(dealerCard: 7,playerCard: 10)] = Action.doubleOrHit
            strategy[CardCombo(dealerCard: 8,playerCard: 10)] = Action.doubleOrHit
            strategy[CardCombo(dealerCard: 9,playerCard: 10)] = Action.doubleOrHit
            strategy[CardCombo(dealerCard: 10,playerCard: 10)] = Action.hit
            strategy[CardCombo(dealerCard: 11,playerCard: 10)] = Action.hit
            
            strategy[CardCombo(dealerCard: 2,playerCard: 12)] = Action.split
            strategy[CardCombo(dealerCard: 3,playerCard: 12)] = Action.split
            strategy[CardCombo(dealerCard: 4,playerCard: 12)] = Action.split
            strategy[CardCombo(dealerCard: 5,playerCard: 12)] = Action.split
            strategy[CardCombo(dealerCard: 6,playerCard: 12)] = Action.split
            strategy[CardCombo(dealerCard: 7,playerCard: 12)] = Action.hit
            strategy[CardCombo(dealerCard: 8,playerCard: 12)] = Action.hit
            strategy[CardCombo(dealerCard: 9,playerCard: 12)] = Action.hit
            strategy[CardCombo(dealerCard: 10,playerCard: 12)] = Action.hit
            strategy[CardCombo(dealerCard: 11,playerCard: 12)] = Action.hit
            
            strategy[CardCombo(dealerCard: 2,playerCard: 14)] = Action.split
            strategy[CardCombo(dealerCard: 3,playerCard: 14)] = Action.split
            strategy[CardCombo(dealerCard: 4,playerCard: 14)] = Action.split
            strategy[CardCombo(dealerCard: 5,playerCard: 14)] = Action.split
            strategy[CardCombo(dealerCard: 6,playerCard: 14)] = Action.split
            strategy[CardCombo(dealerCard: 7,playerCard: 14)] = Action.split
            strategy[CardCombo(dealerCard: 8,playerCard: 14)] = Action.hit
            strategy[CardCombo(dealerCard: 9,playerCard: 14)] = Action.hit
            strategy[CardCombo(dealerCard: 10,playerCard: 14)] = Action.hit
            strategy[CardCombo(dealerCard: 11,playerCard: 14)] = Action.hit
            
            strategy[CardCombo(dealerCard: 2,playerCard: 16)] = Action.split
            strategy[CardCombo(dealerCard: 3,playerCard: 16)] = Action.split
            strategy[CardCombo(dealerCard: 4,playerCard: 16)] = Action.split
            strategy[CardCombo(dealerCard: 5,playerCard: 16)] = Action.split
            strategy[CardCombo(dealerCard: 6,playerCard: 16)] = Action.split
            strategy[CardCombo(dealerCard: 7,playerCard: 16)] = Action.split
            strategy[CardCombo(dealerCard: 8,playerCard: 16)] = Action.split
            strategy[CardCombo(dealerCard: 9,playerCard: 16)] = Action.split
            strategy[CardCombo(dealerCard: 10,playerCard: 16)] = Action.split
            strategy[CardCombo(dealerCard: 11,playerCard: 16)] = Action.split
            
            strategy[CardCombo(dealerCard: 2,playerCard: 18)] = Action.split
            strategy[CardCombo(dealerCard: 3,playerCard: 18)] = Action.split
            strategy[CardCombo(dealerCard: 4,playerCard: 18)] = Action.split
            strategy[CardCombo(dealerCard: 5,playerCard: 18)] = Action.split
            strategy[CardCombo(dealerCard: 6,playerCard: 18)] = Action.split
            strategy[CardCombo(dealerCard: 7,playerCard: 18)] = Action.stand
            strategy[CardCombo(dealerCard: 8,playerCard: 18)] = Action.split
            strategy[CardCombo(dealerCard: 9,playerCard: 18)] = Action.split
            strategy[CardCombo(dealerCard: 10,playerCard: 18)] = Action.stand
            strategy[CardCombo(dealerCard: 11,playerCard: 18)] = Action.stand
            
            strategy[CardCombo(dealerCard: 2,playerCard: 20)] = Action.stand
            strategy[CardCombo(dealerCard: 3,playerCard: 20)] = Action.stand
            strategy[CardCombo(dealerCard: 4,playerCard: 20)] = Action.stand
            strategy[CardCombo(dealerCard: 5,playerCard: 20)] = Action.stand
            strategy[CardCombo(dealerCard: 6,playerCard: 20)] = Action.stand
            strategy[CardCombo(dealerCard: 7,playerCard: 20)] = Action.stand
            strategy[CardCombo(dealerCard: 8,playerCard: 20)] = Action.stand
            strategy[CardCombo(dealerCard: 9,playerCard: 20)] = Action.stand
            strategy[CardCombo(dealerCard: 10,playerCard: 20)] = Action.stand
            strategy[CardCombo(dealerCard: 11,playerCard: 20)] = Action.stand
            
            strategy[CardCombo(dealerCard: 2,playerCard: 22)] = Action.split
            strategy[CardCombo(dealerCard: 3,playerCard: 22)] = Action.split
            strategy[CardCombo(dealerCard: 4,playerCard: 22)] = Action.split
            strategy[CardCombo(dealerCard: 5,playerCard: 22)] = Action.split
            strategy[CardCombo(dealerCard: 6,playerCard: 22)] = Action.split
            strategy[CardCombo(dealerCard: 7,playerCard: 22)] = Action.split
            strategy[CardCombo(dealerCard: 8,playerCard: 22)] = Action.split
            strategy[CardCombo(dealerCard: 9,playerCard: 22)] = Action.split
            strategy[CardCombo(dealerCard: 10,playerCard: 22)] = Action.split
            strategy[CardCombo(dealerCard: 11,playerCard: 22)] = Action.split
            
            if strategy[CardCombo(dealerCard: dealerTotal, playerCard: playerTotal)] != nil {
                return strategy[CardCombo(dealerCard: dealerTotal, playerCard: playerTotal)]!
            } else {
                return .over
            }
            
        } else {
            
            if myFirstCard == 11 || mySecondCard == 11 || myThirdCard == 11 || myFourthCard == 11 {
                
                strategy[CardCombo(dealerCard: 2,playerCard: 13)] = Action.hit
                strategy[CardCombo(dealerCard: 3,playerCard: 13)] = Action.hit
                strategy[CardCombo(dealerCard: 4,playerCard: 13)] = Action.hit
                strategy[CardCombo(dealerCard: 5,playerCard: 13)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 6,playerCard: 13)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 7,playerCard: 13)] = Action.hit
                strategy[CardCombo(dealerCard: 8,playerCard: 13)] = Action.hit
                strategy[CardCombo(dealerCard: 9,playerCard: 13)] = Action.hit
                strategy[CardCombo(dealerCard: 10,playerCard: 13)] = Action.hit
                strategy[CardCombo(dealerCard: 11,playerCard: 13)] = Action.hit
                
                strategy[CardCombo(dealerCard: 2,playerCard: 14)] = Action.hit
                strategy[CardCombo(dealerCard: 3,playerCard: 14)] = Action.hit
                strategy[CardCombo(dealerCard: 4,playerCard: 14)] = Action.hit
                strategy[CardCombo(dealerCard: 5,playerCard: 14)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 6,playerCard: 14)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 7,playerCard: 14)] = Action.hit
                strategy[CardCombo(dealerCard: 8,playerCard: 14)] = Action.hit
                strategy[CardCombo(dealerCard: 9,playerCard: 14)] = Action.hit
                strategy[CardCombo(dealerCard: 10,playerCard: 14)] = Action.hit
                strategy[CardCombo(dealerCard: 11,playerCard: 14)] = Action.hit
                
                strategy[CardCombo(dealerCard: 2,playerCard: 15)] = Action.hit
                strategy[CardCombo(dealerCard: 3,playerCard: 15)] = Action.hit
                strategy[CardCombo(dealerCard: 4,playerCard: 15)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 5,playerCard: 15)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 6,playerCard: 15)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 7,playerCard: 15)] = Action.hit
                strategy[CardCombo(dealerCard: 8,playerCard: 15)] = Action.hit
                strategy[CardCombo(dealerCard: 9,playerCard: 15)] = Action.hit
                strategy[CardCombo(dealerCard: 10,playerCard: 15)] = Action.hit
                strategy[CardCombo(dealerCard: 11,playerCard: 15)] = Action.hit
                
                strategy[CardCombo(dealerCard: 2,playerCard: 16)] = Action.hit
                strategy[CardCombo(dealerCard: 3,playerCard: 16)] = Action.hit
                strategy[CardCombo(dealerCard: 4,playerCard: 16)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 5,playerCard: 16)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 6,playerCard: 16)] = Action.hit
                strategy[CardCombo(dealerCard: 7,playerCard: 16)] = Action.hit
                strategy[CardCombo(dealerCard: 8,playerCard: 16)] = Action.hit
                strategy[CardCombo(dealerCard: 9,playerCard: 16)] = Action.hit
                strategy[CardCombo(dealerCard: 10,playerCard: 16)] = Action.hit
                strategy[CardCombo(dealerCard: 11,playerCard: 16)] = Action.hit
                
                strategy[CardCombo(dealerCard: 2,playerCard: 17)] = Action.hit
                strategy[CardCombo(dealerCard: 3,playerCard: 17)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 4,playerCard: 17)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 5,playerCard: 17)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 6,playerCard: 17)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 7,playerCard: 17)] = Action.hit
                strategy[CardCombo(dealerCard: 8,playerCard: 17)] = Action.hit
                strategy[CardCombo(dealerCard: 9,playerCard: 17)] = Action.hit
                strategy[CardCombo(dealerCard: 10,playerCard: 17)] = Action.hit
                strategy[CardCombo(dealerCard: 11,playerCard: 17)] = Action.hit
                
                strategy[CardCombo(dealerCard: 2,playerCard: 18)] = Action.stand
                strategy[CardCombo(dealerCard: 3,playerCard: 18)] = Action.doubleOrStand
                strategy[CardCombo(dealerCard: 4,playerCard: 18)] = Action.doubleOrStand
                strategy[CardCombo(dealerCard: 5,playerCard: 18)] = Action.doubleOrStand
                strategy[CardCombo(dealerCard: 6,playerCard: 18)] = Action.doubleOrStand
                strategy[CardCombo(dealerCard: 7,playerCard: 18)] = Action.stand
                strategy[CardCombo(dealerCard: 8,playerCard: 18)] = Action.stand
                strategy[CardCombo(dealerCard: 9,playerCard: 18)] = Action.hit
                strategy[CardCombo(dealerCard: 10,playerCard: 18)] = Action.hit
                strategy[CardCombo(dealerCard: 11,playerCard: 18)] = Action.hit
                
                strategy[CardCombo(dealerCard: 2,playerCard: 19)] = Action.stand
                strategy[CardCombo(dealerCard: 3,playerCard: 19)] = Action.stand
                strategy[CardCombo(dealerCard: 4,playerCard: 19)] = Action.stand
                strategy[CardCombo(dealerCard: 5,playerCard: 19)] = Action.stand
                strategy[CardCombo(dealerCard: 6,playerCard: 19)] = Action.stand
                strategy[CardCombo(dealerCard: 7,playerCard: 19)] = Action.stand
                strategy[CardCombo(dealerCard: 8,playerCard: 19)] = Action.stand
                strategy[CardCombo(dealerCard: 9,playerCard: 19)] = Action.stand
                strategy[CardCombo(dealerCard: 10,playerCard: 19)] = Action.stand
                strategy[CardCombo(dealerCard: 11,playerCard: 19)] = Action.stand
                
                strategy[CardCombo(dealerCard: 2,playerCard: 20)] = Action.stand
                strategy[CardCombo(dealerCard: 3,playerCard: 20)] = Action.stand
                strategy[CardCombo(dealerCard: 4,playerCard: 20)] = Action.stand
                strategy[CardCombo(dealerCard: 5,playerCard: 20)] = Action.stand
                strategy[CardCombo(dealerCard: 6,playerCard: 20)] = Action.stand
                strategy[CardCombo(dealerCard: 7,playerCard: 20)] = Action.stand
                strategy[CardCombo(dealerCard: 8,playerCard: 20)] = Action.stand
                strategy[CardCombo(dealerCard: 9,playerCard: 20)] = Action.stand
                strategy[CardCombo(dealerCard: 10,playerCard: 20)] = Action.stand
                strategy[CardCombo(dealerCard: 11,playerCard: 20)] = Action.stand
                
                strategy[CardCombo(dealerCard: 2,playerCard: 21)] = Action.stand
                strategy[CardCombo(dealerCard: 3,playerCard: 21)] = Action.stand
                strategy[CardCombo(dealerCard: 4,playerCard: 21)] = Action.stand
                strategy[CardCombo(dealerCard: 5,playerCard: 21)] = Action.stand
                strategy[CardCombo(dealerCard: 6,playerCard: 21)] = Action.stand
                strategy[CardCombo(dealerCard: 7,playerCard: 21)] = Action.stand
                strategy[CardCombo(dealerCard: 8,playerCard: 21)] = Action.stand
                strategy[CardCombo(dealerCard: 9,playerCard: 21)] = Action.stand
                strategy[CardCombo(dealerCard: 10,playerCard: 21)] = Action.stand
                strategy[CardCombo(dealerCard: 11,playerCard: 21)] = Action.stand
                
                if strategy[CardCombo(dealerCard: dealerTotal, playerCard: playerTotalWithAces!)] != nil {
                    return strategy[CardCombo(dealerCard: dealerTotal, playerCard: playerTotalWithAces!)]!
                } else {
                    return .over
                }
                
            } else {
                
                strategy[CardCombo(dealerCard: 2,playerCard: 5)] = Action.hit
                strategy[CardCombo(dealerCard: 3,playerCard: 5)] = Action.hit
                strategy[CardCombo(dealerCard: 4,playerCard: 5)] = Action.hit
                strategy[CardCombo(dealerCard: 5,playerCard: 5)] = Action.hit
                strategy[CardCombo(dealerCard: 6,playerCard: 5)] = Action.hit
                strategy[CardCombo(dealerCard: 7,playerCard: 5)] = Action.hit
                strategy[CardCombo(dealerCard: 8,playerCard: 5)] = Action.hit
                strategy[CardCombo(dealerCard: 9,playerCard: 5)] = Action.hit
                strategy[CardCombo(dealerCard: 10,playerCard: 5)] = Action.hit
                strategy[CardCombo(dealerCard: 11,playerCard: 5)] = Action.hit
                
                strategy[CardCombo(dealerCard: 2,playerCard: 6)] = Action.hit
                strategy[CardCombo(dealerCard: 3,playerCard: 6)] = Action.hit
                strategy[CardCombo(dealerCard: 4,playerCard: 6)] = Action.hit
                strategy[CardCombo(dealerCard: 5,playerCard: 6)] = Action.hit
                strategy[CardCombo(dealerCard: 6,playerCard: 6)] = Action.hit
                strategy[CardCombo(dealerCard: 7,playerCard: 6)] = Action.hit
                strategy[CardCombo(dealerCard: 8,playerCard: 6)] = Action.hit
                strategy[CardCombo(dealerCard: 9,playerCard: 6)] = Action.hit
                strategy[CardCombo(dealerCard: 10,playerCard: 6)] = Action.hit
                strategy[CardCombo(dealerCard: 11,playerCard: 6)] = Action.hit
                
                strategy[CardCombo(dealerCard: 2,playerCard: 7)] = Action.hit
                strategy[CardCombo(dealerCard: 3,playerCard: 7)] = Action.hit
                strategy[CardCombo(dealerCard: 4,playerCard: 7)] = Action.hit
                strategy[CardCombo(dealerCard: 5,playerCard: 7)] = Action.hit
                strategy[CardCombo(dealerCard: 6,playerCard: 7)] = Action.hit
                strategy[CardCombo(dealerCard: 7,playerCard: 7)] = Action.hit
                strategy[CardCombo(dealerCard: 8,playerCard: 7)] = Action.hit
                strategy[CardCombo(dealerCard: 9,playerCard: 7)] = Action.hit
                strategy[CardCombo(dealerCard: 10,playerCard: 7)] = Action.hit
                strategy[CardCombo(dealerCard: 11,playerCard: 7)] = Action.hit
                
                strategy[CardCombo(dealerCard: 2,playerCard: 8)] = Action.hit
                strategy[CardCombo(dealerCard: 3,playerCard: 8)] = Action.hit
                strategy[CardCombo(dealerCard: 4,playerCard: 8)] = Action.hit
                strategy[CardCombo(dealerCard: 5,playerCard: 8)] = Action.hit
                strategy[CardCombo(dealerCard: 6,playerCard: 8)] = Action.hit
                strategy[CardCombo(dealerCard: 7,playerCard: 8)] = Action.hit
                strategy[CardCombo(dealerCard: 8,playerCard: 8)] = Action.hit
                strategy[CardCombo(dealerCard: 9,playerCard: 8)] = Action.hit
                strategy[CardCombo(dealerCard: 10,playerCard: 8)] = Action.hit
                strategy[CardCombo(dealerCard: 11,playerCard: 8)] = Action.hit
                
                strategy[CardCombo(dealerCard: 2,playerCard: 9)] = Action.hit
                strategy[CardCombo(dealerCard: 3,playerCard: 9)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 4,playerCard: 9)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 5,playerCard: 9)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 6,playerCard: 9)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 7,playerCard: 9)] = Action.hit
                strategy[CardCombo(dealerCard: 8,playerCard: 9)] = Action.hit
                strategy[CardCombo(dealerCard: 9,playerCard: 9)] = Action.hit
                strategy[CardCombo(dealerCard: 10,playerCard: 9)] = Action.hit
                strategy[CardCombo(dealerCard: 11,playerCard: 9)] = Action.hit
                
                strategy[CardCombo(dealerCard: 2,playerCard: 10)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 3,playerCard: 10)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 4,playerCard: 10)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 5,playerCard: 10)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 6,playerCard: 10)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 7,playerCard: 10)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 8,playerCard: 10)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 9,playerCard: 10)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 10,playerCard: 10)] = Action.hit
                strategy[CardCombo(dealerCard: 11,playerCard: 10)] = Action.hit
                
                strategy[CardCombo(dealerCard: 2,playerCard: 11)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 3,playerCard: 11)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 4,playerCard: 11)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 5,playerCard: 11)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 6,playerCard: 11)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 7,playerCard: 11)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 8,playerCard: 11)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 9,playerCard: 11)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 10,playerCard: 11)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 11,playerCard: 11)] = Action.hit
                
                strategy[CardCombo(dealerCard: 2,playerCard: 12)] = Action.hit
                strategy[CardCombo(dealerCard: 3,playerCard: 12)] = Action.hit
                strategy[CardCombo(dealerCard: 4,playerCard: 12)] = Action.stand
                strategy[CardCombo(dealerCard: 5,playerCard: 12)] = Action.stand
                strategy[CardCombo(dealerCard: 6,playerCard: 12)] = Action.stand
                strategy[CardCombo(dealerCard: 7,playerCard: 12)] = Action.hit
                strategy[CardCombo(dealerCard: 8,playerCard: 12)] = Action.hit
                strategy[CardCombo(dealerCard: 9,playerCard: 12)] = Action.hit
                strategy[CardCombo(dealerCard: 10,playerCard: 12)] = Action.hit
                strategy[CardCombo(dealerCard: 11,playerCard: 12)] = Action.hit
                
                strategy[CardCombo(dealerCard: 2,playerCard: 13)] = Action.stand
                strategy[CardCombo(dealerCard: 3,playerCard: 13)] = Action.stand
                strategy[CardCombo(dealerCard: 4,playerCard: 13)] = Action.stand
                strategy[CardCombo(dealerCard: 5,playerCard: 13)] = Action.stand
                strategy[CardCombo(dealerCard: 6,playerCard: 13)] = Action.stand
                strategy[CardCombo(dealerCard: 7,playerCard: 13)] = Action.hit
                strategy[CardCombo(dealerCard: 8,playerCard: 13)] = Action.hit
                strategy[CardCombo(dealerCard: 9,playerCard: 13)] = Action.hit
                strategy[CardCombo(dealerCard: 10,playerCard: 13)] = Action.hit
                strategy[CardCombo(dealerCard: 11,playerCard: 13)] = Action.hit
                
                strategy[CardCombo(dealerCard: 2,playerCard: 14)] = Action.stand
                strategy[CardCombo(dealerCard: 3,playerCard: 14)] = Action.stand
                strategy[CardCombo(dealerCard: 4,playerCard: 14)] = Action.stand
                strategy[CardCombo(dealerCard: 5,playerCard: 14)] = Action.stand
                strategy[CardCombo(dealerCard: 6,playerCard: 14)] = Action.stand
                strategy[CardCombo(dealerCard: 7,playerCard: 14)] = Action.hit
                strategy[CardCombo(dealerCard: 8,playerCard: 14)] = Action.hit
                strategy[CardCombo(dealerCard: 9,playerCard: 14)] = Action.hit
                strategy[CardCombo(dealerCard: 10,playerCard: 14)] = Action.hit
                strategy[CardCombo(dealerCard: 11,playerCard: 14)] = Action.hit
                
                strategy[CardCombo(dealerCard: 2,playerCard: 15)] = Action.stand
                strategy[CardCombo(dealerCard: 3,playerCard: 15)] = Action.stand
                strategy[CardCombo(dealerCard: 4,playerCard: 15)] = Action.stand
                strategy[CardCombo(dealerCard: 5,playerCard: 15)] = Action.stand
                strategy[CardCombo(dealerCard: 6,playerCard: 15)] = Action.stand
                strategy[CardCombo(dealerCard: 7,playerCard: 15)] = Action.hit
                strategy[CardCombo(dealerCard: 8,playerCard: 15)] = Action.hit
                strategy[CardCombo(dealerCard: 9,playerCard: 15)] = Action.hit
                strategy[CardCombo(dealerCard: 10,playerCard: 15)] = Action.hit
                strategy[CardCombo(dealerCard: 11,playerCard: 15)] = Action.hit
                
                strategy[CardCombo(dealerCard: 2,playerCard: 16)] = Action.stand
                strategy[CardCombo(dealerCard: 3,playerCard: 16)] = Action.stand
                strategy[CardCombo(dealerCard: 4,playerCard: 16)] = Action.stand
                strategy[CardCombo(dealerCard: 5,playerCard: 16)] = Action.stand
                strategy[CardCombo(dealerCard: 6,playerCard: 16)] = Action.stand
                strategy[CardCombo(dealerCard: 7,playerCard: 16)] = Action.hit
                strategy[CardCombo(dealerCard: 8,playerCard: 16)] = Action.hit
                strategy[CardCombo(dealerCard: 9,playerCard: 16)] = Action.hit
                strategy[CardCombo(dealerCard: 10,playerCard: 16)] = Action.hit
                strategy[CardCombo(dealerCard: 11,playerCard: 16)] = Action.hit
                
                strategy[CardCombo(dealerCard: 2,playerCard: 17)] = Action.stand
                strategy[CardCombo(dealerCard: 3,playerCard: 17)] = Action.stand
                strategy[CardCombo(dealerCard: 4,playerCard: 17)] = Action.stand
                strategy[CardCombo(dealerCard: 5,playerCard: 17)] = Action.stand
                strategy[CardCombo(dealerCard: 6,playerCard: 17)] = Action.stand
                strategy[CardCombo(dealerCard: 7,playerCard: 17)] = Action.stand
                strategy[CardCombo(dealerCard: 8,playerCard: 17)] = Action.stand
                strategy[CardCombo(dealerCard: 9,playerCard: 17)] = Action.stand
                strategy[CardCombo(dealerCard: 10,playerCard: 17)] = Action.stand
                strategy[CardCombo(dealerCard: 11,playerCard: 17)] = Action.stand
                
                strategy[CardCombo(dealerCard: 2,playerCard: 18)] = Action.stand
                strategy[CardCombo(dealerCard: 3,playerCard: 18)] = Action.stand
                strategy[CardCombo(dealerCard: 4,playerCard: 18)] = Action.stand
                strategy[CardCombo(dealerCard: 5,playerCard: 18)] = Action.stand
                strategy[CardCombo(dealerCard: 6,playerCard: 18)] = Action.stand
                strategy[CardCombo(dealerCard: 7,playerCard: 18)] = Action.stand
                strategy[CardCombo(dealerCard: 8,playerCard: 18)] = Action.stand
                strategy[CardCombo(dealerCard: 9,playerCard: 18)] = Action.stand
                strategy[CardCombo(dealerCard: 10,playerCard: 18)] = Action.stand
                strategy[CardCombo(dealerCard: 11,playerCard: 18)] = Action.stand
                
                strategy[CardCombo(dealerCard: 2,playerCard: 19)] = Action.stand
                strategy[CardCombo(dealerCard: 3,playerCard: 19)] = Action.stand
                strategy[CardCombo(dealerCard: 4,playerCard: 19)] = Action.stand
                strategy[CardCombo(dealerCard: 5,playerCard: 19)] = Action.stand
                strategy[CardCombo(dealerCard: 6,playerCard: 19)] = Action.stand
                strategy[CardCombo(dealerCard: 7,playerCard: 19)] = Action.stand
                strategy[CardCombo(dealerCard: 8,playerCard: 19)] = Action.stand
                strategy[CardCombo(dealerCard: 9,playerCard: 19)] = Action.stand
                strategy[CardCombo(dealerCard: 10,playerCard: 19)] = Action.stand
                strategy[CardCombo(dealerCard: 11,playerCard: 19)] = Action.stand
                
                strategy[CardCombo(dealerCard: 2,playerCard: 20)] = Action.stand
                strategy[CardCombo(dealerCard: 3,playerCard: 20)] = Action.stand
                strategy[CardCombo(dealerCard: 4,playerCard: 20)] = Action.stand
                strategy[CardCombo(dealerCard: 5,playerCard: 20)] = Action.stand
                strategy[CardCombo(dealerCard: 6,playerCard: 20)] = Action.stand
                strategy[CardCombo(dealerCard: 7,playerCard: 20)] = Action.stand
                strategy[CardCombo(dealerCard: 8,playerCard: 20)] = Action.stand
                strategy[CardCombo(dealerCard: 9,playerCard: 20)] = Action.stand
                strategy[CardCombo(dealerCard: 10,playerCard: 20)] = Action.stand
                strategy[CardCombo(dealerCard: 11,playerCard: 20)] = Action.stand
                
                strategy[CardCombo(dealerCard: 2,playerCard: 21)] = Action.stand
                strategy[CardCombo(dealerCard: 3,playerCard: 21)] = Action.stand
                strategy[CardCombo(dealerCard: 4,playerCard: 21)] = Action.stand
                strategy[CardCombo(dealerCard: 5,playerCard: 21)] = Action.stand
                strategy[CardCombo(dealerCard: 6,playerCard: 21)] = Action.stand
                strategy[CardCombo(dealerCard: 7,playerCard: 21)] = Action.stand
                strategy[CardCombo(dealerCard: 8,playerCard: 21)] = Action.stand
                strategy[CardCombo(dealerCard: 9,playerCard: 21)] = Action.stand
                strategy[CardCombo(dealerCard: 10,playerCard: 21)] = Action.stand
                strategy[CardCombo(dealerCard: 11,playerCard: 21)] = Action.stand
                
                if strategy[CardCombo(dealerCard: dealerTotal, playerCard: playerTotal)] != nil {
                    return strategy[CardCombo(dealerCard: dealerTotal, playerCard: playerTotal)]!
                } else {
                    return .over
                }
                
            }
            }
        } else
            
            
            
            
            
            
            if decks == .one && soft17 == .dealerStands && doubleAfterSplit == .yesSplit && surrender == .surrenderNotAllowed && dealerPeek == .dealerPeaks {
            
            if myFirstCard == mySecondCard && myThirdCard == 0 && myFourthCard == 0 {
                
                strategy[CardCombo(dealerCard: 2,playerCard: 4)] = Action.split
                strategy[CardCombo(dealerCard: 3,playerCard: 4)] = Action.split
                strategy[CardCombo(dealerCard: 4,playerCard: 4)] = Action.split
                strategy[CardCombo(dealerCard: 5,playerCard: 4)] = Action.split
                strategy[CardCombo(dealerCard: 6,playerCard: 4)] = Action.split
                strategy[CardCombo(dealerCard: 7,playerCard: 4)] = Action.split
                strategy[CardCombo(dealerCard: 8,playerCard: 4)] = Action.hit
                strategy[CardCombo(dealerCard: 9,playerCard: 4)] = Action.hit
                strategy[CardCombo(dealerCard: 10,playerCard: 4)] = Action.hit
                strategy[CardCombo(dealerCard: 11,playerCard: 4)] = Action.hit
                
                strategy[CardCombo(dealerCard: 2,playerCard: 6)] = Action.split
                strategy[CardCombo(dealerCard: 3,playerCard: 6)] = Action.split
                strategy[CardCombo(dealerCard: 4,playerCard: 6)] = Action.split
                strategy[CardCombo(dealerCard: 5,playerCard: 6)] = Action.split
                strategy[CardCombo(dealerCard: 6,playerCard: 6)] = Action.split
                strategy[CardCombo(dealerCard: 7,playerCard: 6)] = Action.split
                strategy[CardCombo(dealerCard: 8,playerCard: 6)] = Action.split
                strategy[CardCombo(dealerCard: 9,playerCard: 6)] = Action.hit
                strategy[CardCombo(dealerCard: 10,playerCard: 6)] = Action.hit
                strategy[CardCombo(dealerCard: 11,playerCard: 6)] = Action.hit
                
                strategy[CardCombo(dealerCard: 2,playerCard: 8)] = Action.hit
                strategy[CardCombo(dealerCard: 3,playerCard: 8)] = Action.hit
                strategy[CardCombo(dealerCard: 4,playerCard: 8)] = Action.split
                strategy[CardCombo(dealerCard: 5,playerCard: 8)] = Action.split
                strategy[CardCombo(dealerCard: 6,playerCard: 8)] = Action.split
                strategy[CardCombo(dealerCard: 7,playerCard: 8)] = Action.hit
                strategy[CardCombo(dealerCard: 8,playerCard: 8)] = Action.hit
                strategy[CardCombo(dealerCard: 9,playerCard: 8)] = Action.hit
                strategy[CardCombo(dealerCard: 10,playerCard: 8)] = Action.hit
                strategy[CardCombo(dealerCard: 11,playerCard: 8)] = Action.hit
                
                strategy[CardCombo(dealerCard: 2,playerCard: 10)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 3,playerCard: 10)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 4,playerCard: 10)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 5,playerCard: 10)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 6,playerCard: 10)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 7,playerCard: 10)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 8,playerCard: 10)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 9,playerCard: 10)] = Action.doubleOrHit
                strategy[CardCombo(dealerCard: 10,playerCard: 10)] = Action.hit
                strategy[CardCombo(dealerCard: 11,playerCard: 10)] = Action.hit
                
                strategy[CardCombo(dealerCard: 2,playerCard: 12)] = Action.split
                strategy[CardCombo(dealerCard: 3,playerCard: 12)] = Action.split
                strategy[CardCombo(dealerCard: 4,playerCard: 12)] = Action.split
                strategy[CardCombo(dealerCard: 5,playerCard: 12)] = Action.split
                strategy[CardCombo(dealerCard: 6,playerCard: 12)] = Action.split
                strategy[CardCombo(dealerCard: 7,playerCard: 12)] = Action.split
                strategy[CardCombo(dealerCard: 8,playerCard: 12)] = Action.hit
                strategy[CardCombo(dealerCard: 9,playerCard: 12)] = Action.hit
                strategy[CardCombo(dealerCard: 10,playerCard: 12)] = Action.hit
                strategy[CardCombo(dealerCard: 11,playerCard: 12)] = Action.hit
                
                strategy[CardCombo(dealerCard: 2,playerCard: 14)] = Action.split
                strategy[CardCombo(dealerCard: 3,playerCard: 14)] = Action.split
                strategy[CardCombo(dealerCard: 4,playerCard: 14)] = Action.split
                strategy[CardCombo(dealerCard: 5,playerCard: 14)] = Action.split
                strategy[CardCombo(dealerCard: 6,playerCard: 14)] = Action.split
                strategy[CardCombo(dealerCard: 7,playerCard: 14)] = Action.split
                strategy[CardCombo(dealerCard: 8,playerCard: 14)] = Action.split
                strategy[CardCombo(dealerCard: 9,playerCard: 14)] = Action.hit
                strategy[CardCombo(dealerCard: 10,playerCard: 14)] = Action.stand
                strategy[CardCombo(dealerCard: 11,playerCard: 14)] = Action.hit
                
                strategy[CardCombo(dealerCard: 2,playerCard: 16)] = Action.split
                strategy[CardCombo(dealerCard: 3,playerCard: 16)] = Action.split
                strategy[CardCombo(dealerCard: 4,playerCard: 16)] = Action.split
                strategy[CardCombo(dealerCard: 5,playerCard: 16)] = Action.split
                strategy[CardCombo(dealerCard: 6,playerCard: 16)] = Action.split
                strategy[CardCombo(dealerCard: 7,playerCard: 16)] = Action.split
                strategy[CardCombo(dealerCard: 8,playerCard: 16)] = Action.split
                strategy[CardCombo(dealerCard: 9,playerCard: 16)] = Action.split
                strategy[CardCombo(dealerCard: 10,playerCard: 16)] = Action.split
                strategy[CardCombo(dealerCard: 11,playerCard: 16)] = Action.split
                
                strategy[CardCombo(dealerCard: 2,playerCard: 18)] = Action.split
                strategy[CardCombo(dealerCard: 3,playerCard: 18)] = Action.split
                strategy[CardCombo(dealerCard: 4,playerCard: 18)] = Action.split
                strategy[CardCombo(dealerCard: 5,playerCard: 18)] = Action.split
                strategy[CardCombo(dealerCard: 6,playerCard: 18)] = Action.split
                strategy[CardCombo(dealerCard: 7,playerCard: 18)] = Action.stand
                strategy[CardCombo(dealerCard: 8,playerCard: 18)] = Action.split
                strategy[CardCombo(dealerCard: 9,playerCard: 18)] = Action.split
                strategy[CardCombo(dealerCard: 10,playerCard: 18)] = Action.stand
                strategy[CardCombo(dealerCard: 11,playerCard: 18)] = Action.stand
                
                strategy[CardCombo(dealerCard: 2,playerCard: 20)] = Action.stand
                strategy[CardCombo(dealerCard: 3,playerCard: 20)] = Action.stand
                strategy[CardCombo(dealerCard: 4,playerCard: 20)] = Action.stand
                strategy[CardCombo(dealerCard: 5,playerCard: 20)] = Action.stand
                strategy[CardCombo(dealerCard: 6,playerCard: 20)] = Action.stand
                strategy[CardCombo(dealerCard: 7,playerCard: 20)] = Action.stand
                strategy[CardCombo(dealerCard: 8,playerCard: 20)] = Action.stand
                strategy[CardCombo(dealerCard: 9,playerCard: 20)] = Action.stand
                strategy[CardCombo(dealerCard: 10,playerCard: 20)] = Action.stand
                strategy[CardCombo(dealerCard: 11,playerCard: 20)] = Action.stand
                
                strategy[CardCombo(dealerCard: 2,playerCard: 22)] = Action.split
                strategy[CardCombo(dealerCard: 3,playerCard: 22)] = Action.split
                strategy[CardCombo(dealerCard: 4,playerCard: 22)] = Action.split
                strategy[CardCombo(dealerCard: 5,playerCard: 22)] = Action.split
                strategy[CardCombo(dealerCard: 6,playerCard: 22)] = Action.split
                strategy[CardCombo(dealerCard: 7,playerCard: 22)] = Action.split
                strategy[CardCombo(dealerCard: 8,playerCard: 22)] = Action.split
                strategy[CardCombo(dealerCard: 9,playerCard: 22)] = Action.split
                strategy[CardCombo(dealerCard: 10,playerCard: 22)] = Action.split
                strategy[CardCombo(dealerCard: 11,playerCard: 22)] = Action.split
                
                if strategy[CardCombo(dealerCard: dealerTotal, playerCard: playerTotal)] != nil {
                    return strategy[CardCombo(dealerCard: dealerTotal, playerCard: playerTotal)]!
                } else {
                    return .over
                }
                
            } else {
                
                if myFirstCard == 11 || mySecondCard == 11 || myThirdCard == 11 || myFourthCard == 11 {
                    
                    strategy[CardCombo(dealerCard: 2,playerCard: 13)] = Action.hit
                    strategy[CardCombo(dealerCard: 3,playerCard: 13)] = Action.hit
                    strategy[CardCombo(dealerCard: 4,playerCard: 13)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 5,playerCard: 13)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 6,playerCard: 13)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 7,playerCard: 13)] = Action.hit
                    strategy[CardCombo(dealerCard: 8,playerCard: 13)] = Action.hit
                    strategy[CardCombo(dealerCard: 9,playerCard: 13)] = Action.hit
                    strategy[CardCombo(dealerCard: 10,playerCard: 13)] = Action.hit
                    strategy[CardCombo(dealerCard: 11,playerCard: 13)] = Action.hit
                    
                    strategy[CardCombo(dealerCard: 2,playerCard: 14)] = Action.hit
                    strategy[CardCombo(dealerCard: 3,playerCard: 14)] = Action.hit
                    strategy[CardCombo(dealerCard: 4,playerCard: 14)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 5,playerCard: 14)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 6,playerCard: 14)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 7,playerCard: 14)] = Action.hit
                    strategy[CardCombo(dealerCard: 8,playerCard: 14)] = Action.hit
                    strategy[CardCombo(dealerCard: 9,playerCard: 14)] = Action.hit
                    strategy[CardCombo(dealerCard: 10,playerCard: 14)] = Action.hit
                    strategy[CardCombo(dealerCard: 11,playerCard: 14)] = Action.hit
                    
                    strategy[CardCombo(dealerCard: 2,playerCard: 15)] = Action.hit
                    strategy[CardCombo(dealerCard: 3,playerCard: 15)] = Action.hit
                    strategy[CardCombo(dealerCard: 4,playerCard: 15)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 5,playerCard: 15)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 6,playerCard: 15)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 7,playerCard: 15)] = Action.hit
                    strategy[CardCombo(dealerCard: 8,playerCard: 15)] = Action.hit
                    strategy[CardCombo(dealerCard: 9,playerCard: 15)] = Action.hit
                    strategy[CardCombo(dealerCard: 10,playerCard: 15)] = Action.hit
                    strategy[CardCombo(dealerCard: 11,playerCard: 15)] = Action.hit
                    
                    strategy[CardCombo(dealerCard: 2,playerCard: 16)] = Action.hit
                    strategy[CardCombo(dealerCard: 3,playerCard: 16)] = Action.hit
                    strategy[CardCombo(dealerCard: 4,playerCard: 16)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 5,playerCard: 16)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 6,playerCard: 16)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 7,playerCard: 16)] = Action.hit
                    strategy[CardCombo(dealerCard: 8,playerCard: 16)] = Action.hit
                    strategy[CardCombo(dealerCard: 9,playerCard: 16)] = Action.hit
                    strategy[CardCombo(dealerCard: 10,playerCard: 16)] = Action.hit
                    strategy[CardCombo(dealerCard: 11,playerCard: 16)] = Action.hit
                    
                    strategy[CardCombo(dealerCard: 2,playerCard: 17)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 3,playerCard: 17)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 4,playerCard: 17)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 5,playerCard: 17)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 6,playerCard: 17)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 7,playerCard: 17)] = Action.hit
                    strategy[CardCombo(dealerCard: 8,playerCard: 17)] = Action.hit
                    strategy[CardCombo(dealerCard: 9,playerCard: 17)] = Action.hit
                    strategy[CardCombo(dealerCard: 10,playerCard: 17)] = Action.hit
                    strategy[CardCombo(dealerCard: 11,playerCard: 17)] = Action.hit
                    
                    strategy[CardCombo(dealerCard: 2,playerCard: 18)] = Action.stand
                    strategy[CardCombo(dealerCard: 3,playerCard: 18)] = Action.doubleOrStand
                    strategy[CardCombo(dealerCard: 4,playerCard: 18)] = Action.doubleOrStand
                    strategy[CardCombo(dealerCard: 5,playerCard: 18)] = Action.doubleOrStand
                    strategy[CardCombo(dealerCard: 6,playerCard: 18)] = Action.doubleOrStand
                    strategy[CardCombo(dealerCard: 7,playerCard: 18)] = Action.stand
                    strategy[CardCombo(dealerCard: 8,playerCard: 18)] = Action.stand
                    strategy[CardCombo(dealerCard: 9,playerCard: 18)] = Action.hit
                    strategy[CardCombo(dealerCard: 10,playerCard: 18)] = Action.hit
                    strategy[CardCombo(dealerCard: 11,playerCard: 18)] = Action.stand
                    
                    strategy[CardCombo(dealerCard: 2,playerCard: 19)] = Action.stand
                    strategy[CardCombo(dealerCard: 3,playerCard: 19)] = Action.stand
                    strategy[CardCombo(dealerCard: 4,playerCard: 19)] = Action.stand
                    strategy[CardCombo(dealerCard: 5,playerCard: 19)] = Action.stand
                    strategy[CardCombo(dealerCard: 6,playerCard: 19)] = Action.doubleOrStand
                    strategy[CardCombo(dealerCard: 7,playerCard: 19)] = Action.stand
                    strategy[CardCombo(dealerCard: 8,playerCard: 19)] = Action.stand
                    strategy[CardCombo(dealerCard: 9,playerCard: 19)] = Action.stand
                    strategy[CardCombo(dealerCard: 10,playerCard: 19)] = Action.stand
                    strategy[CardCombo(dealerCard: 11,playerCard: 19)] = Action.stand
                    
                    strategy[CardCombo(dealerCard: 2,playerCard: 20)] = Action.stand
                    strategy[CardCombo(dealerCard: 3,playerCard: 20)] = Action.stand
                    strategy[CardCombo(dealerCard: 4,playerCard: 20)] = Action.stand
                    strategy[CardCombo(dealerCard: 5,playerCard: 20)] = Action.stand
                    strategy[CardCombo(dealerCard: 6,playerCard: 20)] = Action.stand
                    strategy[CardCombo(dealerCard: 7,playerCard: 20)] = Action.stand
                    strategy[CardCombo(dealerCard: 8,playerCard: 20)] = Action.stand
                    strategy[CardCombo(dealerCard: 9,playerCard: 20)] = Action.stand
                    strategy[CardCombo(dealerCard: 10,playerCard: 20)] = Action.stand
                    strategy[CardCombo(dealerCard: 11,playerCard: 20)] = Action.stand
                    
                    strategy[CardCombo(dealerCard: 2,playerCard: 21)] = Action.stand
                    strategy[CardCombo(dealerCard: 3,playerCard: 21)] = Action.stand
                    strategy[CardCombo(dealerCard: 4,playerCard: 21)] = Action.stand
                    strategy[CardCombo(dealerCard: 5,playerCard: 21)] = Action.stand
                    strategy[CardCombo(dealerCard: 6,playerCard: 21)] = Action.stand
                    strategy[CardCombo(dealerCard: 7,playerCard: 21)] = Action.stand
                    strategy[CardCombo(dealerCard: 8,playerCard: 21)] = Action.stand
                    strategy[CardCombo(dealerCard: 9,playerCard: 21)] = Action.stand
                    strategy[CardCombo(dealerCard: 10,playerCard: 21)] = Action.stand
                    strategy[CardCombo(dealerCard: 11,playerCard: 21)] = Action.stand
                    
                    if strategy[CardCombo(dealerCard: dealerTotal, playerCard: playerTotalWithAces!)] != nil {
                        return strategy[CardCombo(dealerCard: dealerTotal, playerCard: playerTotalWithAces!)]!
                    } else {
                        return .over
                    }
                    
                } else {
                    
                    strategy[CardCombo(dealerCard: 2,playerCard: 5)] = Action.hit
                    strategy[CardCombo(dealerCard: 3,playerCard: 5)] = Action.hit
                    strategy[CardCombo(dealerCard: 4,playerCard: 5)] = Action.hit
                    strategy[CardCombo(dealerCard: 5,playerCard: 5)] = Action.hit
                    strategy[CardCombo(dealerCard: 6,playerCard: 5)] = Action.hit
                    strategy[CardCombo(dealerCard: 7,playerCard: 5)] = Action.hit
                    strategy[CardCombo(dealerCard: 8,playerCard: 5)] = Action.hit
                    strategy[CardCombo(dealerCard: 9,playerCard: 5)] = Action.hit
                    strategy[CardCombo(dealerCard: 10,playerCard: 5)] = Action.hit
                    strategy[CardCombo(dealerCard: 11,playerCard: 5)] = Action.hit
                    
                    strategy[CardCombo(dealerCard: 2,playerCard: 6)] = Action.hit
                    strategy[CardCombo(dealerCard: 3,playerCard: 6)] = Action.hit
                    strategy[CardCombo(dealerCard: 4,playerCard: 6)] = Action.hit
                    strategy[CardCombo(dealerCard: 5,playerCard: 6)] = Action.hit
                    strategy[CardCombo(dealerCard: 6,playerCard: 6)] = Action.hit
                    strategy[CardCombo(dealerCard: 7,playerCard: 6)] = Action.hit
                    strategy[CardCombo(dealerCard: 8,playerCard: 6)] = Action.hit
                    strategy[CardCombo(dealerCard: 9,playerCard: 6)] = Action.hit
                    strategy[CardCombo(dealerCard: 10,playerCard: 6)] = Action.hit
                    strategy[CardCombo(dealerCard: 11,playerCard: 6)] = Action.hit
                    
                    strategy[CardCombo(dealerCard: 2,playerCard: 7)] = Action.hit
                    strategy[CardCombo(dealerCard: 3,playerCard: 7)] = Action.hit
                    strategy[CardCombo(dealerCard: 4,playerCard: 7)] = Action.hit
                    strategy[CardCombo(dealerCard: 5,playerCard: 7)] = Action.hit
                    strategy[CardCombo(dealerCard: 6,playerCard: 7)] = Action.hit
                    strategy[CardCombo(dealerCard: 7,playerCard: 7)] = Action.hit
                    strategy[CardCombo(dealerCard: 8,playerCard: 7)] = Action.hit
                    strategy[CardCombo(dealerCard: 9,playerCard: 7)] = Action.hit
                    strategy[CardCombo(dealerCard: 10,playerCard: 7)] = Action.hit
                    strategy[CardCombo(dealerCard: 11,playerCard: 7)] = Action.hit
                    
                    strategy[CardCombo(dealerCard: 2,playerCard: 8)] = Action.hit
                    strategy[CardCombo(dealerCard: 3,playerCard: 8)] = Action.hit
                    strategy[CardCombo(dealerCard: 4,playerCard: 8)] = Action.hit
                    strategy[CardCombo(dealerCard: 5,playerCard: 8)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 6,playerCard: 8)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 7,playerCard: 8)] = Action.hit
                    strategy[CardCombo(dealerCard: 8,playerCard: 8)] = Action.hit
                    strategy[CardCombo(dealerCard: 9,playerCard: 8)] = Action.hit
                    strategy[CardCombo(dealerCard: 10,playerCard: 8)] = Action.hit
                    strategy[CardCombo(dealerCard: 11,playerCard: 8)] = Action.hit
                    
                    strategy[CardCombo(dealerCard: 2,playerCard: 9)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 3,playerCard: 9)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 4,playerCard: 9)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 5,playerCard: 9)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 6,playerCard: 9)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 7,playerCard: 9)] = Action.hit
                    strategy[CardCombo(dealerCard: 8,playerCard: 9)] = Action.hit
                    strategy[CardCombo(dealerCard: 9,playerCard: 9)] = Action.hit
                    strategy[CardCombo(dealerCard: 10,playerCard: 9)] = Action.hit
                    strategy[CardCombo(dealerCard: 11,playerCard: 9)] = Action.hit
                    
                    strategy[CardCombo(dealerCard: 2,playerCard: 10)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 3,playerCard: 10)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 4,playerCard: 10)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 5,playerCard: 10)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 6,playerCard: 10)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 7,playerCard: 10)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 8,playerCard: 10)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 9,playerCard: 10)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 10,playerCard: 10)] = Action.hit
                    strategy[CardCombo(dealerCard: 11,playerCard: 10)] = Action.hit
                    
                    strategy[CardCombo(dealerCard: 2,playerCard: 11)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 3,playerCard: 11)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 4,playerCard: 11)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 5,playerCard: 11)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 6,playerCard: 11)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 7,playerCard: 11)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 8,playerCard: 11)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 9,playerCard: 11)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 10,playerCard: 11)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 11,playerCard: 11)] = Action.doubleOrHit
                    
                    strategy[CardCombo(dealerCard: 2,playerCard: 12)] = Action.hit
                    strategy[CardCombo(dealerCard: 3,playerCard: 12)] = Action.hit
                    strategy[CardCombo(dealerCard: 4,playerCard: 12)] = Action.stand
                    strategy[CardCombo(dealerCard: 5,playerCard: 12)] = Action.stand
                    strategy[CardCombo(dealerCard: 6,playerCard: 12)] = Action.stand
                    strategy[CardCombo(dealerCard: 7,playerCard: 12)] = Action.hit
                    strategy[CardCombo(dealerCard: 8,playerCard: 12)] = Action.hit
                    strategy[CardCombo(dealerCard: 9,playerCard: 12)] = Action.hit
                    strategy[CardCombo(dealerCard: 10,playerCard: 12)] = Action.hit
                    strategy[CardCombo(dealerCard: 11,playerCard: 12)] = Action.hit
                    
                    strategy[CardCombo(dealerCard: 2,playerCard: 13)] = Action.stand
                    strategy[CardCombo(dealerCard: 3,playerCard: 13)] = Action.stand
                    strategy[CardCombo(dealerCard: 4,playerCard: 13)] = Action.stand
                    strategy[CardCombo(dealerCard: 5,playerCard: 13)] = Action.stand
                    strategy[CardCombo(dealerCard: 6,playerCard: 13)] = Action.stand
                    strategy[CardCombo(dealerCard: 7,playerCard: 13)] = Action.hit
                    strategy[CardCombo(dealerCard: 8,playerCard: 13)] = Action.hit
                    strategy[CardCombo(dealerCard: 9,playerCard: 13)] = Action.hit
                    strategy[CardCombo(dealerCard: 10,playerCard: 13)] = Action.hit
                    strategy[CardCombo(dealerCard: 11,playerCard: 13)] = Action.hit
                    
                    strategy[CardCombo(dealerCard: 2,playerCard: 14)] = Action.stand
                    strategy[CardCombo(dealerCard: 3,playerCard: 14)] = Action.stand
                    strategy[CardCombo(dealerCard: 4,playerCard: 14)] = Action.stand
                    strategy[CardCombo(dealerCard: 5,playerCard: 14)] = Action.stand
                    strategy[CardCombo(dealerCard: 6,playerCard: 14)] = Action.stand
                    strategy[CardCombo(dealerCard: 7,playerCard: 14)] = Action.hit
                    strategy[CardCombo(dealerCard: 8,playerCard: 14)] = Action.hit
                    strategy[CardCombo(dealerCard: 9,playerCard: 14)] = Action.hit
                    strategy[CardCombo(dealerCard: 10,playerCard: 14)] = Action.hit
                    strategy[CardCombo(dealerCard: 11,playerCard: 14)] = Action.hit
                    
                    strategy[CardCombo(dealerCard: 2,playerCard: 15)] = Action.stand
                    strategy[CardCombo(dealerCard: 3,playerCard: 15)] = Action.stand
                    strategy[CardCombo(dealerCard: 4,playerCard: 15)] = Action.stand
                    strategy[CardCombo(dealerCard: 5,playerCard: 15)] = Action.stand
                    strategy[CardCombo(dealerCard: 6,playerCard: 15)] = Action.stand
                    strategy[CardCombo(dealerCard: 7,playerCard: 15)] = Action.hit
                    strategy[CardCombo(dealerCard: 8,playerCard: 15)] = Action.hit
                    strategy[CardCombo(dealerCard: 9,playerCard: 15)] = Action.hit
                    strategy[CardCombo(dealerCard: 10,playerCard: 15)] = Action.hit
                    strategy[CardCombo(dealerCard: 11,playerCard: 15)] = Action.hit
                    
                    strategy[CardCombo(dealerCard: 2,playerCard: 16)] = Action.stand
                    strategy[CardCombo(dealerCard: 3,playerCard: 16)] = Action.stand
                    strategy[CardCombo(dealerCard: 4,playerCard: 16)] = Action.stand
                    strategy[CardCombo(dealerCard: 5,playerCard: 16)] = Action.stand
                    strategy[CardCombo(dealerCard: 6,playerCard: 16)] = Action.stand
                    strategy[CardCombo(dealerCard: 7,playerCard: 16)] = Action.hit
                    strategy[CardCombo(dealerCard: 8,playerCard: 16)] = Action.hit
                    strategy[CardCombo(dealerCard: 9,playerCard: 16)] = Action.hit
                    strategy[CardCombo(dealerCard: 10,playerCard: 16)] = Action.hit
                    strategy[CardCombo(dealerCard: 11,playerCard: 16)] = Action.hit
                    
                    strategy[CardCombo(dealerCard: 2,playerCard: 17)] = Action.stand
                    strategy[CardCombo(dealerCard: 3,playerCard: 17)] = Action.stand
                    strategy[CardCombo(dealerCard: 4,playerCard: 17)] = Action.stand
                    strategy[CardCombo(dealerCard: 5,playerCard: 17)] = Action.stand
                    strategy[CardCombo(dealerCard: 6,playerCard: 17)] = Action.stand
                    strategy[CardCombo(dealerCard: 7,playerCard: 17)] = Action.stand
                    strategy[CardCombo(dealerCard: 8,playerCard: 17)] = Action.stand
                    strategy[CardCombo(dealerCard: 9,playerCard: 17)] = Action.stand
                    strategy[CardCombo(dealerCard: 10,playerCard: 17)] = Action.stand
                    strategy[CardCombo(dealerCard: 11,playerCard: 17)] = Action.stand
                    
                    strategy[CardCombo(dealerCard: 2,playerCard: 18)] = Action.stand
                    strategy[CardCombo(dealerCard: 3,playerCard: 18)] = Action.stand
                    strategy[CardCombo(dealerCard: 4,playerCard: 18)] = Action.stand
                    strategy[CardCombo(dealerCard: 5,playerCard: 18)] = Action.stand
                    strategy[CardCombo(dealerCard: 6,playerCard: 18)] = Action.stand
                    strategy[CardCombo(dealerCard: 7,playerCard: 18)] = Action.stand
                    strategy[CardCombo(dealerCard: 8,playerCard: 18)] = Action.stand
                    strategy[CardCombo(dealerCard: 9,playerCard: 18)] = Action.stand
                    strategy[CardCombo(dealerCard: 10,playerCard: 18)] = Action.stand
                    strategy[CardCombo(dealerCard: 11,playerCard: 18)] = Action.stand
                    
                    strategy[CardCombo(dealerCard: 2,playerCard: 19)] = Action.stand
                    strategy[CardCombo(dealerCard: 3,playerCard: 19)] = Action.stand
                    strategy[CardCombo(dealerCard: 4,playerCard: 19)] = Action.stand
                    strategy[CardCombo(dealerCard: 5,playerCard: 19)] = Action.stand
                    strategy[CardCombo(dealerCard: 6,playerCard: 19)] = Action.stand
                    strategy[CardCombo(dealerCard: 7,playerCard: 19)] = Action.stand
                    strategy[CardCombo(dealerCard: 8,playerCard: 19)] = Action.stand
                    strategy[CardCombo(dealerCard: 9,playerCard: 19)] = Action.stand
                    strategy[CardCombo(dealerCard: 10,playerCard: 19)] = Action.stand
                    strategy[CardCombo(dealerCard: 11,playerCard: 19)] = Action.stand
                    
                    strategy[CardCombo(dealerCard: 2,playerCard: 20)] = Action.stand
                    strategy[CardCombo(dealerCard: 3,playerCard: 20)] = Action.stand
                    strategy[CardCombo(dealerCard: 4,playerCard: 20)] = Action.stand
                    strategy[CardCombo(dealerCard: 5,playerCard: 20)] = Action.stand
                    strategy[CardCombo(dealerCard: 6,playerCard: 20)] = Action.stand
                    strategy[CardCombo(dealerCard: 7,playerCard: 20)] = Action.stand
                    strategy[CardCombo(dealerCard: 8,playerCard: 20)] = Action.stand
                    strategy[CardCombo(dealerCard: 9,playerCard: 20)] = Action.stand
                    strategy[CardCombo(dealerCard: 10,playerCard: 20)] = Action.stand
                    strategy[CardCombo(dealerCard: 11,playerCard: 20)] = Action.stand
                    
                    strategy[CardCombo(dealerCard: 2,playerCard: 21)] = Action.stand
                    strategy[CardCombo(dealerCard: 3,playerCard: 21)] = Action.stand
                    strategy[CardCombo(dealerCard: 4,playerCard: 21)] = Action.stand
                    strategy[CardCombo(dealerCard: 5,playerCard: 21)] = Action.stand
                    strategy[CardCombo(dealerCard: 6,playerCard: 21)] = Action.stand
                    strategy[CardCombo(dealerCard: 7,playerCard: 21)] = Action.stand
                    strategy[CardCombo(dealerCard: 8,playerCard: 21)] = Action.stand
                    strategy[CardCombo(dealerCard: 9,playerCard: 21)] = Action.stand
                    strategy[CardCombo(dealerCard: 10,playerCard: 21)] = Action.stand
                    strategy[CardCombo(dealerCard: 11,playerCard: 21)] = Action.stand
                    
                    if strategy[CardCombo(dealerCard: dealerTotal, playerCard: playerTotal)] != nil {
                        return strategy[CardCombo(dealerCard: dealerTotal, playerCard: playerTotal)]!
                    } else {
                        return .over
                    }
                    
                }
            }
            } else
                
                
                
                
                if decks == .two && soft17 == .dealerStands && doubleAfterSplit == .yesSplit && surrender == .surrenderNotAllowed && dealerPeek == .dealerPeaks {
                
                if myFirstCard == mySecondCard && myThirdCard == 0 && myFourthCard == 0 {
                    
                    strategy[CardCombo(dealerCard: 2,playerCard: 4)] = Action.split
                    strategy[CardCombo(dealerCard: 3,playerCard: 4)] = Action.split
                    strategy[CardCombo(dealerCard: 4,playerCard: 4)] = Action.split
                    strategy[CardCombo(dealerCard: 5,playerCard: 4)] = Action.split
                    strategy[CardCombo(dealerCard: 6,playerCard: 4)] = Action.split
                    strategy[CardCombo(dealerCard: 7,playerCard: 4)] = Action.split
                    strategy[CardCombo(dealerCard: 8,playerCard: 4)] = Action.hit
                    strategy[CardCombo(dealerCard: 9,playerCard: 4)] = Action.hit
                    strategy[CardCombo(dealerCard: 10,playerCard: 4)] = Action.hit
                    strategy[CardCombo(dealerCard: 11,playerCard: 4)] = Action.hit
                    
                    strategy[CardCombo(dealerCard: 2,playerCard: 6)] = Action.split
                    strategy[CardCombo(dealerCard: 3,playerCard: 6)] = Action.split
                    strategy[CardCombo(dealerCard: 4,playerCard: 6)] = Action.split
                    strategy[CardCombo(dealerCard: 5,playerCard: 6)] = Action.split
                    strategy[CardCombo(dealerCard: 6,playerCard: 6)] = Action.split
                    strategy[CardCombo(dealerCard: 7,playerCard: 6)] = Action.split
                    strategy[CardCombo(dealerCard: 8,playerCard: 6)] = Action.hit
                    strategy[CardCombo(dealerCard: 9,playerCard: 6)] = Action.hit
                    strategy[CardCombo(dealerCard: 10,playerCard: 6)] = Action.hit
                    strategy[CardCombo(dealerCard: 11,playerCard: 6)] = Action.hit
                    
                    strategy[CardCombo(dealerCard: 2,playerCard: 8)] = Action.hit
                    strategy[CardCombo(dealerCard: 3,playerCard: 8)] = Action.hit
                    strategy[CardCombo(dealerCard: 4,playerCard: 8)] = Action.hit
                    strategy[CardCombo(dealerCard: 5,playerCard: 8)] = Action.split
                    strategy[CardCombo(dealerCard: 6,playerCard: 8)] = Action.split
                    strategy[CardCombo(dealerCard: 7,playerCard: 8)] = Action.hit
                    strategy[CardCombo(dealerCard: 8,playerCard: 8)] = Action.hit
                    strategy[CardCombo(dealerCard: 9,playerCard: 8)] = Action.hit
                    strategy[CardCombo(dealerCard: 10,playerCard: 8)] = Action.hit
                    strategy[CardCombo(dealerCard: 11,playerCard: 8)] = Action.hit
                    
                    strategy[CardCombo(dealerCard: 2,playerCard: 10)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 3,playerCard: 10)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 4,playerCard: 10)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 5,playerCard: 10)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 6,playerCard: 10)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 7,playerCard: 10)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 8,playerCard: 10)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 9,playerCard: 10)] = Action.doubleOrHit
                    strategy[CardCombo(dealerCard: 10,playerCard: 10)] = Action.hit
                    strategy[CardCombo(dealerCard: 11,playerCard: 10)] = Action.hit
                    
                    strategy[CardCombo(dealerCard: 2,playerCard: 12)] = Action.split
                    strategy[CardCombo(dealerCard: 3,playerCard: 12)] = Action.split
                    strategy[CardCombo(dealerCard: 4,playerCard: 12)] = Action.split
                    strategy[CardCombo(dealerCard: 5,playerCard: 12)] = Action.split
                    strategy[CardCombo(dealerCard: 6,playerCard: 12)] = Action.split
                    strategy[CardCombo(dealerCard: 7,playerCard: 12)] = Action.split
                    strategy[CardCombo(dealerCard: 8,playerCard: 12)] = Action.hit
                    strategy[CardCombo(dealerCard: 9,playerCard: 12)] = Action.hit
                    strategy[CardCombo(dealerCard: 10,playerCard: 12)] = Action.hit
                    strategy[CardCombo(dealerCard: 11,playerCard: 12)] = Action.hit
                    
                    strategy[CardCombo(dealerCard: 2,playerCard: 14)] = Action.split
                    strategy[CardCombo(dealerCard: 3,playerCard: 14)] = Action.split
                    strategy[CardCombo(dealerCard: 4,playerCard: 14)] = Action.split
                    strategy[CardCombo(dealerCard: 5,playerCard: 14)] = Action.split
                    strategy[CardCombo(dealerCard: 6,playerCard: 14)] = Action.split
                    strategy[CardCombo(dealerCard: 7,playerCard: 14)] = Action.split
                    strategy[CardCombo(dealerCard: 8,playerCard: 14)] = Action.split
                    strategy[CardCombo(dealerCard: 9,playerCard: 14)] = Action.hit
                    strategy[CardCombo(dealerCard: 10,playerCard: 14)] = Action.hit
                    strategy[CardCombo(dealerCard: 11,playerCard: 14)] = Action.hit
                    
                    strategy[CardCombo(dealerCard: 2,playerCard: 16)] = Action.split
                    strategy[CardCombo(dealerCard: 3,playerCard: 16)] = Action.split
                    strategy[CardCombo(dealerCard: 4,playerCard: 16)] = Action.split
                    strategy[CardCombo(dealerCard: 5,playerCard: 16)] = Action.split
                    strategy[CardCombo(dealerCard: 6,playerCard: 16)] = Action.split
                    strategy[CardCombo(dealerCard: 7,playerCard: 16)] = Action.split
                    strategy[CardCombo(dealerCard: 8,playerCard: 16)] = Action.split
                    strategy[CardCombo(dealerCard: 9,playerCard: 16)] = Action.split
                    strategy[CardCombo(dealerCard: 10,playerCard: 16)] = Action.split
                    strategy[CardCombo(dealerCard: 11,playerCard: 16)] = Action.split
                    
                    strategy[CardCombo(dealerCard: 2,playerCard: 18)] = Action.split
                    strategy[CardCombo(dealerCard: 3,playerCard: 18)] = Action.split
                    strategy[CardCombo(dealerCard: 4,playerCard: 18)] = Action.split
                    strategy[CardCombo(dealerCard: 5,playerCard: 18)] = Action.split
                    strategy[CardCombo(dealerCard: 6,playerCard: 18)] = Action.split
                    strategy[CardCombo(dealerCard: 7,playerCard: 18)] = Action.stand
                    strategy[CardCombo(dealerCard: 8,playerCard: 18)] = Action.split
                    strategy[CardCombo(dealerCard: 9,playerCard: 18)] = Action.split
                    strategy[CardCombo(dealerCard: 10,playerCard: 18)] = Action.stand
                    strategy[CardCombo(dealerCard: 11,playerCard: 18)] = Action.stand
                    
                    strategy[CardCombo(dealerCard: 2,playerCard: 20)] = Action.stand
                    strategy[CardCombo(dealerCard: 3,playerCard: 20)] = Action.stand
                    strategy[CardCombo(dealerCard: 4,playerCard: 20)] = Action.stand
                    strategy[CardCombo(dealerCard: 5,playerCard: 20)] = Action.stand
                    strategy[CardCombo(dealerCard: 6,playerCard: 20)] = Action.stand
                    strategy[CardCombo(dealerCard: 7,playerCard: 20)] = Action.stand
                    strategy[CardCombo(dealerCard: 8,playerCard: 20)] = Action.stand
                    strategy[CardCombo(dealerCard: 9,playerCard: 20)] = Action.stand
                    strategy[CardCombo(dealerCard: 10,playerCard: 20)] = Action.stand
                    strategy[CardCombo(dealerCard: 11,playerCard: 20)] = Action.stand
                    
                    strategy[CardCombo(dealerCard: 2,playerCard: 22)] = Action.split
                    strategy[CardCombo(dealerCard: 3,playerCard: 22)] = Action.split
                    strategy[CardCombo(dealerCard: 4,playerCard: 22)] = Action.split
                    strategy[CardCombo(dealerCard: 5,playerCard: 22)] = Action.split
                    strategy[CardCombo(dealerCard: 6,playerCard: 22)] = Action.split
                    strategy[CardCombo(dealerCard: 7,playerCard: 22)] = Action.split
                    strategy[CardCombo(dealerCard: 8,playerCard: 22)] = Action.split
                    strategy[CardCombo(dealerCard: 9,playerCard: 22)] = Action.split
                    strategy[CardCombo(dealerCard: 10,playerCard: 22)] = Action.split
                    strategy[CardCombo(dealerCard: 11,playerCard: 22)] = Action.split
                    
                    if strategy[CardCombo(dealerCard: dealerTotal, playerCard: playerTotal)] != nil {
                        return strategy[CardCombo(dealerCard: dealerTotal, playerCard: playerTotal)]!
                    } else {
                        return .over
                    }
                    
                } else {
                    
                    if myFirstCard == 11 || mySecondCard == 11 || myThirdCard == 11 || myFourthCard == 11 {
                        
                        strategy[CardCombo(dealerCard: 2,playerCard: 13)] = Action.hit
                        strategy[CardCombo(dealerCard: 3,playerCard: 13)] = Action.hit
                        strategy[CardCombo(dealerCard: 4,playerCard: 13)] = Action.hit
                        strategy[CardCombo(dealerCard: 5,playerCard: 13)] = Action.doubleOrHit
                        strategy[CardCombo(dealerCard: 6,playerCard: 13)] = Action.doubleOrHit
                        strategy[CardCombo(dealerCard: 7,playerCard: 13)] = Action.hit
                        strategy[CardCombo(dealerCard: 8,playerCard: 13)] = Action.hit
                        strategy[CardCombo(dealerCard: 9,playerCard: 13)] = Action.hit
                        strategy[CardCombo(dealerCard: 10,playerCard: 13)] = Action.hit
                        strategy[CardCombo(dealerCard: 11,playerCard: 13)] = Action.hit
                        
                        strategy[CardCombo(dealerCard: 2,playerCard: 14)] = Action.hit
                        strategy[CardCombo(dealerCard: 3,playerCard: 14)] = Action.hit
                        strategy[CardCombo(dealerCard: 4,playerCard: 14)] = Action.hit
                        strategy[CardCombo(dealerCard: 5,playerCard: 14)] = Action.doubleOrHit
                        strategy[CardCombo(dealerCard: 6,playerCard: 14)] = Action.doubleOrHit
                        strategy[CardCombo(dealerCard: 7,playerCard: 14)] = Action.hit
                        strategy[CardCombo(dealerCard: 8,playerCard: 14)] = Action.hit
                        strategy[CardCombo(dealerCard: 9,playerCard: 14)] = Action.hit
                        strategy[CardCombo(dealerCard: 10,playerCard: 14)] = Action.hit
                        strategy[CardCombo(dealerCard: 11,playerCard: 14)] = Action.hit
                        
                        strategy[CardCombo(dealerCard: 2,playerCard: 15)] = Action.hit
                        strategy[CardCombo(dealerCard: 3,playerCard: 15)] = Action.hit
                        strategy[CardCombo(dealerCard: 4,playerCard: 15)] = Action.doubleOrHit
                        strategy[CardCombo(dealerCard: 5,playerCard: 15)] = Action.doubleOrHit
                        strategy[CardCombo(dealerCard: 6,playerCard: 15)] = Action.doubleOrHit
                        strategy[CardCombo(dealerCard: 7,playerCard: 15)] = Action.hit
                        strategy[CardCombo(dealerCard: 8,playerCard: 15)] = Action.hit
                        strategy[CardCombo(dealerCard: 9,playerCard: 15)] = Action.hit
                        strategy[CardCombo(dealerCard: 10,playerCard: 15)] = Action.hit
                        strategy[CardCombo(dealerCard: 11,playerCard: 15)] = Action.hit
                        
                        strategy[CardCombo(dealerCard: 2,playerCard: 16)] = Action.hit
                        strategy[CardCombo(dealerCard: 3,playerCard: 16)] = Action.hit
                        strategy[CardCombo(dealerCard: 4,playerCard: 16)] = Action.doubleOrHit
                        strategy[CardCombo(dealerCard: 5,playerCard: 16)] = Action.doubleOrHit
                        strategy[CardCombo(dealerCard: 6,playerCard: 16)] = Action.doubleOrHit
                        strategy[CardCombo(dealerCard: 7,playerCard: 16)] = Action.hit
                        strategy[CardCombo(dealerCard: 8,playerCard: 16)] = Action.hit
                        strategy[CardCombo(dealerCard: 9,playerCard: 16)] = Action.hit
                        strategy[CardCombo(dealerCard: 10,playerCard: 16)] = Action.hit
                        strategy[CardCombo(dealerCard: 11,playerCard: 16)] = Action.hit
                        
                        strategy[CardCombo(dealerCard: 2,playerCard: 17)] = Action.hit
                        strategy[CardCombo(dealerCard: 3,playerCard: 17)] = Action.doubleOrHit
                        strategy[CardCombo(dealerCard: 4,playerCard: 17)] = Action.doubleOrHit
                        strategy[CardCombo(dealerCard: 5,playerCard: 17)] = Action.doubleOrHit
                        strategy[CardCombo(dealerCard: 6,playerCard: 17)] = Action.doubleOrHit
                        strategy[CardCombo(dealerCard: 7,playerCard: 17)] = Action.hit
                        strategy[CardCombo(dealerCard: 8,playerCard: 17)] = Action.hit
                        strategy[CardCombo(dealerCard: 9,playerCard: 17)] = Action.hit
                        strategy[CardCombo(dealerCard: 10,playerCard: 17)] = Action.hit
                        strategy[CardCombo(dealerCard: 11,playerCard: 17)] = Action.hit
                        
                        strategy[CardCombo(dealerCard: 2,playerCard: 18)] = Action.stand
                        strategy[CardCombo(dealerCard: 3,playerCard: 18)] = Action.doubleOrStand
                        strategy[CardCombo(dealerCard: 4,playerCard: 18)] = Action.doubleOrStand
                        strategy[CardCombo(dealerCard: 5,playerCard: 18)] = Action.doubleOrStand
                        strategy[CardCombo(dealerCard: 6,playerCard: 18)] = Action.doubleOrStand
                        strategy[CardCombo(dealerCard: 7,playerCard: 18)] = Action.stand
                        strategy[CardCombo(dealerCard: 8,playerCard: 18)] = Action.stand
                        strategy[CardCombo(dealerCard: 9,playerCard: 18)] = Action.hit
                        strategy[CardCombo(dealerCard: 10,playerCard: 18)] = Action.hit
                        strategy[CardCombo(dealerCard: 11,playerCard: 18)] = Action.hit
                        
                        strategy[CardCombo(dealerCard: 2,playerCard: 19)] = Action.stand
                        strategy[CardCombo(dealerCard: 3,playerCard: 19)] = Action.stand
                        strategy[CardCombo(dealerCard: 4,playerCard: 19)] = Action.stand
                        strategy[CardCombo(dealerCard: 5,playerCard: 19)] = Action.stand
                        strategy[CardCombo(dealerCard: 6,playerCard: 19)] = Action.stand
                        strategy[CardCombo(dealerCard: 7,playerCard: 19)] = Action.stand
                        strategy[CardCombo(dealerCard: 8,playerCard: 19)] = Action.stand
                        strategy[CardCombo(dealerCard: 9,playerCard: 19)] = Action.stand
                        strategy[CardCombo(dealerCard: 10,playerCard: 19)] = Action.stand
                        strategy[CardCombo(dealerCard: 11,playerCard: 19)] = Action.stand
                        
                        strategy[CardCombo(dealerCard: 2,playerCard: 20)] = Action.stand
                        strategy[CardCombo(dealerCard: 3,playerCard: 20)] = Action.stand
                        strategy[CardCombo(dealerCard: 4,playerCard: 20)] = Action.stand
                        strategy[CardCombo(dealerCard: 5,playerCard: 20)] = Action.stand
                        strategy[CardCombo(dealerCard: 6,playerCard: 20)] = Action.stand
                        strategy[CardCombo(dealerCard: 7,playerCard: 20)] = Action.stand
                        strategy[CardCombo(dealerCard: 8,playerCard: 20)] = Action.stand
                        strategy[CardCombo(dealerCard: 9,playerCard: 20)] = Action.stand
                        strategy[CardCombo(dealerCard: 10,playerCard: 20)] = Action.stand
                        strategy[CardCombo(dealerCard: 11,playerCard: 20)] = Action.stand
                        
                        strategy[CardCombo(dealerCard: 2,playerCard: 21)] = Action.stand
                        strategy[CardCombo(dealerCard: 3,playerCard: 21)] = Action.stand
                        strategy[CardCombo(dealerCard: 4,playerCard: 21)] = Action.stand
                        strategy[CardCombo(dealerCard: 5,playerCard: 21)] = Action.stand
                        strategy[CardCombo(dealerCard: 6,playerCard: 21)] = Action.stand
                        strategy[CardCombo(dealerCard: 7,playerCard: 21)] = Action.stand
                        strategy[CardCombo(dealerCard: 8,playerCard: 21)] = Action.stand
                        strategy[CardCombo(dealerCard: 9,playerCard: 21)] = Action.stand
                        strategy[CardCombo(dealerCard: 10,playerCard: 21)] = Action.stand
                        strategy[CardCombo(dealerCard: 11,playerCard: 21)] = Action.stand
                        
                        if strategy[CardCombo(dealerCard: dealerTotal, playerCard: playerTotalWithAces!)] != nil {
                            return strategy[CardCombo(dealerCard: dealerTotal, playerCard: playerTotalWithAces!)]!
                        } else {
                            return .over
                        }
                        
                    } else {
                        
                        strategy[CardCombo(dealerCard: 2,playerCard: 5)] = Action.hit
                        strategy[CardCombo(dealerCard: 3,playerCard: 5)] = Action.hit
                        strategy[CardCombo(dealerCard: 4,playerCard: 5)] = Action.hit
                        strategy[CardCombo(dealerCard: 5,playerCard: 5)] = Action.hit
                        strategy[CardCombo(dealerCard: 6,playerCard: 5)] = Action.hit
                        strategy[CardCombo(dealerCard: 7,playerCard: 5)] = Action.hit
                        strategy[CardCombo(dealerCard: 8,playerCard: 5)] = Action.hit
                        strategy[CardCombo(dealerCard: 9,playerCard: 5)] = Action.hit
                        strategy[CardCombo(dealerCard: 10,playerCard: 5)] = Action.hit
                        strategy[CardCombo(dealerCard: 11,playerCard: 5)] = Action.hit
                        
                        strategy[CardCombo(dealerCard: 2,playerCard: 6)] = Action.hit
                        strategy[CardCombo(dealerCard: 3,playerCard: 6)] = Action.hit
                        strategy[CardCombo(dealerCard: 4,playerCard: 6)] = Action.hit
                        strategy[CardCombo(dealerCard: 5,playerCard: 6)] = Action.hit
                        strategy[CardCombo(dealerCard: 6,playerCard: 6)] = Action.hit
                        strategy[CardCombo(dealerCard: 7,playerCard: 6)] = Action.hit
                        strategy[CardCombo(dealerCard: 8,playerCard: 6)] = Action.hit
                        strategy[CardCombo(dealerCard: 9,playerCard: 6)] = Action.hit
                        strategy[CardCombo(dealerCard: 10,playerCard: 6)] = Action.hit
                        strategy[CardCombo(dealerCard: 11,playerCard: 6)] = Action.hit
                        
                        strategy[CardCombo(dealerCard: 2,playerCard: 7)] = Action.hit
                        strategy[CardCombo(dealerCard: 3,playerCard: 7)] = Action.hit
                        strategy[CardCombo(dealerCard: 4,playerCard: 7)] = Action.hit
                        strategy[CardCombo(dealerCard: 5,playerCard: 7)] = Action.hit
                        strategy[CardCombo(dealerCard: 6,playerCard: 7)] = Action.hit
                        strategy[CardCombo(dealerCard: 7,playerCard: 7)] = Action.hit
                        strategy[CardCombo(dealerCard: 8,playerCard: 7)] = Action.hit
                        strategy[CardCombo(dealerCard: 9,playerCard: 7)] = Action.hit
                        strategy[CardCombo(dealerCard: 10,playerCard: 7)] = Action.hit
                        strategy[CardCombo(dealerCard: 11,playerCard: 7)] = Action.hit
                        
                        strategy[CardCombo(dealerCard: 2,playerCard: 8)] = Action.hit
                        strategy[CardCombo(dealerCard: 3,playerCard: 8)] = Action.hit
                        strategy[CardCombo(dealerCard: 4,playerCard: 8)] = Action.hit
                        strategy[CardCombo(dealerCard: 5,playerCard: 8)] = Action.hit
                        strategy[CardCombo(dealerCard: 6,playerCard: 8)] = Action.hit
                        strategy[CardCombo(dealerCard: 7,playerCard: 8)] = Action.hit
                        strategy[CardCombo(dealerCard: 8,playerCard: 8)] = Action.hit
                        strategy[CardCombo(dealerCard: 9,playerCard: 8)] = Action.hit
                        strategy[CardCombo(dealerCard: 10,playerCard: 8)] = Action.hit
                        strategy[CardCombo(dealerCard: 11,playerCard: 8)] = Action.hit
                        
                        strategy[CardCombo(dealerCard: 2,playerCard: 9)] = Action.doubleOrHit
                        strategy[CardCombo(dealerCard: 3,playerCard: 9)] = Action.doubleOrHit
                        strategy[CardCombo(dealerCard: 4,playerCard: 9)] = Action.doubleOrHit
                        strategy[CardCombo(dealerCard: 5,playerCard: 9)] = Action.doubleOrHit
                        strategy[CardCombo(dealerCard: 6,playerCard: 9)] = Action.doubleOrHit
                        strategy[CardCombo(dealerCard: 7,playerCard: 9)] = Action.hit
                        strategy[CardCombo(dealerCard: 8,playerCard: 9)] = Action.hit
                        strategy[CardCombo(dealerCard: 9,playerCard: 9)] = Action.hit
                        strategy[CardCombo(dealerCard: 10,playerCard: 9)] = Action.hit
                        strategy[CardCombo(dealerCard: 11,playerCard: 9)] = Action.hit
                        
                        strategy[CardCombo(dealerCard: 2,playerCard: 10)] = Action.doubleOrHit
                        strategy[CardCombo(dealerCard: 3,playerCard: 10)] = Action.doubleOrHit
                        strategy[CardCombo(dealerCard: 4,playerCard: 10)] = Action.doubleOrHit
                        strategy[CardCombo(dealerCard: 5,playerCard: 10)] = Action.doubleOrHit
                        strategy[CardCombo(dealerCard: 6,playerCard: 10)] = Action.doubleOrHit
                        strategy[CardCombo(dealerCard: 7,playerCard: 10)] = Action.doubleOrHit
                        strategy[CardCombo(dealerCard: 8,playerCard: 10)] = Action.doubleOrHit
                        strategy[CardCombo(dealerCard: 9,playerCard: 10)] = Action.doubleOrHit
                        strategy[CardCombo(dealerCard: 10,playerCard: 10)] = Action.hit
                        strategy[CardCombo(dealerCard: 11,playerCard: 10)] = Action.hit
                        
                        strategy[CardCombo(dealerCard: 2,playerCard: 11)] = Action.doubleOrHit
                        strategy[CardCombo(dealerCard: 3,playerCard: 11)] = Action.doubleOrHit
                        strategy[CardCombo(dealerCard: 4,playerCard: 11)] = Action.doubleOrHit
                        strategy[CardCombo(dealerCard: 5,playerCard: 11)] = Action.doubleOrHit
                        strategy[CardCombo(dealerCard: 6,playerCard: 11)] = Action.doubleOrHit
                        strategy[CardCombo(dealerCard: 7,playerCard: 11)] = Action.doubleOrHit
                        strategy[CardCombo(dealerCard: 8,playerCard: 11)] = Action.doubleOrHit
                        strategy[CardCombo(dealerCard: 9,playerCard: 11)] = Action.doubleOrHit
                        strategy[CardCombo(dealerCard: 10,playerCard: 11)] = Action.doubleOrHit
                        strategy[CardCombo(dealerCard: 11,playerCard: 11)] = Action.doubleOrHit
                        
                        strategy[CardCombo(dealerCard: 2,playerCard: 12)] = Action.hit
                        strategy[CardCombo(dealerCard: 3,playerCard: 12)] = Action.hit
                        strategy[CardCombo(dealerCard: 4,playerCard: 12)] = Action.stand
                        strategy[CardCombo(dealerCard: 5,playerCard: 12)] = Action.stand
                        strategy[CardCombo(dealerCard: 6,playerCard: 12)] = Action.stand
                        strategy[CardCombo(dealerCard: 7,playerCard: 12)] = Action.hit
                        strategy[CardCombo(dealerCard: 8,playerCard: 12)] = Action.hit
                        strategy[CardCombo(dealerCard: 9,playerCard: 12)] = Action.hit
                        strategy[CardCombo(dealerCard: 10,playerCard: 12)] = Action.hit
                        strategy[CardCombo(dealerCard: 11,playerCard: 12)] = Action.hit
                        
                        strategy[CardCombo(dealerCard: 2,playerCard: 13)] = Action.stand
                        strategy[CardCombo(dealerCard: 3,playerCard: 13)] = Action.stand
                        strategy[CardCombo(dealerCard: 4,playerCard: 13)] = Action.stand
                        strategy[CardCombo(dealerCard: 5,playerCard: 13)] = Action.stand
                        strategy[CardCombo(dealerCard: 6,playerCard: 13)] = Action.stand
                        strategy[CardCombo(dealerCard: 7,playerCard: 13)] = Action.hit
                        strategy[CardCombo(dealerCard: 8,playerCard: 13)] = Action.hit
                        strategy[CardCombo(dealerCard: 9,playerCard: 13)] = Action.hit
                        strategy[CardCombo(dealerCard: 10,playerCard: 13)] = Action.hit
                        strategy[CardCombo(dealerCard: 11,playerCard: 13)] = Action.hit
                        
                        strategy[CardCombo(dealerCard: 2,playerCard: 14)] = Action.stand
                        strategy[CardCombo(dealerCard: 3,playerCard: 14)] = Action.stand
                        strategy[CardCombo(dealerCard: 4,playerCard: 14)] = Action.stand
                        strategy[CardCombo(dealerCard: 5,playerCard: 14)] = Action.stand
                        strategy[CardCombo(dealerCard: 6,playerCard: 14)] = Action.stand
                        strategy[CardCombo(dealerCard: 7,playerCard: 14)] = Action.hit
                        strategy[CardCombo(dealerCard: 8,playerCard: 14)] = Action.hit
                        strategy[CardCombo(dealerCard: 9,playerCard: 14)] = Action.hit
                        strategy[CardCombo(dealerCard: 10,playerCard: 14)] = Action.hit
                        strategy[CardCombo(dealerCard: 11,playerCard: 14)] = Action.hit
                        
                        strategy[CardCombo(dealerCard: 2,playerCard: 15)] = Action.stand
                        strategy[CardCombo(dealerCard: 3,playerCard: 15)] = Action.stand
                        strategy[CardCombo(dealerCard: 4,playerCard: 15)] = Action.stand
                        strategy[CardCombo(dealerCard: 5,playerCard: 15)] = Action.stand
                        strategy[CardCombo(dealerCard: 6,playerCard: 15)] = Action.stand
                        strategy[CardCombo(dealerCard: 7,playerCard: 15)] = Action.hit
                        strategy[CardCombo(dealerCard: 8,playerCard: 15)] = Action.hit
                        strategy[CardCombo(dealerCard: 9,playerCard: 15)] = Action.hit
                        strategy[CardCombo(dealerCard: 10,playerCard: 15)] = Action.hit
                        strategy[CardCombo(dealerCard: 11,playerCard: 15)] = Action.hit
                        
                        strategy[CardCombo(dealerCard: 2,playerCard: 16)] = Action.stand
                        strategy[CardCombo(dealerCard: 3,playerCard: 16)] = Action.stand
                        strategy[CardCombo(dealerCard: 4,playerCard: 16)] = Action.stand
                        strategy[CardCombo(dealerCard: 5,playerCard: 16)] = Action.stand
                        strategy[CardCombo(dealerCard: 6,playerCard: 16)] = Action.stand
                        strategy[CardCombo(dealerCard: 7,playerCard: 16)] = Action.hit
                        strategy[CardCombo(dealerCard: 8,playerCard: 16)] = Action.hit
                        strategy[CardCombo(dealerCard: 9,playerCard: 16)] = Action.hit
                        strategy[CardCombo(dealerCard: 10,playerCard: 16)] = Action.hit
                        strategy[CardCombo(dealerCard: 11,playerCard: 16)] = Action.hit
                        
                        strategy[CardCombo(dealerCard: 2,playerCard: 17)] = Action.stand
                        strategy[CardCombo(dealerCard: 3,playerCard: 17)] = Action.stand
                        strategy[CardCombo(dealerCard: 4,playerCard: 17)] = Action.stand
                        strategy[CardCombo(dealerCard: 5,playerCard: 17)] = Action.stand
                        strategy[CardCombo(dealerCard: 6,playerCard: 17)] = Action.stand
                        strategy[CardCombo(dealerCard: 7,playerCard: 17)] = Action.stand
                        strategy[CardCombo(dealerCard: 8,playerCard: 17)] = Action.stand
                        strategy[CardCombo(dealerCard: 9,playerCard: 17)] = Action.stand
                        strategy[CardCombo(dealerCard: 10,playerCard: 17)] = Action.stand
                        strategy[CardCombo(dealerCard: 11,playerCard: 17)] = Action.stand
                        
                        strategy[CardCombo(dealerCard: 2,playerCard: 18)] = Action.stand
                        strategy[CardCombo(dealerCard: 3,playerCard: 18)] = Action.stand
                        strategy[CardCombo(dealerCard: 4,playerCard: 18)] = Action.stand
                        strategy[CardCombo(dealerCard: 5,playerCard: 18)] = Action.stand
                        strategy[CardCombo(dealerCard: 6,playerCard: 18)] = Action.stand
                        strategy[CardCombo(dealerCard: 7,playerCard: 18)] = Action.stand
                        strategy[CardCombo(dealerCard: 8,playerCard: 18)] = Action.stand
                        strategy[CardCombo(dealerCard: 9,playerCard: 18)] = Action.stand
                        strategy[CardCombo(dealerCard: 10,playerCard: 18)] = Action.stand
                        strategy[CardCombo(dealerCard: 11,playerCard: 18)] = Action.stand
                        
                        strategy[CardCombo(dealerCard: 2,playerCard: 19)] = Action.stand
                        strategy[CardCombo(dealerCard: 3,playerCard: 19)] = Action.stand
                        strategy[CardCombo(dealerCard: 4,playerCard: 19)] = Action.stand
                        strategy[CardCombo(dealerCard: 5,playerCard: 19)] = Action.stand
                        strategy[CardCombo(dealerCard: 6,playerCard: 19)] = Action.stand
                        strategy[CardCombo(dealerCard: 7,playerCard: 19)] = Action.stand
                        strategy[CardCombo(dealerCard: 8,playerCard: 19)] = Action.stand
                        strategy[CardCombo(dealerCard: 9,playerCard: 19)] = Action.stand
                        strategy[CardCombo(dealerCard: 10,playerCard: 19)] = Action.stand
                        strategy[CardCombo(dealerCard: 11,playerCard: 19)] = Action.stand
                        
                        strategy[CardCombo(dealerCard: 2,playerCard: 20)] = Action.stand
                        strategy[CardCombo(dealerCard: 3,playerCard: 20)] = Action.stand
                        strategy[CardCombo(dealerCard: 4,playerCard: 20)] = Action.stand
                        strategy[CardCombo(dealerCard: 5,playerCard: 20)] = Action.stand
                        strategy[CardCombo(dealerCard: 6,playerCard: 20)] = Action.stand
                        strategy[CardCombo(dealerCard: 7,playerCard: 20)] = Action.stand
                        strategy[CardCombo(dealerCard: 8,playerCard: 20)] = Action.stand
                        strategy[CardCombo(dealerCard: 9,playerCard: 20)] = Action.stand
                        strategy[CardCombo(dealerCard: 10,playerCard: 20)] = Action.stand
                        strategy[CardCombo(dealerCard: 11,playerCard: 20)] = Action.stand
                        
                        strategy[CardCombo(dealerCard: 2,playerCard: 21)] = Action.stand
                        strategy[CardCombo(dealerCard: 3,playerCard: 21)] = Action.stand
                        strategy[CardCombo(dealerCard: 4,playerCard: 21)] = Action.stand
                        strategy[CardCombo(dealerCard: 5,playerCard: 21)] = Action.stand
                        strategy[CardCombo(dealerCard: 6,playerCard: 21)] = Action.stand
                        strategy[CardCombo(dealerCard: 7,playerCard: 21)] = Action.stand
                        strategy[CardCombo(dealerCard: 8,playerCard: 21)] = Action.stand
                        strategy[CardCombo(dealerCard: 9,playerCard: 21)] = Action.stand
                        strategy[CardCombo(dealerCard: 10,playerCard: 21)] = Action.stand
                        strategy[CardCombo(dealerCard: 11,playerCard: 21)] = Action.stand
                        
                        if strategy[CardCombo(dealerCard: dealerTotal, playerCard: playerTotal)] != nil {
                            return strategy[CardCombo(dealerCard: dealerTotal, playerCard: playerTotal)]!
                        } else {
                            return .over
                        }
                        
                    }
                }
                } else
                    
                    
                    
        
                    if decks == .fourOrMore && soft17 == .dealerHits && doubleAfterSplit == .yesSplit && surrender == .surrenderNotAllowed && dealerPeek == .dealerPeaks {
                        
                        if myFirstCard == mySecondCard && myThirdCard == 0 && myFourthCard == 0 {
                            
                            strategy[CardCombo(dealerCard: 2,playerCard: 4)] = Action.split
                            strategy[CardCombo(dealerCard: 3,playerCard: 4)] = Action.split
                            strategy[CardCombo(dealerCard: 4,playerCard: 4)] = Action.split
                            strategy[CardCombo(dealerCard: 5,playerCard: 4)] = Action.split
                            strategy[CardCombo(dealerCard: 6,playerCard: 4)] = Action.split
                            strategy[CardCombo(dealerCard: 7,playerCard: 4)] = Action.split
                            strategy[CardCombo(dealerCard: 8,playerCard: 4)] = Action.hit
                            strategy[CardCombo(dealerCard: 9,playerCard: 4)] = Action.hit
                            strategy[CardCombo(dealerCard: 10,playerCard: 4)] = Action.hit
                            strategy[CardCombo(dealerCard: 11,playerCard: 4)] = Action.hit
                            
                            strategy[CardCombo(dealerCard: 2,playerCard: 6)] = Action.split
                            strategy[CardCombo(dealerCard: 3,playerCard: 6)] = Action.split
                            strategy[CardCombo(dealerCard: 4,playerCard: 6)] = Action.split
                            strategy[CardCombo(dealerCard: 5,playerCard: 6)] = Action.split
                            strategy[CardCombo(dealerCard: 6,playerCard: 6)] = Action.split
                            strategy[CardCombo(dealerCard: 7,playerCard: 6)] = Action.split
                            strategy[CardCombo(dealerCard: 8,playerCard: 6)] = Action.hit
                            strategy[CardCombo(dealerCard: 9,playerCard: 6)] = Action.hit
                            strategy[CardCombo(dealerCard: 10,playerCard: 6)] = Action.hit
                            strategy[CardCombo(dealerCard: 11,playerCard: 6)] = Action.hit
                            
                            strategy[CardCombo(dealerCard: 2,playerCard: 8)] = Action.hit
                            strategy[CardCombo(dealerCard: 3,playerCard: 8)] = Action.hit
                            strategy[CardCombo(dealerCard: 4,playerCard: 8)] = Action.hit
                            strategy[CardCombo(dealerCard: 5,playerCard: 8)] = Action.split
                            strategy[CardCombo(dealerCard: 6,playerCard: 8)] = Action.split
                            strategy[CardCombo(dealerCard: 7,playerCard: 8)] = Action.hit
                            strategy[CardCombo(dealerCard: 8,playerCard: 8)] = Action.hit
                            strategy[CardCombo(dealerCard: 9,playerCard: 8)] = Action.hit
                            strategy[CardCombo(dealerCard: 10,playerCard: 8)] = Action.hit
                            strategy[CardCombo(dealerCard: 11,playerCard: 8)] = Action.hit
                            
                            strategy[CardCombo(dealerCard: 2,playerCard: 10)] = Action.doubleOrHit
                            strategy[CardCombo(dealerCard: 3,playerCard: 10)] = Action.doubleOrHit
                            strategy[CardCombo(dealerCard: 4,playerCard: 10)] = Action.doubleOrHit
                            strategy[CardCombo(dealerCard: 5,playerCard: 10)] = Action.doubleOrHit
                            strategy[CardCombo(dealerCard: 6,playerCard: 10)] = Action.doubleOrHit
                            strategy[CardCombo(dealerCard: 7,playerCard: 10)] = Action.doubleOrHit
                            strategy[CardCombo(dealerCard: 8,playerCard: 10)] = Action.doubleOrHit
                            strategy[CardCombo(dealerCard: 9,playerCard: 10)] = Action.doubleOrHit
                            strategy[CardCombo(dealerCard: 10,playerCard: 10)] = Action.hit
                            strategy[CardCombo(dealerCard: 11,playerCard: 10)] = Action.hit
                            
                            strategy[CardCombo(dealerCard: 2,playerCard: 12)] = Action.split
                            strategy[CardCombo(dealerCard: 3,playerCard: 12)] = Action.split
                            strategy[CardCombo(dealerCard: 4,playerCard: 12)] = Action.split
                            strategy[CardCombo(dealerCard: 5,playerCard: 12)] = Action.split
                            strategy[CardCombo(dealerCard: 6,playerCard: 12)] = Action.split
                            strategy[CardCombo(dealerCard: 7,playerCard: 12)] = Action.hit
                            strategy[CardCombo(dealerCard: 8,playerCard: 12)] = Action.hit
                            strategy[CardCombo(dealerCard: 9,playerCard: 12)] = Action.hit
                            strategy[CardCombo(dealerCard: 10,playerCard: 12)] = Action.hit
                            strategy[CardCombo(dealerCard: 11,playerCard: 12)] = Action.hit
                            
                            strategy[CardCombo(dealerCard: 2,playerCard: 14)] = Action.split
                            strategy[CardCombo(dealerCard: 3,playerCard: 14)] = Action.split
                            strategy[CardCombo(dealerCard: 4,playerCard: 14)] = Action.split
                            strategy[CardCombo(dealerCard: 5,playerCard: 14)] = Action.split
                            strategy[CardCombo(dealerCard: 6,playerCard: 14)] = Action.split
                            strategy[CardCombo(dealerCard: 7,playerCard: 14)] = Action.split
                            strategy[CardCombo(dealerCard: 8,playerCard: 14)] = Action.hit
                            strategy[CardCombo(dealerCard: 9,playerCard: 14)] = Action.hit
                            strategy[CardCombo(dealerCard: 10,playerCard: 14)] = Action.hit
                            strategy[CardCombo(dealerCard: 11,playerCard: 14)] = Action.hit
                            
                            strategy[CardCombo(dealerCard: 2,playerCard: 16)] = Action.split
                            strategy[CardCombo(dealerCard: 3,playerCard: 16)] = Action.split
                            strategy[CardCombo(dealerCard: 4,playerCard: 16)] = Action.split
                            strategy[CardCombo(dealerCard: 5,playerCard: 16)] = Action.split
                            strategy[CardCombo(dealerCard: 6,playerCard: 16)] = Action.split
                            strategy[CardCombo(dealerCard: 7,playerCard: 16)] = Action.split
                            strategy[CardCombo(dealerCard: 8,playerCard: 16)] = Action.split
                            strategy[CardCombo(dealerCard: 9,playerCard: 16)] = Action.split
                            strategy[CardCombo(dealerCard: 10,playerCard: 16)] = Action.split
                            strategy[CardCombo(dealerCard: 11,playerCard: 16)] = Action.split
                            
                            strategy[CardCombo(dealerCard: 2,playerCard: 18)] = Action.split
                            strategy[CardCombo(dealerCard: 3,playerCard: 18)] = Action.split
                            strategy[CardCombo(dealerCard: 4,playerCard: 18)] = Action.split
                            strategy[CardCombo(dealerCard: 5,playerCard: 18)] = Action.split
                            strategy[CardCombo(dealerCard: 6,playerCard: 18)] = Action.split
                            strategy[CardCombo(dealerCard: 7,playerCard: 18)] = Action.stand
                            strategy[CardCombo(dealerCard: 8,playerCard: 18)] = Action.split
                            strategy[CardCombo(dealerCard: 9,playerCard: 18)] = Action.split
                            strategy[CardCombo(dealerCard: 10,playerCard: 18)] = Action.stand
                            strategy[CardCombo(dealerCard: 11,playerCard: 18)] = Action.stand
                            
                            strategy[CardCombo(dealerCard: 2,playerCard: 20)] = Action.stand
                            strategy[CardCombo(dealerCard: 3,playerCard: 20)] = Action.stand
                            strategy[CardCombo(dealerCard: 4,playerCard: 20)] = Action.stand
                            strategy[CardCombo(dealerCard: 5,playerCard: 20)] = Action.stand
                            strategy[CardCombo(dealerCard: 6,playerCard: 20)] = Action.stand
                            strategy[CardCombo(dealerCard: 7,playerCard: 20)] = Action.stand
                            strategy[CardCombo(dealerCard: 8,playerCard: 20)] = Action.stand
                            strategy[CardCombo(dealerCard: 9,playerCard: 20)] = Action.stand
                            strategy[CardCombo(dealerCard: 10,playerCard: 20)] = Action.stand
                            strategy[CardCombo(dealerCard: 11,playerCard: 20)] = Action.stand
                            
                            strategy[CardCombo(dealerCard: 2,playerCard: 22)] = Action.split
                            strategy[CardCombo(dealerCard: 3,playerCard: 22)] = Action.split
                            strategy[CardCombo(dealerCard: 4,playerCard: 22)] = Action.split
                            strategy[CardCombo(dealerCard: 5,playerCard: 22)] = Action.split
                            strategy[CardCombo(dealerCard: 6,playerCard: 22)] = Action.split
                            strategy[CardCombo(dealerCard: 7,playerCard: 22)] = Action.split
                            strategy[CardCombo(dealerCard: 8,playerCard: 22)] = Action.split
                            strategy[CardCombo(dealerCard: 9,playerCard: 22)] = Action.split
                            strategy[CardCombo(dealerCard: 10,playerCard: 22)] = Action.split
                            strategy[CardCombo(dealerCard: 11,playerCard: 22)] = Action.split
                            
                            if strategy[CardCombo(dealerCard: dealerTotal, playerCard: playerTotal)] != nil {
                                return strategy[CardCombo(dealerCard: dealerTotal, playerCard: playerTotal)]!
                            } else {
                                return .over
                            }
                            
                        } else {
                            
                            if myFirstCard == 11 || mySecondCard == 11 || myThirdCard == 11 || myFourthCard == 11 {
                                
                                strategy[CardCombo(dealerCard: 2,playerCard: 13)] = Action.hit
                                strategy[CardCombo(dealerCard: 3,playerCard: 13)] = Action.hit
                                strategy[CardCombo(dealerCard: 4,playerCard: 13)] = Action.hit
                                strategy[CardCombo(dealerCard: 5,playerCard: 13)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 6,playerCard: 13)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 7,playerCard: 13)] = Action.hit
                                strategy[CardCombo(dealerCard: 8,playerCard: 13)] = Action.hit
                                strategy[CardCombo(dealerCard: 9,playerCard: 13)] = Action.hit
                                strategy[CardCombo(dealerCard: 10,playerCard: 13)] = Action.hit
                                strategy[CardCombo(dealerCard: 11,playerCard: 13)] = Action.hit
                                
                                strategy[CardCombo(dealerCard: 2,playerCard: 14)] = Action.hit
                                strategy[CardCombo(dealerCard: 3,playerCard: 14)] = Action.hit
                                strategy[CardCombo(dealerCard: 4,playerCard: 14)] = Action.hit
                                strategy[CardCombo(dealerCard: 5,playerCard: 14)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 6,playerCard: 14)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 7,playerCard: 14)] = Action.hit
                                strategy[CardCombo(dealerCard: 8,playerCard: 14)] = Action.hit
                                strategy[CardCombo(dealerCard: 9,playerCard: 14)] = Action.hit
                                strategy[CardCombo(dealerCard: 10,playerCard: 14)] = Action.hit
                                strategy[CardCombo(dealerCard: 11,playerCard: 14)] = Action.hit
                                
                                strategy[CardCombo(dealerCard: 2,playerCard: 15)] = Action.hit
                                strategy[CardCombo(dealerCard: 3,playerCard: 15)] = Action.hit
                                strategy[CardCombo(dealerCard: 4,playerCard: 15)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 5,playerCard: 15)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 6,playerCard: 15)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 7,playerCard: 15)] = Action.hit
                                strategy[CardCombo(dealerCard: 8,playerCard: 15)] = Action.hit
                                strategy[CardCombo(dealerCard: 9,playerCard: 15)] = Action.hit
                                strategy[CardCombo(dealerCard: 10,playerCard: 15)] = Action.hit
                                strategy[CardCombo(dealerCard: 11,playerCard: 15)] = Action.hit
                                
                                strategy[CardCombo(dealerCard: 2,playerCard: 16)] = Action.hit
                                strategy[CardCombo(dealerCard: 3,playerCard: 16)] = Action.hit
                                strategy[CardCombo(dealerCard: 4,playerCard: 16)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 5,playerCard: 16)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 6,playerCard: 16)] = Action.hit
                                strategy[CardCombo(dealerCard: 7,playerCard: 16)] = Action.hit
                                strategy[CardCombo(dealerCard: 8,playerCard: 16)] = Action.hit
                                strategy[CardCombo(dealerCard: 9,playerCard: 16)] = Action.hit
                                strategy[CardCombo(dealerCard: 10,playerCard: 16)] = Action.hit
                                strategy[CardCombo(dealerCard: 11,playerCard: 16)] = Action.hit
                                
                                strategy[CardCombo(dealerCard: 2,playerCard: 17)] = Action.hit
                                strategy[CardCombo(dealerCard: 3,playerCard: 17)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 4,playerCard: 17)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 5,playerCard: 17)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 6,playerCard: 17)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 7,playerCard: 17)] = Action.hit
                                strategy[CardCombo(dealerCard: 8,playerCard: 17)] = Action.hit
                                strategy[CardCombo(dealerCard: 9,playerCard: 17)] = Action.hit
                                strategy[CardCombo(dealerCard: 10,playerCard: 17)] = Action.hit
                                strategy[CardCombo(dealerCard: 11,playerCard: 17)] = Action.hit
                                
                                strategy[CardCombo(dealerCard: 2,playerCard: 18)] = Action.doubleOrStand
                                strategy[CardCombo(dealerCard: 3,playerCard: 18)] = Action.doubleOrStand
                                strategy[CardCombo(dealerCard: 4,playerCard: 18)] = Action.doubleOrStand
                                strategy[CardCombo(dealerCard: 5,playerCard: 18)] = Action.doubleOrStand
                                strategy[CardCombo(dealerCard: 6,playerCard: 18)] = Action.doubleOrStand
                                strategy[CardCombo(dealerCard: 7,playerCard: 18)] = Action.stand
                                strategy[CardCombo(dealerCard: 8,playerCard: 18)] = Action.stand
                                strategy[CardCombo(dealerCard: 9,playerCard: 18)] = Action.hit
                                strategy[CardCombo(dealerCard: 10,playerCard: 18)] = Action.hit
                                strategy[CardCombo(dealerCard: 11,playerCard: 18)] = Action.hit
                                
                                strategy[CardCombo(dealerCard: 2,playerCard: 19)] = Action.stand
                                strategy[CardCombo(dealerCard: 3,playerCard: 19)] = Action.stand
                                strategy[CardCombo(dealerCard: 4,playerCard: 19)] = Action.stand
                                strategy[CardCombo(dealerCard: 5,playerCard: 19)] = Action.stand
                                strategy[CardCombo(dealerCard: 6,playerCard: 19)] = Action.stand
                                strategy[CardCombo(dealerCard: 7,playerCard: 19)] = Action.doubleOrStand
                                strategy[CardCombo(dealerCard: 8,playerCard: 19)] = Action.stand
                                strategy[CardCombo(dealerCard: 9,playerCard: 19)] = Action.stand
                                strategy[CardCombo(dealerCard: 10,playerCard: 19)] = Action.stand
                                strategy[CardCombo(dealerCard: 11,playerCard: 19)] = Action.stand
                                
                                strategy[CardCombo(dealerCard: 2,playerCard: 20)] = Action.stand
                                strategy[CardCombo(dealerCard: 3,playerCard: 20)] = Action.stand
                                strategy[CardCombo(dealerCard: 4,playerCard: 20)] = Action.stand
                                strategy[CardCombo(dealerCard: 5,playerCard: 20)] = Action.stand
                                strategy[CardCombo(dealerCard: 6,playerCard: 20)] = Action.stand
                                strategy[CardCombo(dealerCard: 7,playerCard: 20)] = Action.stand
                                strategy[CardCombo(dealerCard: 8,playerCard: 20)] = Action.stand
                                strategy[CardCombo(dealerCard: 9,playerCard: 20)] = Action.stand
                                strategy[CardCombo(dealerCard: 10,playerCard: 20)] = Action.stand
                                strategy[CardCombo(dealerCard: 11,playerCard: 20)] = Action.stand
                                
                                strategy[CardCombo(dealerCard: 2,playerCard: 21)] = Action.stand
                                strategy[CardCombo(dealerCard: 3,playerCard: 21)] = Action.stand
                                strategy[CardCombo(dealerCard: 4,playerCard: 21)] = Action.stand
                                strategy[CardCombo(dealerCard: 5,playerCard: 21)] = Action.stand
                                strategy[CardCombo(dealerCard: 6,playerCard: 21)] = Action.stand
                                strategy[CardCombo(dealerCard: 7,playerCard: 21)] = Action.stand
                                strategy[CardCombo(dealerCard: 8,playerCard: 21)] = Action.stand
                                strategy[CardCombo(dealerCard: 9,playerCard: 21)] = Action.stand
                                strategy[CardCombo(dealerCard: 10,playerCard: 21)] = Action.stand
                                strategy[CardCombo(dealerCard: 11,playerCard: 21)] = Action.stand
                                
                                if strategy[CardCombo(dealerCard: dealerTotal, playerCard: playerTotalWithAces!)] != nil {
                                    return strategy[CardCombo(dealerCard: dealerTotal, playerCard: playerTotalWithAces!)]!
                                } else {
                                    return .over
                                }
                                
                            } else {
                                
                                strategy[CardCombo(dealerCard: 2,playerCard: 5)] = Action.hit
                                strategy[CardCombo(dealerCard: 3,playerCard: 5)] = Action.hit
                                strategy[CardCombo(dealerCard: 4,playerCard: 5)] = Action.hit
                                strategy[CardCombo(dealerCard: 5,playerCard: 5)] = Action.hit
                                strategy[CardCombo(dealerCard: 6,playerCard: 5)] = Action.hit
                                strategy[CardCombo(dealerCard: 7,playerCard: 5)] = Action.hit
                                strategy[CardCombo(dealerCard: 8,playerCard: 5)] = Action.hit
                                strategy[CardCombo(dealerCard: 9,playerCard: 5)] = Action.hit
                                strategy[CardCombo(dealerCard: 10,playerCard: 5)] = Action.hit
                                strategy[CardCombo(dealerCard: 11,playerCard: 5)] = Action.hit
                                
                                strategy[CardCombo(dealerCard: 2,playerCard: 6)] = Action.hit
                                strategy[CardCombo(dealerCard: 3,playerCard: 6)] = Action.hit
                                strategy[CardCombo(dealerCard: 4,playerCard: 6)] = Action.hit
                                strategy[CardCombo(dealerCard: 5,playerCard: 6)] = Action.hit
                                strategy[CardCombo(dealerCard: 6,playerCard: 6)] = Action.hit
                                strategy[CardCombo(dealerCard: 7,playerCard: 6)] = Action.hit
                                strategy[CardCombo(dealerCard: 8,playerCard: 6)] = Action.hit
                                strategy[CardCombo(dealerCard: 9,playerCard: 6)] = Action.hit
                                strategy[CardCombo(dealerCard: 10,playerCard: 6)] = Action.hit
                                strategy[CardCombo(dealerCard: 11,playerCard: 6)] = Action.hit
                                
                                strategy[CardCombo(dealerCard: 2,playerCard: 7)] = Action.hit
                                strategy[CardCombo(dealerCard: 3,playerCard: 7)] = Action.hit
                                strategy[CardCombo(dealerCard: 4,playerCard: 7)] = Action.hit
                                strategy[CardCombo(dealerCard: 5,playerCard: 7)] = Action.hit
                                strategy[CardCombo(dealerCard: 6,playerCard: 7)] = Action.hit
                                strategy[CardCombo(dealerCard: 7,playerCard: 7)] = Action.hit
                                strategy[CardCombo(dealerCard: 8,playerCard: 7)] = Action.hit
                                strategy[CardCombo(dealerCard: 9,playerCard: 7)] = Action.hit
                                strategy[CardCombo(dealerCard: 10,playerCard: 7)] = Action.hit
                                strategy[CardCombo(dealerCard: 11,playerCard: 7)] = Action.hit
                                
                                strategy[CardCombo(dealerCard: 2,playerCard: 8)] = Action.hit
                                strategy[CardCombo(dealerCard: 3,playerCard: 8)] = Action.hit
                                strategy[CardCombo(dealerCard: 4,playerCard: 8)] = Action.hit
                                strategy[CardCombo(dealerCard: 5,playerCard: 8)] = Action.hit
                                strategy[CardCombo(dealerCard: 6,playerCard: 8)] = Action.hit
                                strategy[CardCombo(dealerCard: 7,playerCard: 8)] = Action.hit
                                strategy[CardCombo(dealerCard: 8,playerCard: 8)] = Action.hit
                                strategy[CardCombo(dealerCard: 9,playerCard: 8)] = Action.hit
                                strategy[CardCombo(dealerCard: 10,playerCard: 8)] = Action.hit
                                strategy[CardCombo(dealerCard: 11,playerCard: 8)] = Action.hit
                                
                                strategy[CardCombo(dealerCard: 2,playerCard: 9)] = Action.hit
                                strategy[CardCombo(dealerCard: 3,playerCard: 9)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 4,playerCard: 9)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 5,playerCard: 9)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 6,playerCard: 9)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 7,playerCard: 9)] = Action.hit
                                strategy[CardCombo(dealerCard: 8,playerCard: 9)] = Action.hit
                                strategy[CardCombo(dealerCard: 9,playerCard: 9)] = Action.hit
                                strategy[CardCombo(dealerCard: 10,playerCard: 9)] = Action.hit
                                strategy[CardCombo(dealerCard: 11,playerCard: 9)] = Action.hit
                                
                                strategy[CardCombo(dealerCard: 2,playerCard: 10)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 3,playerCard: 10)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 4,playerCard: 10)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 5,playerCard: 10)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 6,playerCard: 10)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 7,playerCard: 10)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 8,playerCard: 10)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 9,playerCard: 10)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 10,playerCard: 10)] = Action.hit
                                strategy[CardCombo(dealerCard: 11,playerCard: 10)] = Action.hit
                                
                                strategy[CardCombo(dealerCard: 2,playerCard: 11)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 3,playerCard: 11)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 4,playerCard: 11)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 5,playerCard: 11)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 6,playerCard: 11)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 7,playerCard: 11)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 8,playerCard: 11)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 9,playerCard: 11)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 10,playerCard: 11)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 11,playerCard: 11)] = Action.doubleOrHit
                                
                                strategy[CardCombo(dealerCard: 2,playerCard: 12)] = Action.hit
                                strategy[CardCombo(dealerCard: 3,playerCard: 12)] = Action.hit
                                strategy[CardCombo(dealerCard: 4,playerCard: 12)] = Action.stand
                                strategy[CardCombo(dealerCard: 5,playerCard: 12)] = Action.stand
                                strategy[CardCombo(dealerCard: 6,playerCard: 12)] = Action.stand
                                strategy[CardCombo(dealerCard: 7,playerCard: 12)] = Action.hit
                                strategy[CardCombo(dealerCard: 8,playerCard: 12)] = Action.hit
                                strategy[CardCombo(dealerCard: 9,playerCard: 12)] = Action.hit
                                strategy[CardCombo(dealerCard: 10,playerCard: 12)] = Action.hit
                                strategy[CardCombo(dealerCard: 11,playerCard: 12)] = Action.hit
                                
                                strategy[CardCombo(dealerCard: 2,playerCard: 13)] = Action.stand
                                strategy[CardCombo(dealerCard: 3,playerCard: 13)] = Action.stand
                                strategy[CardCombo(dealerCard: 4,playerCard: 13)] = Action.stand
                                strategy[CardCombo(dealerCard: 5,playerCard: 13)] = Action.stand
                                strategy[CardCombo(dealerCard: 6,playerCard: 13)] = Action.stand
                                strategy[CardCombo(dealerCard: 7,playerCard: 13)] = Action.hit
                                strategy[CardCombo(dealerCard: 8,playerCard: 13)] = Action.hit
                                strategy[CardCombo(dealerCard: 9,playerCard: 13)] = Action.hit
                                strategy[CardCombo(dealerCard: 10,playerCard: 13)] = Action.hit
                                strategy[CardCombo(dealerCard: 11,playerCard: 13)] = Action.hit
                                
                                strategy[CardCombo(dealerCard: 2,playerCard: 14)] = Action.stand
                                strategy[CardCombo(dealerCard: 3,playerCard: 14)] = Action.stand
                                strategy[CardCombo(dealerCard: 4,playerCard: 14)] = Action.stand
                                strategy[CardCombo(dealerCard: 5,playerCard: 14)] = Action.stand
                                strategy[CardCombo(dealerCard: 6,playerCard: 14)] = Action.stand
                                strategy[CardCombo(dealerCard: 7,playerCard: 14)] = Action.hit
                                strategy[CardCombo(dealerCard: 8,playerCard: 14)] = Action.hit
                                strategy[CardCombo(dealerCard: 9,playerCard: 14)] = Action.hit
                                strategy[CardCombo(dealerCard: 10,playerCard: 14)] = Action.hit
                                strategy[CardCombo(dealerCard: 11,playerCard: 14)] = Action.hit
                                
                                strategy[CardCombo(dealerCard: 2,playerCard: 15)] = Action.stand
                                strategy[CardCombo(dealerCard: 3,playerCard: 15)] = Action.stand
                                strategy[CardCombo(dealerCard: 4,playerCard: 15)] = Action.stand
                                strategy[CardCombo(dealerCard: 5,playerCard: 15)] = Action.stand
                                strategy[CardCombo(dealerCard: 6,playerCard: 15)] = Action.stand
                                strategy[CardCombo(dealerCard: 7,playerCard: 15)] = Action.hit
                                strategy[CardCombo(dealerCard: 8,playerCard: 15)] = Action.hit
                                strategy[CardCombo(dealerCard: 9,playerCard: 15)] = Action.hit
                                strategy[CardCombo(dealerCard: 10,playerCard: 15)] = Action.hit
                                strategy[CardCombo(dealerCard: 11,playerCard: 15)] = Action.hit
                                
                                strategy[CardCombo(dealerCard: 2,playerCard: 16)] = Action.stand
                                strategy[CardCombo(dealerCard: 3,playerCard: 16)] = Action.stand
                                strategy[CardCombo(dealerCard: 4,playerCard: 16)] = Action.stand
                                strategy[CardCombo(dealerCard: 5,playerCard: 16)] = Action.stand
                                strategy[CardCombo(dealerCard: 6,playerCard: 16)] = Action.stand
                                strategy[CardCombo(dealerCard: 7,playerCard: 16)] = Action.hit
                                strategy[CardCombo(dealerCard: 8,playerCard: 16)] = Action.hit
                                strategy[CardCombo(dealerCard: 9,playerCard: 16)] = Action.hit
                                strategy[CardCombo(dealerCard: 10,playerCard: 16)] = Action.hit
                                strategy[CardCombo(dealerCard: 11,playerCard: 16)] = Action.hit
                                
                                strategy[CardCombo(dealerCard: 2,playerCard: 17)] = Action.stand
                                strategy[CardCombo(dealerCard: 3,playerCard: 17)] = Action.stand
                                strategy[CardCombo(dealerCard: 4,playerCard: 17)] = Action.stand
                                strategy[CardCombo(dealerCard: 5,playerCard: 17)] = Action.stand
                                strategy[CardCombo(dealerCard: 6,playerCard: 17)] = Action.stand
                                strategy[CardCombo(dealerCard: 7,playerCard: 17)] = Action.stand
                                strategy[CardCombo(dealerCard: 8,playerCard: 17)] = Action.stand
                                strategy[CardCombo(dealerCard: 9,playerCard: 17)] = Action.stand
                                strategy[CardCombo(dealerCard: 10,playerCard: 17)] = Action.stand
                                strategy[CardCombo(dealerCard: 11,playerCard: 17)] = Action.stand
                                
                                strategy[CardCombo(dealerCard: 2,playerCard: 18)] = Action.stand
                                strategy[CardCombo(dealerCard: 3,playerCard: 18)] = Action.stand
                                strategy[CardCombo(dealerCard: 4,playerCard: 18)] = Action.stand
                                strategy[CardCombo(dealerCard: 5,playerCard: 18)] = Action.stand
                                strategy[CardCombo(dealerCard: 6,playerCard: 18)] = Action.stand
                                strategy[CardCombo(dealerCard: 7,playerCard: 18)] = Action.stand
                                strategy[CardCombo(dealerCard: 8,playerCard: 18)] = Action.stand
                                strategy[CardCombo(dealerCard: 9,playerCard: 18)] = Action.stand
                                strategy[CardCombo(dealerCard: 10,playerCard: 18)] = Action.stand
                                strategy[CardCombo(dealerCard: 11,playerCard: 18)] = Action.stand
                                
                                strategy[CardCombo(dealerCard: 2,playerCard: 19)] = Action.stand
                                strategy[CardCombo(dealerCard: 3,playerCard: 19)] = Action.stand
                                strategy[CardCombo(dealerCard: 4,playerCard: 19)] = Action.stand
                                strategy[CardCombo(dealerCard: 5,playerCard: 19)] = Action.stand
                                strategy[CardCombo(dealerCard: 6,playerCard: 19)] = Action.stand
                                strategy[CardCombo(dealerCard: 7,playerCard: 19)] = Action.stand
                                strategy[CardCombo(dealerCard: 8,playerCard: 19)] = Action.stand
                                strategy[CardCombo(dealerCard: 9,playerCard: 19)] = Action.stand
                                strategy[CardCombo(dealerCard: 10,playerCard: 19)] = Action.stand
                                strategy[CardCombo(dealerCard: 11,playerCard: 19)] = Action.stand
                                
                                strategy[CardCombo(dealerCard: 2,playerCard: 20)] = Action.stand
                                strategy[CardCombo(dealerCard: 3,playerCard: 20)] = Action.stand
                                strategy[CardCombo(dealerCard: 4,playerCard: 20)] = Action.stand
                                strategy[CardCombo(dealerCard: 5,playerCard: 20)] = Action.stand
                                strategy[CardCombo(dealerCard: 6,playerCard: 20)] = Action.stand
                                strategy[CardCombo(dealerCard: 7,playerCard: 20)] = Action.stand
                                strategy[CardCombo(dealerCard: 8,playerCard: 20)] = Action.stand
                                strategy[CardCombo(dealerCard: 9,playerCard: 20)] = Action.stand
                                strategy[CardCombo(dealerCard: 10,playerCard: 20)] = Action.stand
                                strategy[CardCombo(dealerCard: 11,playerCard: 20)] = Action.stand
                                
                                strategy[CardCombo(dealerCard: 2,playerCard: 21)] = Action.stand
                                strategy[CardCombo(dealerCard: 3,playerCard: 21)] = Action.stand
                                strategy[CardCombo(dealerCard: 4,playerCard: 21)] = Action.stand
                                strategy[CardCombo(dealerCard: 5,playerCard: 21)] = Action.stand
                                strategy[CardCombo(dealerCard: 6,playerCard: 21)] = Action.stand
                                strategy[CardCombo(dealerCard: 7,playerCard: 21)] = Action.stand
                                strategy[CardCombo(dealerCard: 8,playerCard: 21)] = Action.stand
                                strategy[CardCombo(dealerCard: 9,playerCard: 21)] = Action.stand
                                strategy[CardCombo(dealerCard: 10,playerCard: 21)] = Action.stand
                                strategy[CardCombo(dealerCard: 11,playerCard: 21)] = Action.stand
                                
                                if strategy[CardCombo(dealerCard: dealerTotal, playerCard: playerTotal)] != nil {
                                    return strategy[CardCombo(dealerCard: dealerTotal, playerCard: playerTotal)]!
                                } else {
                                    return .over
                                }
                                
                            }
                        }
                    } else
        
        
                        if decks == .one && soft17 == .dealerHits && doubleAfterSplit == .yesSplit && surrender == .surrenderNotAllowed && dealerPeek == .dealerPeaks {
                            
                            if myFirstCard == mySecondCard && myThirdCard == 0 && myFourthCard == 0 {
                                
                                strategy[CardCombo(dealerCard: 2,playerCard: 4)] = Action.split
                                strategy[CardCombo(dealerCard: 3,playerCard: 4)] = Action.split
                                strategy[CardCombo(dealerCard: 4,playerCard: 4)] = Action.split
                                strategy[CardCombo(dealerCard: 5,playerCard: 4)] = Action.split
                                strategy[CardCombo(dealerCard: 6,playerCard: 4)] = Action.split
                                strategy[CardCombo(dealerCard: 7,playerCard: 4)] = Action.split
                                strategy[CardCombo(dealerCard: 8,playerCard: 4)] = Action.hit
                                strategy[CardCombo(dealerCard: 9,playerCard: 4)] = Action.hit
                                strategy[CardCombo(dealerCard: 10,playerCard: 4)] = Action.hit
                                strategy[CardCombo(dealerCard: 11,playerCard: 4)] = Action.hit
                                
                                strategy[CardCombo(dealerCard: 2,playerCard: 6)] = Action.split
                                strategy[CardCombo(dealerCard: 3,playerCard: 6)] = Action.split
                                strategy[CardCombo(dealerCard: 4,playerCard: 6)] = Action.split
                                strategy[CardCombo(dealerCard: 5,playerCard: 6)] = Action.split
                                strategy[CardCombo(dealerCard: 6,playerCard: 6)] = Action.split
                                strategy[CardCombo(dealerCard: 7,playerCard: 6)] = Action.split
                                strategy[CardCombo(dealerCard: 8,playerCard: 6)] = Action.split
                                strategy[CardCombo(dealerCard: 9,playerCard: 6)] = Action.hit
                                strategy[CardCombo(dealerCard: 10,playerCard: 6)] = Action.hit
                                strategy[CardCombo(dealerCard: 11,playerCard: 6)] = Action.hit
                                
                                strategy[CardCombo(dealerCard: 2,playerCard: 8)] = Action.hit
                                strategy[CardCombo(dealerCard: 3,playerCard: 8)] = Action.hit
                                strategy[CardCombo(dealerCard: 4,playerCard: 8)] = Action.split
                                strategy[CardCombo(dealerCard: 5,playerCard: 8)] = Action.split
                                strategy[CardCombo(dealerCard: 6,playerCard: 8)] = Action.split
                                strategy[CardCombo(dealerCard: 7,playerCard: 8)] = Action.hit
                                strategy[CardCombo(dealerCard: 8,playerCard: 8)] = Action.hit
                                strategy[CardCombo(dealerCard: 9,playerCard: 8)] = Action.hit
                                strategy[CardCombo(dealerCard: 10,playerCard: 8)] = Action.hit
                                strategy[CardCombo(dealerCard: 11,playerCard: 8)] = Action.hit
                                
                                strategy[CardCombo(dealerCard: 2,playerCard: 10)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 3,playerCard: 10)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 4,playerCard: 10)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 5,playerCard: 10)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 6,playerCard: 10)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 7,playerCard: 10)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 8,playerCard: 10)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 9,playerCard: 10)] = Action.doubleOrHit
                                strategy[CardCombo(dealerCard: 10,playerCard: 10)] = Action.hit
                                strategy[CardCombo(dealerCard: 11,playerCard: 10)] = Action.hit
                                
                                strategy[CardCombo(dealerCard: 2,playerCard: 12)] = Action.split
                                strategy[CardCombo(dealerCard: 3,playerCard: 12)] = Action.split
                                strategy[CardCombo(dealerCard: 4,playerCard: 12)] = Action.split
                                strategy[CardCombo(dealerCard: 5,playerCard: 12)] = Action.split
                                strategy[CardCombo(dealerCard: 6,playerCard: 12)] = Action.split
                                strategy[CardCombo(dealerCard: 7,playerCard: 12)] = Action.split
                                strategy[CardCombo(dealerCard: 8,playerCard: 12)] = Action.hit
                                strategy[CardCombo(dealerCard: 9,playerCard: 12)] = Action.hit
                                strategy[CardCombo(dealerCard: 10,playerCard: 12)] = Action.hit
                                strategy[CardCombo(dealerCard: 11,playerCard: 12)] = Action.hit
                                
                                strategy[CardCombo(dealerCard: 2,playerCard: 14)] = Action.split
                                strategy[CardCombo(dealerCard: 3,playerCard: 14)] = Action.split
                                strategy[CardCombo(dealerCard: 4,playerCard: 14)] = Action.split
                                strategy[CardCombo(dealerCard: 5,playerCard: 14)] = Action.split
                                strategy[CardCombo(dealerCard: 6,playerCard: 14)] = Action.split
                                strategy[CardCombo(dealerCard: 7,playerCard: 14)] = Action.split
                                strategy[CardCombo(dealerCard: 8,playerCard: 14)] = Action.split
                                strategy[CardCombo(dealerCard: 9,playerCard: 14)] = Action.hit
                                strategy[CardCombo(dealerCard: 10,playerCard: 14)] = Action.stand
                                strategy[CardCombo(dealerCard: 11,playerCard: 14)] = Action.hit
                                
                                strategy[CardCombo(dealerCard: 2,playerCard: 16)] = Action.split
                                strategy[CardCombo(dealerCard: 3,playerCard: 16)] = Action.split
                                strategy[CardCombo(dealerCard: 4,playerCard: 16)] = Action.split
                                strategy[CardCombo(dealerCard: 5,playerCard: 16)] = Action.split
                                strategy[CardCombo(dealerCard: 6,playerCard: 16)] = Action.split
                                strategy[CardCombo(dealerCard: 7,playerCard: 16)] = Action.split
                                strategy[CardCombo(dealerCard: 8,playerCard: 16)] = Action.split
                                strategy[CardCombo(dealerCard: 9,playerCard: 16)] = Action.split
                                strategy[CardCombo(dealerCard: 10,playerCard: 16)] = Action.split
                                strategy[CardCombo(dealerCard: 11,playerCard: 16)] = Action.split
                                
                                strategy[CardCombo(dealerCard: 2,playerCard: 18)] = Action.split
                                strategy[CardCombo(dealerCard: 3,playerCard: 18)] = Action.split
                                strategy[CardCombo(dealerCard: 4,playerCard: 18)] = Action.split
                                strategy[CardCombo(dealerCard: 5,playerCard: 18)] = Action.split
                                strategy[CardCombo(dealerCard: 6,playerCard: 18)] = Action.split
                                strategy[CardCombo(dealerCard: 7,playerCard: 18)] = Action.stand
                                strategy[CardCombo(dealerCard: 8,playerCard: 18)] = Action.split
                                strategy[CardCombo(dealerCard: 9,playerCard: 18)] = Action.split
                                strategy[CardCombo(dealerCard: 10,playerCard: 18)] = Action.stand
                                strategy[CardCombo(dealerCard: 11,playerCard: 18)] = Action.split
                                
                                strategy[CardCombo(dealerCard: 2,playerCard: 20)] = Action.stand
                                strategy[CardCombo(dealerCard: 3,playerCard: 20)] = Action.stand
                                strategy[CardCombo(dealerCard: 4,playerCard: 20)] = Action.stand
                                strategy[CardCombo(dealerCard: 5,playerCard: 20)] = Action.stand
                                strategy[CardCombo(dealerCard: 6,playerCard: 20)] = Action.stand
                                strategy[CardCombo(dealerCard: 7,playerCard: 20)] = Action.stand
                                strategy[CardCombo(dealerCard: 8,playerCard: 20)] = Action.stand
                                strategy[CardCombo(dealerCard: 9,playerCard: 20)] = Action.stand
                                strategy[CardCombo(dealerCard: 10,playerCard: 20)] = Action.stand
                                strategy[CardCombo(dealerCard: 11,playerCard: 20)] = Action.stand
                                
                                strategy[CardCombo(dealerCard: 2,playerCard: 22)] = Action.split
                                strategy[CardCombo(dealerCard: 3,playerCard: 22)] = Action.split
                                strategy[CardCombo(dealerCard: 4,playerCard: 22)] = Action.split
                                strategy[CardCombo(dealerCard: 5,playerCard: 22)] = Action.split
                                strategy[CardCombo(dealerCard: 6,playerCard: 22)] = Action.split
                                strategy[CardCombo(dealerCard: 7,playerCard: 22)] = Action.split
                                strategy[CardCombo(dealerCard: 8,playerCard: 22)] = Action.split
                                strategy[CardCombo(dealerCard: 9,playerCard: 22)] = Action.split
                                strategy[CardCombo(dealerCard: 10,playerCard: 22)] = Action.split
                                strategy[CardCombo(dealerCard: 11,playerCard: 22)] = Action.split
                                
                                if strategy[CardCombo(dealerCard: dealerTotal, playerCard: playerTotal)] != nil {
                                    return strategy[CardCombo(dealerCard: dealerTotal, playerCard: playerTotal)]!
                                } else {
                                    return .over
                                }
                                
                            } else {
                                
                                if myFirstCard == 11 || mySecondCard == 11 || myThirdCard == 11 || myFourthCard == 11 {
                                    
                                    strategy[CardCombo(dealerCard: 2,playerCard: 13)] = Action.hit
                                    strategy[CardCombo(dealerCard: 3,playerCard: 13)] = Action.hit
                                    strategy[CardCombo(dealerCard: 4,playerCard: 13)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 5,playerCard: 13)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 6,playerCard: 13)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 7,playerCard: 13)] = Action.hit
                                    strategy[CardCombo(dealerCard: 8,playerCard: 13)] = Action.hit
                                    strategy[CardCombo(dealerCard: 9,playerCard: 13)] = Action.hit
                                    strategy[CardCombo(dealerCard: 10,playerCard: 13)] = Action.hit
                                    strategy[CardCombo(dealerCard: 11,playerCard: 13)] = Action.hit
                                    
                                    strategy[CardCombo(dealerCard: 2,playerCard: 14)] = Action.hit
                                    strategy[CardCombo(dealerCard: 3,playerCard: 14)] = Action.hit
                                    strategy[CardCombo(dealerCard: 4,playerCard: 14)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 5,playerCard: 14)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 6,playerCard: 14)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 7,playerCard: 14)] = Action.hit
                                    strategy[CardCombo(dealerCard: 8,playerCard: 14)] = Action.hit
                                    strategy[CardCombo(dealerCard: 9,playerCard: 14)] = Action.hit
                                    strategy[CardCombo(dealerCard: 10,playerCard: 14)] = Action.hit
                                    strategy[CardCombo(dealerCard: 11,playerCard: 14)] = Action.hit
                                    
                                    strategy[CardCombo(dealerCard: 2,playerCard: 15)] = Action.hit
                                    strategy[CardCombo(dealerCard: 3,playerCard: 15)] = Action.hit
                                    strategy[CardCombo(dealerCard: 4,playerCard: 15)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 5,playerCard: 15)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 6,playerCard: 15)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 7,playerCard: 15)] = Action.hit
                                    strategy[CardCombo(dealerCard: 8,playerCard: 15)] = Action.hit
                                    strategy[CardCombo(dealerCard: 9,playerCard: 15)] = Action.hit
                                    strategy[CardCombo(dealerCard: 10,playerCard: 15)] = Action.hit
                                    strategy[CardCombo(dealerCard: 11,playerCard: 15)] = Action.hit
                                    
                                    strategy[CardCombo(dealerCard: 2,playerCard: 16)] = Action.hit
                                    strategy[CardCombo(dealerCard: 3,playerCard: 16)] = Action.hit
                                    strategy[CardCombo(dealerCard: 4,playerCard: 16)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 5,playerCard: 16)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 6,playerCard: 16)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 7,playerCard: 16)] = Action.hit
                                    strategy[CardCombo(dealerCard: 8,playerCard: 16)] = Action.hit
                                    strategy[CardCombo(dealerCard: 9,playerCard: 16)] = Action.hit
                                    strategy[CardCombo(dealerCard: 10,playerCard: 16)] = Action.hit
                                    strategy[CardCombo(dealerCard: 11,playerCard: 16)] = Action.hit
                                    
                                    strategy[CardCombo(dealerCard: 2,playerCard: 17)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 3,playerCard: 17)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 4,playerCard: 17)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 5,playerCard: 17)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 6,playerCard: 17)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 7,playerCard: 17)] = Action.hit
                                    strategy[CardCombo(dealerCard: 8,playerCard: 17)] = Action.hit
                                    strategy[CardCombo(dealerCard: 9,playerCard: 17)] = Action.hit
                                    strategy[CardCombo(dealerCard: 10,playerCard: 17)] = Action.hit
                                    strategy[CardCombo(dealerCard: 11,playerCard: 17)] = Action.hit
                                    
                                    strategy[CardCombo(dealerCard: 2,playerCard: 18)] = Action.stand
                                    strategy[CardCombo(dealerCard: 3,playerCard: 18)] = Action.doubleOrStand
                                    strategy[CardCombo(dealerCard: 4,playerCard: 18)] = Action.doubleOrStand
                                    strategy[CardCombo(dealerCard: 5,playerCard: 18)] = Action.doubleOrStand
                                    strategy[CardCombo(dealerCard: 6,playerCard: 18)] = Action.doubleOrStand
                                    strategy[CardCombo(dealerCard: 7,playerCard: 18)] = Action.stand
                                    strategy[CardCombo(dealerCard: 8,playerCard: 18)] = Action.stand
                                    strategy[CardCombo(dealerCard: 9,playerCard: 18)] = Action.hit
                                    strategy[CardCombo(dealerCard: 10,playerCard: 18)] = Action.hit
                                    strategy[CardCombo(dealerCard: 11,playerCard: 18)] = Action.hit
                                    
                                    strategy[CardCombo(dealerCard: 2,playerCard: 19)] = Action.stand
                                    strategy[CardCombo(dealerCard: 3,playerCard: 19)] = Action.stand
                                    strategy[CardCombo(dealerCard: 4,playerCard: 19)] = Action.stand
                                    strategy[CardCombo(dealerCard: 5,playerCard: 19)] = Action.stand
                                    strategy[CardCombo(dealerCard: 6,playerCard: 19)] = Action.doubleOrStand
                                    strategy[CardCombo(dealerCard: 7,playerCard: 19)] = Action.stand
                                    strategy[CardCombo(dealerCard: 8,playerCard: 19)] = Action.stand
                                    strategy[CardCombo(dealerCard: 9,playerCard: 19)] = Action.stand
                                    strategy[CardCombo(dealerCard: 10,playerCard: 19)] = Action.stand
                                    strategy[CardCombo(dealerCard: 11,playerCard: 19)] = Action.stand
                                    
                                    strategy[CardCombo(dealerCard: 2,playerCard: 20)] = Action.stand
                                    strategy[CardCombo(dealerCard: 3,playerCard: 20)] = Action.stand
                                    strategy[CardCombo(dealerCard: 4,playerCard: 20)] = Action.stand
                                    strategy[CardCombo(dealerCard: 5,playerCard: 20)] = Action.stand
                                    strategy[CardCombo(dealerCard: 6,playerCard: 20)] = Action.stand
                                    strategy[CardCombo(dealerCard: 7,playerCard: 20)] = Action.stand
                                    strategy[CardCombo(dealerCard: 8,playerCard: 20)] = Action.stand
                                    strategy[CardCombo(dealerCard: 9,playerCard: 20)] = Action.stand
                                    strategy[CardCombo(dealerCard: 10,playerCard: 20)] = Action.stand
                                    strategy[CardCombo(dealerCard: 11,playerCard: 20)] = Action.stand
                                    
                                    strategy[CardCombo(dealerCard: 2,playerCard: 21)] = Action.stand
                                    strategy[CardCombo(dealerCard: 3,playerCard: 21)] = Action.stand
                                    strategy[CardCombo(dealerCard: 4,playerCard: 21)] = Action.stand
                                    strategy[CardCombo(dealerCard: 5,playerCard: 21)] = Action.stand
                                    strategy[CardCombo(dealerCard: 6,playerCard: 21)] = Action.stand
                                    strategy[CardCombo(dealerCard: 7,playerCard: 21)] = Action.stand
                                    strategy[CardCombo(dealerCard: 8,playerCard: 21)] = Action.stand
                                    strategy[CardCombo(dealerCard: 9,playerCard: 21)] = Action.stand
                                    strategy[CardCombo(dealerCard: 10,playerCard: 21)] = Action.stand
                                    strategy[CardCombo(dealerCard: 11,playerCard: 21)] = Action.stand
                                    
                                    if strategy[CardCombo(dealerCard: dealerTotal, playerCard: playerTotalWithAces!)] != nil {
                                        return strategy[CardCombo(dealerCard: dealerTotal, playerCard: playerTotalWithAces!)]!
                                    } else {
                                        return .over
                                    }
                                    
                                } else {
                                    
                                    strategy[CardCombo(dealerCard: 2,playerCard: 5)] = Action.hit
                                    strategy[CardCombo(dealerCard: 3,playerCard: 5)] = Action.hit
                                    strategy[CardCombo(dealerCard: 4,playerCard: 5)] = Action.hit
                                    strategy[CardCombo(dealerCard: 5,playerCard: 5)] = Action.hit
                                    strategy[CardCombo(dealerCard: 6,playerCard: 5)] = Action.hit
                                    strategy[CardCombo(dealerCard: 7,playerCard: 5)] = Action.hit
                                    strategy[CardCombo(dealerCard: 8,playerCard: 5)] = Action.hit
                                    strategy[CardCombo(dealerCard: 9,playerCard: 5)] = Action.hit
                                    strategy[CardCombo(dealerCard: 10,playerCard: 5)] = Action.hit
                                    strategy[CardCombo(dealerCard: 11,playerCard: 5)] = Action.hit
                                    
                                    strategy[CardCombo(dealerCard: 2,playerCard: 6)] = Action.hit
                                    strategy[CardCombo(dealerCard: 3,playerCard: 6)] = Action.hit
                                    strategy[CardCombo(dealerCard: 4,playerCard: 6)] = Action.hit
                                    strategy[CardCombo(dealerCard: 5,playerCard: 6)] = Action.hit
                                    strategy[CardCombo(dealerCard: 6,playerCard: 6)] = Action.hit
                                    strategy[CardCombo(dealerCard: 7,playerCard: 6)] = Action.hit
                                    strategy[CardCombo(dealerCard: 8,playerCard: 6)] = Action.hit
                                    strategy[CardCombo(dealerCard: 9,playerCard: 6)] = Action.hit
                                    strategy[CardCombo(dealerCard: 10,playerCard: 6)] = Action.hit
                                    strategy[CardCombo(dealerCard: 11,playerCard: 6)] = Action.hit
                                    
                                    strategy[CardCombo(dealerCard: 2,playerCard: 7)] = Action.hit
                                    strategy[CardCombo(dealerCard: 3,playerCard: 7)] = Action.hit
                                    strategy[CardCombo(dealerCard: 4,playerCard: 7)] = Action.hit
                                    strategy[CardCombo(dealerCard: 5,playerCard: 7)] = Action.hit
                                    strategy[CardCombo(dealerCard: 6,playerCard: 7)] = Action.hit
                                    strategy[CardCombo(dealerCard: 7,playerCard: 7)] = Action.hit
                                    strategy[CardCombo(dealerCard: 8,playerCard: 7)] = Action.hit
                                    strategy[CardCombo(dealerCard: 9,playerCard: 7)] = Action.hit
                                    strategy[CardCombo(dealerCard: 10,playerCard: 7)] = Action.hit
                                    strategy[CardCombo(dealerCard: 11,playerCard: 7)] = Action.hit
                                    
                                    strategy[CardCombo(dealerCard: 2,playerCard: 8)] = Action.hit
                                    strategy[CardCombo(dealerCard: 3,playerCard: 8)] = Action.hit
                                    strategy[CardCombo(dealerCard: 4,playerCard: 8)] = Action.hit
                                    strategy[CardCombo(dealerCard: 5,playerCard: 8)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 6,playerCard: 8)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 7,playerCard: 8)] = Action.hit
                                    strategy[CardCombo(dealerCard: 8,playerCard: 8)] = Action.hit
                                    strategy[CardCombo(dealerCard: 9,playerCard: 8)] = Action.hit
                                    strategy[CardCombo(dealerCard: 10,playerCard: 8)] = Action.hit
                                    strategy[CardCombo(dealerCard: 11,playerCard: 8)] = Action.hit
                                    
                                    strategy[CardCombo(dealerCard: 2,playerCard: 9)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 3,playerCard: 9)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 4,playerCard: 9)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 5,playerCard: 9)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 6,playerCard: 9)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 7,playerCard: 9)] = Action.hit
                                    strategy[CardCombo(dealerCard: 8,playerCard: 9)] = Action.hit
                                    strategy[CardCombo(dealerCard: 9,playerCard: 9)] = Action.hit
                                    strategy[CardCombo(dealerCard: 10,playerCard: 9)] = Action.hit
                                    strategy[CardCombo(dealerCard: 11,playerCard: 9)] = Action.hit
                                    
                                    strategy[CardCombo(dealerCard: 2,playerCard: 10)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 3,playerCard: 10)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 4,playerCard: 10)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 5,playerCard: 10)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 6,playerCard: 10)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 7,playerCard: 10)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 8,playerCard: 10)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 9,playerCard: 10)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 10,playerCard: 10)] = Action.hit
                                    strategy[CardCombo(dealerCard: 11,playerCard: 10)] = Action.hit
                                    
                                    strategy[CardCombo(dealerCard: 2,playerCard: 11)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 3,playerCard: 11)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 4,playerCard: 11)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 5,playerCard: 11)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 6,playerCard: 11)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 7,playerCard: 11)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 8,playerCard: 11)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 9,playerCard: 11)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 10,playerCard: 11)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 11,playerCard: 11)] = Action.doubleOrHit
                                    
                                    strategy[CardCombo(dealerCard: 2,playerCard: 12)] = Action.hit
                                    strategy[CardCombo(dealerCard: 3,playerCard: 12)] = Action.hit
                                    strategy[CardCombo(dealerCard: 4,playerCard: 12)] = Action.stand
                                    strategy[CardCombo(dealerCard: 5,playerCard: 12)] = Action.stand
                                    strategy[CardCombo(dealerCard: 6,playerCard: 12)] = Action.stand
                                    strategy[CardCombo(dealerCard: 7,playerCard: 12)] = Action.hit
                                    strategy[CardCombo(dealerCard: 8,playerCard: 12)] = Action.hit
                                    strategy[CardCombo(dealerCard: 9,playerCard: 12)] = Action.hit
                                    strategy[CardCombo(dealerCard: 10,playerCard: 12)] = Action.hit
                                    strategy[CardCombo(dealerCard: 11,playerCard: 12)] = Action.hit
                                    
                                    strategy[CardCombo(dealerCard: 2,playerCard: 13)] = Action.stand
                                    strategy[CardCombo(dealerCard: 3,playerCard: 13)] = Action.stand
                                    strategy[CardCombo(dealerCard: 4,playerCard: 13)] = Action.stand
                                    strategy[CardCombo(dealerCard: 5,playerCard: 13)] = Action.stand
                                    strategy[CardCombo(dealerCard: 6,playerCard: 13)] = Action.stand
                                    strategy[CardCombo(dealerCard: 7,playerCard: 13)] = Action.hit
                                    strategy[CardCombo(dealerCard: 8,playerCard: 13)] = Action.hit
                                    strategy[CardCombo(dealerCard: 9,playerCard: 13)] = Action.hit
                                    strategy[CardCombo(dealerCard: 10,playerCard: 13)] = Action.hit
                                    strategy[CardCombo(dealerCard: 11,playerCard: 13)] = Action.hit
                                    
                                    strategy[CardCombo(dealerCard: 2,playerCard: 14)] = Action.stand
                                    strategy[CardCombo(dealerCard: 3,playerCard: 14)] = Action.stand
                                    strategy[CardCombo(dealerCard: 4,playerCard: 14)] = Action.stand
                                    strategy[CardCombo(dealerCard: 5,playerCard: 14)] = Action.stand
                                    strategy[CardCombo(dealerCard: 6,playerCard: 14)] = Action.stand
                                    strategy[CardCombo(dealerCard: 7,playerCard: 14)] = Action.hit
                                    strategy[CardCombo(dealerCard: 8,playerCard: 14)] = Action.hit
                                    strategy[CardCombo(dealerCard: 9,playerCard: 14)] = Action.hit
                                    strategy[CardCombo(dealerCard: 10,playerCard: 14)] = Action.hit
                                    strategy[CardCombo(dealerCard: 11,playerCard: 14)] = Action.hit
                                    
                                    strategy[CardCombo(dealerCard: 2,playerCard: 15)] = Action.stand
                                    strategy[CardCombo(dealerCard: 3,playerCard: 15)] = Action.stand
                                    strategy[CardCombo(dealerCard: 4,playerCard: 15)] = Action.stand
                                    strategy[CardCombo(dealerCard: 5,playerCard: 15)] = Action.stand
                                    strategy[CardCombo(dealerCard: 6,playerCard: 15)] = Action.stand
                                    strategy[CardCombo(dealerCard: 7,playerCard: 15)] = Action.hit
                                    strategy[CardCombo(dealerCard: 8,playerCard: 15)] = Action.hit
                                    strategy[CardCombo(dealerCard: 9,playerCard: 15)] = Action.hit
                                    strategy[CardCombo(dealerCard: 10,playerCard: 15)] = Action.hit
                                    strategy[CardCombo(dealerCard: 11,playerCard: 15)] = Action.hit
                                    
                                    strategy[CardCombo(dealerCard: 2,playerCard: 16)] = Action.stand
                                    strategy[CardCombo(dealerCard: 3,playerCard: 16)] = Action.stand
                                    strategy[CardCombo(dealerCard: 4,playerCard: 16)] = Action.stand
                                    strategy[CardCombo(dealerCard: 5,playerCard: 16)] = Action.stand
                                    strategy[CardCombo(dealerCard: 6,playerCard: 16)] = Action.stand
                                    strategy[CardCombo(dealerCard: 7,playerCard: 16)] = Action.hit
                                    strategy[CardCombo(dealerCard: 8,playerCard: 16)] = Action.hit
                                    strategy[CardCombo(dealerCard: 9,playerCard: 16)] = Action.hit
                                    strategy[CardCombo(dealerCard: 10,playerCard: 16)] = Action.hit
                                    strategy[CardCombo(dealerCard: 11,playerCard: 16)] = Action.hit
                                    
                                    strategy[CardCombo(dealerCard: 2,playerCard: 17)] = Action.stand
                                    strategy[CardCombo(dealerCard: 3,playerCard: 17)] = Action.stand
                                    strategy[CardCombo(dealerCard: 4,playerCard: 17)] = Action.stand
                                    strategy[CardCombo(dealerCard: 5,playerCard: 17)] = Action.stand
                                    strategy[CardCombo(dealerCard: 6,playerCard: 17)] = Action.stand
                                    strategy[CardCombo(dealerCard: 7,playerCard: 17)] = Action.stand
                                    strategy[CardCombo(dealerCard: 8,playerCard: 17)] = Action.stand
                                    strategy[CardCombo(dealerCard: 9,playerCard: 17)] = Action.stand
                                    strategy[CardCombo(dealerCard: 10,playerCard: 17)] = Action.stand
                                    strategy[CardCombo(dealerCard: 11,playerCard: 17)] = Action.stand
                                    
                                    strategy[CardCombo(dealerCard: 2,playerCard: 18)] = Action.stand
                                    strategy[CardCombo(dealerCard: 3,playerCard: 18)] = Action.stand
                                    strategy[CardCombo(dealerCard: 4,playerCard: 18)] = Action.stand
                                    strategy[CardCombo(dealerCard: 5,playerCard: 18)] = Action.stand
                                    strategy[CardCombo(dealerCard: 6,playerCard: 18)] = Action.stand
                                    strategy[CardCombo(dealerCard: 7,playerCard: 18)] = Action.stand
                                    strategy[CardCombo(dealerCard: 8,playerCard: 18)] = Action.stand
                                    strategy[CardCombo(dealerCard: 9,playerCard: 18)] = Action.stand
                                    strategy[CardCombo(dealerCard: 10,playerCard: 18)] = Action.stand
                                    strategy[CardCombo(dealerCard: 11,playerCard: 18)] = Action.stand
                                    
                                    strategy[CardCombo(dealerCard: 2,playerCard: 19)] = Action.stand
                                    strategy[CardCombo(dealerCard: 3,playerCard: 19)] = Action.stand
                                    strategy[CardCombo(dealerCard: 4,playerCard: 19)] = Action.stand
                                    strategy[CardCombo(dealerCard: 5,playerCard: 19)] = Action.stand
                                    strategy[CardCombo(dealerCard: 6,playerCard: 19)] = Action.stand
                                    strategy[CardCombo(dealerCard: 7,playerCard: 19)] = Action.stand
                                    strategy[CardCombo(dealerCard: 8,playerCard: 19)] = Action.stand
                                    strategy[CardCombo(dealerCard: 9,playerCard: 19)] = Action.stand
                                    strategy[CardCombo(dealerCard: 10,playerCard: 19)] = Action.stand
                                    strategy[CardCombo(dealerCard: 11,playerCard: 19)] = Action.stand
                                    
                                    strategy[CardCombo(dealerCard: 2,playerCard: 20)] = Action.stand
                                    strategy[CardCombo(dealerCard: 3,playerCard: 20)] = Action.stand
                                    strategy[CardCombo(dealerCard: 4,playerCard: 20)] = Action.stand
                                    strategy[CardCombo(dealerCard: 5,playerCard: 20)] = Action.stand
                                    strategy[CardCombo(dealerCard: 6,playerCard: 20)] = Action.stand
                                    strategy[CardCombo(dealerCard: 7,playerCard: 20)] = Action.stand
                                    strategy[CardCombo(dealerCard: 8,playerCard: 20)] = Action.stand
                                    strategy[CardCombo(dealerCard: 9,playerCard: 20)] = Action.stand
                                    strategy[CardCombo(dealerCard: 10,playerCard: 20)] = Action.stand
                                    strategy[CardCombo(dealerCard: 11,playerCard: 20)] = Action.stand
                                    
                                    strategy[CardCombo(dealerCard: 2,playerCard: 21)] = Action.stand
                                    strategy[CardCombo(dealerCard: 3,playerCard: 21)] = Action.stand
                                    strategy[CardCombo(dealerCard: 4,playerCard: 21)] = Action.stand
                                    strategy[CardCombo(dealerCard: 5,playerCard: 21)] = Action.stand
                                    strategy[CardCombo(dealerCard: 6,playerCard: 21)] = Action.stand
                                    strategy[CardCombo(dealerCard: 7,playerCard: 21)] = Action.stand
                                    strategy[CardCombo(dealerCard: 8,playerCard: 21)] = Action.stand
                                    strategy[CardCombo(dealerCard: 9,playerCard: 21)] = Action.stand
                                    strategy[CardCombo(dealerCard: 10,playerCard: 21)] = Action.stand
                                    strategy[CardCombo(dealerCard: 11,playerCard: 21)] = Action.stand
                                    
                                    if strategy[CardCombo(dealerCard: dealerTotal, playerCard: playerTotal)] != nil {
                                        return strategy[CardCombo(dealerCard: dealerTotal, playerCard: playerTotal)]!
                                    } else {
                                        return .over
                                    }
                                    
                                }
                            }
                        } else
        
        
        
        
                            if decks == .two && soft17 == .dealerStands && doubleAfterSplit == .yesSplit && surrender == .surrenderNotAllowed && dealerPeek == .dealerPeaks {
                                
                                if myFirstCard == mySecondCard && myThirdCard == 0 && myFourthCard == 0 {
                                    
                                    strategy[CardCombo(dealerCard: 2,playerCard: 4)] = Action.split
                                    strategy[CardCombo(dealerCard: 3,playerCard: 4)] = Action.split
                                    strategy[CardCombo(dealerCard: 4,playerCard: 4)] = Action.split
                                    strategy[CardCombo(dealerCard: 5,playerCard: 4)] = Action.split
                                    strategy[CardCombo(dealerCard: 6,playerCard: 4)] = Action.split
                                    strategy[CardCombo(dealerCard: 7,playerCard: 4)] = Action.split
                                    strategy[CardCombo(dealerCard: 8,playerCard: 4)] = Action.hit
                                    strategy[CardCombo(dealerCard: 9,playerCard: 4)] = Action.hit
                                    strategy[CardCombo(dealerCard: 10,playerCard: 4)] = Action.hit
                                    strategy[CardCombo(dealerCard: 11,playerCard: 4)] = Action.hit
                                    
                                    strategy[CardCombo(dealerCard: 2,playerCard: 6)] = Action.split
                                    strategy[CardCombo(dealerCard: 3,playerCard: 6)] = Action.split
                                    strategy[CardCombo(dealerCard: 4,playerCard: 6)] = Action.split
                                    strategy[CardCombo(dealerCard: 5,playerCard: 6)] = Action.split
                                    strategy[CardCombo(dealerCard: 6,playerCard: 6)] = Action.split
                                    strategy[CardCombo(dealerCard: 7,playerCard: 6)] = Action.split
                                    strategy[CardCombo(dealerCard: 8,playerCard: 6)] = Action.hit
                                    strategy[CardCombo(dealerCard: 9,playerCard: 6)] = Action.hit
                                    strategy[CardCombo(dealerCard: 10,playerCard: 6)] = Action.hit
                                    strategy[CardCombo(dealerCard: 11,playerCard: 6)] = Action.hit
                                    
                                    strategy[CardCombo(dealerCard: 2,playerCard: 8)] = Action.hit
                                    strategy[CardCombo(dealerCard: 3,playerCard: 8)] = Action.hit
                                    strategy[CardCombo(dealerCard: 4,playerCard: 8)] = Action.hit
                                    strategy[CardCombo(dealerCard: 5,playerCard: 8)] = Action.split
                                    strategy[CardCombo(dealerCard: 6,playerCard: 8)] = Action.split
                                    strategy[CardCombo(dealerCard: 7,playerCard: 8)] = Action.hit
                                    strategy[CardCombo(dealerCard: 8,playerCard: 8)] = Action.hit
                                    strategy[CardCombo(dealerCard: 9,playerCard: 8)] = Action.hit
                                    strategy[CardCombo(dealerCard: 10,playerCard: 8)] = Action.hit
                                    strategy[CardCombo(dealerCard: 11,playerCard: 8)] = Action.hit
                                    
                                    strategy[CardCombo(dealerCard: 2,playerCard: 10)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 3,playerCard: 10)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 4,playerCard: 10)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 5,playerCard: 10)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 6,playerCard: 10)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 7,playerCard: 10)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 8,playerCard: 10)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 9,playerCard: 10)] = Action.doubleOrHit
                                    strategy[CardCombo(dealerCard: 10,playerCard: 10)] = Action.hit
                                    strategy[CardCombo(dealerCard: 11,playerCard: 10)] = Action.hit
                                    
                                    strategy[CardCombo(dealerCard: 2,playerCard: 12)] = Action.split
                                    strategy[CardCombo(dealerCard: 3,playerCard: 12)] = Action.split
                                    strategy[CardCombo(dealerCard: 4,playerCard: 12)] = Action.split
                                    strategy[CardCombo(dealerCard: 5,playerCard: 12)] = Action.split
                                    strategy[CardCombo(dealerCard: 6,playerCard: 12)] = Action.split
                                    strategy[CardCombo(dealerCard: 7,playerCard: 12)] = Action.split
                                    strategy[CardCombo(dealerCard: 8,playerCard: 12)] = Action.hit
                                    strategy[CardCombo(dealerCard: 9,playerCard: 12)] = Action.hit
                                    strategy[CardCombo(dealerCard: 10,playerCard: 12)] = Action.hit
                                    strategy[CardCombo(dealerCard: 11,playerCard: 12)] = Action.hit
                                    
                                    strategy[CardCombo(dealerCard: 2,playerCard: 14)] = Action.split
                                    strategy[CardCombo(dealerCard: 3,playerCard: 14)] = Action.split
                                    strategy[CardCombo(dealerCard: 4,playerCard: 14)] = Action.split
                                    strategy[CardCombo(dealerCard: 5,playerCard: 14)] = Action.split
                                    strategy[CardCombo(dealerCard: 6,playerCard: 14)] = Action.split
                                    strategy[CardCombo(dealerCard: 7,playerCard: 14)] = Action.split
                                    strategy[CardCombo(dealerCard: 8,playerCard: 14)] = Action.split
                                    strategy[CardCombo(dealerCard: 9,playerCard: 14)] = Action.hit
                                    strategy[CardCombo(dealerCard: 10,playerCard: 14)] = Action.hit
                                    strategy[CardCombo(dealerCard: 11,playerCard: 14)] = Action.hit
                                    
                                    strategy[CardCombo(dealerCard: 2,playerCard: 16)] = Action.split
                                    strategy[CardCombo(dealerCard: 3,playerCard: 16)] = Action.split
                                    strategy[CardCombo(dealerCard: 4,playerCard: 16)] = Action.split
                                    strategy[CardCombo(dealerCard: 5,playerCard: 16)] = Action.split
                                    strategy[CardCombo(dealerCard: 6,playerCard: 16)] = Action.split
                                    strategy[CardCombo(dealerCard: 7,playerCard: 16)] = Action.split
                                    strategy[CardCombo(dealerCard: 8,playerCard: 16)] = Action.split
                                    strategy[CardCombo(dealerCard: 9,playerCard: 16)] = Action.split
                                    strategy[CardCombo(dealerCard: 10,playerCard: 16)] = Action.split
                                    strategy[CardCombo(dealerCard: 11,playerCard: 16)] = Action.split
                                    
                                    strategy[CardCombo(dealerCard: 2,playerCard: 18)] = Action.split
                                    strategy[CardCombo(dealerCard: 3,playerCard: 18)] = Action.split
                                    strategy[CardCombo(dealerCard: 4,playerCard: 18)] = Action.split
                                    strategy[CardCombo(dealerCard: 5,playerCard: 18)] = Action.split
                                    strategy[CardCombo(dealerCard: 6,playerCard: 18)] = Action.split
                                    strategy[CardCombo(dealerCard: 7,playerCard: 18)] = Action.stand
                                    strategy[CardCombo(dealerCard: 8,playerCard: 18)] = Action.split
                                    strategy[CardCombo(dealerCard: 9,playerCard: 18)] = Action.split
                                    strategy[CardCombo(dealerCard: 10,playerCard: 18)] = Action.stand
                                    strategy[CardCombo(dealerCard: 11,playerCard: 18)] = Action.stand
                                    
                                    strategy[CardCombo(dealerCard: 2,playerCard: 20)] = Action.stand
                                    strategy[CardCombo(dealerCard: 3,playerCard: 20)] = Action.stand
                                    strategy[CardCombo(dealerCard: 4,playerCard: 20)] = Action.stand
                                    strategy[CardCombo(dealerCard: 5,playerCard: 20)] = Action.stand
                                    strategy[CardCombo(dealerCard: 6,playerCard: 20)] = Action.stand
                                    strategy[CardCombo(dealerCard: 7,playerCard: 20)] = Action.stand
                                    strategy[CardCombo(dealerCard: 8,playerCard: 20)] = Action.stand
                                    strategy[CardCombo(dealerCard: 9,playerCard: 20)] = Action.stand
                                    strategy[CardCombo(dealerCard: 10,playerCard: 20)] = Action.stand
                                    strategy[CardCombo(dealerCard: 11,playerCard: 20)] = Action.stand
                                    
                                    strategy[CardCombo(dealerCard: 2,playerCard: 22)] = Action.split
                                    strategy[CardCombo(dealerCard: 3,playerCard: 22)] = Action.split
                                    strategy[CardCombo(dealerCard: 4,playerCard: 22)] = Action.split
                                    strategy[CardCombo(dealerCard: 5,playerCard: 22)] = Action.split
                                    strategy[CardCombo(dealerCard: 6,playerCard: 22)] = Action.split
                                    strategy[CardCombo(dealerCard: 7,playerCard: 22)] = Action.split
                                    strategy[CardCombo(dealerCard: 8,playerCard: 22)] = Action.split
                                    strategy[CardCombo(dealerCard: 9,playerCard: 22)] = Action.split
                                    strategy[CardCombo(dealerCard: 10,playerCard: 22)] = Action.split
                                    strategy[CardCombo(dealerCard: 11,playerCard: 22)] = Action.split
                                    
                                    if strategy[CardCombo(dealerCard: dealerTotal, playerCard: playerTotal)] != nil {
                                        return strategy[CardCombo(dealerCard: dealerTotal, playerCard: playerTotal)]!
                                    } else {
                                        return .over
                                    }
                                    
                                } else {
                                    
                                    if myFirstCard == 11 || mySecondCard == 11 || myThirdCard == 11 || myFourthCard == 11 {
                                        
                                        strategy[CardCombo(dealerCard: 2,playerCard: 13)] = Action.hit
                                        strategy[CardCombo(dealerCard: 3,playerCard: 13)] = Action.hit
                                        strategy[CardCombo(dealerCard: 4,playerCard: 13)] = Action.hit
                                        strategy[CardCombo(dealerCard: 5,playerCard: 13)] = Action.doubleOrHit
                                        strategy[CardCombo(dealerCard: 6,playerCard: 13)] = Action.doubleOrHit
                                        strategy[CardCombo(dealerCard: 7,playerCard: 13)] = Action.hit
                                        strategy[CardCombo(dealerCard: 8,playerCard: 13)] = Action.hit
                                        strategy[CardCombo(dealerCard: 9,playerCard: 13)] = Action.hit
                                        strategy[CardCombo(dealerCard: 10,playerCard: 13)] = Action.hit
                                        strategy[CardCombo(dealerCard: 11,playerCard: 13)] = Action.hit
                                        
                                        strategy[CardCombo(dealerCard: 2,playerCard: 14)] = Action.hit
                                        strategy[CardCombo(dealerCard: 3,playerCard: 14)] = Action.hit
                                        strategy[CardCombo(dealerCard: 4,playerCard: 14)] = Action.doubleOrHit
                                        strategy[CardCombo(dealerCard: 5,playerCard: 14)] = Action.doubleOrHit
                                        strategy[CardCombo(dealerCard: 6,playerCard: 14)] = Action.doubleOrHit
                                        strategy[CardCombo(dealerCard: 7,playerCard: 14)] = Action.hit
                                        strategy[CardCombo(dealerCard: 8,playerCard: 14)] = Action.hit
                                        strategy[CardCombo(dealerCard: 9,playerCard: 14)] = Action.hit
                                        strategy[CardCombo(dealerCard: 10,playerCard: 14)] = Action.hit
                                        strategy[CardCombo(dealerCard: 11,playerCard: 14)] = Action.hit
                                        
                                        strategy[CardCombo(dealerCard: 2,playerCard: 15)] = Action.hit
                                        strategy[CardCombo(dealerCard: 3,playerCard: 15)] = Action.hit
                                        strategy[CardCombo(dealerCard: 4,playerCard: 15)] = Action.doubleOrHit
                                        strategy[CardCombo(dealerCard: 5,playerCard: 15)] = Action.doubleOrHit
                                        strategy[CardCombo(dealerCard: 6,playerCard: 15)] = Action.doubleOrHit
                                        strategy[CardCombo(dealerCard: 7,playerCard: 15)] = Action.hit
                                        strategy[CardCombo(dealerCard: 8,playerCard: 15)] = Action.hit
                                        strategy[CardCombo(dealerCard: 9,playerCard: 15)] = Action.hit
                                        strategy[CardCombo(dealerCard: 10,playerCard: 15)] = Action.hit
                                        strategy[CardCombo(dealerCard: 11,playerCard: 15)] = Action.hit
                                        
                                        strategy[CardCombo(dealerCard: 2,playerCard: 16)] = Action.hit
                                        strategy[CardCombo(dealerCard: 3,playerCard: 16)] = Action.hit
                                        strategy[CardCombo(dealerCard: 4,playerCard: 16)] = Action.doubleOrHit
                                        strategy[CardCombo(dealerCard: 5,playerCard: 16)] = Action.doubleOrHit
                                        strategy[CardCombo(dealerCard: 6,playerCard: 16)] = Action.doubleOrHit
                                        strategy[CardCombo(dealerCard: 7,playerCard: 16)] = Action.hit
                                        strategy[CardCombo(dealerCard: 8,playerCard: 16)] = Action.hit
                                        strategy[CardCombo(dealerCard: 9,playerCard: 16)] = Action.hit
                                        strategy[CardCombo(dealerCard: 10,playerCard: 16)] = Action.hit
                                        strategy[CardCombo(dealerCard: 11,playerCard: 16)] = Action.hit
                                        
                                        strategy[CardCombo(dealerCard: 2,playerCard: 17)] = Action.hit
                                        strategy[CardCombo(dealerCard: 3,playerCard: 17)] = Action.doubleOrHit
                                        strategy[CardCombo(dealerCard: 4,playerCard: 17)] = Action.doubleOrHit
                                        strategy[CardCombo(dealerCard: 5,playerCard: 17)] = Action.doubleOrHit
                                        strategy[CardCombo(dealerCard: 6,playerCard: 17)] = Action.doubleOrHit
                                        strategy[CardCombo(dealerCard: 7,playerCard: 17)] = Action.hit
                                        strategy[CardCombo(dealerCard: 8,playerCard: 17)] = Action.hit
                                        strategy[CardCombo(dealerCard: 9,playerCard: 17)] = Action.hit
                                        strategy[CardCombo(dealerCard: 10,playerCard: 17)] = Action.hit
                                        strategy[CardCombo(dealerCard: 11,playerCard: 17)] = Action.hit
                                        
                                        strategy[CardCombo(dealerCard: 2,playerCard: 18)] = Action.doubleOrStand
                                        strategy[CardCombo(dealerCard: 3,playerCard: 18)] = Action.doubleOrStand
                                        strategy[CardCombo(dealerCard: 4,playerCard: 18)] = Action.doubleOrStand
                                        strategy[CardCombo(dealerCard: 5,playerCard: 18)] = Action.doubleOrStand
                                        strategy[CardCombo(dealerCard: 6,playerCard: 18)] = Action.doubleOrStand
                                        strategy[CardCombo(dealerCard: 7,playerCard: 18)] = Action.stand
                                        strategy[CardCombo(dealerCard: 8,playerCard: 18)] = Action.stand
                                        strategy[CardCombo(dealerCard: 9,playerCard: 18)] = Action.hit
                                        strategy[CardCombo(dealerCard: 10,playerCard: 18)] = Action.hit
                                        strategy[CardCombo(dealerCard: 11,playerCard: 18)] = Action.hit
                                        
                                        strategy[CardCombo(dealerCard: 2,playerCard: 19)] = Action.stand
                                        strategy[CardCombo(dealerCard: 3,playerCard: 19)] = Action.stand
                                        strategy[CardCombo(dealerCard: 4,playerCard: 19)] = Action.stand
                                        strategy[CardCombo(dealerCard: 5,playerCard: 19)] = Action.stand
                                        strategy[CardCombo(dealerCard: 6,playerCard: 19)] = Action.doubleOrStand
                                        strategy[CardCombo(dealerCard: 7,playerCard: 19)] = Action.stand
                                        strategy[CardCombo(dealerCard: 8,playerCard: 19)] = Action.stand
                                        strategy[CardCombo(dealerCard: 9,playerCard: 19)] = Action.stand
                                        strategy[CardCombo(dealerCard: 10,playerCard: 19)] = Action.stand
                                        strategy[CardCombo(dealerCard: 11,playerCard: 19)] = Action.stand
                                        
                                        strategy[CardCombo(dealerCard: 2,playerCard: 20)] = Action.stand
                                        strategy[CardCombo(dealerCard: 3,playerCard: 20)] = Action.stand
                                        strategy[CardCombo(dealerCard: 4,playerCard: 20)] = Action.stand
                                        strategy[CardCombo(dealerCard: 5,playerCard: 20)] = Action.stand
                                        strategy[CardCombo(dealerCard: 6,playerCard: 20)] = Action.stand
                                        strategy[CardCombo(dealerCard: 7,playerCard: 20)] = Action.stand
                                        strategy[CardCombo(dealerCard: 8,playerCard: 20)] = Action.stand
                                        strategy[CardCombo(dealerCard: 9,playerCard: 20)] = Action.stand
                                        strategy[CardCombo(dealerCard: 10,playerCard: 20)] = Action.stand
                                        strategy[CardCombo(dealerCard: 11,playerCard: 20)] = Action.stand
                                        
                                        strategy[CardCombo(dealerCard: 2,playerCard: 21)] = Action.stand
                                        strategy[CardCombo(dealerCard: 3,playerCard: 21)] = Action.stand
                                        strategy[CardCombo(dealerCard: 4,playerCard: 21)] = Action.stand
                                        strategy[CardCombo(dealerCard: 5,playerCard: 21)] = Action.stand
                                        strategy[CardCombo(dealerCard: 6,playerCard: 21)] = Action.stand
                                        strategy[CardCombo(dealerCard: 7,playerCard: 21)] = Action.stand
                                        strategy[CardCombo(dealerCard: 8,playerCard: 21)] = Action.stand
                                        strategy[CardCombo(dealerCard: 9,playerCard: 21)] = Action.stand
                                        strategy[CardCombo(dealerCard: 10,playerCard: 21)] = Action.stand
                                        strategy[CardCombo(dealerCard: 11,playerCard: 21)] = Action.stand
                                        
                                        if strategy[CardCombo(dealerCard: dealerTotal, playerCard: playerTotalWithAces!)] != nil {
                                            return strategy[CardCombo(dealerCard: dealerTotal, playerCard: playerTotalWithAces!)]!
                                        } else {
                                            return .over
                                        }
                                        
                                    } else {
                                        
                                        strategy[CardCombo(dealerCard: 2,playerCard: 5)] = Action.hit
                                        strategy[CardCombo(dealerCard: 3,playerCard: 5)] = Action.hit
                                        strategy[CardCombo(dealerCard: 4,playerCard: 5)] = Action.hit
                                        strategy[CardCombo(dealerCard: 5,playerCard: 5)] = Action.hit
                                        strategy[CardCombo(dealerCard: 6,playerCard: 5)] = Action.hit
                                        strategy[CardCombo(dealerCard: 7,playerCard: 5)] = Action.hit
                                        strategy[CardCombo(dealerCard: 8,playerCard: 5)] = Action.hit
                                        strategy[CardCombo(dealerCard: 9,playerCard: 5)] = Action.hit
                                        strategy[CardCombo(dealerCard: 10,playerCard: 5)] = Action.hit
                                        strategy[CardCombo(dealerCard: 11,playerCard: 5)] = Action.hit
                                        
                                        strategy[CardCombo(dealerCard: 2,playerCard: 6)] = Action.hit
                                        strategy[CardCombo(dealerCard: 3,playerCard: 6)] = Action.hit
                                        strategy[CardCombo(dealerCard: 4,playerCard: 6)] = Action.hit
                                        strategy[CardCombo(dealerCard: 5,playerCard: 6)] = Action.hit
                                        strategy[CardCombo(dealerCard: 6,playerCard: 6)] = Action.hit
                                        strategy[CardCombo(dealerCard: 7,playerCard: 6)] = Action.hit
                                        strategy[CardCombo(dealerCard: 8,playerCard: 6)] = Action.hit
                                        strategy[CardCombo(dealerCard: 9,playerCard: 6)] = Action.hit
                                        strategy[CardCombo(dealerCard: 10,playerCard: 6)] = Action.hit
                                        strategy[CardCombo(dealerCard: 11,playerCard: 6)] = Action.hit
                                        
                                        strategy[CardCombo(dealerCard: 2,playerCard: 7)] = Action.hit
                                        strategy[CardCombo(dealerCard: 3,playerCard: 7)] = Action.hit
                                        strategy[CardCombo(dealerCard: 4,playerCard: 7)] = Action.hit
                                        strategy[CardCombo(dealerCard: 5,playerCard: 7)] = Action.hit
                                        strategy[CardCombo(dealerCard: 6,playerCard: 7)] = Action.hit
                                        strategy[CardCombo(dealerCard: 7,playerCard: 7)] = Action.hit
                                        strategy[CardCombo(dealerCard: 8,playerCard: 7)] = Action.hit
                                        strategy[CardCombo(dealerCard: 9,playerCard: 7)] = Action.hit
                                        strategy[CardCombo(dealerCard: 10,playerCard: 7)] = Action.hit
                                        strategy[CardCombo(dealerCard: 11,playerCard: 7)] = Action.hit
                                        
                                        strategy[CardCombo(dealerCard: 2,playerCard: 8)] = Action.hit
                                        strategy[CardCombo(dealerCard: 3,playerCard: 8)] = Action.hit
                                        strategy[CardCombo(dealerCard: 4,playerCard: 8)] = Action.hit
                                        strategy[CardCombo(dealerCard: 5,playerCard: 8)] = Action.hit
                                        strategy[CardCombo(dealerCard: 6,playerCard: 8)] = Action.hit
                                        strategy[CardCombo(dealerCard: 7,playerCard: 8)] = Action.hit
                                        strategy[CardCombo(dealerCard: 8,playerCard: 8)] = Action.hit
                                        strategy[CardCombo(dealerCard: 9,playerCard: 8)] = Action.hit
                                        strategy[CardCombo(dealerCard: 10,playerCard: 8)] = Action.hit
                                        strategy[CardCombo(dealerCard: 11,playerCard: 8)] = Action.hit
                                        
                                        strategy[CardCombo(dealerCard: 2,playerCard: 9)] = Action.doubleOrHit
                                        strategy[CardCombo(dealerCard: 3,playerCard: 9)] = Action.doubleOrHit
                                        strategy[CardCombo(dealerCard: 4,playerCard: 9)] = Action.doubleOrHit
                                        strategy[CardCombo(dealerCard: 5,playerCard: 9)] = Action.doubleOrHit
                                        strategy[CardCombo(dealerCard: 6,playerCard: 9)] = Action.doubleOrHit
                                        strategy[CardCombo(dealerCard: 7,playerCard: 9)] = Action.hit
                                        strategy[CardCombo(dealerCard: 8,playerCard: 9)] = Action.hit
                                        strategy[CardCombo(dealerCard: 9,playerCard: 9)] = Action.hit
                                        strategy[CardCombo(dealerCard: 10,playerCard: 9)] = Action.hit
                                        strategy[CardCombo(dealerCard: 11,playerCard: 9)] = Action.hit
                                        
                                        strategy[CardCombo(dealerCard: 2,playerCard: 10)] = Action.doubleOrHit
                                        strategy[CardCombo(dealerCard: 3,playerCard: 10)] = Action.doubleOrHit
                                        strategy[CardCombo(dealerCard: 4,playerCard: 10)] = Action.doubleOrHit
                                        strategy[CardCombo(dealerCard: 5,playerCard: 10)] = Action.doubleOrHit
                                        strategy[CardCombo(dealerCard: 6,playerCard: 10)] = Action.doubleOrHit
                                        strategy[CardCombo(dealerCard: 7,playerCard: 10)] = Action.doubleOrHit
                                        strategy[CardCombo(dealerCard: 8,playerCard: 10)] = Action.doubleOrHit
                                        strategy[CardCombo(dealerCard: 9,playerCard: 10)] = Action.doubleOrHit
                                        strategy[CardCombo(dealerCard: 10,playerCard: 10)] = Action.hit
                                        strategy[CardCombo(dealerCard: 11,playerCard: 10)] = Action.hit
                                        
                                        strategy[CardCombo(dealerCard: 2,playerCard: 11)] = Action.doubleOrHit
                                        strategy[CardCombo(dealerCard: 3,playerCard: 11)] = Action.doubleOrHit
                                        strategy[CardCombo(dealerCard: 4,playerCard: 11)] = Action.doubleOrHit
                                        strategy[CardCombo(dealerCard: 5,playerCard: 11)] = Action.doubleOrHit
                                        strategy[CardCombo(dealerCard: 6,playerCard: 11)] = Action.doubleOrHit
                                        strategy[CardCombo(dealerCard: 7,playerCard: 11)] = Action.doubleOrHit
                                        strategy[CardCombo(dealerCard: 8,playerCard: 11)] = Action.doubleOrHit
                                        strategy[CardCombo(dealerCard: 9,playerCard: 11)] = Action.doubleOrHit
                                        strategy[CardCombo(dealerCard: 10,playerCard: 11)] = Action.doubleOrHit
                                        strategy[CardCombo(dealerCard: 11,playerCard: 11)] = Action.doubleOrHit
                                        
                                        strategy[CardCombo(dealerCard: 2,playerCard: 12)] = Action.hit
                                        strategy[CardCombo(dealerCard: 3,playerCard: 12)] = Action.hit
                                        strategy[CardCombo(dealerCard: 4,playerCard: 12)] = Action.stand
                                        strategy[CardCombo(dealerCard: 5,playerCard: 12)] = Action.stand
                                        strategy[CardCombo(dealerCard: 6,playerCard: 12)] = Action.stand
                                        strategy[CardCombo(dealerCard: 7,playerCard: 12)] = Action.hit
                                        strategy[CardCombo(dealerCard: 8,playerCard: 12)] = Action.hit
                                        strategy[CardCombo(dealerCard: 9,playerCard: 12)] = Action.hit
                                        strategy[CardCombo(dealerCard: 10,playerCard: 12)] = Action.hit
                                        strategy[CardCombo(dealerCard: 11,playerCard: 12)] = Action.hit
                                        
                                        strategy[CardCombo(dealerCard: 2,playerCard: 13)] = Action.stand
                                        strategy[CardCombo(dealerCard: 3,playerCard: 13)] = Action.stand
                                        strategy[CardCombo(dealerCard: 4,playerCard: 13)] = Action.stand
                                        strategy[CardCombo(dealerCard: 5,playerCard: 13)] = Action.stand
                                        strategy[CardCombo(dealerCard: 6,playerCard: 13)] = Action.stand
                                        strategy[CardCombo(dealerCard: 7,playerCard: 13)] = Action.hit
                                        strategy[CardCombo(dealerCard: 8,playerCard: 13)] = Action.hit
                                        strategy[CardCombo(dealerCard: 9,playerCard: 13)] = Action.hit
                                        strategy[CardCombo(dealerCard: 10,playerCard: 13)] = Action.hit
                                        strategy[CardCombo(dealerCard: 11,playerCard: 13)] = Action.hit
                                        
                                        strategy[CardCombo(dealerCard: 2,playerCard: 14)] = Action.stand
                                        strategy[CardCombo(dealerCard: 3,playerCard: 14)] = Action.stand
                                        strategy[CardCombo(dealerCard: 4,playerCard: 14)] = Action.stand
                                        strategy[CardCombo(dealerCard: 5,playerCard: 14)] = Action.stand
                                        strategy[CardCombo(dealerCard: 6,playerCard: 14)] = Action.stand
                                        strategy[CardCombo(dealerCard: 7,playerCard: 14)] = Action.hit
                                        strategy[CardCombo(dealerCard: 8,playerCard: 14)] = Action.hit
                                        strategy[CardCombo(dealerCard: 9,playerCard: 14)] = Action.hit
                                        strategy[CardCombo(dealerCard: 10,playerCard: 14)] = Action.hit
                                        strategy[CardCombo(dealerCard: 11,playerCard: 14)] = Action.hit
                                        
                                        strategy[CardCombo(dealerCard: 2,playerCard: 15)] = Action.stand
                                        strategy[CardCombo(dealerCard: 3,playerCard: 15)] = Action.stand
                                        strategy[CardCombo(dealerCard: 4,playerCard: 15)] = Action.stand
                                        strategy[CardCombo(dealerCard: 5,playerCard: 15)] = Action.stand
                                        strategy[CardCombo(dealerCard: 6,playerCard: 15)] = Action.stand
                                        strategy[CardCombo(dealerCard: 7,playerCard: 15)] = Action.hit
                                        strategy[CardCombo(dealerCard: 8,playerCard: 15)] = Action.hit
                                        strategy[CardCombo(dealerCard: 9,playerCard: 15)] = Action.hit
                                        strategy[CardCombo(dealerCard: 10,playerCard: 15)] = Action.hit
                                        strategy[CardCombo(dealerCard: 11,playerCard: 15)] = Action.hit
                                        
                                        strategy[CardCombo(dealerCard: 2,playerCard: 16)] = Action.stand
                                        strategy[CardCombo(dealerCard: 3,playerCard: 16)] = Action.stand
                                        strategy[CardCombo(dealerCard: 4,playerCard: 16)] = Action.stand
                                        strategy[CardCombo(dealerCard: 5,playerCard: 16)] = Action.stand
                                        strategy[CardCombo(dealerCard: 6,playerCard: 16)] = Action.stand
                                        strategy[CardCombo(dealerCard: 7,playerCard: 16)] = Action.hit
                                        strategy[CardCombo(dealerCard: 8,playerCard: 16)] = Action.hit
                                        strategy[CardCombo(dealerCard: 9,playerCard: 16)] = Action.hit
                                        strategy[CardCombo(dealerCard: 10,playerCard: 16)] = Action.hit
                                        strategy[CardCombo(dealerCard: 11,playerCard: 16)] = Action.hit
                                        
                                        strategy[CardCombo(dealerCard: 2,playerCard: 17)] = Action.stand
                                        strategy[CardCombo(dealerCard: 3,playerCard: 17)] = Action.stand
                                        strategy[CardCombo(dealerCard: 4,playerCard: 17)] = Action.stand
                                        strategy[CardCombo(dealerCard: 5,playerCard: 17)] = Action.stand
                                        strategy[CardCombo(dealerCard: 6,playerCard: 17)] = Action.stand
                                        strategy[CardCombo(dealerCard: 7,playerCard: 17)] = Action.stand
                                        strategy[CardCombo(dealerCard: 8,playerCard: 17)] = Action.stand
                                        strategy[CardCombo(dealerCard: 9,playerCard: 17)] = Action.stand
                                        strategy[CardCombo(dealerCard: 10,playerCard: 17)] = Action.stand
                                        strategy[CardCombo(dealerCard: 11,playerCard: 17)] = Action.stand
                                        
                                        strategy[CardCombo(dealerCard: 2,playerCard: 18)] = Action.stand
                                        strategy[CardCombo(dealerCard: 3,playerCard: 18)] = Action.stand
                                        strategy[CardCombo(dealerCard: 4,playerCard: 18)] = Action.stand
                                        strategy[CardCombo(dealerCard: 5,playerCard: 18)] = Action.stand
                                        strategy[CardCombo(dealerCard: 6,playerCard: 18)] = Action.stand
                                        strategy[CardCombo(dealerCard: 7,playerCard: 18)] = Action.stand
                                        strategy[CardCombo(dealerCard: 8,playerCard: 18)] = Action.stand
                                        strategy[CardCombo(dealerCard: 9,playerCard: 18)] = Action.stand
                                        strategy[CardCombo(dealerCard: 10,playerCard: 18)] = Action.stand
                                        strategy[CardCombo(dealerCard: 11,playerCard: 18)] = Action.stand
                                        
                                        strategy[CardCombo(dealerCard: 2,playerCard: 19)] = Action.stand
                                        strategy[CardCombo(dealerCard: 3,playerCard: 19)] = Action.stand
                                        strategy[CardCombo(dealerCard: 4,playerCard: 19)] = Action.stand
                                        strategy[CardCombo(dealerCard: 5,playerCard: 19)] = Action.stand
                                        strategy[CardCombo(dealerCard: 6,playerCard: 19)] = Action.stand
                                        strategy[CardCombo(dealerCard: 7,playerCard: 19)] = Action.stand
                                        strategy[CardCombo(dealerCard: 8,playerCard: 19)] = Action.stand
                                        strategy[CardCombo(dealerCard: 9,playerCard: 19)] = Action.stand
                                        strategy[CardCombo(dealerCard: 10,playerCard: 19)] = Action.stand
                                        strategy[CardCombo(dealerCard: 11,playerCard: 19)] = Action.stand
                                        
                                        strategy[CardCombo(dealerCard: 2,playerCard: 20)] = Action.stand
                                        strategy[CardCombo(dealerCard: 3,playerCard: 20)] = Action.stand
                                        strategy[CardCombo(dealerCard: 4,playerCard: 20)] = Action.stand
                                        strategy[CardCombo(dealerCard: 5,playerCard: 20)] = Action.stand
                                        strategy[CardCombo(dealerCard: 6,playerCard: 20)] = Action.stand
                                        strategy[CardCombo(dealerCard: 7,playerCard: 20)] = Action.stand
                                        strategy[CardCombo(dealerCard: 8,playerCard: 20)] = Action.stand
                                        strategy[CardCombo(dealerCard: 9,playerCard: 20)] = Action.stand
                                        strategy[CardCombo(dealerCard: 10,playerCard: 20)] = Action.stand
                                        strategy[CardCombo(dealerCard: 11,playerCard: 20)] = Action.stand
                                        
                                        strategy[CardCombo(dealerCard: 2,playerCard: 21)] = Action.stand
                                        strategy[CardCombo(dealerCard: 3,playerCard: 21)] = Action.stand
                                        strategy[CardCombo(dealerCard: 4,playerCard: 21)] = Action.stand
                                        strategy[CardCombo(dealerCard: 5,playerCard: 21)] = Action.stand
                                        strategy[CardCombo(dealerCard: 6,playerCard: 21)] = Action.stand
                                        strategy[CardCombo(dealerCard: 7,playerCard: 21)] = Action.stand
                                        strategy[CardCombo(dealerCard: 8,playerCard: 21)] = Action.stand
                                        strategy[CardCombo(dealerCard: 9,playerCard: 21)] = Action.stand
                                        strategy[CardCombo(dealerCard: 10,playerCard: 21)] = Action.stand
                                        strategy[CardCombo(dealerCard: 11,playerCard: 21)] = Action.stand
                                        
                                        if strategy[CardCombo(dealerCard: dealerTotal, playerCard: playerTotal)] != nil {
                                            return strategy[CardCombo(dealerCard: dealerTotal, playerCard: playerTotal)]!
                                        } else {
                                            return .over
                                        }
                                        
                                    }
                                }
                            }
            
            
            
            
            
            
        else {
            if strategy[CardCombo(dealerCard: dealerTotal, playerCard: playerTotal)] != nil {
                return strategy[CardCombo(dealerCard: dealerTotal, playerCard: playerTotal)]!
            } else {
                return .over
            }
        }
        
        
    }
    
    
}
