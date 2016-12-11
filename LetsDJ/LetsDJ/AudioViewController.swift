//
//  AudioViewController.swift
//  Pods
//
//  Created by Milan Saxena on 12/5/16.
//
//

import Foundation
import UIKit
import AVFoundation

class AudioViewController : UIViewController {
    
    var image = UIImage()
    var mainSongTitle = String()
    var mainPreviewURL = String()
    var playOrPause: Int = 2
    var listNames = [String]()
    var listImages = [UIImage]()
    var mainPreviewURLArr = [String]()
    
    
    @IBOutlet var background: UIImageView!
    
    @IBOutlet var mainImageView: UIImageView!
    
    @IBOutlet var playPause: UIImageView!
    
    @IBOutlet var songTitle: UILabel!
    
    override func viewDidLoad() {
        songTitle.text = mainSongTitle
        background.image = image
        mainImageView.image = image
        downloadFileFromURL(url: URL(string: mainPreviewURL)!)
        playPause.image = UIImage(named: "Play_Pause_\(playOrPause)")
        playPause.isUserInteractionEnabled = true
        //now you need a tap gesture recognizer
        //note that target and action point to what happens when the action is recognized.
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(AudioViewController.imageTapped))
        //Add the recognizer to your view.
        playPause.addGestureRecognizer(tapRecognizer)
        
    }
    
    
    func downloadFileFromURL(url: URL) {
        var downloadTask = URLSessionDownloadTask()
        downloadTask = URLSession.shared.downloadTask(with: url, completionHandler: {
            customURL, response, error in
            self.play(url:customURL!)
        })
        
        downloadTask.resume()
    }
    
    func play(url: URL) {
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            player.play()
        } catch {
            print(error)
        }
        
        
    }
    
    func setImageArray(images: [UIImage]) {
        listImages = images
    }
    
    func setNameArray(names: [String]) {
        listNames = names
    }
    
    func setPreviewArr(preview: [String]) {
        mainPreviewURLArr = preview
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "playlist" {
            listNames.append(mainSongTitle)
            listImages.append(image)
            mainPreviewURLArr.append(mainPreviewURL)
            let vc = segue.destination as! PlaylistTableViewController
            vc.setImage(image: image)
            vc.setName(theName: mainSongTitle)
            vc.configNameArray(names: listNames)
            vc.configImageArray(images: listImages)
            vc.configPreviewArray(preview: mainPreviewURLArr)
        }
    }
    
    func imageTapped() {
        if player.isPlaying {
            player.pause()
            playPause.image = UIImage(named: "Play_Pause_1")
            
            
        } else {
            player.play()
            playPause.image = UIImage(named: "Play_Pause_2")
        }
        
    }
    
}
