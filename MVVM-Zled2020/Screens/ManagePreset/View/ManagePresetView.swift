//
//  ManagePresetView.swift
//  MVVM-Zled2020
//
//  Created by hope on 8/21/20.
//  Copyright © 2020 Ace. All rights reserved.
//

import UIKit

class ManagePresetView<T>: UIView where T: ManagePresetHeaderPresentable {
    
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
    
    private let headerView = ManagePresetHeaderView<T>()
    
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
        [headerView, tableView].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }
    
    private func setupConstraints() {
        let constraints = [
            headerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func indexPath(for cell: UITableViewCell) -> IndexPath? {
        return tableView.indexPath(for: cell)
    }
    
    func configure(with delegate: T) {
        headerView.configure(with: delegate)
    }
    
    func setTableView(_ dataSource: UITableViewDataSource, delegate: UITableViewDelegate) {
        tableView.dataSource = dataSource
        tableView.delegate = delegate
    }
    
    func register(_ cellType: UITableViewCell.Type, forCellReuseIdentifier identifier: String) {
        tableView.register(cellType, forCellReuseIdentifier: identifier)
    }
    
    func refreshTableView() {
        tableView.reloadData()
    }
}

