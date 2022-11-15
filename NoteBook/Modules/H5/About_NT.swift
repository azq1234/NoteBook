//
//  About_NT.swift
//  NoteBook
//
//  Created by admin on 2022/11/15.
//

import UIKit
class About_NT: NT_WebViewController {
    deinit {
        print("deinit")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
    }
    private func setNavBar() {
        title = "关于我们"
        addBackBarButtonItem()
    }
}
