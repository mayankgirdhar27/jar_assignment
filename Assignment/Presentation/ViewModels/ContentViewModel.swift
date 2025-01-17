//
//  ContentViewModel.swift
//  Assignment
//
//  Created by Kunal on 10/01/25.
//

import Foundation


class ContentViewModel : ObservableObject {
    
    private let fetchDeviceUseCase: FetchDevicesUseCase
    private let apiService = ApiService()
    @Published var navigateDetail: DeviceData? = nil
    @Published var data: [DeviceData]? = []
    
    @Published var searchText: String = ""

    var filteredDevices: [DeviceData]? {
        guard let devices = data else {return nil}
        
        guard !searchText.isEmpty else {return devices}
        
        return devices.filter { device in
            device.name.lowercased().contains(searchText.lowercased())
        }
            
    }
    
    
    init(fetchDeviceUseCase: FetchDevicesUseCase = DefaultFetchDevicesUseCase(
        repository:
            DefaultDeviceRepository(
                apiStore: ApiService()) as DeviceRepositoryProtocol
    )) {
        self.fetchDeviceUseCase = fetchDeviceUseCase
    }
    
    
    
    func fetchAPI(completion: @escaping (Bool) -> Void = { _ in}) {
        fetchDeviceUseCase.execute { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case.success((let data, let isCached)):
                    self?.data = data
                    completion(isCached)
                case .failure:
                    self?.data = []
                    completion(true)
                }
            }
        }
    }
    
    func navigateToDetail(navigateDetail: DeviceData) {
        self.navigateDetail = navigateDetail
    }
}
