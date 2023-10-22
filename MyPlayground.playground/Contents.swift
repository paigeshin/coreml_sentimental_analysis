import Cocoa
import CreateML
import Foundation

let filePath = "/Users/paigeshin/Desktop/playground/sentimental_analysis/epinions3.csv"
let outputFileName = "/Users/paigeshin/Desktop/playground/sentimental_analysis/SentimentAnalysisClassiferModel.mlmodel"

let dataURL = URL(fileURLWithPath: filePath)
let data = try MLDataTable(contentsOf: dataURL)

let (trainingData,testingData) = data.randomSplit(by: 0.8)

let sentimentClassifier = try MLTextClassifier(trainingData: trainingData, textColumn: "text", labelColumn: "class")

let metadata = MLModelMetadata(author: "Paige Shin", shortDescription: "Sentiment Analysis Model", version: "1.0")

try sentimentClassifier.write(to: URL(fileURLWithPath: outputFileName), metadata: metadata)

