//
//  File.swift
//  
//
//  Created by Adam Wienconek on 24/11/2022.
//

import Foundation
import UIKit

protocol ScrollableContentDisplaying: UIScrollView {
    var numberOfItems: Int { get }
}

extension UITableView: ScrollableContentDisplaying {
    
    var numberOfItems: Int {
        let sections = self.numberOfSections
        var rows = 0
        for section in (0 ..< sections) {
            rows += numberOfRows(inSection: section)
        }
        
        return rows
    }
    
}

extension UICollectionView: ScrollableContentDisplaying {
    
    var numberOfItems: Int {
        let sections = self.numberOfSections
        var rows = 0
        for section in (0 ..< sections) {
            rows += numberOfItems(inSection: section)
        }
        
        return rows
    }
    
}
