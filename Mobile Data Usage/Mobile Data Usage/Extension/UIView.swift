//
//  UIView.swift
//  Mobile Data Usage
//
//  Created by Pere Dev on 27/07/20.
//  Copyright © 2020 Perennial Sys. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Adds a shadow effect into the view with height.
    /// - Parameter height: Effect height.
    func addShadow(height: CGFloat = 2) {
        addShadow(withHeight: height)
    }
    
    /// Adds a shadow effect into the view with height and radius
    /// - Parameters:
    ///   - withHeight: Effect height.
    ///   - radius: Effect radius.
    func addShadow(withHeight: CGFloat, radius: CGFloat = 5.0) {

        let shadowColor = UIColor.lightGray
        self.layer.masksToBounds = false
        self.layer.shadowColor =  shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: withHeight)
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = 0.5
    }
    
}
