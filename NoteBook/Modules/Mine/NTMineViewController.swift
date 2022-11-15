//
//  NTMineViewController.swift
//  NoteBook
//
//  Created by admin on 2022/11/15.
//

import UIKit
import MJRefresh
private let HeaderViewHeight : CGFloat = 265

class NTMineViewController: UIViewController {
    private var tableView : UITableView!
    private var headerView : NT_MineHeaderView!
//    lazy var viewModel = NT_MineViewModel()
    private var unreadMsgCount = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
        
//        NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: NSNotification.Name(rawValue:notificationRequestMemberInfoAccountInfo), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: NSNotification.Name(rawValue:notificationRefreshUnreadMsg), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // 4.设置导航栏背景图片
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        // 5.设置导航栏阴影图片
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 4.设置导航栏背景图片
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        // 5.设置导航栏阴影图片
        self.navigationController?.navigationBar.shadowImage = nil
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }


}
//MARK: - 布局UI
extension NTMineViewController {
    private func setupUI() {
        
        addBackBarButtonItem()
        
        let serviceBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        serviceBtn.setImage(UIImage(named: "mine_kefu"), for: .normal)
        serviceBtn.addTarget(self, action: #selector(self.serviceItemAction), for: .touchUpInside)
        
        let setBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        setBtn.setImage(UIImage(named: "mine_setting"), for: .normal)
        setBtn.addTarget(self, action: #selector(self.setItemAction), for: .touchUpInside)
        
        let serviceItem = UIBarButtonItem(customView: serviceBtn)
        let setItem = UIBarButtonItem(customView: setBtn)
        self.navigationItem.rightBarButtonItems = [serviceItem, setItem]
        
        let headerView = UIView.xibView("NT_MineHeaderView") as! NT_MineHeaderView
        headerView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: HeaderViewHeight)
        self.headerView = headerView
        
        let tableView = UITableView(frame: CGRect(x: 0, y: kNavitionbarH, width: kScreenW, height: kScreenH - kNavitionbarH - KTabBarH), style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = headerView
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.rowHeight = 47.5
        view.addSubview(tableView)
        self.tableView = tableView
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {[weak self] in
            self?.loadData()
        })
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    private func updateUI() {
        headerView.updateUI()
        tableView.reloadData()
        tableView.mj_header?.endRefreshing()
    }
}

//MARK: - 网络请求
extension NTMineViewController {
    @objc func loadData() {
        // 定义队列
        let queue = DispatchQueue(label: "queue")
        // 定义一个组
        let group = DispatchGroup()
        //把队列放进组里
        queue.async(group: group, execute: {
            group.enter()//开始线程1
            // 发送request
           // http 成功
//                group.leave()//结束线程1
//                }, failure: { error in
          // http 失败
//                    group.leave()//结束线程1
//            })
        })
        queue.async(group: group, execute: {
            group.enter()//开始线程2
            // 发送request
            
          
        })
        
        queue.async(group: group, execute: {
             group.enter()//开始线程2
             // 发送request
             
//
         })
        group.notify(queue: queue) {
            //线程队列全部结束
            DispatchQueue.main.async {
                self.updateUI()
            }
        }
    }
}

//MARK: - 事件监听
extension NTMineViewController {
    
    @objc private func setItemAction() {
        nt_playVoice(resource: "a08-清除快捷")
//        let vc = CPT_SetViewController()
//        vc.hidesBottomBarWhenPushed = true
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func serviceItemAction() {
        nt_playVoice(resource: "a08-清除快捷")
//        let vc = CPT_ContactCustomerServiceVC()
//        vc.hidesBottomBarWhenPushed = true
//        navigationController?.pushViewController(vc, animated: true)
        
//        let alertVc = UIAlertController(title: "切换语言", message: nil, preferredStyle: .actionSheet)
//
//        let action1 = UIAlertAction(title: "英文", style: .default) { (action) in
//            HCLocalizableManager.share.updateLanguage("en")
//        }
//
//        let action2 = UIAlertAction(title: "中文", style: .default) { (action) in
//            HCLocalizableManager.share.updateLanguage("zh-Hans")
//        }
//
//        alertVc.addAction(action1)
//        alertVc.addAction(action2)
//
//        present(alertVc, animated: true, completion: nil)
    }
}

//MARK: - UITableViewDataSource,UITableViewDelegate
extension NTMineViewController : UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = NT_MineViewCell.cell(tableView: tableView, indexPath: indexPath, unreadMsgCount: unreadMsgCount)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.000001
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 10))
        view.backgroundColor = .hex(hexString: "#F5F5F5")
        
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        nt_playVoice(resource: "a03-圈子按钮")
        if indexPath.section == 0 {
            
        } else if indexPath.section == 1 {
            
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                
            } else if indexPath.row == 1 {
              
            } else if indexPath.row == 2 {
                
            } else if indexPath.row == 3 {
                
            } else if indexPath.row == 4 {
                
            }
        }
        PageChange.goToWeb(viewVC: self)
    }
    
    
      private func getDateTime () {
          
        let curDate = Date()
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM"
        let calendar = Calendar(identifier: .gregorian)
        var lastMonthComps = DateComponents()
        lastMonthComps.month = -1
        let newDate = calendar.date(byAdding: lastMonthComps, to: curDate)
        let monthTime = formater.string(from: newDate!)
    }
    
}
