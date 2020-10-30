//
//  SectionModelItem.swift
//  MVVM-Zled2020
//
//  Created by hope on 8/6/20.
//  Copyright © 2020 Ace. All rights reserved.
//

import UIKit

protocol UpdatableCell {
    
    associatedtype ModelDataType
    
    func update(with item: ModelDataType)
}

protocol SectionModelItem {
    
    typealias UpdatableTableViewCell = UITableViewCell & UpdatableCell

    associatedtype CellType : UpdatableTableViewCell

    typealias ModelDataType = CellType.ModelDataType

    var itemsCount: Int { get }

    var rowData: [ModelDataType] { get }

    var cellClass: CellType.Type { get }

    func append(_ item: ModelDataType)
    
    func remove(_ row: Int)
}

