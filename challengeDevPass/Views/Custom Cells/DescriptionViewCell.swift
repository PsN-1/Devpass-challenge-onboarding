//
//  DescriptionView.swift
//  challengeDevPass
//
//  Created by Pedro Neto on 29/12/21.
//

import UIKit

struct CellData {
    var title: String?
    var descriptionTitle: String?
    var subTitle: String?
    var buttonTitle: String?
    var imageName: String?
    var hasButtom: Bool?
    var hasImage: Bool?
}

class DescriptionViewCell: UITableViewCell {
    
    lazy var title = buildTitleLabel()
    lazy var descriptionTitle = buildDescriptionTitle()
    lazy var userPhoto = buildImageView()
    lazy var subTitle = buildSubTitle()
    lazy var genericButton = buildGenericButton()
        
    var hasButton = false
    var hasImage = false
    var cellData: CellData?
    
    let imageDiameter: CGFloat = 60

    init(cellData: CellData, style: UITableViewCell.CellStyle = UITableViewCell.CellStyle.default, reuseIdentifier: String? =  K.descriptionCell) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.cellData = cellData
        setupView()
    }

    override init(style: UITableViewCell.CellStyle = UITableViewCell.CellStyle.default, reuseIdentifier: String? =  K.descriptionCell) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        hasButton = cellData?.hasButtom ?? false
        hasImage = cellData?.hasImage ?? false
        let buttonHeight: CGFloat = hasButton ? 48 : 0
        backgroundColor = .systemBackground
        contentView.addSubview(title)
        contentView.addSubview(descriptionTitle)
        contentView.addSubview(userPhoto)
        contentView.addSubview(subTitle)
        contentView.addSubview(genericButton)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            descriptionTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            descriptionTitle.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            descriptionTitle.trailingAnchor.constraint(equalTo: title.trailingAnchor),
            
            userPhoto.centerYAnchor.constraint(equalTo: descriptionTitle.centerYAnchor),
            userPhoto.trailingAnchor.constraint(equalTo: title.trailingAnchor),
            userPhoto.heightAnchor.constraint(equalToConstant: imageDiameter),
            userPhoto.widthAnchor.constraint(equalToConstant: imageDiameter),
            
            subTitle.topAnchor.constraint(equalTo: descriptionTitle.bottomAnchor, constant: 10),
            subTitle.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            subTitle.trailingAnchor.constraint(equalTo: title.trailingAnchor),
            subTitle.bottomAnchor.constraint(equalTo: genericButton.topAnchor, constant: -10),
            
            genericButton.leadingAnchor.constraint(equalTo: subTitle.leadingAnchor),
            genericButton.trailingAnchor.constraint(equalTo: subTitle.trailingAnchor),
            genericButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            genericButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])

        title.text = cellData?.title
        descriptionTitle.text = cellData?.descriptionTitle
        subTitle.text = cellData?.subTitle
        genericButton.setTitle(cellData?.buttonTitle, for: .normal)
        userPhoto.isHidden = !(cellData?.hasImage ?? false)
        
        if let imageUrl = URL(string: cellData?.imageName ?? ""), hasImage {
            userPhoto.load(url: imageUrl)
        }
    }
}

extension DescriptionViewCell {
    private func buildTitleLabel() -> UILabel {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 22)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Title"
        return view
    }
    
    private func buildDescriptionTitle() -> UITextView {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        view.backgroundColor = .clear
        view.isScrollEnabled = false
        view.font = UIFont.systemFont(ofSize: 18)
        view.text = "Description Title"
        return view
    }
    
    private func buildImageView() -> UIImageView {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "plus")
        view.frame = CGRect(x: 0, y: 0, width: imageDiameter, height: imageDiameter)
        view.layer.cornerRadius = view.frame.height / 2
        view.clipsToBounds = true
        return view
    }
    
    private func buildSubTitle() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 14)
        view.textColor = .lightGray
        view.text = "Sub Title"
        return view
    }
    
    private func buildGenericButton() -> UIButton {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemPink
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        view.setTitle("Tap Me", for: .normal)
        view.layer.cornerRadius = 12
        view.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return view
    }
    
    @objc func buttonTapped() {
        print("TAPPED!")
    }
}
