//
//  kitchenAppApp.swift
//  kitchenApp
//
//  Created by Willi Pindjukov on 06.05.22.
//

import SwiftUI

@main
struct kitchenAppApp: App {
    var body: some Scene {
        WindowGroup {
            StartScreen()
        }
    }
}


struct ApplicationSwitcher: View {

    @EnvironmentObject var vm: LoginViewModel

    var body: some View {
        
        if(vm.isBusy){
            ProgressView()
        }   else  if(vm.isAdmin){
            MainScreenAdmin()
            // 1
                  .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { (_) in
                      vm.resetTimer()
                  }
                  // 2
                  .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { (_) in
                      vm.startTimer()
                      
                  }
        } else if (vm.isLoggedIn) {
            MainScreen()
            // 1
                  .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { (_) in
                      vm.resetTimer()
                  }
                  // 2
                  .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { (_) in
                      vm.startTimer()
                  }
        } else {
            LoginScreen()
        }
    }
}
