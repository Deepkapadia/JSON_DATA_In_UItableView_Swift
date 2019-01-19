//
//  ViewController.swift
//  JSON_Data_IN_UITableView_With_Image
//
//  Created by DeEp KapaDia on 27/05/18.
//  Copyright © 2018 DeEp KapaDia. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var TableView: UITableView!
    
    var Heroes = [HeroStats]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DownloadJSON{
            
            print("Successfull")
            self.TableView.reloadData()
            
        }
        
        TableView.delegate = self
        TableView.dataSource = self
        
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        cell.textLabel?.text = Heroes[indexPath.row].localized_name.capitalized
        
        return cell
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "ShowDetails", sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? HeroViewController{
            
            destination.hero = Heroes[(TableView.indexPathForSelectedRow?.row)!]
        
        }
        
    }
    
    func DownloadJSON(completed:@escaping () -> ()){
        
        let url = URL(string: "https://api.opendota.com/api/heroStats")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error == nil{
                do{
                    
                self.Heroes = try JSONDecoder().decode([HeroStats].self, from: data!)
                    
                    DispatchQueue.main.async {
                    
                        completed()
                    
                    }
                    
                }
                catch{
                    
                    print("JSON Error")
                    
                }
            }
            
        }.resume()
        
        
    }
    
    
}

