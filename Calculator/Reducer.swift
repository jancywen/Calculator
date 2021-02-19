//
//  Reducer.swift
//  Calculator
//
//  Created by captain on 2021/2/19.
//

import Foundation


typealias CalculatorState = CalculatorBrain
typealias CalculatorStateAction = CalculatorButtonItem

struct Reducer {
    static func reduce (state: CalculatorState, action: CalculatorStateAction) -> CalculatorState {
        return state.apply(item: action)
    }
}
