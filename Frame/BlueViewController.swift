//
//  BlueViewController.swift
//  switch
//
//  Created by 刘炳辰 on 15/7/23.
//  Copyright (c) 2015年 刘炳辰. All rights reserved.
//

import UIKit

class BlueViewController: UIViewController {
    
    @IBOutlet var btnRight: UIButton!
    @IBOutlet var btnLeft: UIButton!
    
    /*@IBAction func circleTapped(sender: UIButton){
    let vc = storyboard?.instantiateViewControllerWithIdentifier("blue") as! ViewController
    self.navigationController?.presentViewController(vc, animated: false, completion: nil)
    //self.navigationController?.popViewControllerAnimated(true)
    }*/
    func touched(){
        drawerVc.toggleDrawerWithSide(JVFloatingDrawerSide.Left, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
