//
//  User.swift
//  Resume Builder
//
//  Created by Shweta Shahane on 12/17/17.
//  Copyright © 2017 Rutvik Desai. All rights reserved.
//

import Foundation

class User {
    var Name:String?
    var Address:String?
    var Contact:Int?
    var Email:String?
    var ProfessionalSummary:String?

    var EducationDegree:String?
    var EducationDept:String?
    var EducationEndYr:Int?
    var EducationStartYr:Int?
    var UniversityName:String?

    var ExpCompanyAddr1:String?
    var ExpCompanyName1:String?
    var ExpEndYr1:Int?
    var ExpPosition1:String?
    var ExpResp1:String?
    var ExpStartYr1:Int?

    var ExpCompanyAddr2:String?
    var ExpCompanyName2:String?
    var ExpEndYr2:Int?
    var ExpPosition2:String?
    var ExpResp2:String?
    var ExpStartYr2:Int?

    var ExpCompanyAddr3:String?
    var ExpCompanyName3:String?
    var ExpEndYr3:Int?
    var ExpPosition3:String?
    var ExpResp3:String?
    var ExpStartYr3:Int?

    var Gpa:Int?

    var ProjectDescription1:String?
    var ProjectEndYr1:Int?
    var ProjectStartYr1:Int?
    var ProjectName1:String?
    var ProjectTech1:String?
    var ProjectOrg1:String?

    var ProjectDescription2:String?
    var ProjectEndYr2:Int?
    var ProjectStartYr2:Int?
    var ProjectName2:String?
    var ProjectTech2:String?
    var ProjectOrg2:String?

    var ProjectDescription3:String?
    var ProjectEndYr3:Int?
    var ProjectStartYr3:Int?
    var ProjectName3:String?
    var ProjectTech3:String?
    var ProjectOrg3:String?

    var PublicationDesc:String?
    var PublicationLink:String?
    var PublicationName:String?

    init(Name:String? ,Address:String?,Contact:Int?,Email:String?,ProfessionalSummary:String?,
        EducationDegree:String?,EducationDept:String?,EducationEndYr:Int?,EducationStartYr:Int?,UniversityName:String?,
        ExpCompanyAddr1:String?,ExpCompanyName1:String?,ExpEndYr1:Int?, ExpPosition1:String?,ExpResp1:String?,
        ExpStartYr1:Int?,ExpCompanyAddr2:String?,ExpCompanyName2:String?,ExpEndYr2:Int?,ExpPosition2:String?,
        ExpResp2:String?, ExpStartYr2:Int?, ExpCompanyAddr3:String?,ExpCompanyName3:String?,
        ExpEndYr3:Int?,ExpPosition3:String?,ExpResp3:String?,ExpStartYr3:Int?,Gpa:Int?,
        ProjectDescription1:String?,ProjectEndYr1:Int?,ProjectStartYr1:Int?,ProjectName1:String?, ProjectTech1:String?,
        ProjectOrg1:String?,ProjectDescription2:String?,ProjectEndYr2:Int?,ProjectStartYr2:Int?, ProjectName2:String?,
        ProjectTech2:String?,ProjectOrg2:String?, ProjectDescription3:String?,ProjectEndYr3:Int?,
        ProjectStartYr3:Int?,ProjectName3:String?,ProjectTech3:String?,ProjectOrg3:String?, PublicationDesc:String?,
        PublicationLink:String?, PublicationName:String?){

        self.Name = Name
        self.Address = Address
        self.Contact = Contact
        self.Email = Email
        self.ProfessionalSummary = ProfessionalSummary

        self.EducationDegree = EducationDegree
        self.EducationDept = EducationDept
        self.EducationEndYr = EducationEndYr
        self.EducationStartYr = EducationStartYr
        self.UniversityName = UniversityName

        self.ExpCompanyAddr1 = ExpCompanyAddr1
        self.ExpCompanyName1 = ExpCompanyName1
        self.ExpEndYr1 = ExpEndYr1
        self.ExpPosition1 = ExpPosition1
        self.ExpResp1 = ExpResp1
        self.ExpStartYr1 = ExpStartYr1

        self.ExpCompanyAddr2 = ExpCompanyAddr2
        self.ExpCompanyName2 = ExpCompanyName2
        self.ExpEndYr2 = ExpEndYr2
        self.ExpPosition2 = ExpPosition2
        self.ExpResp2 = ExpResp2
        self.ExpStartYr2 = ExpStartYr2

        self.ExpCompanyAddr3 = ExpCompanyAddr3
        self.ExpCompanyName3 = ExpCompanyName3
        self.ExpEndYr3 = ExpEndYr3
        self.ExpPosition3 = ExpPosition3
        self.ExpResp3 = ExpResp3
        self.ExpStartYr3 = ExpStartYr3

        self.Gpa = Gpa

        self.ProjectDescription1 = ProjectDescription1
        self.ProjectEndYr1 = ProjectEndYr1
        self.ProjectStartYr1 = ProjectStartYr1
        self.ProjectName1 = ProjectName1
        self.ProjectTech1 = ProjectTech1
        self.ProjectOrg1 = ProjectOrg1

        self.ProjectDescription2 = ProjectDescription2
        self.ProjectEndYr2 = ProjectEndYr2
        self.ProjectStartYr2 = ProjectStartYr2
        self.ProjectName2 = ProjectName2
        self.ProjectTech2 = ProjectTech2
        self.ProjectOrg2 = ProjectOrg2

        self.ProjectDescription3 = ProjectDescription3
        self.ProjectEndYr3 = ProjectEndYr3
        self.ProjectStartYr3 = ProjectStartYr3
        self.ProjectName3 = ProjectName3
        self.ProjectTech3 = ProjectTech3
        self.ProjectOrg3 = ProjectOrg3

        self.PublicationDesc = PublicationDesc
        self.PublicationLink = PublicationLink
        self.PublicationName = PublicationName

    }




}
