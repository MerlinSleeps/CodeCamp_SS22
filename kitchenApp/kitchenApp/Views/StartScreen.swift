//
//  StartScreen.swift
//  kitchenApp
//
//  Created by Olga Molenova on 14.06.22.
//
import SwiftUI

enum AnimationState {
    case normal
    case compress
    case expand
}

struct StartScreen: View {
    
    @State private var animationState: AnimationState = .normal
    @State private var done: Bool = false
    
    
    func calculate() -> Double {
        
        switch animationState {
        case .normal:
            return 0.2
        case .compress:
            return 0.18
        case .expand:
            return 10.0
        }
    }
    
    
    var body: some View {
        
        NavigationView {
            ZStack {
                
                LoginScreen()
               
                VStack {
                    Image("Image-2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaleEffect(calculate())
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.green)
                    .opacity(done ? 0: 1)
                
            }
            .navigationBarHidden(done ? false: true)
            
            .onAppear(){
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.spring()) {
                        animationState = .compress
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation(.spring()) {
                                animationState = .expand
                                withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 100.0, damping: 10.0, initialVelocity: 0)) {
                                    done = true
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct StartScreen_Previews: PreviewProvider {
    static var previews: some View {
        StartScreen()
    }
}
