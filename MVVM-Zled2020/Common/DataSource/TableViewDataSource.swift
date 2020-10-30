//
//  TableViewDataSource.swift
//  MVVM-Zled2020
//
//  Created by hope on 8/6/20.
//  Copyright © 2020 Ace. All rights reserved.
//

import RxSwift
import RxBluetoothKit
import UIKit

/*
    Generic UITableViewDataSource

    S - represents SectionModelItem, which stores
    information about given section's itemsCount, sectionName, cells' class and provides collection of model data
    check: DataSource/SectionModelItem.swift
*/

final class TableViewDataSource<S:SectionModelItem>: NSObject, UITableViewDataSource {
    
    // MARK: - Typealiases
    
    // Block set by a UIViewController, meant to be called for reloading data
    typealias RefreshDataBlock = (_ item: S.ModelDataType) -> Void
    
    // Block set by a UIViewController, meant to be called inside at any OnError
    typealias OnErrorBlock = (_ error: Error) -> Void
    
    // MARK: - Fields
    private var refreshDataBlock: RefreshDataBlock = { _ in
    }
    
    private var onErrorBlock: OnErrorBlock = { _ in
    }
    
    private let itemsSubject = PublishSubject<S.ModelDataType>()
    
    public let dataItem: S
    
    private let disposeBag = DisposeBag()
    
    //MARK: - Initialization
    init(dataItem: S) {
        self.dataItem = dataItem
        super.init()
    }
    
    //MARK: -Methods
    func bindData() {
        itemsSubject.subscribe(onNext: { [unowned self] item in
            self.dataItem.append(item)
            self.refreshDataBlock(item)
            }, onError: { [unowned self] (error) in
                self.onErrorBlock(error)
        }).disposed(by: disposeBag)
    }
    
    func bindData(to data: [S.ModelDataType]) {
        data.forEach {
            self.dataItem.append($0)
        }
    }
    
    func bindItemObserver(to observable: Observable<Result<S.ModelDataType, Error>>) {
        observable.subscribe(onNext: { [unowned self] result in
            switch result {
            case .success(let value):
                self.itemsSubject.onNext(value)
            case .error(let error):
                self.onErrorBlock(error)
            }
            }, onError: { self.onErrorBlock($0) }).disposed(by: disposeBag)
    }
    
    func setRefreshBlock(_ block: @escaping RefreshDataBlock) {
        refreshDataBlock = block
    }
    
    func setOnErrorBlock(_ block: @escaping OnErrorBlock) {
        onErrorBlock = block
    }
    
    func takeItemAt(index: Int) -> Any {
        return dataItem.rowData[index]
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataItem.itemsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = String(describing: dataItem.cellClass)
        let item = dataItem.rowData[indexPath.item]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? S.CellType else {
            return UITableViewCell()
        }
        
        cell.update(with: item)
        return cell
    }
}
