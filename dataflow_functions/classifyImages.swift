import Foundation
import AppKit
import TabularData

fileprivate var predictionResults: String = ""

func classifyImages(_ success: Bool, _ df: DataFrame?) -> Data? {
    var images : Array<NSImage> = Array<NSImage>()
    
    if success {
        if let df = df {
//            print(df)
            images = df["asset"].map{
                $0 as! NSImage
            }
            print("Number of images: \(images.count)")
//            print(images.first!.isValid)
//            print(images.first!.size)
            let imagePredictor = ImagePredictor()
            
            
            do {
                for (i, image) in images.enumerated() {
                    
                    predictionResults += "image\(i):\n"
                    try imagePredictor.makePredictions(for: image,
                                                        completionHandler: imagePredictionHandler)
                }
                
            } catch {
                print("Vision was unable to make a prediction...\n\n\(error.localizedDescription)")
            }
        }
    }
    else {
        print("error")
    }
    
//    return nil
    print(predictionResults)
    return Data(predictionResults.utf8)
}

/// The method the Image Predictor calls when its image classifier model generates a prediction.
/// - Parameter predictions: An array of predictions.
/// - Tag: imagePredictionHandler
fileprivate func imagePredictionHandler(_ predictions: [ImagePredictor.Prediction]?) {
    guard let predictions = predictions else {
        fatalError("No predictions. (Check console log.)")
    }

    let formattedPredictions = formatPredictions(predictions)

    let predictionString = formattedPredictions.joined(separator: "\n")
//    updatePredictionLabel(predictionString)
    predictionResults += predictionString + "\n"
}

/// Converts a prediction's observations into human-readable strings.
/// - Parameter observations: The classification observations from a Vision request.
/// - Tag: formatPredictions
fileprivate func formatPredictions(_ predictions: [ImagePredictor.Prediction]) -> [String] {
    
    let predictionsToShow = 2
    
    // Vision sorts the classifications in descending confidence order.
    let topPredictions: [String] = predictions.prefix(predictionsToShow).map { prediction in
        var name = prediction.classification

        // For classifications with more than one name, keep the one before the first comma.
        if let firstComma = name.firstIndex(of: ",") {
            name = String(name.prefix(upTo: firstComma))
        }

        return "\(name) - \(prediction.confidencePercentage)%"
    }

    return topPredictions
}
