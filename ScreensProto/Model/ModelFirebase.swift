//
//  ModelFirebase.swift
//  ScreensProto
//
//  Created by לידור משיח on 06/01/2020.
//  Copyright © 2020 לידור משיח. All rights reserved.
//

import Foundation
import Firebase

class ModelFirebase{
    
    func addUser(user:User){
        let db = Firestore.firestore()
        
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("users").addDocument(data: user.toJson(), completion: { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
        })

    }
    
    func addTeam(team:Team){
           let db = Firestore.firestore()
           // Add a new document with a generated ID
           var ref: DocumentReference? = nil
           ref = db.collection("teams").addDocument(data: team.toJson(), completion: { err in
                   if let err = err {
                       print("Error adding document: \(err)")
                   } else {
                       print("Document added with ID: \(ref!.documentID)")
                   }
           })
       }
    
    func getAllTeams(callback: @escaping ([Team]?)->Void){
        let db = Firestore.firestore();
        db.collection("teams").getDocuments{ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)");
                callback(nil);
            }else{
                var data = [Team]();
                for document in querySnapshot!.documents {
                    data.append(Team(json: document.data()));
                }
                callback(data);
            }
        }
    }
    
    func addCategory(category:CategoriesModel){
              let db = Firestore.firestore()
              // Add a new document with a generated ID
              var ref: DocumentReference? = nil
              ref = db.collection("categories").addDocument(data: category.toJson(), completion: { err in
                      if let err = err {
                        print("Error adding document: \(err)")
                      } else {
                          print("Document added with ID: \(ref!.documentID)")
                      }
              })
          }
    
    func getTeamsByType(types:[String],callback: @escaping ([Team]?)->Void){
        
        let db = Firestore.firestore();
        db.collection("teams").getDocuments{ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)");
                callback(nil);
            }else{
                var data = [Team]();
                for document in querySnapshot!.documents {
                    data.append(Team(json: document.data()));
                }
                var filteredTeams:[Team] = [Team]();
                for item in data {
                    if(types.contains(item.type)){
                        filteredTeams.append(item);
                    }
                }
                callback(filteredTeams);
            }
        }
    }
    
        func getAllCategories(callback: @escaping ([CategoriesModel]?)->Void){
            let db = Firestore.firestore();
            db.collection("categories").getDocuments{ (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)");
                    callback(nil);
                }else{
                    var data = [CategoriesModel]();
                    for document in querySnapshot!.documents {
                        data.append(CategoriesModel(json: document.data()));
                    }
                    callback(data);
                }
            }
        }
    
    func getCurrentUserNameByID(callback:@escaping (String?)->Void) {

        let userID = Auth.auth().currentUser?.uid;
        let db = Firestore.firestore();
        var name = "";
        
        db.collection("users").whereField("uid", isEqualTo: userID as Any).getDocuments { (querySnapshot, err) in
            if err != nil {
                print("Error getting document");
            }else{
                 name = querySnapshot!.documents[0].data()["fullName"] as! String;
                callback(name);
            }
        }
    }
    
    
    
}