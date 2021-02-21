//
//  ZoomViewController.swift
//  SlideshowApp
//
//  Created by 井口創太 on 2021/02/19.
//

import UIKit

class ZoomViewController: UIViewController {
    @IBOutlet weak var zoomView: UIImageView!
    
    //ViewControllerから送られてくるnowIndexの番号のために変数を用意
    var index:Int = 0
  
    override func viewDidLoad() {
        super.viewDidLoad()
        zoomView.image = imageList[index]
    }
    
}
