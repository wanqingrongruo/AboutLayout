//
//  ViewController.swift
//  YogaKitDemo
//
//  Created by roni on 2017/12/26.
//  Copyright © 2017年 roni. All rights reserved.
//

import UIKit
import YogaKit

class ViewController: UIViewController {
    
    private let paddingHorizontal: YGValue = 8.0
    private let padding: YGValue = 8.0
    private let backgroundColor: UIColor = .black
    
    private var shows = [Show]()
    
    private let contentView: UIScrollView = UIScrollView(frame: .zero)
    private let showCellIdentifier = "ShowCell"
    
    // Overall show info
    private let showPopularity = 5
    private let showYear = "2010"
    private let showRating = "TV-14"
    private let showLength = "3 Series"
    private let showCast = "Benedict Cumberbatch, Martin Freeman, Una Stubbs"
    private let showCreators = "Mark Gatiss, Steven Moffat"
    
    // Show selected
    private let showSelectedIndex = 2
    private let selectedShowSeriesLabel = "S3:E3"

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.configureLayout { (layout) in
//            layout.isEnabled = true
//            layout.width = YGValue(self.view.bounds.size.width)
//            layout.height = YGValue(self.view.bounds.size.height)
//            layout.alignItems = .center
//            layout.justifyContent = .center
//        }
//
//        setupUI()
        
        // Load shows from plist
        shows = Show.loadShows()
        
        // -----------------------
        // Content View
        // -----------------------
        contentView.backgroundColor = backgroundColor
        contentView.configureLayout { (layout) in
            layout.isEnabled = true
            layout.height = YGValue(self.view.bounds.size.height)
            layout.width = YGValue(self.view.bounds.size.width)
            layout.justifyContent = .flexStart
        }
        self.view.addSubview(contentView)
        
        // TODO: Lay out content sub-views
        let episodeImageView = UIImageView(frame: .zero)
        episodeImageView.backgroundColor = .gray
        let image = UIImage(named: "sherlock")
        episodeImageView.image = image
        let imageWidth = image?.size.width ?? 1.0
        let imageHeight = image?.size.height ?? 1.0
        episodeImageView.configureLayout { (layout) in
            layout.isEnabled = true
            layout.flexGrow = 1.0
            layout.aspectRatio = imageWidth / imageHeight
        }
        contentView.addSubview(episodeImageView)
        
        let summaryView = UIView(frame: .zero)
        summaryView.configureLayout { (layout) in
            layout.isEnabled = true
            layout.flexDirection = .row
            layout.padding = self.padding
        }
        let summaryPopularityLabel = UILabel(frame: .zero)
        summaryPopularityLabel.text = String(repeating: "★", count: showPopularity)
        summaryPopularityLabel.textColor = .red
        summaryPopularityLabel.configureLayout { (layout) in
            layout.isEnabled = true
            layout.flexGrow = 1.0
        }
        summaryView.addSubview(summaryPopularityLabel)
        
        let summaryInfoView = UIView(frame: .zero)
        summaryInfoView.configureLayout { (layout) in
            layout.isEnabled = true
            layout.flexGrow = 2.0
            layout.flexDirection = .row
            layout.justifyContent = .spaceBetween
        }
        for text in [showYear, showRating, showLength] {
            let summaryInfoLabel = UILabel(frame: .zero)
            summaryInfoLabel.text = text
            summaryInfoLabel.font = UIFont.systemFont(ofSize: 14.0)
            summaryInfoLabel.textColor = .lightGray
            summaryInfoLabel.configureLayout { (layout) in
                layout.isEnabled = true
            }
            summaryInfoView.addSubview(summaryInfoLabel)
        }
        summaryView.addSubview(summaryInfoView)
        
        let summaryInfoSpacerView =
            UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 1))
        summaryInfoSpacerView.configureLayout { (layout) in
            layout.isEnabled = true
            layout.flexGrow = 1.0
        }
        summaryView.addSubview(summaryInfoSpacerView)
        
        contentView.addSubview(summaryView)
        
        let titleView = UIView(frame: .zero)
        titleView.configureLayout { (layout) in
            layout.isEnabled = true
            layout.flexDirection = .row
            layout.padding = self.padding
        }
        
        let titleEpisodeLabel =
            showLabelFor(text: selectedShowSeriesLabel,
                         font: UIFont.boldSystemFont(ofSize: 16.0))
        titleView.addSubview(titleEpisodeLabel)
        
        let titleFullLabel = UILabel(frame: .zero)
        titleFullLabel.text = "kkkkkk"
        titleFullLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        titleFullLabel.textColor = .lightGray
        titleFullLabel.configureLayout { (layout) in
            layout.isEnabled = true
            layout.marginLeft = 20.0
            layout.marginBottom = 5.0
        }
        titleView.addSubview(titleFullLabel)
        contentView.addSubview(titleView)
        let descriptionView = UIView(frame: .zero)
        descriptionView.configureLayout { (layout) in
            layout.isEnabled = true
            layout.paddingHorizontal = self.paddingHorizontal
        }
        
        let descriptionLabel = UILabel(frame: .zero)
        descriptionLabel.font = UIFont.systemFont(ofSize: 14.0)
        descriptionLabel.numberOfLines = 3
        descriptionLabel.textColor = .lightGray
        descriptionLabel.text = "show.detail"
        descriptionLabel.configureLayout { (layout) in
            layout.isEnabled = true
            layout.marginBottom = 5.0
        }
        descriptionView.addSubview(descriptionLabel)
        let castText = "Cast: \(showCast)";
        let castLabel = showLabelFor(text: castText,
                                     font: UIFont.boldSystemFont(ofSize: 14.0))
        descriptionView.addSubview(castLabel)
        
        let creatorText = "Creators: \(showCreators)"
        let creatorLabel = showLabelFor(text: creatorText,
                                        font: UIFont.boldSystemFont(ofSize: 14.0))
        descriptionView.addSubview(creatorLabel)
        
        contentView.addSubview(descriptionView)
        
        let actionsView = UIView(frame: .zero)
        actionsView.configureLayout { (layout) in
            layout.isEnabled = true
            layout.flexDirection = .row
            layout.padding = self.padding
        }
        
        let addActionView =
            showActionViewFor(imageName: "add", text: "My List")
        actionsView.addSubview(addActionView)
        
        let shareActionView =
            showActionViewFor(imageName: "share", text: "Share")
        actionsView.addSubview(shareActionView)
        
        contentView.addSubview(actionsView)
        
        let tabsView = UIView(frame: .zero)
        tabsView.configureLayout { (layout) in
            layout.isEnabled = true
            layout.flexDirection = .row
            layout.padding = self.padding
        }
        
        let episodesTabView = showTabBarFor(text: "EPISODES", selected: true)
        tabsView.addSubview(episodesTabView)
        let moreTabView = showTabBarFor(text: "MORE LIKE THIS", selected: false)
        tabsView.addSubview(moreTabView)
        
        contentView.addSubview(tabsView)
        
        let showsTableView = UITableView()
        showsTableView.delegate = self
        showsTableView.dataSource = self
        showsTableView.backgroundColor = backgroundColor
        showsTableView.register(ShowTableViewCell.self,
                                forCellReuseIdentifier: showCellIdentifier)
        showsTableView.configureLayout{ (layout) in
            layout.isEnabled = true
            layout.flexGrow = 1.0
        }
        contentView.addSubview(showsTableView)
        
        // Apply the layout to view and subviews
        contentView.yoga.applyLayout(preservingOrigin: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Calculate and set the content size for the scroll view
        var contentViewRect: CGRect = .zero
        for view in contentView.subviews {
            contentViewRect = contentViewRect.union(view.frame)
        }
        contentView.contentSize = contentViewRect.size
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        view.configureLayout { (layout) in
            layout.width = YGValue(size.width)
            layout.height = YGValue(size.height)
        }
        
        view.yoga.applyLayout(preservingOrigin: true)
    }
}

