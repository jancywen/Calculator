//
//  CalculatorButtonRow.swift
//  Calculator
//
//  Created by captain on 2021/2/19.
//

import SwiftUI

struct CalculatorButtonRow: View {
    let row: [CalculatorButtonItem]
    @Binding var brain: CalculatorBrain
    
    var body: some View {
        HStack {
            ForEach(row, id: \.self){ item in
                CalculatorButton(
                    title: item.title,
                    size: item.size,
                    backgroundColorName: item.backgroundColorName)
                {
                    self.brain = self.brain.apply(item: item)
                }
            }
        }
    }
}

//struct CalculatorButtonRow_Previews: PreviewProvider {
//    static var previews: some View {
//        CalculatorButtonRow(row: [.digit(1), .digit(2), .digit(3), .op(.plus)])
//    }
//}
