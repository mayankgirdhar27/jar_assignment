//
//  APIServiceProtocol.swift
//  Assignment
//
//  Created by Mayank Girdhar on 1/17/25.
//


import Foundation

protocol APIServiceProtocol{
    func fetchDeviceDetails(completion : @escaping (Result<([DeviceData], Bool), Error>) -> Void)
}
