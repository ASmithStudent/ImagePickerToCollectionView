//
//  ViewController.swift
//  ImagePickerTest
//
//  Created by Adrian Smith on 5/28/18.
//  Copyright © 2018 Adrian Smith. All rights reserved.
//

import UIKit
import ImagePicker
import Lightbox

class ViewController: UIViewController, ImagePickerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    //Storyboard Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Public Variable Initializations
    var imageArray: [UIImage] = []
    var imageArrayCount : Int = 0


    //View loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Image Array Count", imageArrayCount)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    //On "Select Image" Press
    @IBAction func selectImage(_ sender: Any) {
        var config = Configuration()
        config.doneButtonTitle = "Finish"
        config.noImagesTitle = "Sorry! There are no images here."
        config.recordLocation = false
        config.allowVideoSelection = false
        
        let imagePicker = ImagePickerController(configuration: config)
        imagePicker.delegate = self
        
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK - Image Picker Delegate Methods
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        guard images.count > 0 else {return}
        
        
        let lightboxImages = images.map {
            return LightboxImage(image: $0)
        }
        
        let lightbox = LightboxController(images: lightboxImages, startIndex: 0)
        imagePicker.present(lightbox, animated: true, completion: nil)
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
        //Loop through all images when done button pressed and pull out images into array of images.
        createImageArray(images: images)
        
        imagePicker.dismiss(animated: true, completion: nil)
        self.collectionView.reloadData()
//        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    // Collection View Delegate Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("Image Array Length: ", imageArray.count)
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.imageImageView.image = imageArray[indexPath.item]
        print("ImageArray[indexpath.item]", imageArray[indexPath.item])
        return cell
        
    }
    
    
    // Helper Functions
    func createImageArray(images: [UIImage]) {
        var i = 0
        
        while i < images.count {
            imageArray.append(images[i])
            i += 1
        }
        
        print("Image Array: ", imageArray)
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

