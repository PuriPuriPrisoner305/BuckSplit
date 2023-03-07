//
//  Popup.swift
//  BuckSplit
//
//  Created by ardy on 07/03/23.
//

import Foundation
import SwiftUI

struct Popup<T: View>: ViewModifier {
    @Binding var isPresented: Bool
    
    let popup: T
    let alignment: Alignment
    
    init(isPresented: Binding<Bool>, alignment: Alignment, @ViewBuilder content: () -> T) {
        self._isPresented = isPresented
        self.alignment = alignment
        popup = content()
    }

    func body(content: Content) -> some View {
        content
            .overlay(popupContent())
            
    }

    @ViewBuilder private func popupContent() -> some View {
        GeometryReader { geometry in
            if isPresented {
                ZStack {
                    Color.black
                        .opacity(0.2)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .gesture(
                            TapGesture()
                                .onEnded({ _ in
                                    withAnimation {
                                        self.isPresented = false
                                    }
                                })
                        )
                        
                    
                    popup
                        .transition(.move(edge: .bottom))
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: alignment)
                        
                }
                
            } else {
                popup.hidden()
            }
        }
        .ignoresSafeArea()
    }
}

struct Popup2_Previews: PreviewProvider {
    static var previews: some View {
        Color.clear
            .modifier(Popup(isPresented: .constant(true),
                            alignment: .topTrailing,
                            content: { Color.orange.frame(width: 100, height: 100) }))
            .modifier(Popup(isPresented: .constant(true),
                            alignment: .bottomLeading,
                            content: { Color.blue.frame(width: 100, height: 100) }))
    }
}
