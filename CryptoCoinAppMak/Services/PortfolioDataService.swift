//
//  PortfolioDataService.swift
//  CryptoCoinAppMak
//
//  Created by Paris Makris on 16/12/23.
//

import Foundation
import CoreData
import SwiftUI

class PortfolioDataService {
    
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "Portfolio"
    
    @Published var savedEntities: [Portfolio] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading Core Data: \(error.localizedDescription)")
            }
            self.getPortfolio()
        }
        
    }
    
    //MARK: - PUBLIC
    
    func updatePortfolio(coin: Coin, amount: Double){
        
        if let entity = savedEntities.first(where: {$0.coinID == coin.id}){
            
            if amount > 0 {
                update(entity: entity, amount: amount)
            }else{
                delete(entity: entity)
            }
        }else{
            add(coin: coin, amount: amount)
        }
          
            
    }
    
    
    //MARK: - PRIVATE
    
    func getPortfolio(){
        let request = NSFetchRequest<Portfolio>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching Portfolio Entities: \(error.localizedDescription)")
        }
    }
    
    private func add(coin: Coin, amount: Double){
        let entity = Portfolio(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    private func update(entity: Portfolio, amount: Double){
        entity.amount = amount
        applyChanges()
    }
    
    private func delete(entity: Portfolio){
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save(){
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to Core Data. \(error)")
        }
    }
    
    private func applyChanges(){
        save()
        getPortfolio()
    }
    
}
