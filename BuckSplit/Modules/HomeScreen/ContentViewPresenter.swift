//
//  ContentViewPresenter.swift
//  BuckSplit
//
//  Created by Ardyansyah Wijaya on 10/02/23.
//

import Foundation
import SwiftUI

class ContentViewPresenter: ObservableObject {
    @Published var loanData: [TransactionEntity] = []
    @Published var debtData: [TransactionEntity] = []
    @Published var totalLoan: String = ""
    @Published var totalDebt: String = ""
    
    init() {
        let loanData = getLoanData()
        let debtData = getDebtData()
        self.loanData = loanData
        self.debtData = debtData
        updateTotalDebtAmount(debtData: debtData)
        updateTotalLoanAmount(loanData: loanData)
    }
    
    func getDebtData() -> [TransactionEntity] {
        if let data = UserDataManager.getDebtData() {
            return data
        }
        return []
    }
    
    func getLoanData() -> [TransactionEntity] {
        if let data = UserDataManager.getLoanData() {
            return data
        }
        return []
    }
    
    func updateTotalLoanAmount(loanData: [TransactionEntity]) {
        var loanAmount = 0
        for loan in loanData {
            loanAmount += Int(loan.amount) ?? 0
        }
        totalLoan = String(loanAmount)
    }
    
    func updateTotalDebtAmount(debtData: [TransactionEntity]) {
        var debtAmount = 0
        for debt in debtData {
            debtAmount += Int(debt.amount) ?? 0
        }
        totalDebt = String(debtAmount)
    }
}
