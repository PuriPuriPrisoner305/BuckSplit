//
//  ContentView.swift
//  BuckSplit
//
//  Created by Ardyansyah Wijaya on 11/08/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var selectedtab: CurrentTab = .home
    @ObservedObject var presenter = ContentViewPresenter()
    var screenSize = UIScreen.main.bounds.size
    
    var body: some View {
        NavigationView {
            VStack {
                // Card View
                VStack{
                    // Text Inside
                    VStack(alignment: .leading, spacing: 14){
                        Text("\(.localized("homescreen.main_card.loan")): \(presenter.totalLoan)")
                        Text("\(.localized("homescreen.main_card.debt")): \(presenter.totalDebt)")

                    }
                    .padding([.top, .leading, .bottom], 10)
                    
                }
                .frame(width: screenSize.width - 40, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white)
                        .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 3, y: 3)
                )
                Spacer()
                
                CustomTabView(selectedTab: $selectedtab)
                
            }
            .navigationTitle(Text("homescreen.title"))
        }
        .background(.white)
    }

}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
