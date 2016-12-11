//
//  ViewController.swift
//  LetsDJ
//
//  Created by Milan Saxena on 11/30/16.
//  Copyright © 2016 Milan Saxena. All rights reserved.
//

import UIKit
import Alamofire
import AVFoundation

var player = AVAudioPlayer()

var playlistNames = [String]()
var playlistImages = [UIImage]()
var previewURLArr = [String]()

struct post {
    let mainImage : UIImage!
    let name : String!
    let previewURL: String!
    
}

class TableViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet var searchBar: UISearchBar!

    
    var posts = [post]()

    var searchURL = String()
    
    typealias JSONStandard = [String: AnyObject]
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        tableView.reloadData()
        let keywords = searchBar.text
        let finalKeywords = keywords?.replacingOccurrences(of: " ", with: "+")
        
        
        
        searchURL = "https://api.spotify.com/v1/search?q=\(finalKeywords!)&type=track"
        
        callAlamo(url: searchURL)
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func callAlamo(url: String) {
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            self.parseData(JSONData: response.data!)
            
        })
        
        
    }
    
    func parseData(JSONData: Data) {
        
        do {
            var readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! JSONStandard
            if let tracks = readableJSON["tracks"] as? JSONStandard {
                if let items = tracks["items"] as? [JSONStandard]{
                    for i in 0..<items.count{
                        let item = items[i]
                        let name = item["name"] as! String
                        let previewURL = item["preview_url"] as! String
                        print(name)
                        print(previewURL)
                        if let album = item["album"] as? JSONStandard {
                            if let images = album["images"] as? [JSONStandard]{
                                let imageData = images[0] //highest quality
                                let mainImageURL = URL(string: imageData["url"] as! String)
                                let mainImageData = NSData(contentsOf: mainImageURL!)
                                
                                let mainImage = UIImage(data: mainImageData as! Data)
                                
                                posts.append(post.init( mainImage: mainImage, name: name, previewURL: previewURL))
                                self.tableView.reloadData()


                            }
                        }
                        
                        
                    }
                }
                
            }
            print(readableJSON)
        } catch {
            print(error)
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        let mainImageView = cell?.viewWithTag(2) as! UIImageView
        
        mainImageView.image = posts[indexPath.row].mainImage
        
        let mainLabel = cell?.viewWithTag(1) as! UILabel
        
        mainLabel.text = posts[indexPath.row].name
                
        return cell!
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = self.tableView.indexPathForSelectedRow?.row
        if segue.identifier == "audio" {
        
            let vc = segue.destination as! AudioViewController
            
            vc.image = posts[indexPath!].mainImage
            vc.mainSongTitle = posts[indexPath!].name
            vc.mainPreviewURL = posts[indexPath!].previewURL
            vc.setNameArray(names: playlistNames)
            vc.setImageArray(images: playlistImages)
            vc.setPreviewArr(preview: previewURLArr)
        } else if segue.identifier == "goingToThePlaylist" {
            let vc = segue.destination as! PlaylistTableViewController
            vc.setImage(image: mainImage)
            vc.setName(theName: name)
            vc.configNameArray(names: playlistNames)
            vc.configImageArray(images: playlistImages)
            vc.configPreviewArray(preview: previewURLArr)

        }
        
    }
    
    
    func setNArray(names: [String]) {
        playlistNames = names
    }
    
    func setImgArray(images: [UIImage]) {
        playlistImages = images
    }
    
    func setPrevArray(prev: [String]) {
        previewURLArr = prev
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

