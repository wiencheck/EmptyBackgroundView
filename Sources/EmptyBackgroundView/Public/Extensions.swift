//
//  File.swift
//  
//
//  Created by Adam Wienconek on 24/11/2022.
//

import Foundation
import UIKit

@available(iOS 14.0, *)
public extension UITableView {
    
    /**
     Object holding configuration values for view displayed when there is no data available in table view.
     
     Setting new value will overwrite existing `backgroundView`.
     */
    var emptyViewConfiguration: EmptyBackgroundView.Configuration? {
        get {
            guard let view = backgroundView as? EmptyBackgroundView else {
                return nil
            }
            return view.configuration as? EmptyBackgroundView.Configuration
        }
        set {
            backgroundView = newValue?.makeContentView()
        }
    }
    
}

@available(iOS 14.0, *)
public extension UICollectionView {
    
    /**
     Object holding configuration values for view displayed when there is no data available in collection view.
     
     Setting new value will overwrite existing `backgroundView`.
     */
    var emptyViewConfiguration: EmptyBackgroundView.Configuration? {
        get {
            guard let view = backgroundView as? EmptyBackgroundView else {
                return nil
            }
            return view.configuration as? EmptyBackgroundView.Configuration
        }
        set {
            backgroundView = newValue?.makeContentView()
        }
    }
    
}
