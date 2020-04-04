//
//  Base.swift
//  NumbersConverter
//
//  Created by Macbook Pro 15 on 3/31/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import Foundation

let kPOSSIBLECHARACTERS: [Character] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

enum Base: Int {
    case two = 2, three = 3, four = 4, five = 5, six = 6, seven = 7, eight = 8, nine = 9, ten = 10, eleven = 11, twelve = 12, thirteen = 13, fourteen = 14, fifteen = 15, sixteen = 16, seventeen = 17, eighteen = 18, nineteen = 19, twenty = 20, twentyOne = 21, twentyTwo = 22, twentyThree = 23, twentyFour = 24, twentyFive = 25, twentySix = 26, twentySeven = 27, twentyEight = 28, twentyNine = 29, thirty = 30, thirtyOne = 31, thirtyTwo = 32, thirtyThree = 33, thirtyFour = 34, thirtyFive = 35, thirtysix = 36
    
///returns list of possible characters for that base
    func getImpossibleCharacters() -> [Character] {
        var impossibleChars: [Character] = []
        let iterationCount = Base.allCases.count - self.rawValue + 1 //get length impossible characters
        for i in 0 ..< iterationCount {
            impossibleChars.append(kPOSSIBLECHARACTERS.reversed()[i]) //append each impossible characters //reversed to get impossible instead
        }
        return impossibleChars
    }
    
///takes a character and returns its base 10 value
    func getAsBase10(ofChar: Character) -> Int {
        for char in kPOSSIBLECHARACTERS.enumerated() where char.element.lowercased() == ofChar.lowercased() { //loop through each possibleChars, and return the index which is its base 10 value
            return char.offset
        }
        return -1
    }
}

extension Base: CaseIterable {
    mutating func getRandomBase() { //updates base to a random Base from all Color cases //CaseIterable allows me to use the allCases typeProperty
        self = Base.allCases[Int(arc4random_uniform(UInt32(Base.allCases.count)))]
    }
}

//enum Base: String {
//
//    case two, three, four, five , six, seven, eight, nine, ten, eleven, twelve, thirteen, fourteen, fifteen, sixteen, seventeen, eighteen, nineteen, twenty, twentyOne, twentyTwo, twentyThree, twentyFour, twentyFive, twentySix, twentySeven, twentyEight, twentyNine, thirty, thirtyOne, thirtyTwo, thirtyThree, thirtyFour, thirtyFive, thirtySix
//
//
//    var intValue: Int {
//        switch self {
//        case .two:
//            return 2
//        case .three:
//            return 3
//        case .four:
//            return 4
//        case .five:
//            return 5
//        case .six:
//            return 6
//        case .seven:
//            return 7
//        case .eight:
//            return 8
//        case .nine:
//            return 9
//        case .ten:
//            return 10
//        case .eleven:
//            return 11
//        case .twelve:
//            return 12
//        case .thirteen:
//            return 13
//        case .fourteen:
//            return 14
//        case .fifteen:
//            return 15
//        case .sixteen:
//            return 16
//        case .seventeen:
//            return 17
//        case .eighteen:
//            return 18
//        case .nineteen:
//            return 19
//        case .twenty:
//            return 20
//        case .twentyOne:
//            return 21
//        case .twentyTwo:
//            return 22
//        case .twentyThree:
//            return 23
//        case .twentyFour:
//            return 24
//        case .twentyFive:
//            return 25
//        case .twentySix:
//            return 26
//        case .twentySeven:
//            return 27
//        case .twentyEight:
//            return 28
//        case .twentyNine:
//            return 29
//        case .thirty:
//            return 30
//        case .thirtyOne:
//            return 31
//        case .thirtyTwo:
//            return 32
//        case .thirtyThree:
//            return 33
//        case .thirtyFour:
//            return 34
//        case .thirtyFive:
//            return 35
//        case .thirtySix:
//            return 36
//        }
//    }
//}
