//
//  SequenceListTableViewCell.swift
//  MVVM-Zled2020
//
//  Created by hope on 8/30/20.
//  Copyright © 2020 Ace. All rights reserved.
//

import UIKit

final class SequenceListTableViewCell<T>: UITableViewCell where T : SequenceItemPresentable {
    
    private var delegate: T?
    
    private let sequenceImageIcon = UIImageView()
    
    private let sequenceDetailContainer = UIView()
    
    private let sequenceNameLabel = UILabel(style: Stylesheet.Commons.mdLabel)
    
    private let dateTimeLabel = UILabel(style: Stylesheet.Commons.smLabel)
    
    private let removeButton = UIButton(style: Stylesheet.Commons.frameControlButton)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        sequenceNameLabel.text = nil
        dateTimeLabel.text = nil
    }
    
    private func setupCell() {
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
    }
    
    private func setupConstraints() {
        [sequenceImageIcon, sequenceDetailContainer, removeButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        [sequenceNameLabel, dateTimeLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            sequenceDetailContainer.addSubview($0)
        }
        let constraints = [
            sequenceImageIcon.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            sequenceImageIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            sequenceImageIcon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            sequenceDetailContainer.leadingAnchor.constraint(equalTo: sequenceImageIcon.trailingAnchor, constant: 12),
            sequenceDetailContainer.topAnchor.constraint(equalTo: topAnchor),
            sequenceDetailContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            sequenceDetailContainer.trailingAnchor.constraint(equalTo: removeButton.leadingAnchor),
            sequenceNameLabel.leadingAnchor.constraint(equalTo: sequenceDetailContainer.leadingAnchor),
            sequenceNameLabel.topAnchor.constraint(equalTo: sequenceDetailContainer.topAnchor, constant: 12),
            dateTimeLabel.bottomAnchor.constraint(equalTo: sequenceDetailContainer.bottomAnchor, constant: -6),
            dateTimeLabel.leadingAnchor.constraint(equalTo: sequenceDetailContainer.leadingAnchor),
            removeButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            removeButton.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func configure(with delegate: T) {
        self.delegate = delegate
        sequenceImageIcon.image = delegate.icon
        sequenceNameLabel.text = delegate.sequenceName
        dateTimeLabel.text = delegate.dateTime
        removeButton.setImage(delegate.trashIcon, for: .normal)
    }
    
    func setRemoveTarget(_ target: Any, action: Selector, for event: UIControl.Event) {
        if removeButton.allTargets.isEmpty {
            removeButton.addTarget(target, action: action, for: event)
        }
    }
}

extension SequenceListTableViewCell: UpdatableCell {
    
    func update(with delegate: T) {
        self.configure(with: delegate)
    }
}
