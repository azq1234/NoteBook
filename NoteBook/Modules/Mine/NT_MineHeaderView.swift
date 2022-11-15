//
//  NT_MineHeaderView.swift
//  NoteBook
//
//  Created by admin on 2022/11/15.
//

import UIKit

class NT_MineHeaderView: UIView {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var headImgView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var gradeBtn: UIButton!
    @IBOutlet weak var rechargeBtn: UIButton!
    @IBOutlet weak var rechargeArrowImgView: UIImageView!
    @IBOutlet weak var accountBalanceLabel: UILabel!
    @IBOutlet weak var winningAmountLabel: UILabel!
    @IBOutlet weak var withdrawAmountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.bgView.corner([.bottomLeft,.bottomRight], radii: 20)
    }
    
    func updateUI() {
//
//        if memberModel?.avatar?.isEmpty == false {
//            headImgView.kf.setImage(with: URL(string: memberModel!.avatar!))
//        }
//        nicknameLabel.text = memberModel?.nickname
//        gradeBtn.setTitle(memberModel?.vipLevel, for: .normal)
//        accountBalanceLabel.text = accountModel?.balance
//        winningAmountLabel.text = accountModel?.sumReward
//        withdrawAmountLabel.text = accountModel?.sumWithdraw
//
//        let level = Int(memberModel?.vipLevel ?? "0") ?? 0
//        if level == 8 {
//            rechargeBtn.setTitle("", for: .normal)
//            rechargeBtn.isHidden = false
//        } else {
//            let rechargeBtnTitle = "充值\(memberModel?.nextLevelNeedAmount ?? "0" )元，即可升级到VIP\(level + 1)"
//            rechargeBtn.setTitle(rechargeBtnTitle, for: .normal)
//            rechargeBtn.isHidden = false
//        }
    }
    @IBAction func headImgViewTap(_ sender: UITapGestureRecognizer) {
        
    }
    
    @IBAction func goToVipDetails(_ sender: UIButton) {
      
//        currentNavViewController()?.pushViewController(vc, animated: true)
    }
    
    @IBAction func rechargeBtnAction(_ sender: UIButton) {
        nt_playVoice(resource: "a17-常规按钮音")
    }
    @IBAction func withdrawBtnAction(_ sender: UIButton) {
        nt_playVoice(resource: "a17-常规按钮音")
    }
    @IBAction func walletBtnAction(_ sender: UIButton) {
        nt_playVoice(resource: "a17-常规按钮音")
    }
    @IBAction func recordBtnAction(_ sender: UIButton) {
        nt_playVoice(resource: "a17-常规按钮音")
    }
    
    

}
