import Foundation
import TabularData

//class DataflowFunction: NSObject {
    
//    public static let shared = DataflowFunction()

//}

class DataflowFunction {
    
    private static let shared = DataflowFunction()
        
    private var funcNameDict: [String : DataflowFunctionType] = [:]
    
    private init() {
        
        // Assuming the developer implemented all dataflow functions in the dataflow_functions folder (in their app code), Apple/users will vet the functions, if allowed, the server pulls the folder (I omit this part) and create a mapping for all functions
        
        self.funcNameDict = self.mapNameToFunction()
        
//        funcNameDict["test"] = test
    }
    
    static func runFunction(_ funcName: String, _ success: Bool, _ df: DataFrame?) -> Data {
        
        if let function = shared.funcNameDict[funcName] {
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
        
        let functions = DataflowFunctions()
        let mirror = Mirror(reflecting: functions)
        
        for (_, value) in mirror.children {
    //        print("\(label), \(value)")
            let function = value as? DataflowFunctionWrapper
            dict[function!.name] = function!.wrappedValue
        }
        
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
