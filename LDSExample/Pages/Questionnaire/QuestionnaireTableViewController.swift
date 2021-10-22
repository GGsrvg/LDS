//
//  QuestionnaireTableViewController.swift
//  LDSExample
//
//  Created by GGsrvg on 22.10.2021.
//

import UIKit
import LDS

class QuestionnaireTableViewController: UITableViewController, UINavigationControllerDelegate {
    
    var adapter: UITableViewAdapter<QuestionnaireViewModel.SectionItemType>!
    
    let viewModel = QuestionnaireViewModel()

    init() {
        if #available(iOS 13.0, *) {
            super.init(style: .insetGrouped)
        } else {
            super.init(style: .grouped)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.delegate = self
        
        tableView.register(LabelTableViewCell.self, forCellReuseIdentifier: "LabelTableViewCell")
        tableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier: "TextFieldTableViewCell")
        tableView.register(ButtonTableViewCell.self, forCellReuseIdentifier: "ButtonTableViewCell")
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: "ImageTableViewCell")
        
        tableView.separatorStyle = .none
        
        adapter = .init(
            self.tableView,
            cellForRowHandler: { tableView, indexPath, field in
                let cell: UITableViewCell
                
                switch field {
                case let field as LabelPresenter:
                    let _cell = tableView.dequeueReusableCell(withIdentifier: "LabelTableViewCell", for: indexPath) as! LabelTableViewCell
                    _cell.presenter = field
                    cell = _cell
                case let field as TextFieldPresenter:
                    let _cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldTableViewCell", for: indexPath) as! TextFieldTableViewCell
                    _cell.presenter = field
                    cell = _cell
                case let field as ButtonPresenter:
                    let _cell = tableView.dequeueReusableCell(withIdentifier: "ButtonTableViewCell", for: indexPath) as! ButtonTableViewCell
                    _cell.presenter = field
                    cell = _cell
                case let field as ImagePresenter:
                    let _cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as! ImageTableViewCell
                    _cell.presenter = field
                    cell = _cell
                default:
                    fatalError("unknown type")
                }
                
                cell.selectionStyle = .none
                
                return cell
            },
            titleForHeaderSectionHandler: nil,
            titleForFooterSectionHandler: nil,
            numberOfSectionsHandler: nil,
            numberOfItemsInSectionHandler: nil
        )
        adapter.observableDataSource = viewModel.fields
        tableView.dataSource = adapter
    }
    
    
}

extension QuestionnaireTableViewController: QuestionnaireViewModelDelegate {
    func selectPhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
}

extension QuestionnaireTableViewController: UIImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.viewModel.setSelectedPhoto(image)
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let tempImage: UIImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.viewModel.setSelectedPhoto(tempImage)
        
        self.dismiss(animated: true, completion: nil)
    }
}
