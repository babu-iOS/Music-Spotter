//
//  UIImageView.swift
//  MusicSpotter
//
//  Created by IOS-Babu on 10/05/24.
//

import SDWebImage
import UIKit

extension UIImageView {
    
    func loadImage(string: String, withActivityIndicator: Bool = true) {
        if string.contains(".") {
            if withActivityIndicator {
                let activityIndicator = UIActivityIndicatorView(style: .medium)
                activityIndicator.frame = self.bounds
                activityIndicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                activityIndicator.startAnimating()
                self.addSubview(activityIndicator)
            }
            self.sd_setImage(with: URL(string: string)) { [weak self] (image, error, cacheType, url) in
                if withActivityIndicator {
                    self?.subviews.filter({ $0 is UIActivityIndicatorView }).first?.removeFromSuperview()
                }
            }
        } else {
            self.image = UIImage(named: string)
        }
    }
}
