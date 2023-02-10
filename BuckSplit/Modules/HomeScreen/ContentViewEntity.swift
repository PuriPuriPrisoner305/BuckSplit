//
//  ContentViewEntity.swift
//  BuckSplit
//
//  Created by Ardyansyah Wijaya on 10/02/23.
//

import Foundation

struct TransactionEntity: Codable {
    let lenderName: String
    let recipientName: String
    let amount: String
    let transDate: Date
    let transStatus: PaymentStatus
    let transDescription: String
}

enum PaymentStatus: Codable {
    case notPaid
    case partiallyPaid
    case paid
}
