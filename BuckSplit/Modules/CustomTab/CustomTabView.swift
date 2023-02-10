//
//  CustomTabView.swift
//  BuckSplit
//
//  Created by Ardyansyah Wijaya on 10/02/23.
//

import SwiftUI

struct CustomTabView: View {
    @State var isAddButtonTap = false
    @Binding var selectedTab: CurrentTab
    
    var body: some View {
        HStack {
            // MARK: Home Button
            Button {
                withAnimation {
                    selectedTab = .home
                }
            } label: {
                GeometryReader { geo in
                    if selectedTab == .home {
                        Rectangle()
                            .frame(width: geo.size.width/2, height: 5)
                            .position(x: geo.size.width/2)
                    }
                  
                    VStack(alignment: .center, spacing: 10) {
                        Image(systemName: "house")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        Text("Home")
                            .font(Font.caption)
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                }
                
            }
            .tint(Color.indigo)
            
            // MARK: Add Button
            Button {
                isAddButtonTap = true
            } label: {
                GeometryReader { geo in
                    VStack(alignment: .center, spacing: 10) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 36, height: 36)
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                }
            }
            .tint(Color.indigo)
            .sheet(isPresented: $isAddButtonTap, onDismiss: {
                isAddButtonTap = false
            }) {
                NewTransactionFormView(isPresented: $isAddButtonTap)
            }
                
            // MARK: Profile Button
            Button {
                withAnimation {
                    selectedTab = .profile
                }
            } label: {
                GeometryReader { geo in
                    if selectedTab == .profile {
                        Rectangle()
                            .frame(width: geo.size.width/2, height: 5)
                            .position(x: geo.size.width/2)
                    }
                    
                    VStack(alignment: .center, spacing: 10) {
                        Image(systemName: "person")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        Text("Profile")
                            .font(Font.caption)
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                }
            }
            .tint(Color.indigo)
            
        }
        .frame(height: 70)
    }
}

struct CustomTabView_Previews: PreviewProvider {

    static var previews: some View {
        CustomTabView(selectedTab: .constant(.home))
    }
}
