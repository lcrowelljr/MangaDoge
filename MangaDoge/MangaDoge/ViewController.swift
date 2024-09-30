//
//  ViewController.swift
//  MangaDoge
//
//  Created by Lani Crowell on 9/13/24.
//

import UIKit
import FirebaseStorage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIApplicationDelegate {
    
    var mangaList = [String]()
    var mangaIndexToSend = 0
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getManga()
        
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mangaList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "chapterCell", for: indexPath) as? ChapterTableViewCell
        else{return tableView.dequeueReusableCell(withIdentifier: "chapterCell", for: indexPath)}
        
        let currentChapter = mangaList[indexPath.row]
        cell.mangaNameLabel.text = currentChapter
        
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let mangaToSend = tableView.indexPathForSelectedRow
        if let destination = segue.destination as? ChapterListViewController{
            destination.mangaTitle = mangaList[mangaToSend!.row]
        }
        
    }
    func getManga(){
        let storage = Storage.storage()
        let storageRef = storage.reference().child("Manga")
        storageRef.listAll() { (result, error) in
            if error != nil {
                print("Error fetching folders")
                return
            }
            for folder in result!.prefixes {
                self.mangaList.append(folder.name)
            }
            self.tableView.reloadData()
        }
    }
}

