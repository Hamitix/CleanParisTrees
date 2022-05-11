//
//  NetworkMonitor.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 05/05/2022.
//

import Foundation
import Network

final class NetworkMonitor: ObservableObject {
    static let shared: NetworkMonitor = NetworkMonitor()
    
    private let monitor: NWPathMonitor
    private let queue: DispatchQueue = DispatchQueue.global()
    
    public private(set) var fetchStrategy: FetchStrategy = .local
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    func startMonitoring() {
        monitor.start(queue: queue)

        monitor.pathUpdateHandler = { [weak self] newPath in
            if newPath.status != .unsatisfied {
                self?.fetchStrategy = .remote
            } else {
                self?.fetchStrategy = .local
            }
        }
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
    
    func isDeviceConnectedToInternet() -> Bool {
        self.fetchStrategy == .remote
    }
}
