//
//  UIApplication.swift
//  CryptoCoinAppMak
//
//  Created by Paris Makris on 16/11/23.
//

import Foundation
import SwiftUI

extension UIApplication{
    
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
