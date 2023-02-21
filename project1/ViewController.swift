//
//  ViewController.swift
//  project1
//
//  Created by Tamim Khan on 25/1/23.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "storm viewer"
        navigationItem.largeTitleDisplayMode = .never
        
        
        performSelector(inBackground: #selector(load), with: nil)
        tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        
    }
    
    @objc func load(){
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl"){
                pictures.append(item)
            }
        }
        
        pictures.sort()
        
    }
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return pictures.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
            cell.textLabel?.text = pictures[indexPath.row]
            
            return cell
        }
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
                vc.selectedImage = pictures[indexPath.row]
                vc.selectedPictureNumber = indexPath.row + 1
                vc.totalPictures = pictures.count
                navigationController?.pushViewController(vc, animated: true)
                
            }
            
        }
    }
    

