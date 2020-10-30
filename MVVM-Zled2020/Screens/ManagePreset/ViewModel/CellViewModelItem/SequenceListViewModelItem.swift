//
//  PresetListViewModelItem.swift
//  MVVM-Zled2020
//
//  Created by hope on 8/30/20.
//  Copyright © 2020 Ace. All rights reserved.
//

final class SequenceListViewModelItem<T>: SectionModelItem where T: SequenceItemPresentable {
    
    
    typealias ModelDataType = T
    
    var rowData: [ModelDataType] {
        return sequenceRowItems
    }
    
    var itemsCount: Int {
        return sequenceRowItems.count
    }
    
    var sequenceRowItems: [ModelDataType] = []
    
    var cellClass: SequenceListTableViewCell<T>.Type {
        return SequenceListTableViewCell.self
    }
    
    func append(_ item: ModelDataType) {
        sequenceRowItems.append(item)
    }
    
    func remove(_ row: Int) {
        sequenceRowItems.remove(at: row)
    }
}
