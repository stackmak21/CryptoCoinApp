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
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                HomeView()
                    .navigationBarHidden(true)
                    .navigationBarTitleDisplayMode(.large)
            }
            .environmentObject(vm)
        }
    }
}
