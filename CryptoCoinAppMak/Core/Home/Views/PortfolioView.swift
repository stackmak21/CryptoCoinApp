//
//  PortfolioView.swift
//  CryptoCoinAppMak
//
//  Created by Paris Makris on 25/11/23.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: Coin? = nil
    @State private var quantityText: String = ""
    @State private var showCheckmark: Bool = false
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(alignment: .leading, spacing: 0.0){
                    SearchBarView(searchText: $vm.searchText)
                    coinLogoList
                    if selectedCoin != nil {
                        portfolioInputSection
                    }
                }
                .navigationTitle("Edit Portfolio")
                .navigationBarTitleDisplayMode(.large)
            }
            
            .toolbar{
                ToolbarItem(placement: .topBarLeading) { XMarkButton() }
                ToolbarItem(placement: .topBarTrailing) {
                    trailingNavBarButtons
                }
            }
            .onChange(of: vm.searchText) { oldValue, newValue in
                if newValue.isEmpty{
                    removeSelectedCoin()
                }
            }
        }
    }
}

#Preview {
    PortfolioView()
        .environmentObject(Preview.dev.homeVm)
}


extension PortfolioView {
    
    private var coinLogoList: some View {
        ScrollView(.horizontal){
            LazyHStack(spacing: 10){
                ForEach(vm.searchText.isEmpty ? vm.portfolioCoins : vm.allCoins ){ coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                updateSelectedCoin(coin: coin)
                            }
                        }
                    
                        .background{
                            RoundedRectangle(cornerRadius: 10)

                                .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear ,lineWidth: 1)
                        }
                }
                
            }
            .frame(height: 120)
            .padding(.leading)
            
        }
        .scrollIndicators(ScrollIndicatorVisibility.hidden)
    }
    
    private func updateSelectedCoin(coin: Coin){
        selectedCoin = coin
        
        if let portfolioCoin = vm.portfolioCoins.first(where: {$0.id == coin.id}),
           let amount = portfolioCoin.currentHoldings {
            print("\(portfolioCoin.currentHoldings ?? 0) updateSelectedCoin PortfolioView" )
            quantityText = "\(amount)"
        } else {
            quantityText = ""
        }
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    
    private var portfolioInputSection: some View{
        VStack(spacing: 20){
            HStack{
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
            }
            Divider()
            HStack{
                Text("Amount in your portfolio:")
                Spacer()
                TextField("Ex. 14", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack{
                Text("Current value:")
                Spacer()
                Text(getCurrentValue().asCurrencyWith6Decimals())
            }
        }
        .animation(.none, value: selectedCoin)
        .font(.headline)
        .padding(.horizontal)
    }
    
    private var trailingNavBarButtons: some View {
        HStack{
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1.0 : 0.0)
            Button{
                print("Button pressed")
                saveButtonPressed()
            }label: {
                Text("save".uppercased())
                    .foregroundStyle(Color.primary)
            }
            .opacity(selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText) ? 1.0 : 0.0)
        }
        .font(.headline)
    }
    
    private func saveButtonPressed(){
        guard 
            let coin = selectedCoin,
            let amount = Double(quantityText)
        else { return }
        vm.updatePortfolio(coin: coin, amount: amount)
        withAnimation(.easeIn) {
            showCheckmark = true
            removeSelectedCoin()
        }
        // Hide Keyboard
        UIApplication.shared.endEditing()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            withAnimation(.easeOut) {
                showCheckmark = false
            }
        }
    }
    
    private func removeSelectedCoin(){
        selectedCoin = nil
        vm.searchText = ""
    }
}
