//
//  DetailedViewController.swift
//  MusicSpotter
//
//  Created by IOS-Babu on 10/05/24.
//

import UIKit

class DetailedViewController: UIViewController {
    
    @IBOutlet weak var songImage: UIImageView!
    @IBOutlet weak var favImage: UIImageView!
    @IBOutlet weak var songname: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var timeProgressBar :UIProgressView!
    
    var data : Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindDataToUI()
    }
    
    private func bindDataToUI(){
        guard let data = data else{ return }
        songImage.loadImage(string: data.artworkUrl60)
        songname.text = data.trackName
        artistName.text = data.artistName
        
        CoreDataManager.shared.fetchFavoriteTracks() { favoriteTrackIds in
            if let favoriteTrackIds = favoriteTrackIds  {
                if favoriteTrackIds.contains(data.trackId) {
                    self.favImage.image = UIImage(systemName: "heart.fill")
                    self.favImage.tintColor = .red
                } else {
                    self.favImage.image = UIImage(systemName: "heart")
                    self.favImage.tintColor = .label
                }
            }
            
        }
    }
    @IBAction func backAction(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func toggleFavAction(_ sender: UIButton) {
        guard let data = data else { return }
        CoreDataManager.shared.fetchFavoriteTracks() { favoriteTrackIds in
            if let favoriteTrackIds = favoriteTrackIds {
                if favoriteTrackIds.contains(data.trackId) {
                    CoreDataManager.shared.removeFavoriteTrack(trackId: data.trackId)
                    self.favImage.image = UIImage(systemName: "heart")
                    self.favImage.tintColor = .label
                } else {
                    CoreDataManager.shared.addFavoriteTrack(trackId: data.trackId)
                    self.favImage.image = UIImage(systemName: "heart.fill")
                    self.favImage.tintColor = .red
                }
            } else {
                CoreDataManager.shared.addFavoriteTrack(trackId: data.trackId)
                self.favImage.image = UIImage(systemName: "heart.fill")
                self.favImage.tintColor = .red
            }
        }
    }
}
