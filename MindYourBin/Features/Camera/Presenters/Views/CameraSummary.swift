//
//  CameraSummary.swift
//  MindYourBin
//
//  Created by Joshua on 22/05/23.
//

import SwiftUI
import CoreML
import Vision

struct CameraSummary: View {
    
    @State var capturedImage: UIImage? = nil
    @State private var isCustomCameraViewPresented = false
    
    @State var classificationResult: String = ""
    private let model = MyImageClassifier2()
    
    var body: some View {
        NavigationView{
            ZStack {
                Color.black.ignoresSafeArea()
                if capturedImage != nil {
                    Image(uiImage: capturedImage!)
                        .resizable()
                        .scaledToFill()
                } else {
                    Color(UIColor.black)
                }
                
                VStack {
                    if capturedImage == nil {
                        Text("Press the camera button to start taking picture")
                            .font(.system(size: 21))
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                        Button(action: {
                            isCustomCameraViewPresented.toggle()
                        }, label: {
                            Image(systemName: "camera.fill")
                                .font(.largeTitle)
                                .padding()
                                .background(Color.black)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                                .padding(.bottom)
                        })
                        .sheet(isPresented: $isCustomCameraViewPresented, content: {
                            CustomCameraView(capturedImage: $capturedImage)
                        })
                    }
                }
            }
            .toolbar(capturedImage == nil ? .hidden : .visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        capturedImage = nil
                    } label: {
                        Text("Retake")
                            .foregroundColor(Color.yellow)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        SummaryView(detectedTrash: $classificationResult, imageTrash: $capturedImage)
                    } label: {
                        Text("Done")
                            .bold()
                            .foregroundColor(Color.yellow)
                    }.simultaneousGesture(TapGesture().onEnded{
                        classifyImage()
                    })

                }
            }
        }.navigationBarHidden(true)
    }
    
    func classifyImage() {
        guard let image = capturedImage,
              let ciImage = CIImage(image: image) else {
            return
        }

        let request = VNCoreMLRequest(model: try! VNCoreMLModel(for: model.model))

        let handler = VNImageRequestHandler(ciImage: ciImage)
        try! handler.perform([request])

        guard let observations = request.results as? [VNClassificationObservation],
              let bestResult = observations.first else {
            return
        }

        self.classificationResult = bestResult.identifier
        print(self.classificationResult)
    }
}

struct CameraSummary_Previews: PreviewProvider {
    static var previews: some View {
        CameraSummary()
    }
}
