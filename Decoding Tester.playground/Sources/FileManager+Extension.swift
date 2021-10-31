import Foundation

public extension FileManager {
    static var docDirURL: URL {
        Self.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    static var docDirPath: String {
        Self.docDirURL.path
    }
    
    static func decode<T: Decodable>(_ type: T.Type, from docName: String) -> T {
        if !FileManager().docExist(named: docName) {
            fatalError("Failed to locaate \(docName) in Documents Directory.")
        }
        let url = Self.docDirURL.appendingPathComponent(docName)
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(docName) from document Directory.")
        }
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(docName) from document Directory.")
        }
        return loaded
    }
    
    func docExist(named docName: String) -> Bool {
        fileExists(atPath: Self.docDirURL.appendingPathComponent(docName).path)
    }
}
