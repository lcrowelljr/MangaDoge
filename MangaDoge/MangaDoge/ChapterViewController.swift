//
//  ChapterViewController.swift
//  MangaDoge
//
//  Created by Lani Crowell on 9/13/24.
//

import Foundation
import UIKit
import FirebaseStorage

class ChapterViewController: UIViewController {
    
    var mangaTitle = ""
    var chapterFolder: String?
    var chapterPageArray = [String]()
    var chapterIndex = 0
    
    @IBOutlet weak var pageView: UIImageView!
    @IBOutlet weak var pageCountLabel: UILabel!
    
    @IBAction func nextButton(_ sender: UIButton) {
        if chapterIndex == chapterPageArray.count-1{
            chapterIndex = 0
            showPage(pageURL: chapterPageArray[chapterIndex])
            updatePageCountLabel(page: chapterIndex)
        }
        else{
            chapterIndex += sender.tag
            showPage(pageURL: chapterPageArray[chapterIndex])
            updatePageCountLabel(page: chapterIndex)
        }
    }
    
    @IBAction func prevButton(_ sender: UIButton) {
        if chapterIndex == 0{
            chapterIndex = chapterPageArray.count-1
            showPage(pageURL: chapterPageArray[chapterIndex])
            updatePageCountLabel(page: chapterIndex)
        }
        else{
            chapterIndex += sender.tag
            showPage(pageURL: chapterPageArray[chapterIndex])
            updatePageCountLabel(page: chapterIndex)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getChapterPages()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            self.updatePageCountLabel(page: self.chapterIndex)
            self.chapterPageArray.sort()
            self.showPage(pageURL: self.chapterPageArray[self.chapterIndex])
        }
    }
    
    func showPage(pageURL: String){
        if let url = URL(string: pageURL) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.pageView.image = image
                    }
                }
            }
            task.resume()
        }
    }
    func updatePageCountLabel(page: Int){
        self.pageCountLabel.text = "Page " + String(page + 1) + "/" + String(chapterPageArray.count)
    }
    func getChapterPages(){
        guard let folder = chapterFolder else {print("Guard error");return}
        let storage = Storage.storage()
        let storageRef = storage.reference().child("Manga").child(mangaTitle).child(folder)
        
        storageRef.listAll() { (result, error) in
            if error != nil {
                return
            }
            for page in result!.items {
                page.downloadURL() { url, error in
                    if let url = url {
                        self.chapterPageArray.append(url.absoluteString)
                    }
                }
            }
        }
    }
}
