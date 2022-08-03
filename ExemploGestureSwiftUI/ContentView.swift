//
//  ContentView.swift
//  ExemploGestureSwiftUI
//
//  Created by Renato Yoshinari on 03/08/22.
//

import SwiftUI

struct ContentView: View {
    @GestureState var isLongPressed = false
    @State var offset: CGSize = .zero
    
    var body: some View {
        VStack {
            let longPressGesture = LongPressGesture()
                .updating($isLongPressed) { newValue, state, transaction in
                    state = newValue
                }
            let dragGesture = DragGesture()
                .onChanged { value in
                    self.offset = value.translation
                }
                .onEnded { _ in
                    self.offset = .zero
                }
            
            Image(systemName: "swift")
                .resizable()
                .frame(width: 128, height: 128, alignment: .center)
                .foregroundColor(isLongPressed ? .blue : .yellow)
                .scaleEffect(isLongPressed ? 2 : 1)
                .gesture(longPressGesture)
                .animation(.default, value: 1.0)

            
            Spacer()
                .frame(width: 128, height: 128, alignment: .center)
            
            Image(systemName: "swift")
                .resizable()
                .foregroundColor(.red)
                .frame(width: 128, height: 128, alignment: .center)
                .offset(offset)
                .gesture(dragGesture)
                .animation(.default, value: isLongPressed)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
