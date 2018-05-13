//
//  CountdownPickerPopoverViewController.swift
//  SwiftyPickerPopover
//
//  Created by Ken Torimaru on 2016/09/29.
//  Copyright © 2016 Ken Torimaru.
//
//
/*  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 */

public class CountdownPickerPopoverViewController: AbstractPickerPopoverViewController {
    
    typealias PopoverType = CountdownPickerPopover

    private var popover: PopoverType? { return anyPopover as? PopoverType }

    @IBOutlet weak private var doneButton: UIBarButtonItem!
    @IBOutlet weak private var cancelButton: UIBarButtonItem!
    @IBOutlet weak private var picker: UIDatePicker!
    @IBOutlet weak private var clearButton: UIButton!
    
    override func refrectPopoverProperties(){
        super.refrectPopoverProperties()

        if #available(iOS 11.0, *) { }
        else {
            navigationItem.leftBarButtonItem = nil
            navigationItem.rightBarButtonItem = nil
        }
        cancelButton.title = popover?.cancelButton.title
        cancelButton.tintColor = popover?.cancelButton.color ?? popover?.tintColor
        navigationItem.setLeftBarButton(cancelButton, animated: false)
        
        doneButton.title = popover?.doneButton.title
        doneButton.tintColor = popover?.doneButton.color ?? popover?.tintColor
        navigationItem.setRightBarButton(doneButton, animated: false)

        clearButton.setTitle(popover?.clearButton.title, for: .normal)
        clearButton.tintColor = popover?.clearButton.color ?? popover?.tintColor
        
        guard let popover = popover else { return }
        if popover.clearButton.action == nil {
            clearButton.removeFromSuperview()
            view.layoutIfNeeded()
        }

        picker.datePickerMode = .countDownTimer
        picker.countDownDuration = popover.selectedTimeInterval
    }
    
    @IBAction func tappedDone(_ sender: UIButton? = nil) {
        popover?.doneButton.action?(popover!, picker.countDownDuration)
        dismiss(animated: false, completion: {})
    }
    
    @IBAction func tappedCancel(_ sender: AnyObject? = nil) {
        popover?.cancelButton.action?(popover!, picker.countDownDuration)
        dismiss(animated: false, completion: {})
    }
    
    @IBAction func tappedClear(_ sender: UIButton? = nil) {
        popover?.redoDisappearAutomatically()
        popover?.clearButton.action?(popover!, picker.countDownDuration)
    }
    
    
    @IBAction func pickerValueChanged(_ sender: UIDatePicker) {
        popover?.valueChangeAction?(popover!, picker.countDownDuration)
        popover?.redoDisappearAutomatically()
    }
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        tappedCancel()
    }

}
