//
//  CryptoCoinAppMakApp.swift
//  CryptoCoinAppMak
//
//  Created by Paris Makris on 5/11/23.
//

import SwiftUI

@main
struct CryptoCoinAppMakApp: App {
    
    @StateObject var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
