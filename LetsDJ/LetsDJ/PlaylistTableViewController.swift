//
//  PlaylistTableViewController.swift
//  LetsDJ
//
//  Created by Milan Saxena on 12/6/16.
//  Copyright © 2016 Milan Saxena. All rights reserved.
//

import UIKit


var mainImage = UIImage()
var name = String()

var playImages = [UIImage]()
var playNames = [String]()
var playPreview = [String]()


class PlaylistTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.tableView.reloadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return playPreview.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        let mainImageView = cell?.viewWithTag(2) as! UIImageView
        
        mainImageView.image = playImages[indexPath.row]
        
        let mainLabel = cell?.viewWithTag(1) as! UILabel
        
        mainLabel.text = playNames[indexPath.row]
        
        return cell!
    }
    
    
    func setImage(image: UIImage) {
        mainImage = image
    }
    
    func setName(theName: String) {
        name = theName
    }

    func configNameArray(names: [String]) {
        playNames = names
    }
    
    func configImageArray(images: [UIImage]) {
        
        playImages = images
    }
    
    func configPreviewArray(preview: [String]) {
        playPreview = preview
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToSearch" {
            let vc = segue.destination as! TableViewController
            vc.setNArray(names: playNames)
            vc.setImgArray(images: playImages)
            vc.setPrevArray(prev: playPreview)
        }
        
        let indexPath = self.tableView.indexPathForSelectedRow?.row
        if segue.identifier == "backToAudio" {
            
            let vc = segue.destination as! AudioViewController
            
            vc.image = playImages[indexPath!]
            vc.mainSongTitle = playNames[indexPath!]
            vc.mainPreviewURL = playPreview[indexPath!]
            vc.setNameArray(names: playlistNames)
            vc.setImageArray(images: playlistImages)
            vc.setPreviewArr(preview: playPreview)
        } else if segue.identifier == "audioFinal" {
            let vc = segue.destination as! AudioFinalViewController
            
            vc.imagePic = playImages[indexPath!]
            vc.mainSongTitle = playNames[indexPath!]
            vc.mainPreviewURL = playPreview[indexPath!]
            vc.setNameArray(names: playlistNames)
            vc.setImageArray(images: playlistImages)
            vc.setPreviewArr(preview: playPreview)
        } 
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            playNames.remove(at: indexPath.row)
            playImages.remove(at: indexPath.row)
            playPreview.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
