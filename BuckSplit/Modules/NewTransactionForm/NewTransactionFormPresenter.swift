//
//  NewTransactionFormPresenter.swift
//  BuckSplit
//
//  Created by Ardyansyah Wijaya on 10/02/23.
//

import Foundation

class NewTransactionFormPresenter: ObservableObject {
    @Published var name = ""
    @Published var type: TransactionType = .loan
    @Published var transLabel = ""
    @Published var transDate = Date()
    @Published var transAmount = ""
    @Published var transDetail = ""
    
    var transactionType: [TransactionType] = [.loan, .debt]
}
