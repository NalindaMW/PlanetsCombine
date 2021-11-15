//
//  Image.swift
//  PlanetsCombine
//
//  Created by Nalinda Wickramarathna on 11/13/21.
//

import UIKit

extension UIImageView {

 public func imageFromURL(urlString: String, PlaceHolderImage:UIImage) {

        if self.image == nil {
              self.image = PlaceHolderImage
        }

        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL,
                                   completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error ?? "Something went wrong while fetching image")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
        }).resume()
    }
}
