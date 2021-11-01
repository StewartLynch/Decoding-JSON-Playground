import Foundation
public class APIService {
    public let urlString: String
    public init(urlString: String) {
        self.urlString = urlString
    }
    
    public func getJSON<T: Decodable>( dateDecodingStategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                                       keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                                       completion: @escaping (T) -> Void) {
        guard let url = URL(string: urlString) else {
            fatalError("Error: Invalid URL.")
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
            guard let data = data else {
                fatalError("Error: Data is corrupt.")
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStategy
            decoder.keyDecodingStrategy = keyDecodingStrategy
            
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                completion(decodedData)
            } catch {
                fatalError("Error: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    @available(iOS 14, *)
    public func getJSON<T: Decodable>(dateDecodingStategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                                      keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) async throws -> T {
        guard let url = URL(string: urlString) else {
           fatalError("Error: Invalid URL.")
        }
        let request = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let _ = response as? HTTPURLResponse else {
            fatalError("Error: Data Request error.")
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStategy
        decoder.keyDecodingStrategy = keyDecodingStrategy
        guard let decodedData =  try? decoder.decode(T.self, from: data) else {
           fatalError("Error: Decoding error.")
        }
        return decodedData
    }
}
