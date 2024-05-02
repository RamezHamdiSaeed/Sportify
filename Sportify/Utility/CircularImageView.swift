//
//  CircularImageView.swift
//  Sportify
//
//  Created by Hadir on 30/04/2024.
//

import UIKit

class CircularImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        layer.cornerRadius = max(bounds.width, bounds.height) / 2.0
        layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = max(bounds.width, bounds.height) / 2.0
    }
}

