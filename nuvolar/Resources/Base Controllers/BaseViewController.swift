//
//  BaseViewController.swift
//  nuvolar
//
//  Created by Developer on 6.06.24.
//

import UIKit
import Combine

class BaseViewController: UIViewController {
    
    enum ShowingState {
        case hidden
        case shown
    }
    
    // MARK: - Variables
    
    var cancellables = Set<AnyCancellable>()
    var coordinator: Coordinator?
    
    // MARK: - Initialization
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem()
                backButton.title = ""
                navigationItem.backBarButtonItem = backButton
    }
    
    // MARK: - Public methods
    
    func setNvigationBarVisibility(for state: ShowingState) {
        switch state {
        case .hidden:
            self.navigationController?.isNavigationBarHidden = true
        case .shown:
            self.navigationController?.isNavigationBarHidden = false

        }
    }
    
    func setNavigationBackButtonVisibility(for state: ShowingState) {
        switch state {
        case .hidden:
            self.navigationItem.hidesBackButton = true
        case .shown:
            self.navigationItem.hidesBackButton = false

        }
    }
}
