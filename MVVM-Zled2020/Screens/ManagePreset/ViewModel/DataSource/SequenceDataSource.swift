//
//  TableViewDataSource.swift
//  MVVM-Zled2020
//
//  Created by hope on 8/29/20.
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

final class SequenceDataSource<S:SectionModelItem>: NSObject, UITableViewDataSource {
    
    private let itemsSubject = PublishSubject<S.ModelDataType>()
    
    public let dataItem: S
    
    private let disposeBag = DisposeBag()
    
    //MARK: - Initialization
    init(dataItem: S) {
        self.dataItem = dataItem
        super.init()
    }
    
    //MARK: -Methods
    
    func bindData(to data: [S.ModelDataType]) {
        data.forEach {
            self.dataItem.append($0)
        }
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
    
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { _, _, complete in
            self.dataItem.remove(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            complete(true)
        }
            
        // here set your image and background color
        deleteAction.image = UIImage(named: "icon_trash")!.scalePreservingAspectRatio(target: CGSize(width:35, height: 35))
        deleteAction.backgroundColor = .red
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
}
