//
//  VideoTableViewCell.swift
//  HOPE
//
//  Created by Asma on 28/12/2021.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    
    var video: Video?
    
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        thumbnailImageView.layer.cornerRadius = 12
        thumbnailImageView.layer.borderColor = UIColor.lightGray.cgColor
        thumbnailImageView.layer.borderWidth = 1.0
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(_ v:Video) {
        
        self.video = v
        
        //MARK: Ensure that we have a video
        guard self.video != nil else {
            return
        }
        
        //MARK: Set the title label
        self.titleLabel.text = video?.title
        
        //MARK: Set the data
        //        let df = DateFormatter()
        //        df.dateFormat = "EEEE, MMM d, yyyy"
        //        self.dateLabel.text = df.string(from: video!.published)
        
        //MARK: Set the thumbnail
        guard self.video!.thumbnail != "" else {
            return
        }
        
        //MARK: Check Cache before downloading data
        if let cacheData = CacheManager.getVideoCache(self.video!.thumbnail) {
            //MARK: Set the thumbnail imageview
            self.thumbnailImageView.image = UIImage(data: cacheData)
            return
        }
        
        //MARK: Download the thumbnail data
        let url = URL(string: self.video!.thumbnail)
        
        //MARK: Get the shared URL Session object
        let session = URLSession.shared
        
        //MARK: Data task
        let dataTask = session.dataTask(with: url!) { data, response, error in
            if error == nil && data != nil {
                
                //MARK: Save the data in the cache
                CacheManager.setVideoCache(url!.absoluteString, data)
                
                //MARK: Check that the downloaded url matches the video thumbnail url that cell is currently set to display
                if url?.absoluteString != self.video?.thumbnail {
                    //MARK: Video cell has been recycled for another video and no longer matches the thumbnail that was downloaded
                    return
                }
                
                //MARK: Create image object
                let image = UIImage(data: data!)
                //MARK: Set the imageview
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = image
                }
            }
        }
        //MARK: Start data task
        dataTask.resume()
    }
}
