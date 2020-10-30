//
//  ManagePresetViewController.swift
//  MVVM-Zled2020
//
//  Created by hope on 8/21/20.
//  Copyright © 2020 Ace. All rights reserved.
//

import UIKit

class ManagePresetViewController: UIViewController, CustomView, CustomController {
    
    typealias ViewClass = ManagePresetView<ManagePresetViewModel>
    
    typealias SequenceListDataSource = SequenceDataSource<SequenceListViewModelItem<SequenceItemViewModel>>
    
    typealias SequenceItemCell = SequenceListTableViewCell<SequenceItemViewModel>
    
    private let dataSource: SequenceListDataSource
    
    private let viewModel: ManagePresetViewModel
    
    init(_ viewModel: ManagePresetViewModel, dataSource: SequenceListDataSource) {
        self.viewModel = viewModel
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        enablePop()
        bindViewModel()
        setupTableView()
    }
    
    override func loadView() {
        view = ViewClass()
    }
    
    private func bindViewModel() {
        dataSource.bindData(to: viewModel.sequenceItems)
        configure()
    }
    
    private func configure() {
        customView.configure(with: viewModel)
    }
    
    private func setupTableView() {
        customView.setTableView(dataSource, delegate: self)
        registerCells()
    }
    
    private func registerCells() {
        customView.register(SequenceItemCell.self, forCellReuseIdentifier: String(describing: SequenceItemCell.self))
    }
    
    @objc private func removeAction(_ button: UIButton) {
        guard let cell = button.superview as? UITableViewCell, let indexPath = customView.indexPath(for: cell) else {
            return
        }
        
        guard let sequenceItem = dataSource.takeItemAt(index: indexPath.row) as? SequenceItemViewModel else {
            return
        }
        let alert = AlertLauncher()
        alert.setAlertTitle(Constant.Strings.confirmRemove)
        alert.alertAction = {
            Common.isRemoved = true
            LocalService.shared.remove(sequenceItem.item)
            self.dataSource.dataItem.remove(indexPath.row)
            self.customView.refreshTableView()
        }
        alert.showAlert()
    }
}

extension ManagePresetViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? SequenceItemCell else {
            return
        }
        cell.setRemoveTarget(self, action: #selector(removeAction(_:)), for: .touchUpInside)
    }
}
