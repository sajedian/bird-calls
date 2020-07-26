//
//  UIImage+Extensions.swift
//  bird-calls
//
//  Created by Renee Sajedian on 7/26/20.
//  Copyright © 2020 Renee Sajedian. All rights reserved.
//

import UIKit

extension UIImage {
    func scaled(toHeight: CGFloat, opaque: Bool = false) -> UIImage? {
        let scale = toHeight / size.height
        let newWidth = size.width * scale
        UIGraphicsBeginImageContextWithOptions(CGSize(width: newWidth, height: toHeight), opaque, self.scale)
        draw(in: CGRect(x: 0, y: 0, width: newWidth, height: toHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
