//
//  ChapterListViewController.swift
//  MangaDoge
//
//  Created by Lani Crowell on 9/26/24.
//

import UIKit
import FirebaseStorage

class ChapterListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var mangaTitle = ""
    var chapterList = [String]()
    var chapterToSend = 0
    
    @IBOutlet weak var chapterTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getChapters()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chapterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "chapterViewCell", for:  indexPath) as? ChapterListTableViewCell
        else {return tableView.dequeueReusableCell(withIdentifier: "chapterViewCell", for: indexPath)}
        let chapter = chapterList[indexPath.row]
        cell.chapterName.text = "\(mangaTitle)"
        cell.chapterNum.text = "Chapter \(chapter.suffix(1))"
        
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chapterToSend = indexPath.row
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let chapterToSend = chapterTableView.indexPathForSelectedRow
        if let destination = segue.destination as? ChapterViewController {
            destination.chapterFolder = chapterList[chapterToSend!.row]
            destination.mangaTitle = self.mangaTitle
        }
    }
    func getChapters(){
        let storage = Storage.storage()
        let storageRef = storage.reference().child("Manga").child(mangaTitle)
        storageRef.listAll() { (result, error) in
            if error != nil {
                print("Error fetching manga chapters")
                return
            }
            for chapter in result!.prefixes {
                self.chapterList.append(chapter.name)
            }
            self.chapterTableView.reloadData()
        }
    }
}
