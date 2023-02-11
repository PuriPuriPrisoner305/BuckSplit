//
//  NewTransactionFormView.swift
//  BuckSplit
//
//  Created by Ardyansyah Wijaya on 10/02/23.
//

import SwiftUI
import Contacts

struct NewTransactionFormView: View {
    @State private var isShowingContactPicker = false
    @ObservedObject private var presenter = NewTransactionFormPresenter()
    
    var body: some View {
        Form {
            // MARK: Transaction Infromation
            Section(header: Text("new_trans_form.trans_infromation")) {
                TextField("common.amount", text: $presenter.transAmount)
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
                
                HStack {
                    TextField(presenter.nameLabel, text: $presenter.name)
                        .autocorrectionDisabled()
                    Button {
                        isShowingContactPicker = true
                    } label: {
                        Text("Contact")
                    }
                    .navigationBarBackButtonHidden()
                    .navigationBarTitleDisplayMode(.inline)

                }
                .sheet(isPresented: $isShowingContactPicker, content: {
                    ContactPickerView(contactInfo: $presenter.contactFile)
                })
                .onChange(of: presenter.contactFile) { newValue in
                    presenter.loadContactInfo(newValue)
                }
                
                TextField("Phone Number", text: $presenter.phoneNumber)
                TextField("Email", text: $presenter.email)

            }
            
            //MARK: Transaction Detail
            Section(header: Text("new_trans_form.trans_detail")) {
                DatePicker("common.date", selection: $presenter.transDate, displayedComponents: .date)
                Button("new_trans_form.add_reminder") {
                    
                }
                
                Button("new_trans_form.set_location") {
                    
                }
                
                Button("new_trans_form.add_photo") {
                    
                }
            }
        }
        .navigationTitle("new_trans_form.title")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(false)
        
    }
}

struct NewTransactionFormView_Previews: PreviewProvider {
    static var previews: some View {
        NewTransactionFormView()
    }
}

