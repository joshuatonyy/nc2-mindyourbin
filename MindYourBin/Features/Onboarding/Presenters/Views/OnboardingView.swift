//
//  OnboardingView.swift
//  MindYourBin
//
//  Created by Joshua on 20/05/23.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        NavigationView {
            ZStack{
                Color.black.ignoresSafeArea()
                VStack{
                    Image("Mind Your Bin-3")
                        .frame(width: 100, height: 150)
                        .padding(.bottom, 90)
                    Text("Welcome to Mind Your Bin")
                        .font(.system(size: 32))
                        .foregroundColor(Color.white)
                    Text("Please mind that the app can detect your trash into either: metal, plastic, glass, cardboard, or paper")
                        .padding(.top, 20)
                        .font(.system(size: 21))
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                    NavigationLink(destination: CameraSummary()){
                        Text("Next")
                            .font(.system(size: 21))
                            .padding(.horizontal, 70)
                            .padding(.vertical, 8)
                            .foregroundColor(.white)
                            .background(.blue)
                            .cornerRadius(8)
                            .padding(.top, 100)
                            .navigationBarBackButtonHidden(true)
                    }
                }
            }
        }
    }
    
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
