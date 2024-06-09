//
//  AvatarCellViewModel.swift
//  nuvolar
//
//  Created by Developer on 9.06.24.
//

import UIKit

final class AvatarCellViewModel: ViewModel {
    private var latestRequestID = UUID()
    
    @Published var imageObserver: UIImage?
    
    func fetchImage(urlString: String) {
        let requestID = UUID()
        latestRequestID = requestID
        
        Task { @MainActor in
            let image = await ImageLoader.shared.loadImage(from: urlString)
            
            // Check if the request ID matches the latest request ID before updating imageObserver
            if requestID == latestRequestID {
                imageObserver = image
            }
        }
    }
    
    func prepareForReuse() {
        // Reset imageObserver when preparing for reuse
        imageObserver = nil
        latestRequestID = UUID() // Reset the latestRequestID
    }
}

