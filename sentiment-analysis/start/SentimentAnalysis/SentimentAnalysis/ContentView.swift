//
//  ContentView.swift
//  SentimentAnalysis
//
//  Created by Mohammad Azam on 2/24/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import CoreML
import SwiftUI

struct ContentView: View {
    
    @State private var text: String = ""
    @State private var isPositive: Bool?
    
    private var model: SentimentAnalysisClassiferModel? {
        try? SentimentAnalysisClassiferModel(configuration: MLModelConfiguration())
    }
    
    var body: some View {
        
        let screenSize = UIScreen.main.bounds
        
        return VStack {
            TextView(text: $text)
                .frame(width: screenSize.width, height: 300)
            Spacer()
            
            (isPositive != nil ? Text(isPositive! ? "😊" : "😞") : Text("")).font(.custom("Arial",size: 100))
            
            Spacer()
    
            Button("Sentiment Analysis") {
                
                // perform sentiment analysis
                DispatchQueue.global().async {
                    guard
                        let output = try? self.model?.prediction(text: self.text)
                    else { return }
                    self.isPositive = output.label == "Pos"
                }
                
                
            }.padding()
                .background(Color.green)
                .foregroundColor(Color.white)
                .cornerRadius(10)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
