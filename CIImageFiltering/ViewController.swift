//
//  ViewController.swift
//  CIImageFiltering
//
//  Created by Mark Wilkinson on 10/27/17.
//  Copyright © 2017 Mark Wilkinson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("view loaded")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    @IBAction public func didTap(_ sender: Any) {

        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        // create the CIImage first
        let ciImage = CIImage(image: self.imageView.image!)
        // create the filter
        let filter = CIFilter(name: "CIPhotoEffectMono", withInputParameters: [ kCIInputImageKey : ciImage])
        // need an output image
        let outputImage = filter!.outputImage
        
        let operationQueue = OperationQueue()
        operationQueue.addOperation {
            // have to use a context to do the work
            let context = CIContext(options: [:])
            // need back a CGImage to actually use
            let cgImage = context.createCGImage(outputImage!, from: outputImage!.extent)
            let finalOutputImage = UIImage(cgImage: cgImage!)
            
            // now put back on the main thread
            OperationQueue.main.addOperation {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self.imageView.image = finalOutputImage
            }
        }
    }
    
}

