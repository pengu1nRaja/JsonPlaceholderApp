//
//  PhotoCell.swift
//  JsonPlaceholderApp
//
//  Created by PenguinRaja on 09.10.2021.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    var imageView: ImageViewManager = {
        let image = ImageViewManager()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    var spinnerView: UIActivityIndicatorView! = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        spinnerView.center = contentView.center
        layoutSubviews()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.addSubview(imageView)
        self.addSubview(label)
        self.addSubview(spinnerView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let frameWidth = contentView.frame.size.width
        
        layer.cornerRadius = 5
        layer.borderWidth = 0.5
        layer.borderColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        
        label.frame = CGRect(
            x: 8,
            y: frameWidth / 2 + 48,
            width: frameWidth - 16,
            height: frameWidth - 40)
        
        imageView.frame = CGRect(
            x: 0,
            y: 0,
            width: frameWidth,
            height: frameWidth)
    }
}
