import GRPC
import TabularData
import NIOCore
import NIOPosix
import NIOSSL

import Foundation

typealias DataflowFunctionType = (_ success: Bool, _ df: DataFrame?) -> Data?

final class MyRunProvider: RunAsyncProvider {
    
    //    func runFunctionByName<T: Codable>(_ funcName: String, _ success: Bool, _ df: DataFrame?) -> T {
    //        let functions = DataflowFunctions()
    //        let mirror = Mirror(reflecting: functions)
    //
    //        for (_, value) in mirror.children {
    //    //        print("\(label), \(value)")
    //            let function = value as? DataflowFunctionWrapper<T>
    //
    //            if function!.name == funcName {
    //                return function!.wrappedValue(success, df)
    //            }
    //        }
    //
    //        fatalError("function \(funcName) does not exist")
    //    }
    
    
    func runFunction(request: FunctionParams, context: GRPC.GRPCAsyncServerCallContext) async throws -> Result {
        
        let success = request.success
        let data = request.data
        
        let df = try? DataFrame(jsonData: data)
        
        // FIXME: calling function by its string name is not possible (the function needs to be marked as @objc but it can't)
        
        let funcName = request.name
        //        let dataflowFunc = DataflowFunction() as NSObject
        //        let selector = Selector(funcName)
        
        //        dataflowFunc.perform(selector, with: success, with: df)
        
        //        test(success, df)
        
        let startTime = CFAbsoluteTimeGetCurrent()

        let resData = EscrowManager.runFunction(funcName, success, df)
        
        let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
        print("Time elapsed for running dataflowFunction in server: \(timeElapsed) s.")
        let filename_remote = getDocumentsDirectory().appendingPathComponent("classify_images_run_function_remote_1.txt")
//        do {
//            try FileManager.default.removeItem(at: filename_remote)
//        } catch let error as NSError {
//            print("Error: \(error.domain)")
//        }
        let resToWrite = "\(timeElapsed)\n"
        log(filename_remote, resToWrite)
        
        let result: Result = .with {
            $0.success = true
            $0.result = resData!
        }
        
        return result
        
    }
}


func runServer(useTLS: Bool) async throws {
    
    let builder: Server.Builder
    
    // Create an event loop group for the server to run on.
    let group = MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount)
    defer {
        try! group.syncShutdownGracefully()
    }
    
    let provider = MyRunProvider()
    
    let keepalive = ServerConnectionKeepalive(
      timeout: .seconds(100)
    )
    
    if useTLS {
        let caCert = SampleCertificate.ca
        let serverCert = SampleCertificate.server
        
        builder = Server.usingTLSBackedByNIOSSL(
            on: group,
            certificateChain: [serverCert.certificate],
            privateKey: SamplePrivateKey.server
        )
        .withTLS(trustRoots: .certificates([caCert.certificate]))
        .withKeepalive(keepalive)
        print("starting secure server")
    } else {
        builder = Server.insecure(group: group).withKeepalive(keepalive)
        print("starting insecure server")
    }
    
    // Start the server and print its address once it has started.
    let server = try await builder
        .withMaximumReceiveMessageLength(200 * 1024 * 1024) //200 mb
        .withServiceProviders([provider])
        .bind(host: "172.16.105.11", port: 1234)
        .get()
    
    print("server started on host \(server.channel.localAddress!.ipAddress!) port \(server.channel.localAddress!.port!)")
    
    // Wait on the server's `onClose` future to stop the program from exiting.
    try await server.onClose.get()
}

try await runServer(useTLS: true)
