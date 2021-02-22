//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 井口創太 on 2021/02/19.
//

import UIKit

class ViewController: UIViewController {
  
  //各種Outlet
  @IBOutlet weak var nextButton: UIButton!
  @IBOutlet weak var backbutton: UIButton!
  @IBOutlet weak var startButton: UIButton!
  @IBOutlet weak var zoomButton: UIButton!
  @IBOutlet weak var imageView: UIImageView!
  
  //imageListの配列
  var imageList:[UIImage] = [
    UIImage(named: "1")!,
    UIImage(named: "2")!,
    UIImage(named: "3")!
  ]
  
  //画像の順番判別のための変数
  var nowIndex:Int = 0
  
  //遷移から戻ってきたとき、スライドショーを再開するかの判別変数
  var check:Bool = false
  
  //タイマー
  var timer: Timer!
  
  //DidLoadで０番目のimageListにある画像を表示
  override func viewDidLoad() {
    super.viewDidLoad()
    imageView.image = imageList[nowIndex]
  }
  
  //タイマーで用いる関数(nowIndexを増やしていき、その度UIImageViewに表示)
  @objc func updateTimer(_ timer: Timer) {
    nowIndex += 1

    if (nowIndex == imageList.count) {
      nowIndex = 0
    }
    imageView.image = imageList[nowIndex]
  }
  
  //画像をタップしたときの拡大表示のnowIndexの番号をZoomViewControllerに送るための関数
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let zoomViewController:ZoomViewController = segue.destination as! ZoomViewController
    zoomViewController.image = imageView.image!
    if self.timer != nil {
      self.timer.invalidate()
      check = true
    }
  }
  
  //進むボタンを押したときの処理(処理自体はタイマーで用いる関数と同様)
  @IBAction func nextImage(_ sender: Any) {
    nowIndex += 1

    if (nowIndex == imageList.count) {
      nowIndex = 0
    }
    imageView.image = imageList[nowIndex]
  }
  
  //戻るボタンを押したときの処理
  @IBAction func backImage(_ sender: Any) {
    nowIndex -= 1
    
     if (nowIndex == -1 ) {
      nowIndex = imageList.count - 1
     }
    imageView.image = imageList[nowIndex]
  }
  
  //再生/停止ボタンを押したときの処理、nilの状態で判断して、各種処理を行う
  @IBAction func slideshow(_ sender: Any) {
    if self.timer == nil {
      self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateTimer(_:)), userInfo: nil, repeats: true)
      self.startButton.setTitle("停止", for: .normal)
      self.nextButton.isEnabled = false
      self.backbutton.isEnabled = false
    } else {
      self.timer.invalidate()
      self.timer = nil
      self.startButton.setTitle("再生", for: .normal)
      self.nextButton.isEnabled = true
      self.backbutton.isEnabled = true
    }
  }
  
  //ZoomViewControllerから戻ってきたときの処理(形式上)
  @IBAction func unwind(_ segue: UIStoryboardSegue) {
    if check == true {
      self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateTimer(_:)), userInfo: nil, repeats: true)
      check = false
    }
  }
  
}

