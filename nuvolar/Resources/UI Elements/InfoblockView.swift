//
//  LogoAndTextView.swift
//  nuvolar
//
//  Created by Developer on 8.06.24.
//

import UIKit

final class InfoblockView: UIStackView {
    
    // MARK: - GUI
    
    private lazy var titleLabel = UILabel()
    private lazy var bodyLabel = UILabel()
    
    private lazy var listStack = UIStackView()
    private var currentList = [String]()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - Public API properties
    
    var title: String? {
        get {
            titleLabel.text?.uppercased()
        }
        set {
            titleLabel.text = newValue?.uppercased()
        }
    }
    
    var body: String? {
        get {
            bodyLabel.text
        }
        set {
            bodyLabel.text = newValue
            bodyLabel.isHidden = false
            listStack.isHidden = true
        }
    }
    
    var list: [String] {
        get {
            currentList
        }
        set {
            currentList = newValue
            listStack.arrangedSubviews.forEach {
                $0.removeFromSuperview()
            }
            
            newValue.forEach {
                listStack.addArrangedSubview(makeMarkedLabel(for: $0))
            }
            
            bodyLabel.isHidden = true
            listStack.isHidden = false
        }
    }
    
    // MARK: - Setter
    
    func set(title: String, body: String) {
        titleLabel.text = title.uppercased()
        bodyLabel.text = body
        bodyLabel.isHidden = false
        listStack.isHidden = true

    }
    
    func set(title: String, list: [String]) {
        titleLabel.text = title.uppercased()
        bodyLabel.isHidden = true
        listStack.isHidden = false
        
        list.forEach {
            listStack.addArrangedSubview(makeMarkedLabel(for: $0))
        }
    }
    
    // MARK: - Builders
    
    private func makeConfiguredLabel(text: String) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = UIColor.secondaryLabel
        label.layer.borderColor = UIColor.systemGray2.withAlphaComponent(0.4).cgColor
        label.numberOfLines = 1
        label.text = text
        return label
    }
    
    private func makeMarkedLabel(for text: String) -> UIView {
        let markedView = UIView()
        let marker = UIView()
        let label = makeConfiguredLabel(text: text)

        markedView.addSubviews([marker, label])
        
        marker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            marker.topAnchor.constraint(equalTo: markedView.topAnchor, constant: 6),
            marker.leadingAnchor.constraint(equalTo: markedView.leadingAnchor),
            marker.widthAnchor.constraint(equalToConstant: 5),
            marker.heightAnchor.constraint(equalToConstant: 5)
        ])
        marker.backgroundColor = .separator
        marker.layer.cornerRadius = 5 / 2
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: markedView.topAnchor),
            label.trailingAnchor.constraint(equalTo: markedView.trailingAnchor),
            label.leadingAnchor.constraint(equalTo: marker.trailingAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: markedView.bottomAnchor)
        ])
        
        return markedView
    }
}

// MARK: - LayoutConfigurableView

extension InfoblockView: LayoutConfigurableView {
    func configureViewProperties() {
        axis = .vertical
        spacing = 7
    }
    
    func configureSubviews() {
        addArrangedSubviews([titleLabel, bodyLabel, listStack])
        listStack.axis = .vertical
        listStack.spacing = 2
        titleLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        bodyLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        bodyLabel.textColor = UIColor.secondaryLabel
        bodyLabel.layer.borderColor = UIColor.systemGray2.withAlphaComponent(0.4).cgColor
        bodyLabel.numberOfLines = 10
        
        backgroundColor = .secondarySystemBackground.withAlphaComponent(0.9)
        directionalLayoutMargins = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        isLayoutMarginsRelativeArrangement = true
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.separator.withAlphaComponent(0.2).cgColor
    }
}
