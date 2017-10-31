//
//  HistoryViewController.swift
//  SimpleCalc-iOS
//
//  Created by Ryan Liang on 10/26/17.
//  Copyright © 2017 Ryan Liang. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class HistoryViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textView: UITextView!
    var history:[String] = []
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ViewController
        destination.history = self.history
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if history.count > 0 {
            for i in 0...history.count-1 {
                /*let label = UILabel(frame: CGRect(x: 20, y: CGFloat(i * 50), width: scrollView.frame.size.width, height: 50))
                label.text = history[i]
                label.font = label.font.withSize(20)
                
                scrollView.addSubview(label)*/
                textView.text! += history[i] + "\n" + "\n"
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
