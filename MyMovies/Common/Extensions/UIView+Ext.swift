//
//  UIView+Ext.swift
//  MyMovies
//
//  Created by Can Gül on 12.09.2024.
//

import UIKit

extension UIView {
    //MARK: - Subview Function
    func addSubviewsFromExt(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