// MARK: - Private methods

private extension ViewController {
    func showLabelFor(
        text: String,
        font: UIFont = UIFont.systemFont(ofSize: 14.0)) -> UILabel {
        let label = UILabel(frame: .zero)
        label.font = font
        label.textColor = .lightGray
        label.text = text
        label.configureLayout { (layout) in
            layout.isEnabled = true
            layout.marginBottom = 5.0
        }
        return label
    }
    
    // TODO: Add private methods below
    func showActionViewFor(imageName: String, text: String) -> UIView {
        let actionView = UIView(frame: .zero)
        actionView.configureLayout { (layout) in
            layout.isEnabled = true
            layout.alignItems = .center
            layout.marginRight = 20.0
        }
        let actionButton = UIButton(type: .custom)
        actionButton.setImage(UIImage(named: imageName), for: .normal)
        actionButton.configureLayout{ (layout) in
            layout.isEnabled = true
            layout.padding = 10.0
        }
        actionView.addSubview(actionButton)
        let actionLabel = showLabelFor(text: text)
        actionView.addSubview(actionLabel)
        return actionView
    }
    func showTabBarFor(text: String, selected: Bool) -> UIView {
        // 1
        let tabView = UIView(frame: .zero)
        tabView.configureLayout { (layout) in
            layout.isEnabled = true
            layout.alignItems = .center
            layout.marginRight = 20.0
        }
        // 2
        let tabLabelFont = selected ?
            UIFont.boldSystemFont(ofSize: 14.0) :
            UIFont.systemFont(ofSize: 14.0)
        let fontSize: CGSize = text.size(withAttributes: [NSAttributedStringKey.font: tabLabelFont])
        // 3
        let tabSelectionView =
            UIView(frame: CGRect(x: 0, y: 0, width: fontSize.width, height: 3))
        if selected {
            tabSelectionView.backgroundColor = .red
        }
        tabSelectionView.configureLayout { (layout) in
            layout.isEnabled = true
            layout.marginBottom = 5.0
        }
        tabView.addSubview(tabSelectionView)
        // 4
        let tabLabel = showLabelFor(text: text, font: tabLabelFont)
        tabView.addSubview(tabLabel)
        
        return tabView
    }
}

