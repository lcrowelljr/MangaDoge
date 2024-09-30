//
//  MangaChapter.swift
//  MangaDoge
//
//  Created by Lani Crowell on 9/14/24.
//

import Foundation
import UIKit

class MangaChapter{//UNUSED
    let name: String
    let chapterNumber: Int
    let uploader: String
    var chapterContent: [String]
    init(name: String, chapterNumber: Int, uploader: String, pages: [String]) {
        self.name = name
        self.chapterNumber = chapterNumber
        self.uploader = uploader
        self.chapterContent = pages
        
    }
}
