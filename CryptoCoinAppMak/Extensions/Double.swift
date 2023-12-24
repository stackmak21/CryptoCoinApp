//
//  Double.swift
//  CryptoCoinAppMak
//
//  Created by Paris Makris on 7/11/23.
//

import Foundation
import SwiftUI

extension Double{
    
    /// Converts a Double into a Currency with 2-6 decimal places
    /// ```
    ///    Convert 1234.56 to 1,234.56€
    ///    Convert 12.3456 to 12.3456€
    ///    Convert 12345.6 to 12,345.60
    /// ```
    private var currencyFormatter6: NumberFormatter{
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current
        
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    private var currencyFormatter2: NumberFormatter{
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    
    /// Converts a Double into a Currency with 2-6 decimal places
    /// ```
    ///    Convert 1234.56 to 1,234.56€
    ///    Convert 12.3456 to 12.3456€
    ///    Convert 12345.6 to 12,345.60€
    /// ```
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "0.0"
    }
    
    
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "0.0"
    }
    
    /// Converts a Double into String representation
    /// ```
    ///    Convert 12.3456 to 12.34
    /// ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
    
    func formattedWithAbbreviations() -> String {
        let num = abs(Double(self))
        let sign = self < 0 ? "-" : ""
        
        switch num {
        case 1_000_000_000_000...:
            let numString: String = (num/1_000_000_000_000).asNumberString()
            return "\(sign)\(numString)Tr"
        case 1_000_000_000...:
            let numString: String = (num/1_000_000_000).asNumberString()
            return "\(sign)\(numString)Bn"
        case 1_000_000...:
            let numString: String = (num/1_000_000).asNumberString()
            return "\(sign)\(numString)M"
        case 1_000...:
            let numString: String = (num/1_000).asNumberString()
            return "\(sign)\(numString)K"
        case 0...:
            return "\(self)"
        default:
            return "\(sign)\(self)"
        }
    }
}
