//
//  FormViewController.swift
//  Meeting
//
//  Created by Aleksandr Borodulin on 16.06.2022.
//

import UIKit

final class FormViewController: UIViewController {
    @IBOutlet private weak var name: UITextField!
    @IBOutlet private weak var start: UITextField!
    @IBOutlet private weak var end: UITextField!
    @IBOutlet private weak var place: UITextField!
    @IBOutlet private weak var desc: UITextView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker(frame: .zero)
        datePicker.datePickerMode = .dateAndTime
        datePicker.timeZone = TimeZone.current
        return datePicker
    }()
    
    private var viewModel = FormViewModel()
    
    private let dateFormat = "dd MMM yyyy HH:mm"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBinders()
        
        desc.layer.borderColor = UIColor.lightGray.cgColor
        
        start.inputView = datePicker
        end.inputView = datePicker
        datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
    }
    
    private func setupBinders() {
        viewModel.updated.bind { [weak self] updated in
            self?.view.endEditing(true)
            if updated {
                self?.activityIndicator.stopAnimating()
                self?.view.isUserInteractionEnabled = true
            } else {
                self?.activityIndicator.startAnimating()
                self?.view.isUserInteractionEnabled = false
            }
        }
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        if start.isFirstResponder {
            start.text = dateFormatter.string(from: sender.date)
        } else {
            end.text = dateFormatter.string(from: sender.date)
        }
     }

    @IBAction func save(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        viewModel.save(name: name.text ?? "",
                       place: place.text ?? "",
                       desc: desc.text ?? "",
                       startDate: dateFormatter.date(from: start.text ?? "") ?? Date(),
                       endDate: dateFormatter.date(from: end.text ?? "") ?? Date())
    }
}

extension FormViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == name {
            start.becomeFirstResponder()
        } else if textField == start {
            end.becomeFirstResponder()
        } else if textField == end {
            place.becomeFirstResponder()
        } else if textField == place {
            desc.becomeFirstResponder()
        }
        
        return true
    }
}

extension FormViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
