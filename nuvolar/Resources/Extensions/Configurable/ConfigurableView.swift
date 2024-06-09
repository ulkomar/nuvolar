//
//  ConfigurableView.swift
//  nuvolar
//
//  Created by Developer on 6.06.24.
//

protocol LayoutConfigurableView {

    /// Method which will trigger chain of calls
    func configureView()

    /// Method for configuring the properties of the main view
    func configureViewProperties()

    ///  Method for configuring and adding subviews
    func configureSubviews()

    /// Method for setting constraints for subviews
    func configureLayout()
}

extension LayoutConfigurableView {
    func configureView() {
        configureViewProperties()
        configureSubviews()
        configureLayout()
    }

    func configureViewProperties() { }
    func configureSubviews() { }
    func configureLayout() { }
}

extension LayoutConfigurableView where Self: BindingConfigurableView {
    func configureView() {
        configureViewProperties()
        configureSubviews()
        configureLayout()
        configureBinding()
    }
}
