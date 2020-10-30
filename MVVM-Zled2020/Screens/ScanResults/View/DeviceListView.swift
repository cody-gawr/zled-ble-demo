//
//  DeviceListView.swift
//  MVVM-Zled2020
//
//  Created by hope on 8/5/20.
//  Copyright © 2020 Ace. All rights reserved.
//

import UIKit

class DeviceListView<T>: UIView where T: SpinnerViewPresentable {
    
    public let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = Constant.UIColors.background
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.layoutMargins = .zero
        tableView.separatorColor = Constant.UIColors.blue
        return tableView
    }()
    
    public let scanButton: UIButton = UIButton(style: Stylesheet.Commons.scanButton)
    
    private let header = DeviceListHeaderView<DeviceListHeaderViewModel>()
    
    private let peripheralNameLabel = UILabel(style: Stylesheet.Commons.mdLabel)
    
    init() {
        super.init(frame: .zero)
        configure()
        addSubviews()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        [header, tableView, scanButton].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }
    
    private func configure() {
        header.configure(with: DeviceListHeaderViewModel())
        scanButton.setTitle(Constant.Strings.scan, for: .normal)
    }
    
    func setTableView(dataSource: UITableViewDataSource, delegate: UITableViewDelegate) {
        self.tableView.dataSource = dataSource
        self.tableView.delegate = delegate
    }
    
    func register(cellType: UITableViewCell.Type, forCellReuseIdentifier identifier: String) {
        tableView.register(cellType, forCellReuseIdentifier: identifier)
    }
    
    func indexPath(for cell: UITableViewCell) -> IndexPath? {
        return tableView.indexPath(for: cell)
    }
    
    func refreshTableView() {
        tableView.reloadData()
    }
    
    private func setupConstraints() {
        let constraints = [
            header.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            header.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            scanButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            scanButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            scanButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            tableView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: scanButton.topAnchor, constant: -20),
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    func setScanTarget(_ target: Any, action: Selector, for events: UIControl.Event) {
        if scanButton.allTargets.isEmpty {
            scanButton.addTarget(target, action: action, for: events)
        }
    }
}
