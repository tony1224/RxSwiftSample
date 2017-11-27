//
//  ViewController.swift
//  RxSwiftSample
//
//  Created by Morita Jun on 2017/11/27.
//  Copyright © 2017年 Morita Jun. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// unsubscribeに必要なもの？
let disposeBug = DisposeBag()

class ViewController: UIViewController {

    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        textField.rx.text
            .map{$0} // observerを１個ずつ処理するよ
            .bind(to: label.rx.text) // observerに紐づける処理
            .disposed(by: disposeBug) // いらなくなったら解放するよ
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

