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
    imageView.layer.borderColor = UIColor.black.cgColor
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

func loadImage(fileName: String) -> UIImage? {
    let fileURL = documentsUrl.appendingPathComponent(fileName)
    do {
        let imageData = try Data(contentsOf: fileURL)
        return UIImage(data: imageData)
    } catch {
        print("Error loading image : \(error)")
    }
    return nil
}

func saveImage(image: UIImage) -> String? {
    let fileName = Constants.kdefaultImageName
    let fileURL = documentsUrl.appendingPathComponent(fileName)
    if let imageData = image.jpegData(compressionQuality: 1.0) {
       try? imageData.write(to: fileURL, options: .atomic)
       return fileName // ----> Save fileName
    }
    print("Error saving image")
    return nil
}


