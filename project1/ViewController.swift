//
//  ViewController.swift
//  project1
//
//  Created by Tamim Khan on 25/1/23.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    var picDic = [String: Int]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "storm viewer"
        navigationItem.largeTitleDisplayMode = .never
        
        let defaults = UserDefaults.standard
        if let saveData = defaults.object(forKey: "picDic") as? Data,
           let savePicture = defaults.object(forKey: "pictures") as? Data{
            let jsonDecoder = JSONDecoder()
            
            do{
                picDic = try jsonDecoder.decode([String: Int].self, from: saveData)
                pictures = try jsonDecoder.decode([String].self, from: savePicture)
            }catch{
                print("faild to load")
            }
        }else{
            performSelector(inBackground: #selector(load), with: nil)
        }
        tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        
        
        
    }
    
    @objc func load(){
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl"){
                pictures.append(item)
                picDic[item] = 0
                
            }
        }
        
        pictures.sort()
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        let picture = pictures[indexPath.row]
        cell.textLabel?.text = picture
        cell.detailTextLabel?.text = "👁️[\(picDic[picture]!)]"
        
        
        
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
            
            
            
            vc.selectedImage = pictures[indexPath.row]
            vc.selectedPictureNumber = indexPath.row + 1
            vc.totalPictures = pictures.count
            
            
            navigationController?.pushViewController(vc, animated: true)
            
        }
        
        let picture = pictures[indexPath.row]
        picDic[picture]! += 1
        save()
        tableView.reloadData()
        
    }
    func save(){
        let jsonEnCoder = JSONEncoder()
        if let saveData = try? jsonEnCoder.encode(picDic),
            let savePicture = try? jsonEnCoder.encode(pictures){
            let defaults = UserDefaults.standard
            defaults.set(saveData, forKey: "picDic")
            defaults.set(savePicture, forKey: "pictures")
        }else{
            print("failed to save")
        }
        
        
    }
    
    
}
