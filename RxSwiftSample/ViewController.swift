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

// unsubscribeを自動的に行ってくれる処理
// 最終的に複数のObservableをまとめてdispose()する処理
let disposeBag = DisposeBag()

class ViewController: UIViewController {

    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var button: UIButton!
    
    @IBOutlet private weak var textField1: UITextField!
    @IBOutlet private weak var textField2: UITextField!
    @IBOutlet private weak var textField3: UITextField!
    @IBOutlet private weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // WwDC18 cherry-pick Xcode 10 beta
        // Source Control Workflow in Xcode
        print("🐶")
        
        textField.rx.text
            .map{$0} // observerを１個ずつ処理するよ
            .bind(to: label.rx.text) // observerに紐づける処理
            .disposed(by: disposeBag) // いらなくなったら解放するよ
        
        button.rx.tap
            .bind(onNext: { [unowned self] in
                self.showAlert()
            })
            .disposed(by: disposeBag)
        
        Observable.combineLatest(textField1.rx.text, textField2.rx.text, textField3.rx.text) {
            textValue1, textValue2, textValue3 -> Int in
            
            return (Int(textValue1!) ?? 0) + (Int(textValue2!) ?? 0) + (Int(textValue3!) ?? 0)
        }
            .map { $0.description }
            .bind(to: resultLabel.rx.text)
            .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Sample Alert", message: "Can you see a sample alert?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            // 何もしない
        }
        alert.addAction(ok)
        
        self.present(alert, animated: true, completion: nil)
    }

}

