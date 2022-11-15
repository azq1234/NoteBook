//
//  NT_MineViewCell.swift
//  NoteBook
//
//  Created by admin on 2022/11/15.
//

import UIKit

class NT_MineViewCell: UITableViewCell {

 
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var pointView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var describeLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    class func cell(tableView:UITableView, indexPath:IndexPath, unreadMsgCount:String) -> NT_MineViewCell {
        let cellId = "NT_MineViewCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? NT_MineViewCell
        if nil == cell {
            cell = (UIView.xibView(cellId) as! NT_MineViewCell)
        }
        cell?.selectionStyle = .none
    
        cell?.setupUI(tableView: tableView, indexPath: indexPath, unreadMsgCount: unreadMsgCount)
        
        return cell!
    }
    
    private func setupUI(tableView:UITableView, indexPath:IndexPath, unreadMsgCount:String) {
        if indexPath.section == 0 {
            iconImgView.image = UIImage(named: "mine_huodong")
            nameLabel.text = "X1"
            describeLabel.text = ""
            lineView.isHidden = true
            pointView.isHidden = true
            describeLabel.text = ""
            describeLabel.isHidden = true
        } else if indexPath.section == 1{
            iconImgView.image = UIImage(named: "mine_zhanneixin")
            nameLabel.text = "X2"
            describeLabel.text = ""
            lineView.isHidden = true
            pointView.isHidden = Int(unreadMsgCount)! > 0 ? false : true
            describeLabel.isHidden = pointView.isHidden
            describeLabel.text = unreadMsgCount + "封未读消息"
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                iconImgView.image = UIImage(named: "mine_daili")
                nameLabel.text = "X3"
                describeLabel.text = ""
                lineView.isHidden = false
                pointView.isHidden = true
                describeLabel.text = ""
                describeLabel.isHidden = true
            } else if indexPath.row == 1 {
                iconImgView.image = UIImage(named: "mine_baobiao")
                nameLabel.text = "X4"
                describeLabel.text = ""
                lineView.isHidden = false
                pointView.isHidden = true
                describeLabel.text = ""
                describeLabel.isHidden = true
            } else if indexPath.row == 2 {
                iconImgView.image = UIImage(named: "mine_yinhangka")
                nameLabel.text = "X5"
                describeLabel.text = ""
                lineView.isHidden = false
                pointView.isHidden = true
                describeLabel.text = ""
                describeLabel.isHidden = true
            } else if indexPath.row == 3 {
                iconImgView.image = UIImage(named: "mine_anquan")
                nameLabel.text = "X6"
                describeLabel.text = ""
                lineView.isHidden = false
                pointView.isHidden = true
                describeLabel.text = ""
                describeLabel.isHidden = true
            } else if indexPath.row == 4 {
                iconImgView.image = UIImage(named: "mine_fenxiang")
                nameLabel.text = "X7"
                describeLabel.text = ""
                lineView.isHidden = false
                pointView.isHidden = true
                describeLabel.text = ""
                describeLabel.isHidden = false
                describeLabel.text = "X7 1122222"
            }
        }
    }
}
