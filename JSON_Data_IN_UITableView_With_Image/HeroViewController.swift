//
//  HeroViewController.swift
//  JSON_Data_IN_UITableView_With_Image
//
//  Created by DeEp KapaDia on 27/05/18.
//  Copyright © 2018 DeEp KapaDia. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}



class HeroViewController: UIViewController {

    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var NameLBL: UILabel!
    
    @IBOutlet weak var AttributeLBL: UILabel!
    
    @IBOutlet weak var LegsLBL: UILabel!
    
    @IBOutlet weak var AttackLBL: UILabel!
    
    
    var hero:HeroStats?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       NameLBL.text = hero?.localized_name
        AttributeLBL.text = hero?.primary_attr
       AttackLBL.text = hero?.attack_type
        LegsLBL.text = "\((hero?.legs)!)"
        
        
        //for image we need to get data with base URL.... 
        let urlString = "https://api.opendota.com"+(hero?.img)!
        
        let url = URL(string: urlString)
        
        ImageView.downloadedFrom(url: url!)
        
    
    }

}
