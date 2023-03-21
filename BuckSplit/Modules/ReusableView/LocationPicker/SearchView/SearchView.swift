//
//  SearchView.swift
//  BuckSplit
//
//  Created by ardy on 21/03/23.
//

import SwiftUI
import MapKit

struct SearchView: View {
    @State private var distance: String?
    
    @ObservedObject var locVM: LocationManager
    let searchResult: MKLocalSearchCompletion
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "pin")
                VStack(alignment: .leading, spacing: 10) {
                    Text(searchResult.title)
                    Text(searchResult.subtitle)
                    if let distance = distance {
                        Text(distance)
                    }
                }
               
            }.task {
                locVM.getDistance(searchResult: searchResult) { value in
                    self.distance = value
                }
            }
            
        }
        
    }
}

struct SearchCompleter: View {
    @ObservedObject var locVM: LocationManager
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        VStack {
            TextField("Search..", text: $locVM.search)
                .textFieldStyle(.roundedBorder)
            List(locVM.searchResults,id: \.self) {res in
                VStack(alignment: .leading, spacing: 0) {
                    SearchView(locVM: locVM, searchResult: res)
                }
                .onTapGesture {
                    locVM.name = res.title
                    locVM.reverseUpdate()
                }
            }
        }.background(.clear)
    }
    
//    var body: some View {
//        NavigationView {
//            VStack {
//                TextField("Search..", text: $locVM.search)
//                    .textFieldStyle(.roundedBorder)
//                List(locVM.searchResults,id: \.self) {res in
//                    VStack(alignment: .leading, spacing: 0) {
//                        SearchView(locVM: locVM, searchResult: res)
//                    }
//                    .onTapGesture {
//                        locVM.name = res.title
//                        locVM.reverseUpdate()
//                        dismiss()
//                    }
//                }
//            }.padding()
//                .navigationTitle(Text("Search For Place"))
//        }
//    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(locVM: LocationManager(), searchResult: MKLocalSearchCompletion())
    }
}
