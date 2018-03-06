//
//  DummyController.swift
//  OMNI
//
//  Created by Chandrachudh on 06/03/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import UIKit

class DummyController: UIViewController {

    @IBOutlet weak var lblDummy: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        addAppThemeGradientToTheBackground()
        
        lblDummy.font = AppThemeFonts.appThemeRegularFontWith(size: 16)
        lblDummy.addCharacterSpacing(spacing: 5.0)
        lblDummy.addParagraphLineSpacing(space: 5.0, alignment: .center)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
