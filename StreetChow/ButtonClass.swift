//
//  ButtonClass.swift
//  StreetChow
//
//  Created by Das Beard on 3/2/17.
//  Copyright © 2017 dasBeard. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews();
        
        // Set border to specific float
        self.layer.cornerRadius = 8.0;
        
    }
    
}
