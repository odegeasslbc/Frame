//
//  ViewController.swift
//  switch
//
//  Created by 刘炳辰 on 15/7/22.
//  Copyright (c) 2015年 刘炳辰. All rights reserved.
//

import UIKit


class RedViewController: UIViewController {
    
    /*@IBAction func circleTapped(sender: UIButton){
        let vc = storyboard?.instantiateViewControllerWithIdentifier("blue") as! ViewController
        self.navigationController?.presentViewController(vc, animated: false, completion: nil)
        //self.navigationController?.popViewControllerAnimated(true)
    }*/
    
    @IBOutlet weak var btnRight: UIButton!
    @IBOutlet weak var btnLeft: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //btnLeft.frame = CGRectMake(60, 600, 40, 40)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

