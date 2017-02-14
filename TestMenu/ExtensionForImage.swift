//
//  ExtentionForImage.swift
//  TestMenu
//
//  Created by Andrey Apet on 14.02.17.
//  Copyright © 2017 i.Apet. All rights reserved.
//

import Foundation

extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
        }).resume()
    }
}
