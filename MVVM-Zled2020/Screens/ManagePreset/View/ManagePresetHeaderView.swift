//
//  ManagePresetHeaderView.swift
//  MVVM-Zled2020
//
//  Created by hope on 8/21/20.
//  Copyright © 2020 Ace. All rights reserved.
//

import UIKit

class ManagePresetHeaderView<T>: UIView where T: ManagePresetHeaderPresentable {
    
    private var delegate: T?
    
    private let label = UILabel(style: Stylesheet.Commons.lgLabel)
    
    private let icon = UIImageView()
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        [icon, label].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }
    
    private func setupConstraints() {
        let constraints = [
            icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            icon.topAnchor.constraint(equalTo: topAnchor),
            icon.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func configure(with delegate: T) {
        self.delegate = delegate
        label.text = self.delegate?.label
        icon.image = self.delegate?.icon
    }
}
