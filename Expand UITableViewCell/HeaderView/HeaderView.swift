//
//  HeaderView.swift
//  Expand UITableViewCell
//
//  Created by Kha on 4/21/20.
//  Copyright © 2020 Kha. All rights reserved.
//

import UIKit

protocol HeaderViewDelegate: class {
    func toggleSection(_ header: HeaderView, section: Int)
}

class HeaderView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    weak var delegate: HeaderViewDelegate?
    var section: Int = 0


    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    
    private func customInit() {
        Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [ .flexibleHeight, .flexibleWidth]
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHeader(_:)))
        self.addGestureRecognizer(tap)
    }
    
    @objc func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let cell = gestureRecognizer.view as? HeaderView else {
            return
        }
        delegate?.toggleSection(self, section: cell.section)
    }
}
