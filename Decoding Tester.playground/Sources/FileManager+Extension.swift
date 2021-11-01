import Foundation

public extension FileManager {
    static var docDirURL: URL {
        Self.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    static var docDirPath: String {
        Self.docDirURL.path
    }
    
    static func decode<T: Decodable>(_ type: T.Type, from docName: String,
                                     dateDecodingStategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                                     keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {
        if !FileManager().docExist(named: docName) {
            fatalError("Error: Failed to locate \(docName) in Documents Directory.")
        }
        let url = Self.docDirURL.appendingPathComponent(docName)
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Error: Failed to load \(docName) from Documents Directory.")
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStategy
        decoder.keyDecodingStrategy = keyDecodingStrategy
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Error: Failed to decode \(docName) from Documents Directory.")
        }
        return loaded
    }
    
    static func endcodeAndSave<T: Encodable>(objects: T, fileName: String) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(objects)
            let jsonString = String(decoding: data, as: UTF8.self)
            FileManager.saveDocument(contents: jsonString, docName: fileName)
            print("Saved to Documents Directory at \n\(Self.docDirPath)")
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
   static func saveDocument(contents: String, docName: String) {
        let url = Self.docDirURL.appendingPathComponent(docName)
        do {
            try contents.write(to: url, atomically: true, encoding: .utf8)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func docExist(named docName: String) -> Bool {
        fileExists(atPath: Self.docDirURL.appendingPathComponent(docName).path)
    }
}
