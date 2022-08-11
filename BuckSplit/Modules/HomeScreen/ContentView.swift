//
//  ContentView.swift
//  BuckSplit
//
//  Created by Ardyansyah Wijaya on 11/08/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var text: [String] = ["A", "B", "C"]
    @State private var textCount = 0
    var body: some View {
        VStack {
            Text(text[textCount])
            Spacer()
            Button("Tap to Change") {
                textCount += 1
            }
        }
    }

}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
