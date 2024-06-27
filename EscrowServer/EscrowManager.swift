import Foundation
import AppKit
import TabularData

//class DataflowFunction: NSObject {
    
//    public static let shared = DataflowFunction()

//}

extension String {
    func toImage() -> NSImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return NSImage(data: data)
        }
        return nil
    }
}

class EscrowManager {
    
    private static let shared = EscrowManager()
        
    private var funcNameDict: [String : DataflowFunctionType] = [:]
    
    private init() {
        
        // Assuming the developer implemented all dataflow functions in the dataflow_functions folder (in their app code), Apple/users will vet the functions, if allowed, the server pulls the folder (I omit this part) and create a mapping for all functions
        
        self.funcNameDict = self.mapNameToFunction()
        
//        funcNameDict["test"] = test
    }
    
    static func runFunction(_ funcName: String, _ success: Bool, _ df: DataFrame?) -> Data? {
        
        
        if let function = shared.funcNameDict[funcName] {
            if let df = df {
                // TODO: need some other param in the request to indicate the asset col needs to be transformed
                if df.containsColumn("asset", String.self) {
    //                let image_arr = df["asset"].map {
    //                    ele in
    //                    let data = Data(String(describing: ele).utf8)
    //                    return NSImage(data: data)
    //                }
                    var new_df = df
                    new_df.transformColumn("asset") {
                        (ele: String) -> NSImage? in
                        let data = Data(String(describing: ele).utf8)
                        return NSImage(data: data)
                    }
                    return function(success, new_df)
                }
            }
            return function(success, df)
        }
        else {
            fatalError("function \(funcName) does not exist")
        }
                
//        let functions = DataflowFunctions()
//        let mirror = Mirror(reflecting: functions)
//
//        for (_, value) in mirror.children {
//    //        print("\(label), \(value)")
//            let function = value as? DataflowFunctionWrapper
//            
//            if function!.name == funcName {
//                return function!.wrappedValue(success, df)
//            }
//        }
//        
//        fatalError("function \(funcName) does not exist")
    }
    
    private func mapNameToFunction() -> [String : DataflowFunctionType] {
        
        var dict: [String : DataflowFunctionType] = [:]
        
        for df in DataflowFunctions {
            dict[df.name] = df.function
        }
        
//        let functions = DataflowFunctions()
//        let mirror = Mirror(reflecting: functions)
//        
//        for (_, value) in mirror.children {
//    //        print("\(label), \(value)")
//            let function = value as? DataflowFunctionWrapper
//            dict[function!.name] = function!.wrappedValue
//        }
//        
        return dict
    }
    
//    func test(_ success: Bool, _ df: DataFrame?) -> Void {
//        if success {
//            if let df = df {
//                print("\(df)")
//                //            var data = try! df.csvRepresentation()
//                //            var new_df = try! DataFrame(csvData: data)
//                //            print("\(new_df)")
//            }
//        }
//        else {
//            print("error")
//        }
//    }
    
}
