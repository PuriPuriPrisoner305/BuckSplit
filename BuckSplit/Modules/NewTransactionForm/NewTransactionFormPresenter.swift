//
//  NewTransactionFormPresenter.swift
//  BuckSplit
//
//  Created by Ardyansyah Wijaya on 10/02/23.
//

import Foundation
import Contacts
import SwiftUI
import CoreLocation

class NewTransactionFormPresenter: ObservableObject {
    @Published var name = ""
    @Published var contactFile = CNContact()
    @Published var type: TransactionType = .loan {
        didSet {
            nameLabel = type == .loan ? .localized("new_trans_form.lender") : .localized("new_trans_form.borrower")
        }
    }
    @Published var phoneNumber = ""
    @Published var email = ""
    
    @Published var transLabel = ""
    @Published var transDate = Date()
    @Published var reminderDate: Date = .now
    @Published var transAmount = ""
    @Published var transDetail = ""
    
    @Published var transLocation = CLLocation(latitude: 35.55552, longitude: -121.55233) {
        didSet {
            print("didupdate \(transLocation)")
        }
    }
    
    var nameLabel: String = .localized("new_trans_form.lender")
    var transactionType: [TransactionType] = [.loan, .debt]
    
    func loadContactInfo(_ contact: CNContact) {
        name = contact.givenName + " " + contact.familyName
        phoneNumber = contact.phoneNumbers.first?.value.stringValue ?? ""
        email = String(contact.emailAddresses.first?.value ?? "")
    }
}
