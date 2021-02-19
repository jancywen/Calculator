//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by captain on 2021/2/19.
//

import Foundation

enum CalculatorBrain {
    case left(String)
    case leftOp(
            left: String,
            op: CalculatorButtonItem.Op)
    case leftOpRight (
            left: String,
            op:CalculatorButtonItem.Op,
            right: String)
    case error
}


extension CalculatorBrain {
    
    var output: String {
        let result: String
        switch self {
        case .left(let left):
            result = left
        case .leftOp(left: let left, op: _):
            result = left
        case .leftOpRight(left: _, op: _, right: let right):
            result = right
        case .error:
            result = "error"
        }
        
        guard let value = Double(result) else {
            return "Error"
        }
        return formatter.string(from: value as NSNumber)!
    }
    
    func apply(item: CalculatorButtonItem) -> CalculatorBrain {
        switch item {
        case .digit(let num):
            return apply(num: num)
        case .dot:
            return applyDot()
        case .op(let op):
            return apply(op: op)
        case .command(let command):
            return apply(command: command)
        }
    }
    
    private func apply(num: Int) -> CalculatorBrain {
        switch self {
        case .left(let value):
            return CalculatorBrain.left(value+"\(num)")
        case .leftOp(left: let leftValue, op: let op):
            return CalculatorBrain.leftOpRight(left: leftValue, op: op, right: "\(num)")
        case .leftOpRight(left: let leftValue, op: let op, right: let rightValue):
            return .leftOpRight(left: leftValue, op: op, right: rightValue + "\(num)")
        default:
            return .error
        }
    }
    private func applyDot() -> CalculatorBrain {
        switch self {
        case .left(let value):
            if value.contains(".") {
                return self
            }
            return CalculatorBrain.left(value + ".")
            
        case .leftOp(left: let leftValue, op: let op):
            return .leftOpRight(left: leftValue, op: op, right: "0.")
            
        case .leftOpRight(left: let leftValue, op: let op, right: let rightValue):
            if rightValue.contains(".") {
                return self
            }
            return .leftOpRight(left: leftValue, op: op, right: rightValue + ".")
            
        case .error:
            return .left("0.")
        }
    }
    
    private func apply(op: CalculatorButtonItem.Op) -> CalculatorBrain {
        switch self {
        case .left(let leftValue):
            return .leftOp(left: leftValue, op: op)
        case .leftOp(left: let leftValue, op: _):
            if case .equal = op {
                return .left(leftValue)
            }
            return .leftOp(left: leftValue, op: op)
        case .leftOpRight(left: let leftValue, op: let leftOp, right: let rightValue):
            guard let leftNum = Double(leftValue),
                  let rightNum = Double(rightValue) else {
                return .error
            }
            let result: Double
            switch leftOp {
            case .plus:
                result = leftNum + rightNum
            case .minus:
                result = leftNum - rightNum
            case .multiply:
                result = leftNum * rightNum
            case .divide:
                result = leftNum / rightNum
            case .equal:
                result = 0
            }
            return .leftOp(left: formatter.string(from: NSNumber(value: result))! , op: op)
            
        default:
            return self
        }
    }
    
    private func apply(command: CalculatorButtonItem.Command) -> CalculatorBrain {
        switch command {
        case .clear:
            return .left("0")
        case .flip:
            switch self {
            case .left(let leftValue):
                guard let leftDouble = Double(leftValue) else {
                    return .error
                }
                let value = 0 - leftDouble
                return .left(formatter.string(from: NSNumber(value: value))!)
            case .leftOp(left: let leftValue, op: let op):
                return .leftOpRight(left: leftValue, op: op, right: "-0")
            case .leftOpRight(left: let leftValue, op: let op, right: let rightValue):
                guard let rightDouble = Double(rightValue) else {
                    return .error
                }
                let value = 0 - rightDouble
                return .leftOpRight(left: leftValue, op: op, right: formatter.string(from: NSNumber(value: value))!)
            case .error:
                return .error
            }
        case .percent:
            switch self {
            case .left(let leftValue):
                guard let leftDouble = Double(leftValue) else {
                    return .error
                }
                let value = leftDouble / 100
                return .left(formatter.string(from: NSNumber(value: value))!)

            default:
                return self
            }
        }

    }
}


var formatter: NumberFormatter = {
    let f = NumberFormatter()
    f.minimumFractionDigits = 0
    f.maximumFractionDigits = 8
    f.numberStyle = .decimal
    return f
}()
