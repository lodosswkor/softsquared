//
//  ViewController.swift
//  Week01
//
//  Created by lodossw on 2021/04/18.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnRow01: UIView!
    @IBOutlet weak var btnRow02: UIView!
    @IBOutlet weak var btnRow03: UIView!
    @IBOutlet weak var btnRow04: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        btnGroupArrangement();
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        btnGroupArrangement();
    }
    
    
    // 동적으로 레이아웃 변경할수 있도록...
    // 다음에 ... ㅠㅠ
    
    func btnGroupArrangement() {
        
        /*self.btnRow01.removeConstraints(self.btnRow01.constraints);
        self.btnRow02.removeConstraints(self.btnRow02.constraints);
        self.btnRow03.removeConstraints(self.btnRow03.constraints);
        self.btnRow04.removeConstraints(self.btnRow04.constraints);
        */
        if isLandscape() {
                
            self.btnRow01.isHidden = true;
            self.btnRow02.isHidden = true;
            self.btnRow03.isHidden = true;
            self.btnRow04.isHidden = true;
            
        } else {
            
            self.btnRow01.isHidden = false;
            self.btnRow02.isHidden = false;
            self.btnRow03.isHidden = false;
            self.btnRow04.isHidden = false;
        }
    }
    
    func isLandscape()->Bool
    {
        return UIDevice.current.orientation.isLandscape;
    }

}

