//
//  ContentView.swift
//  Assignment
//
//  Created by Kunal on 03/01/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    @State private var path: [DeviceData] = []
    
    @State private var isShowingCacheData: Bool = false

    var body: some View {
        NavigationStack(path: $path) {
            
            VStack{
                HStack{
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search", text: $viewModel.searchText)
                }
                .padding()
                
                if isShowingCacheData{
                    Text("Showing Cached Data")
                        .foregroundColor(.yellow)
                }
                
                Group {
                    if let computers = viewModel.filteredDevices, !computers.isEmpty {
                        DevicesList(devices: computers) { selectedComputer in
                            viewModel.navigateToDetail(navigateDetail: selectedComputer)
                        }
                    } else {
                        ProgressView("Loading...")
                    }
                }
                Spacer()
            }
            .onChange(of: viewModel.navigateDetail, perform: { newValue in
                let navigate = viewModel.navigateDetail
               path.append(navigate!)
            })
            
            .navigationTitle("Devices")
            .navigationDestination(for: DeviceData.self) { computer in
                DetailView(device: computer)
            }
            .onAppear {
                viewModel.fetchAPI { isCached in
                    isShowingCacheData = isCached
                }
                
            }
        }
    }
}
