//
//  DeviceRepositoryProtocol.swift
//  Assignment
//
//  Created by Mayank Girdhar on 1/17/25.
//

import Foundation

protocol DeviceRepositoryProtocol{
    func fetchDevices(completion: @escaping (Result<([DeviceData], Bool), Error>) -> Void)
}


