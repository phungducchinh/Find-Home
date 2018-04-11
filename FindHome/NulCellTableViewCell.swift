//
//  NulCellTableViewCell.swift
//  FindHome
//
//  Created by phungducchinh on 4/10/18.
//  Copyright © 2018 phungducchinh. All rights reserved.
//

import UIKit

class NulCellTableViewCell: UITableViewCell {

    public let lbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = lbl.font?.withSize(20)
        lbl.text = "Chưa có bài dăng nào"
        lbl.textColor = .black
        return lbl
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(lbl)

        contentView.backgroundColor = .white
        let View = ["lbl" : self.lbl] as [String : Any]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[lbl]-30-|", options: [], metrics: nil, views: View))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-25-[lbl(25)]", options: [], metrics: nil, views: View))
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
