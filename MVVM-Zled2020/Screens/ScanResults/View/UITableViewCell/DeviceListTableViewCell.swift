//
//  DeviceListTableViewCell.swift
//  MVVM-Zled2020
//
//  Created by hope on 8/6/20.
//  Copyright © 2020 Ace. All rights reserved.
//

import RxBluetoothKit
import UIKit

final class DeviceListTableViewCell: UITableViewCell {
    
    private let bluetoothImageIcon = UIImageView(image: UIImage(named: "icon_bluetooth_dev")?.scalePreservingAspectRatio(target: CGSize(width: 45, height: 45)))
    
    private let peripheralDetailContainer = UIView()
    
    private let peripheralNameLabel = UILabel(style: Stylesheet.Commons.mdLabel)
    
    private let peripheralUUIDLabel = UILabel(style: Stylesheet.Commons.smLabel)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        setupConstraints()
    }
    
    private func setupCell() {
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        peripheralNameLabel.text = nil
        peripheralUUIDLabel.text = nil
    }
    
    private func setupConstraints() {
        [bluetoothImageIcon, peripheralDetailContainer].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
        [peripheralNameLabel, peripheralUUIDLabel].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            peripheralDetailContainer.addSubview(view)
        }
        
        let constraints = [
            bluetoothImageIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            bluetoothImageIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            bluetoothImageIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            peripheralDetailContainer.leadingAnchor.constraint(equalTo: bluetoothImageIcon.trailingAnchor, constant: 20),
            peripheralDetailContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            peripheralDetailContainer.topAnchor.constraint(equalTo: self.topAnchor),
            peripheralDetailContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            peripheralNameLabel.leadingAnchor.constraint(equalTo: peripheralDetailContainer.leadingAnchor),
            peripheralNameLabel.topAnchor.constraint(equalTo: peripheralDetailContainer.topAnchor, constant: 10),
            peripheralUUIDLabel.topAnchor.constraint(equalTo: peripheralNameLabel.bottomAnchor, constant: 10),
            peripheralUUIDLabel.leadingAnchor.constraint(equalTo: peripheralDetailContainer.leadingAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }
}

extension DeviceListTableViewCell: UpdatableCell {
    
    func update(with item: ScannedPeripheral) {
        peripheralNameLabel.text = item.advertisementData.localName ?? "Unknown"
        peripheralUUIDLabel.text = String(describing: item.peripheral.identifier)
    }
}
