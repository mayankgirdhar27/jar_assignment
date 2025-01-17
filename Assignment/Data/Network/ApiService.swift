//
//  ApiService.swift
//  Assignment
//
//  Created by Kunal on 10/01/25.
//

import Foundation

class ApiService : NSObject , APIServiceProtocol{
    private let baseUrl = ""
    private let sourcesURL = URL(string: "https://api.restful-api.dev/objects")!
    
    private let CACHE_KEY = "cached_device_data"
    private let CACHE_TIMESTAMP_KEY = "cache_timestamp"
    
    
    func fetchDeviceDetails(completion : @escaping (Result<([DeviceData], Bool), Error>) -> Void){
        URLSession.shared.dataTask(with: sourcesURL) { [weak self] (data, urlResponse, error) in
            guard let self = self else {return}
            
            if let error = error {
                if let cachedData = self.getCacheData(){
                    completion(.success((cachedData, true)))
                }else{
                    completion(.failure(error))
                }
            }
            
            if let data = data {
                let jsonDecoder = JSONDecoder()
                do {
                    let empData = try! jsonDecoder.decode([DeviceData].self, from: data)
                    self.cacheData(empData)
                    completion(.success((empData, false)))
                }catch{
                    if let cachedData = self.getCacheData(){
                        completion(.success((cachedData, true)))
                    }else{
                        completion(.failure(error))
                    }
                }
                
            }
        }.resume()
    }
    
    
    private func cacheData(_ data: [DeviceData]){
        if let encoded = try? JSONEncoder().encode(data){
            UserDefaults.standard.set(encoded, forKey: CACHE_KEY)
            UserDefaults.standard.set(Data(), forKey: CACHE_TIMESTAMP_KEY)
        }
    }
    
    private func getCacheData() -> [DeviceData]? {
        if let cached = UserDefaults.standard.data(forKey: CACHE_KEY),
           let decodedData = try? JSONDecoder().decode([DeviceData].self, from: cached){
            return decodedData
        }
        return nil
    }
}
