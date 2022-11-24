//
//  File.swift
//  
//
//  Created by Adam Wienconek on 24/11/2022.
//

import Foundation
import UIKit.UIImage

public extension EmptyBackgroundView {
    
    struct Configuration {
        public var primaryText: String?
        public var secondaryText: String?
        public var image: UIImage?
        
        public init(primaryText: String? = nil,
                      secondaryText: String? = nil,
                      image: UIImage? = nil) {
            self.primaryText = primaryText
            self.secondaryText = secondaryText
            self.image = image
        }
    }
    
}

@available(iOS 14.0, *)
extension EmptyBackgroundView.Configuration: UIContentConfiguration {
    
    public func makeContentView() -> UIView & UIContentView {
        let view = EmptyBackgroundView(frame: .zero)
        view.configuration = self
        
        return view
    }
    
    public func updated(for state: UIConfigurationState) -> Self {
        self
    }
    
}
