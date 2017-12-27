//
//  Show.swift
//  YogaKitDemo
//
//  Created by roni on 2017/12/26.
//  Copyright © 2017年 roni. All rights reserved.
//

import Foundation

struct Show {
    let title: String
    let length: String
    let detail: String
    let image: String
    var rowheight: Double = 0.0
}

extension Show {
    static func loadShows() -> [Show] {
        return loadMixersFrom("Shows")
    }
    private static func loadMixersFrom(_ plistName: String) -> [Show] {
        guard
            let path = Bundle.main.path(forResource: plistName, ofType: "plist"),
            let dictArray = NSArray(contentsOfFile: path) as? [[String: Any]]
            else {
                fatalError("An error occurred while reading \(plistName).plist")
                
        }
        var shows = [Show]()
        for dict in dictArray {
            guard
                let title = dict["title"] as? String,
                let length = dict["length"] as? String,
                let detail = dict["detail"] as? String,
                let image = dict["image"] as? String
                else {
                    fatalError("Error parsing dict \(dict)")
            }
            
            let show = Show(
                title: title,
                length: length,
                detail: detail,
                image: image,
                rowheight: 0.0
            )
            
            shows.append(show)
        }
        
        return shows
        
    }
}
