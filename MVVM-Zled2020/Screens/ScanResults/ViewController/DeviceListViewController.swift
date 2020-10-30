//
//  ScanResultsViewController.swift
//  MVVM-Zled2020
//
//  Created by hope on 8/5/20.
//  Copyright © 2020 Ace. All rights reserved.
//

import RxBluetoothKit
import RxSwift
import UIKit

class DeviceListViewController: UIViewController, CustomView, CustomController {
    
    typealias ViewClass = DeviceListView<SpinnerViewModel>
    
    typealias DeviceListDataSource = TableViewDataSource<DeviceListViewModelItem>
    
    private let dataSource: DeviceListDataSource
    
    private let viewModel: DeviceListViewModel
    
    private let disposeBag = DisposeBag()
    
    private var peripheral: Peripheral?
    
    private var characteristic: Characteristic?
    
    init(with dataSource: DeviceListDataSource, viewModel: DeviceListViewModel) {
        self.dataSource = dataSource
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setCharacteristicRefreshblock()
        setCharacteristicErrorBlock()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setNavigationBar()
        setScanTarget()
        bindViewModel()
    }
    
    override func loadView() {
        view = ViewClass()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // MARK: - Remove history list
        dataSource.dataItem.peripheralRowItems = []
        customView.refreshTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            if let _ = LocalService.shared.peripheral {
                self.customView.isUserInteractionEnabled = false
                self.autoScan()
            }
        }
    }
    
    private func setupTableView() {
        customView.setTableView(dataSource: dataSource, delegate: self)
        registerCells()
        setDataSourceRefreshBlock()
        setDataSourceErrorBlock()
    }
    
    private func registerCells() {
        customView.register(cellType: DeviceListTableViewCell.self, forCellReuseIdentifier: String(describing: DeviceListTableViewCell.self))
    }
    
    private func autoScan() {
        guard let _ = LocalService.shared.peripheral else {
            return
        }
        self.scan()
    }
    
    private func scan() {
        viewModel.scanAction()
        if viewModel.isScanning {
            SpinnerLauncher.shared.label = Constant.Strings.scanning
            SpinnerLauncher.shared.showSpinner()
            dataSource.bindData()
        }
    }
    
    private func connect(to scannedPeripheral: ScannedPeripheral) {
        characteristic = nil
        peripheral = scannedPeripheral.peripheral
        SpinnerLauncher.shared.label = Constant.Strings.connecting
        SpinnerLauncher.shared.showSpinner()
        viewModel.connectService(to: scannedPeripheral)
    }
    
    // MARK: - Set refresh table view
    
    private func setDataSourceRefreshBlock() {
        self.dataSource.setRefreshBlock { [weak self] scannedPeripheral in
            guard let self = self else { return }
            self.customView.refreshTableView()
        }
    }
    
    // MARK: - Set Table DataSource Error Block, Show Error bar when find no device.
    private func setDataSourceErrorBlock() {
        self.dataSource.setOnErrorBlock { [weak self]  _ in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.viewModel.scanAction()
                self.customView.isUserInteractionEnabled = true
                SpinnerLauncher.shared.hideSpinner()
                if (self.dataSource.dataItem.itemsCount == 0) {
                    LocalService.shared.save(peripheral: nil)
                    NotificationService.shared.error(body: Constant.Strings.Errors.notFoundAnyDevice)
                } else {
                    if let connectedPeripheral = self.dataSource.dataItem.rowData.first(where: { $0.peripheral.identifier.uuidString == LocalService.shared.peripheral?.uuid }) {
                        self.connect(to: connectedPeripheral)
                    }
                }
            }
        }
    }
    
    // MARK: - Save Characteristic
    private func setCharacteristicRefreshblock() {
        viewModel.setRefreshBlock { [weak self] characteristic in
            SpinnerLauncher.shared.hideSpinner()
            guard let self = self else { return }
            self.characteristic = characteristic
            // Go to MainViewController
            // MARK: -Configure ViewModels
            guard let peripheral = self.peripheral else { return }
            self.viewModel.save(connectedPeripheral: peripheral)
            let mainViewModel = MainViewModel(bluetoothService: self.viewModel.bluetoothService, peripheral: peripheral, characteristic: self.characteristic!)
            let viewController = MainViewController(viewModel: mainViewModel)
            self.show(viewController, sender: self)
        }
    }
    
    // MARK: - Error Handler Block when find no characteristic, and occuring the Time Sequence Error.
    private func setCharacteristicErrorBlock() {
        viewModel.setOnErrorBlock { [weak self] error in
            SpinnerLauncher.shared.hideSpinner()
            guard let _ = self?.characteristic else {
                NotificationService.shared.error(body: Constant.Strings.Errors.unableToConnect)
                return
            }
        }
    }
    
    // MARK: - Register the observer of view model
    private func bindViewModel() {
        dataSource.bindItemObserver(to: viewModel.scanningOutput)
    }
    
    // MARK: - Add Listener for scan button
    private func setScanTarget() {
        customView.setScanTarget(self, action: #selector(scanningAction), for: .touchUpInside)
    }
}

extension DeviceListViewController: UITableViewDelegate {
    
    // MARK: - Starting Loading bar, connecting a peripheral.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let _ = tableView.cellForRow(at: indexPath) as? DeviceListTableViewCell else {
            return
        }
        
        guard let scannedPeripheral = dataSource.takeItemAt(index: indexPath.row) as? ScannedPeripheral else {
            return
        }
        connect(to: scannedPeripheral)
    }
    
    // MARK: - Clickable Effect when highlighting
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? DeviceListTableViewCell else {
            return
        }
        cell.backgroundColor = Constant.UIColors.midBackground
    }

    // MARK: - Clickable Effect when unhighlighting
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? DeviceListTableViewCell else {
            return
        }
        cell.backgroundColor = Constant.UIColors.background
    }
}

// MARK: -Callback

extension DeviceListViewController {
    
    @objc private func scanningAction() {
        LocalService.shared.save(peripheral: nil)
        scan()
    }
}
