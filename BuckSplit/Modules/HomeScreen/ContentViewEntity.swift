//
//  ContentViewEntity.swift
//  BuckSplit
//
//  Created by Ardyansyah Wijaya on 10/02/23.
//

import Foundation
import Contacts

struct TransactionEntity: Codable {
    var name: ContactInfo
    var amount: String
    var transType: TransactionType
    var transDate: Date
    var transStatus: PaymentStatus
    var transDescription: String
}

enum PaymentStatus: Codable {
    case notPaid
    case partiallyPaid
    case paid
}

struct ContactInfo: Identifiable, Codable {
    var id = UUID()
    var firstName: String?
    var lastName: String?
    var phoneNumber: String?
    var email: String?
}
