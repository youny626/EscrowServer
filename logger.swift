import Foundation

func log(_ url: URL, _ message: String) {
    do {
        if FileManager.default.fileExists(atPath: url.path()) {
            if let fileHandle = try? FileHandle(forWritingTo: url) {
                fileHandle.seekToEndOfFile()
                fileHandle.write(message.data(using: .utf8)!)
                fileHandle.closeFile()
            }
        } else {
            try message.write(to: url, atomically: true, encoding: .utf8)
        }
    } catch {
        fatalError(error.localizedDescription)
    }
}

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

