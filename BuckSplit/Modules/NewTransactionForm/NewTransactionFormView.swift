//
//  NewTransactionFormView.swift
//  BuckSplit
//
//  Created by Ardyansyah Wijaya on 10/02/23.
//

import SwiftUI

struct NewTransactionFormView: View {
    @Binding var isPresented: Bool
    @ObservedObject private var presenter = NewTransactionFormPresenter()
    
    var body: some View {
        NavigationView {
            Form {
                // MARK: Transaction Infromation
                Section(header: Text("new_trans_form.trans_infromation")) {
                    TextField("common.name", text: $presenter.name)
                        .autocorrectionDisabled()
                    HStack {
                        Text("common.type")
                        Spacer()
                        Picker("common.type", selection: $presenter.type) {
                            ForEach(presenter.transactionType, id: \.self) { type in
                                Text(type.value)
                            }
                        }
                        .pickerStyle(.segmented)
                        .fixedSize()
                    }
                    TextField("common.amount", text: $presenter.transAmount)
                        .autocorrectionDisabled()
                }
                
                //MARK: Transaction Detail
                Section(header: Text("new_trans_form.trans_detail")) {
                    DatePicker("common.date", selection: $presenter.transDate, displayedComponents: .date)
                    TextField("common.name", text: $presenter.name)
                        .autocorrectionDisabled()
                    TextField("common.name", text: $presenter.name)
                        .autocorrectionDisabled()
                }
            }
            .navigationTitle("new_trans_form.title")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isPresented = false
                    } label: {
                        Image(systemName: "xmark")
                    }

                }
            }
        }
    }
}

struct NewTransactionFormView_Previews: PreviewProvider {
    static var previews: some View {
        NewTransactionFormView(isPresented: .constant(true))
    }
}
