//
//  Base.swift
//  NumbersConverter
//
//  Created by Macbook Pro 15 on 3/31/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import Foundation

enum Base: Int {
    
    case two = 2, three = 3, four = 4, five = 5, six = 6, seven = 7, eight = 8, nine = 9, ten = 10, eleven = 11, twelve = 12, thirteen = 13, fourteen = 14, fifteen = 15, sixteen = 16, seventeen = 17, eighteen = 18, nineteen = 19, twenty = 20, twentyOne = 21, twentyTwo = 22, twentyThree = 23, twentyFour = 24, twentyFive = 25, twentySix = 26, twentySeven = 27, twentyEight = 28, twentyNine = 29, thirty = 30, thirtyOne = 31, thirtyTwo = 32, thirtyThree = 33, thirtyFour = 34, thirtyFive = 35, thirtysix = 36
    
}

extension Base: CaseIterable {
    mutating func getRandomBase() { //updates base to a random Base from all Color cases //CaseIterable allows me to use the allCases typeProperty
        self = Base.allCases[Int(arc4random_uniform(UInt32(Base.allCases.count)))]
    }
}
