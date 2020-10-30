//
//  DeviceListHeader.swift
//  MVVM-Zled2020
//
//  Created by hope on 8/5/20.
//  Copyright © 2020 Ace. All rights reserved.
//

import UIKit

final class DeviceListHeaderView<T>: UIView where T: HeaderViewPresentable {
    
    public let scanIcon = UIImageView(style: Stylesheet.Commons.scanIcon)
    public let headerLabel = UILabel(style: Stylesheet.Commons.lgLabel)
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        setupConstraints()
    }
    
    func configure(with viewModel: T) {
        scanIcon.image = viewModel.image
        headerLabel.text = viewModel.text
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        [scanIcon, headerLabel].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }
    
    private func setupConstraints() {

        let constraints = [
            scanIcon.topAnchor.constraint(equalTo: self.topAnchor),
            scanIcon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5),
            scanIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            headerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
