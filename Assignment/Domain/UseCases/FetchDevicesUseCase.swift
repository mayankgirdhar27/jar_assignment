//
//  FetchDevicesUseCase.swift
//  Assignment
//
//  Created by Mayank Girdhar on 1/17/25.
//

import Foundation

protocol FetchDevicesUseCase{
    func execute(completion: @escaping (Result<([DeviceData], Bool),  Error>) -> Void)
}

final class DefaultFetchDevicesUseCase: FetchDevicesUseCase{
    
    
    private let repository: DeviceRepositoryProtocol

    init(repository: DeviceRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(completion: @escaping (Result<([DeviceData], Bool),  Error>) -> Void) {
        repository.fetchDevices(completion: completion)
    }
}
