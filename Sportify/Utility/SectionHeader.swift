//
//  SectionHeader.swift
//  Sportify
//
//  Created by Hadir on 27/04/2024.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    static let reuseIdentifier = "CustomHeaderReuseIdentifier"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Center titleLabel horizontally
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            // Center titleLabel vertically
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
