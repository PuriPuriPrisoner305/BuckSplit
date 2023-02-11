//
//  NewTransactionFormEntity.swift
//  BuckSplit
//
//  Created by Ardyansyah Wijaya on 10/02/23.
//

import Foundation

enum TransactionType: Codable {
    case debt
    case loan
    
    var value: String {
        switch self {
        case .debt:
            return .localized("common.debt")
        case .loan:
            return .localized("common.loan")
        }
    }
}

