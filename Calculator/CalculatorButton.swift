//
//  CalculatorButton.swift
//  Calculator
//
//  Created by captain on 2021/2/19.
//

import SwiftUI


struct CalculatorButton: View {
    let fontSize: CGFloat = 24
    let title: String
    let size: CGSize
    let backgroundColorName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
//            ZStack {
//                Circle()
//                    .frame(width: size.width, height: size.height)
//                    .foregroundColor(Color(backgroundColorName))
//                Text(title)
//                    .font(.system(size: fontSize))
//                    .foregroundColor(.white)
//            }
            Text(title)
                .font(.system(size: fontSize))
                .bold()
                .foregroundColor(Color("textColor"))
//                .font(.system(size: fontSize))
                .frame(width: size.width, height: size.height, alignment: .center)
                .background(Color(backgroundColorName))
                .cornerRadius(size.width/2)
//                .background(Color.blue)
        })
    }
}

struct CalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        let item = CalculatorButtonItem.op(.equal)
        return CalculatorButton(title: item.title, size: item.size, backgroundColorName: item.backgroundColorName) {
            
        }
    }
}
