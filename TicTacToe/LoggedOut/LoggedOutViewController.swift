//
//  LoggedOutViewController.swift
//  TicTacToe
//
//  Created by Ramon Honorio on 04/05/19.
//  Copyright © 2019 Uber. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import SnapKit

protocol LoggedOutPresentableListener: class {
    func login(withPlayer1Name: String?, player2Name: String?)
}

final class LoggedOutViewController: UIViewController, LoggedOutPresentable, LoggedOutViewControllable {

    weak var listener: LoggedOutPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        let playerFields = buildPlayerFields()
        buildLoginButton(withPlayer1Field: playerFields.player1Field, player2Field: playerFields.player2Field)
    }
    
     // MARK: - Private
    private var player1Field: UITextField?
    private var player2Field: UITextField?
    
    private func buildPlayerFields() -> (player1Field: UITextField, player2Field: UITextField) {
        let player1Field = UITextField()
        self.player1Field = player1Field
        view.addSubview(player1Field)
        player1Field.borderStyle = .line
        player1Field.placeholder = "Player 1"
        player1Field.snp.makeConstraints { (make: ConstraintMaker) in
            make.top.equalToSuperview().offset(100)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }

        let player2Field = UITextField()
        self.player2Field = player2Field
        view.addSubview(player2Field)
        player2Field.borderStyle = .line
        player2Field.placeholder = "Player 2"
        player2Field.snp.makeConstraints { (make: ConstraintMaker) in
            make.top.equalTo(player1Field.snp.bottom).offset(20)
            make.left.right.height.equalTo(player1Field)
        }
        
        return (player1Field, player2Field)
    }
    
    private func buildLoginButton(withPlayer1Field player1Field: UITextField, player2Field: UITextField) {
        let loginButton = UIButton()
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { (make: ConstraintMaker) in
            make.top.equalTo(player2Field.snp.bottom).offset(20)
            make.left.right.height.equalTo(player1Field)
        }
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = .black
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    }
    
    @objc private func didTapLoginButton() {
        listener?.login(withPlayer1Name: player1Field?.text, player2Name: player2Field?.text)
    }
    
}
