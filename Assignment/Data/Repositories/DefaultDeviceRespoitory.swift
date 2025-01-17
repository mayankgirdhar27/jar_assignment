//
//  Untitled.swift
//  Assignment
//
//  Created by Mayank Girdhar on 1/17/25.
//

import Foundation

final class DefaultDeviceRepository: DeviceRepositoryProtocol {
    
    private let apiStore: APIServiceProtocol
    
    init(apiStore: APIServiceProtocol) {
        self.apiStore = apiStore
    }
    
    func fetchDevices(completion: @escaping (Result<([DeviceData], Bool), Error>) -> Void) {
        apiStore.fetchDeviceDetails(completion: completion)
    }
    
}
