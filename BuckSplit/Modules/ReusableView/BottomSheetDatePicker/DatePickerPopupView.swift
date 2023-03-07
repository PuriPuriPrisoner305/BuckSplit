//
//  DatePickerPopupView.swift
//  BuckSplit
//
//  Created by ardy on 07/03/23.
//

import SwiftUI

struct DatePickerPopupView: View {
    @Binding var selectedDate: Date
    
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Spacer()
                
                Button("common.remove") {
                    selectedDate = .now
                    
                    withAnimation {
                        isPresented = false
                    }
                }
                
            }
            
            DatePicker("", selection: $selectedDate)
                .datePickerStyle(.graphical)
            
        }
        .padding(20)
        
    }
}

struct DatePickerPopupView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerPopupView(selectedDate: .constant(Date()), isPresented: .constant(true))
    }
}
