//
//  ContentView.swift
//  Calculator
//
//  Created by captain on 2021/2/19.
//

import SwiftUI

struct ContentView: View {
    
    @State private var brain: CalculatorBrain = .left("0")
    
    let scale: CGFloat = UIScreen.main.bounds.width / 414
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Text(brain.output)
                .font(.system(size: 76))
                .minimumScaleFactor(0.5)
                .padding(.trailing, 24 * scale)
                .lineLimit(1)
                .frame(minWidth: 0,  maxWidth: .infinity,  alignment: .trailing)
            CalculatorButtonPad(brain: $brain)
                .padding(.bottom)
        }
        .scaleEffect(scale)
        
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPhone 11").environment(\.colorScheme, ColorScheme.light)
//            ContentView().previewDevice("iPhone SE (2nd generation)")
        }
    }
}
