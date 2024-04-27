//
//  SectionHeader.swift
//  Sportify
//
//  Created by Hadir on 27/04/2024.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    var sectionHeaderlabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSectionHeaderLabel()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSectionHeaderLabel()
    }

    private func setupSectionHeaderLabel() {
        sectionHeaderlabel = UILabel()
        sectionHeaderlabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sectionHeaderlabel)

        NSLayoutConstraint.activate([
            sectionHeaderlabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            sectionHeaderlabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
