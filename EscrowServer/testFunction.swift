import Foundation
import TabularData

func dataflowFunction(_ success: Bool, _ df: DataFrame?) -> Void {
    if success {
        if let df = df {
            print("\(df)")
//            var data = try! df.csvRepresentation()
//            var new_df = try! DataFrame(csvData: data)
//            print("\(new_df)")
        }
    }
    else {
        print("error")
    }
}
