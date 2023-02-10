//
//  String+Extension.swift
//  BuckSplit
//
//  Created by Ardyansyah Wijaya on 10/02/23.
//

import Foundation
import UIKit

extension String {
    
    static func localized(_ string: String) -> String {
        return NSLocalizedString(string, comment: "")
    }
}

