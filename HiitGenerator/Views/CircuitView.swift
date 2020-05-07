//
//  CircuitView.swift
//  HiitGenerator
//
//  Created by Ethan Joseph on 5/6/20.
//  Copyright © 2020 Ethan Joseph. All rights reserved.
//

import UIKit

class CircuitView: UIView {
    
    var contentView: UIView?
    let nibName = "CircuitView"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
    }

    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
