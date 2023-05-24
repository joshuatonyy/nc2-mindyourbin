//
//  SummaryView.swift
//  MindYourBin
//
//  Created by Joshua on 23/05/23.
//

import SwiftUI

struct SummaryView2: View {
    
    @Binding var detectedTrash: String
    @State private var nonOrganic: [String] = ["plastic", "metal", "glass"]
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.black.ignoresSafeArea()
                VStack{
                    HStack{
                        Text("Summary")
                            .font(.system(size: 40))
                            .bold()
                            .foregroundColor(.white)
                            .padding(.trailing, 145)
                        NavigationLink {
                            CameraSummary()
                        } label: {
                            Text("Done")
                                .bold()
                                .font(.system(size: 21))
                                .foregroundColor(Color.yellow)
                        }
                    }
                    ScrollView{
                        if nonOrganic.contains(detectedTrash){
                            Image("Not Recyclable")
                                .resizable()
                                .scaledToFit()
                        } else {
                            Image("Recyclable")
                                .resizable()
                                .scaledToFit()
                        }
                        HStack{
                            Text("The trash is classified as: ")
                                .foregroundColor(.white)
                                .font(.system(size: 21))
                            if nonOrganic.contains(detectedTrash){
                                Text("Non Recyclable")
                                    .foregroundColor(.white)
                                    .font(.system(size: 21))
                            }
                            else {
                                Text("Recyclable")
                                    .foregroundColor(.white)
                                    .font(.system(size: 21))
                            }
                        }.padding([.top, .bottom], 20)
                        Text("")
                        Spacer()
                    }
                }
            }
        }.navigationBarHidden(true)
    }
}

struct SummaryView2_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView2(detectedTrash: Binding.constant("plastic"))
    }
}

