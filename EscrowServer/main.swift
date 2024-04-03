import GRPC
import TabularData
import NIOCore
import NIOPosix

import struct Foundation.Data
import struct Foundation.URL

final class MyRunProvider: RunAsyncProvider {
    func runFunction(request: FunctionParams, context: GRPC.GRPCAsyncServerCallContext) async throws -> Empty {
        let success = request.success
        let data = request.data
        
        let df = try! DataFrame(csvData: data)
        dataflowFunction(success, df)
        
        return Empty()
    }
}


func runServer() async throws {
    // Create an event loop group for the server to run on.
    let group = MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount)
    defer {
        try! group.syncShutdownGracefully()
    }
    
    let provider = MyRunProvider()
    
    // Start the server and print its address once it has started.
    let server = try await Server.insecure(group: group)
        .withServiceProviders([provider])
        .bind(host: "localhost", port: 1234)
        .get()
    
    print("server started on port \(server.channel.localAddress!.port!)")
    
    // Wait on the server's `onClose` future to stop the program from exiting.
    try await server.onClose.get()
}

try await runServer()
