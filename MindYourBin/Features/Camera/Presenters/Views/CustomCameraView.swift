//
//  CustomCameraView.swift
//  MindYourBin
//
//  Created by Joshua on 22/05/23.
//

import SwiftUI

struct CustomCameraView: View {
    
    let cameraService = CameraService()
    @Binding var capturedImage: UIImage?
    
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
            ZStack{
                Color.black.ignoresSafeArea()
                VStack{
                    VStack {
                        Text("Capture a trash inside the camera")
                            .font(.system(size: 18))
                            .foregroundColor(Color.white)
                            .padding(.top, 20)
                            .padding(.bottom, 20)
                    }
                    Spacer(minLength: 0)
                    GeometryReader{
                        let size = $0.size
                        
                        ZStack{
                            CameraView(cameraService: cameraService) { result in
                                switch result {
                                case .success(let photo):
                                    if let data = photo.fileDataRepresentation(){
                                        capturedImage = UIImage(data: data)
                                    } else {
                                        print("Error: no image found")
                                    }
                                case .failure(let err):
                                    print(err.localizedDescription)
                                }
                            }
                            ForEach(0...4, id:\.self){ index in
                                let rotation = Double(index) * 90
                                
                                RoundedRectangle(cornerRadius: 2, style: .circular)
                                .trim(from: 0.61, to: 0.64)
                                    .stroke(Color.blue, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                                    .aspectRatio(1,contentMode: .fit)
                                    .rotationEffect(.init(degrees: rotation))
                            }
                        }
                        .frame(width: size.width, height: size.height)
                        .aspectRatio(1, contentMode: .fit)
                        .frame(maxWidth:.infinity, maxHeight: .infinity)
                    }
                            Button(action: {
                                cameraService.capturePhoto()
                            }, label: {
                                ZStack{
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 45, height: 45)
                                    Circle()
                                        .stroke(Color.white, lineWidth: 2)
                                        .frame(width: 55, height: 55)
                                }
                            })
                        
                }
            }
        
    }
}

