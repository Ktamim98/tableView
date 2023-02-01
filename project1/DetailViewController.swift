//
//  DetailViewController.swift
//  project1
//
//  Created by Tamim Khan on 26/1/23.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    
    var selectedPictureNumber : Int?
    var totalPictures : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedImage
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shared))
        
        if let imageToLoad = selectedImage{
            imageView.image = UIImage(named: imageToLoad)
        }

        self.title = "Picture \(selectedPictureNumber!) of \(totalPictures!)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    @objc func shared(){
        let shareLink = "https://www.youtube.com/watch?v=xvFZjo5PgG0"
        
        let vc = UIActivityViewController(activityItems: [shareLink], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
}
