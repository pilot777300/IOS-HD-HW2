//
//  FeedViewController.swift
//  NavigTest
//
//  Created by Mac on 07.11.2022.
//

import UIKit

class FeedViewController: UIViewController {

    var coordinator: FeedCoordinator?
    
    var blinkStatus = false
    
    private lazy var checkGuessButton: CustomButton = {
        let button = CustomButton(buttonTitle: "ПРОВЕРИТЬ", buttonColor: .systemBlue) { [unowned self]  in
           buttonAction()
        }
        return button
    }()
    
    
   private lazy var textfield: UITextField = {
        let txt = UITextField()
        txt.backgroundColor = .white
        txt.layer.cornerRadius = 12
        txt.placeholder = "Введите слово, которое я загадал"
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    private lazy var guessColor: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = .systemGray5
        lbl.layer.cornerRadius = 30
        lbl.text = ""
        lbl.font = UIFont.boldSystemFont(ofSize: 40)
        lbl.textColor = .clear
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            textfield.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            textfield.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 200),
            textfield.widthAnchor.constraint(equalToConstant: 300),
            textfield.heightAnchor.constraint(equalToConstant: 50),
            
            checkGuessButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            checkGuessButton.topAnchor.constraint(equalTo: textfield.bottomAnchor, constant: 30),
            checkGuessButton.widthAnchor.constraint(equalToConstant: 300),
            checkGuessButton.heightAnchor.constraint(equalToConstant: 50),
            
            guessColor.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 30),
            guessColor.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 30),
            guessColor.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -30),
            guessColor.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        self.view.addSubview(checkGuessButton)
        self.view.addSubview(textfield)
        self.view.addSubview(guessColor)
        setConstraints()
            }
            
         private func buttonAction() {
             
                let feedModel = FeedModel()
                if textfield.text != nil && textfield.text == feedModel.secretWord  {
                   
                    guessColor.backgroundColor = .green//custom.buttonColor
                    guessColor.text = "YES!!!!"
                    guessColor.textColor = .black
                    
                } else {
                    let timer = Timer.scheduledTimer(timeInterval: 0.5,
                                                     target: self,
                                                     selector: #selector(startTimer),
                                                     userInfo: nil,
                                                     repeats: true)
                    timer.fire()
                    startTimer()
                    guessColor.text = "ОШИБКА"
                    guessColor.textColor = .black
                    
                    }
                }
    
        @objc func startTimer() {
     
            if blinkStatus == false {
                guessColor.backgroundColor = .red
                blinkStatus = true
                
            } else {
                    guessColor.backgroundColor = .systemGray5
                    blinkStatus = false
                }
            }
        }
            

    
    



