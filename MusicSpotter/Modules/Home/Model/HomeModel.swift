//
//  HomeModel.swift
//  MusicSpotter
//
//  Created by IOS-Babu on 10/05/24.
//

import Foundation
import SwiftyJSON

class RootClass{

    var resultCount : Int!
    var results : [Result]!


   
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        resultCount = json["resultCount"].intValue
        results = [Result]()
        let resultsArray = json["results"].arrayValue
        for resultsJson in resultsArray{
            let value = Result(fromJson: resultsJson)
            results.append(value)
        }
    }

}


class Result{

    var artistId : Int!
    var artistName : String!
    var artistViewUrl : String!
    var artworkUrl100 : String!
    var artworkUrl30 : String!
    var artworkUrl60 : String!
    var collectionArtistId : Int!
    var collectionArtistName : String!
    var collectionArtistViewUrl : String!
    var collectionCensoredName : String!
    var collectionExplicitness : String!
    var collectionId : Int!
    var collectionName : String!
    var collectionPrice : Float!
    var collectionViewUrl : String!
    var country : String!
    var currency : String!
    var discCount : Int!
    var discNumber : Int!
    var isStreamable : Bool!
    var kind : String!
    var previewUrl : String!
    var primaryGenreName : String!
    var releaseDate : String!
    var trackCensoredName : String!
    var trackCount : Int!
    var trackExplicitness : String!
    var trackId : String!
    var trackName : String!
    var trackNumber : Int!
    var trackPrice : Float!
    var trackTimeMillis : Int!
    var trackViewUrl : String!
    var wrapperType : String!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        artistId = json["artistId"].intValue
        artistName = json["artistName"].stringValue
        artistViewUrl = json["artistViewUrl"].stringValue
        artworkUrl100 = json["artworkUrl100"].stringValue
        artworkUrl30 = json["artworkUrl30"].stringValue
        artworkUrl60 = json["artworkUrl60"].stringValue
        collectionArtistId = json["collectionArtistId"].intValue
        collectionArtistName = json["collectionArtistName"].stringValue
        collectionArtistViewUrl = json["collectionArtistViewUrl"].stringValue
        collectionCensoredName = json["collectionCensoredName"].stringValue
        collectionExplicitness = json["collectionExplicitness"].stringValue
        collectionId = json["collectionId"].intValue
        collectionName = json["collectionName"].stringValue
        collectionPrice = json["collectionPrice"].floatValue
        collectionViewUrl = json["collectionViewUrl"].stringValue
        country = json["country"].stringValue
        currency = json["currency"].stringValue
        discCount = json["discCount"].intValue
        discNumber = json["discNumber"].intValue
        isStreamable = json["isStreamable"].boolValue
        kind = json["kind"].stringValue
        previewUrl = json["previewUrl"].stringValue
        primaryGenreName = json["primaryGenreName"].stringValue
        releaseDate = json["releaseDate"].stringValue
        trackCensoredName = json["trackCensoredName"].stringValue
        trackCount = json["trackCount"].intValue
        trackExplicitness = json["trackExplicitness"].stringValue
        trackId = json["trackId"].stringValue
        trackName = json["trackName"].stringValue
        trackNumber = json["trackNumber"].intValue
        trackPrice = json["trackPrice"].floatValue
        trackTimeMillis = json["trackTimeMillis"].intValue
        trackViewUrl = json["trackViewUrl"].stringValue
        wrapperType = json["wrapperType"].stringValue
    }

}
