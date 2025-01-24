//
//  ContentView.swift
//  ExampleSwiftUI
//
//  Created by Jakir Hossain on 24/1/25.
//

import SwiftUI
import BackgroundRemoval

struct ContentView: View {
    
    @State private var outputImage: UIImage?
    @State private var segmentedImage: UIImage?
    let image = UIImage(named: "child")

    var body: some View {
        VStack {
            if let inputImage = image {
                Image(uiImage: inputImage)
                    .resizable()
                    .scaledToFit()
            } else {
                Text("Input image not found")
                    .foregroundColor(.red)
            }
            
            if let processedImage = outputImage {
                Image(uiImage: processedImage)
                    .resizable()
                    .scaledToFit()
            } else {
                Text("Processed image will appear here")
                    .foregroundColor(.gray)
            }
            
            if let segmented = segmentedImage {
                Image(uiImage: segmented)
                    .resizable()
                    .scaledToFit()
            }
        }
        .padding()
        .onAppear {
            processImage()
        }
    }
    
    func processImage() {
        guard let image = image else {
            print("Input image not found")
            return
        }
        do {
            let remover = BackgroundRemoval()
            outputImage = try remover.removeBackground(image: image)
            segmentedImage = try remover.removeBackground(image: image, maskOnly: true)
        } catch {
            print("Error while processing image: \(error.localizedDescription)")
        }
    }
}


#Preview {
    ContentView()
}
