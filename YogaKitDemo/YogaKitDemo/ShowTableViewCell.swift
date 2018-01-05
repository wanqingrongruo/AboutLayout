//
//  ShowTableViewCell.swift
//  YogaKitDemo
//
//  Created by roni on 2017/12/26.
//  Copyright © 2017年 roni. All rights reserved.
//

import UIKit

class ShowTableViewCell: UITableViewCell {
    
    var show: Show! {
        didSet {
            self.textLabel?.text = show.title
            self.detailTextLabel?.text = show.length
            self.imageView?.image = UIImage(named: show.image)
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.textLabel?.textColor = .white
        self.textLabel?.font = UIFont.systemFont(ofSize: 14.0)
        self.textLabel?.numberOfLines = 2
        self.textLabel?.adjustsFontSizeToFitWidth = true
        self.textLabel?.minimumScaleFactor = 0.8
        self.detailTextLabel?.textColor = .lightGray
        
        let accessoryView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        accessoryView.image = UIImage(named: "download")
        self.accessoryView = accessoryView
        
        self.backgroundColor = .clear
        self.separatorInset = .zero
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
