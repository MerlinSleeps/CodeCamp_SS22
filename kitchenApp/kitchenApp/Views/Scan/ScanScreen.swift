//
//  ScanScreen.swift
//  kitchenApp
//
//  Created by Olga Molenova on 21.07.22.
//

import SwiftUI
import CodeScanner

struct ScanScreen: View {
    
    @State var isPresentingScanner = false
    @State var scannedCode: String = ""
    @State var scannedItem: ScannedItem?
    @State var showButton: Bool = true
    @State var itemPurchased: Bool = false
    @State var message: String = ""
    @EnvironmentObject var vm: LoginViewModel

    
    var scannerSheet : some View {
        CodeScannerView(
            codeTypes: [.qr],
            completion: { result in
                if case let .success(code) = result {
                    self.scannedCode = code.string
                    self.scannedItem = Optional.none
                    self.isPresentingScanner = false
                    if let jsonData = scannedCode.data(using: .utf8)

                    {
                        do {
                            message = ""
                            let scItem = try JSONDecoder().decode(ScannedItem.self, from: jsonData)
                          
                            self.scannedItem = scItem
                            
                        } catch {
                            message = "Invalid kitchenApp tag"
                            print("ERROR:", error)
                        }
                    }
                }
            }
        )
    }
    
    var body: some View {
        VStack(spacing: 100) {
            
            Spacer()
            
            if let scannedItem = scannedItem {
                Text(scannedItem.name).fontWeight(Font.Weight.bold)
            } else {
                Text(scannedCode)
            }
            
            Text("\(message)")
                .foregroundColor(.red)
            
            Button
            {
                isPresentingScanner = true
            } label: {
                Label("Scan", systemImage: "qrcode.viewfinder")
            }
            .sheet(isPresented: $isPresentingScanner) {
                self.scannerSheet
            }.onAppear {
                if(scannedCode.isEmpty){
                    isPresentingScanner = true
                }
            }
            if(!vm.isAdmin) {
            NavigationLink(destination: MainScreen().environmentObject(self.vm), isActive: $itemPurchased){}
            } else {NavigationLink(destination: MainScreenAdmin().environmentObject(self.vm), isActive: $itemPurchased){}}
            
            Spacer()
            if let item = scannedItem {
                Button ("Buy", action: {
                    let userID = AppState.shared.id
                    Webservice().purchaseItem(id: userID , itemId: item.id, amount: 1) { result in
                       switch result {
                       case .success():
                           self.itemPurchased = true
                       case .failure(let error):
                           message = "Unable to buy"
                           print(error.localizedDescription)
                       }
                    }
                })
                .buttonStyle(GeneralButton())
            } else {
                Button ("Buy", action: {
                    
                }).hidden()
            }
        }
    }
}


struct ScanScreen_Previews: PreviewProvider {
    static var previews: some View {
        ScanScreen()
    }
}
