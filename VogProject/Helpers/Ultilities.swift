//
//  Ultilities.swift
//  VogProject
//
//  Created by Hoang Tran on 2020-08-30.
//  Copyright © 2020 Hoang Tran. All rights reserved.
//

import SwiftUI

var documentsUrl: URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
}

func roundedImage(imageView : UIImageView) {
    imageView.layer.cornerRadius = imageView.frame.size.width/2
    imageView.layer.borderColor = UIColor.systemRed.cgColor
    imageView.layer.borderWidth = 2
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
}

func isTextValid(text : String?) -> Bool
{
    if text == nil || text == "" {
        return false
    }
    
    return true
}