// MARK: - UITableViewDataSource methods

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        print(String(describing: #function))
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(String(describing: #function))
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ShowTableViewCell =
            tableView.dequeueReusableCell(withIdentifier: showCellIdentifier, for: indexPath) as! ShowTableViewCell
        cell.show = shows[indexPath.row]
        print(String(describing: #function))
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        print(String(describing: #function))
        return nil
    }
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        print(String(describing: #function))
        return nil
    }
}

// MARK: - UITableViewDelegate methods

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print(String(describing: #function))
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        print(String(describing: #function))
    }
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        print(String(describing: #function))
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print(String(describing: #function))
    }
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        print(String(describing: #function))
    }
    func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        print(String(describing: #function))
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print(String(describing: #function))
        return 100 //CGFloat(shows[indexPath.row].rowheight)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        print(String(describing: #function))
        return 10
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        print(String(describing: #function))
        return 10
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        print(String(describing: #function))
        return nil
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        print(String(describing: #function))
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("Selected row \(indexPath.row)")
    }
}


//MARK: - custom methods
extension ViewController {
    
    private func setupUI () {
        let contentView = UIView()
        contentView.backgroundColor = UIColor.lightGray
        contentView.configureLayout { (layout) in
            layout.isEnabled = true
            layout.flexDirection = .row
            layout.width = 320
            layout.height = 80
           // layout.marginTop = 40
           // layout.marginLeft = 20
            layout.padding = 10
        }
        view.addSubview(contentView)
        
        let child01 = UIView()
        child01.backgroundColor = .red
        child01.configureLayout { (layout) in
            layout.isEnabled = true
            layout.width = 80
            layout.marginRight = 10
        }
        contentView.addSubview(child01)
        
        let child02 = UIView()
        child02.backgroundColor = .blue
        child02.configureLayout { (layout) in
            layout.isEnabled = true
            layout.width = 80
            layout.flexGrow = 1
            layout.height = 20
            layout.alignSelf = .center
        }
        contentView.addSubview(child02)
        
        view.yoga.applyLayout(preservingOrigin: true)
    }
}
