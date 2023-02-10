//
//  UserDataManager.swift
//  BuckSplit
//
//  Created by Ardyansyah Wijaya on 10/02/23.
//

import Foundation
import UIKit

enum UserDataManager {
    
    static func setDebtData(data: [TransactionEntity]) {
        UserDefaults.standard.set(data, forKey: "transactionDebtData")
    }
    
    static func getDebtData() -> [TransactionEntity]? {
        if let loanData = UserDefaults.standard.object(forKey: "transactionDebtData") as? [TransactionEntity] {
            return loanData
        } else {
            return nil
        }
    }
    
    static func setLoanData(data: [TransactionEntity]) {
        UserDefaults.standard.set(data, forKey: "transactionLoanData")
    }
    
    static func getLoanData() -> [TransactionEntity]? {
        if let loanData = UserDefaults.standard.object(forKey: "transactionLoanData") as? [TransactionEntity] {
            return loanData
        } else {
            return nil
        }
    }
    
}
