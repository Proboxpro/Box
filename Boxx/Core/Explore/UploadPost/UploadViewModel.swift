//
//  UploadViewModel.swift
//  Boxx
//
//  Created by Nikita Larin on 18.11.2023.
//
import Firebase

func AddInfo(freeForm: String, startDate: Int, numbkilo: Int){
    let db = Firestore.firestore()
    db.collection("Customers").document().setData(["Date": startDate, "KG": numbkilo, "FreeForm": freeForm])
    
}

