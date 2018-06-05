//
//  Artist.swift
//  Spotifier
//
//  Created by Igor Tabacki on 4/30/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import Foundation

struct Image: Codable {
    var width:  Int
    var height: Int
    var url:    URL
}


struct Followers: Codable {
    var total: Int                  // pravim SAMO one properties unutar Struct koji mi trebaju
}


struct Artist: Codable {
    
    let name:   String
    let id:     String
    let apiURL: URL
    
    var popularity: Int
    var genres:     [String] = []
    var webURL:     URL?
    
    var images: [Image] = []
    private let followers: Followers
    var followersCount: Int { return followers.total }
}

struct SpotifyArtistContainer: Codable {
    let items: [Artist]
    //    items [Artist] je jedini property unutar ovog dela JSON-a koji me zanima, ni href,limit,next,offset,previous,total, samo ovo, zato ga i pisem ovde,
    //    ONO     STO     MI      NE      TREBA,    TO      NI      NE      NAVODIM !
    //    ovo je "dublji" struct u nizu
}

struct SpotifyArtistResponse: Codable {
    let artists: SpotifyArtistContainer
    //    ovo je "plici - krajni" struct u nizu
}









/*
 
 
 
                                                            Example of Spotify API for Search request ! 
 
 
 
 
 {
 "artists": {
 "href": "https://api.spotify.com/v1/search?query=taylor&type=artist&market=AT&offset=0&limit=20",
 "items": [
 
            { "external_urls": { "spotify": "https://open.spotify.com/artist/06HL4z0CvFAxyc27GXpf02" },
              "followers": { "href": null, "total": 12472407 },
              "genres": [ "dance pop", "pop", "post-teen pop"],
              "href": "https://api.spotify.com/v1/artists/06HL4z0CvFAxyc27GXpf02",
              "id": "06HL4z0CvFAxyc27GXpf02",
              "images": [
                        { "height": 640, "url": "https://i.scdn.co/image/bdaeccb035a8af87b7a70b62217ff5c633ba6c7c", "width": 640 },
                        { "height": 320, "url": "https://i.scdn.co/image/cec43c2fb746ea2a0c7546aa3408fe2f94887fe4", "width": 320 },
                        { "height": 160, "url": "https://i.scdn.co/image/33bc9128ad82f7d39847b6db6a49d5416502e7e7", "width": 160 }
                      ],
              "name": "Taylor Swift",
              "popularity": 89,
              "type": "artist",
              "uri": "spotify:artist:06HL4z0CvFAxyc27GXpf02"
            },
 
 
            { "external_urls": { "spotify": "https://open.spotify.com/artist/4DX2G1URzfEiRg2wBfv4ub" },
              "followers": { "href": null, "total": 72393 },
              "genres": [ "indie anthem-folk", "indie folk" ],
              "href": "https://api.spotify.com/v1/artists/4DX2G1URzfEiRg2wBfv4ub",
              "id": "4DX2G1URzfEiRg2wBfv4ub",
              "images": [
                        { "height": 640, "url": "https://i.scdn.co/image/f97776de59456c48ed8e4a94a3522723f7d3bc19", "width": 640 },
                        { "height": 320, "url": "https://i.scdn.co/image/c9c2fbd02edef4598e7913e5b1935e1e30753c5d", "width": 320 },
                        { "height": 160, "url": "https://i.scdn.co/image/4bf29ca9bea2243f47f50fea8315fb9a3b40e8d8", "width": 160 }
                       ],
              "name": "Hudson Taylor",
              "popularity": 54,
              "type": "artist",
              "uri": "spotify:artist:4DX2G1URzfEiRg2wBfv4ub"
            },
 
 
            { "external_urls": { "spotify": "https://open.spotify.com/artist/6D5xkX8ecb4bGccXqtDI63" },
              "followers": { "href": null, "total": 3374 },
              "genres": [ "acoustic pop"],
              "href": "https://api.spotify.com/v1/artists/6D5xkX8ecb4bGccXqtDI63",
              "id": "6D5xkX8ecb4bGccXqtDI63",
              "images": [
                        { "height": 640, "url": "https://i.scdn.co/image/38ffe560d76e2599950b19793c6ad6b22cfbf8d7", "width": 640 },
                        { "height": 300, "url": "https://i.scdn.co/image/f36494983e67315a9a80d298af11b89038f1aaa3", "width": 300 },
                        { "height": 64, "url": "https://i.scdn.co/image/7883dc6185521f8b4735bf0fd06b986e5b699bee", "width": 64 }
                       ],
              "name": "Angel Taylor",
              "popularity": 56,
              "type": "artist",
              "uri": "spotify:artist:6D5xkX8ecb4bGccXqtDI63"
            },
 
 {
 "external_urls": {
 "spotify": "https://open.spotify.com/artist/0vn7UBvSQECKJm2817Yf1P"
 },
 "followers": {
 "href": null,
 "total": 596773
 },
 "genres": [
 "adult standards",
 "folk",
 "folk rock",
 "mellow gold",
 "rock",
 "roots rock",
 "singer-songwriter",
 "soft rock"
 ],
 "href": "https://api.spotify.com/v1/artists/0vn7UBvSQECKJm2817Yf1P",
 "id": "0vn7UBvSQECKJm2817Yf1P",
 "images": [
 {
 "height": 1000,
 "url": "https://i.scdn.co/image/747d0d0f181eb1c4bce048d4f905622b14647e83",
 "width": 1000
 },
 {
 "height": 640,
 "url": "https://i.scdn.co/image/a2b61e4b56ac755a86898d6d2d3edcd967f5fca1",
 "width": 640
 },
 {
 "height": 200,
 "url": "https://i.scdn.co/image/a1d46914981b6059b9b41328d5def41a31f248d8",
 "width": 200
 },
 {
 "height": 64,
 "url": "https://i.scdn.co/image/61dea47e017e255583e745c7e3f388cf12297c93",
 "width": 64
 }
 ],
 "name": "James Taylor",
 "popularity": 70,
 "type": "artist",
 "uri": "spotify:artist:0vn7UBvSQECKJm2817Yf1P"
 },
 {
 "external_urls": {
 "spotify": "https://open.spotify.com/artist/30ejUciK31BCg0IVCbt1dW"
 },
 "followers": {
 "href": null,
 "total": 3064
 },
 "genres": [],
 "href": "https://api.spotify.com/v1/artists/30ejUciK31BCg0IVCbt1dW",
 "id": "30ejUciK31BCg0IVCbt1dW",
 "images": [
 {
 "height": 640,
 "url": "https://i.scdn.co/image/7985819309a4566f14d3f1a4d823ebae4ab61f8c",
 "width": 640
 },
 {
 "height": 320,
 "url": "https://i.scdn.co/image/5a9deebc6f314ef2877b88642ebc10f2a5744aef",
 "width": 320
 },
 {
 "height": 160,
 "url": "https://i.scdn.co/image/641658fc2dc92f44971265c847de10f4fe18d7d7",
 "width": 160
 }
 ],
 "name": "Mike Taylor",
 "popularity": 54,
 "type": "artist",
 "uri": "spotify:artist:30ejUciK31BCg0IVCbt1dW"
 },
 {
 "external_urls": {
 "spotify": "https://open.spotify.com/artist/6CqjoQyGZlnhnq5gAUz92c"
 },
 "followers": {
 "href": null,
 "total": 55728
 },
 "genres": [
 "drill"
 ],
 "href": "https://api.spotify.com/v1/artists/6CqjoQyGZlnhnq5gAUz92c",
 "id": "6CqjoQyGZlnhnq5gAUz92c",
 "images": [
 {
 "height": 640,
 "url": "https://i.scdn.co/image/bcc1e08429a95efaeea7f446e3d8e67a1bf0a1f3",
 "width": 640
 },
 {
 "height": 320,
 "url": "https://i.scdn.co/image/6f07b5980d808f93c2d8a1e16ed1d70e419cbe9a",
 "width": 320
 },
 {
 "height": 160,
 "url": "https://i.scdn.co/image/855717ab09c113144078e0687cb16c38d0016bf8",
 "width": 160
 }
 ],
 "name": "Taylor Bennett",
 "popularity": 58,
 "type": "artist",
 "uri": "spotify:artist:6CqjoQyGZlnhnq5gAUz92c"
 },
 {
 "external_urls": {
 "spotify": "https://open.spotify.com/artist/480xKab3lUPhBBnCzlzqIu"
 },
 "followers": {
 "href": null,
 "total": 113657
 },
 "genres": [
 "bow pop",
 "classify",
 "otacore",
 "scorecore",
 "video game music"
 ],
 "href": "https://api.spotify.com/v1/artists/480xKab3lUPhBBnCzlzqIu",
 "id": "480xKab3lUPhBBnCzlzqIu",
 "images": [
 {
 "height": 640,
 "url": "https://i.scdn.co/image/33d8769d1b92f690ba3906c0c9143bbaf1c5c763",
 "width": 640
 },
 {
 "height": 320,
 "url": "https://i.scdn.co/image/71abc9af652e2922e8cf57ba511fbead06acaa87",
 "width": 320
 },
 {
 "height": 160,
 "url": "https://i.scdn.co/image/7def102f505c2a5d7ebf3def01a4bb0401db3768",
 "width": 160
 }
 ],
 "name": "Taylor Davis",
 "popularity": 57,
 "type": "artist",
 "uri": "spotify:artist:480xKab3lUPhBBnCzlzqIu"
 },
 {
 "external_urls": {
 "spotify": "https://open.spotify.com/artist/2gR0iQTVBPHDKiNn1Kq8HI"
 },
 "followers": {
 "href": null,
 "total": 20659
 },
 "genres": [
 "afrobeat",
 "afropop",
 "deep funk",
 "funk",
 "highlife",
 "indie jazz",
 "soul",
 "world"
 ],
 "href": "https://api.spotify.com/v1/artists/2gR0iQTVBPHDKiNn1Kq8HI",
 "id": "2gR0iQTVBPHDKiNn1Kq8HI",
 "images": [
 {
 "height": 640,
 "url": "https://i.scdn.co/image/28006567e8a040ad17dba9899eb9edd41dd16743",
 "width": 640
 },
 {
 "height": 320,
 "url": "https://i.scdn.co/image/3d439965454dca62e39afabc8f6fd9adab623a33",
 "width": 320
 },
 {
 "height": 160,
 "url": "https://i.scdn.co/image/f6740770fcfa9b0c9cc3369575cae93404fbff91",
 "width": 160
 }
 ],
 "name": "Ebo Taylor",
 "popularity": 50,
 "type": "artist",
 "uri": "spotify:artist:2gR0iQTVBPHDKiNn1Kq8HI"
 },
 {
 "external_urls": {
 "spotify": "https://open.spotify.com/artist/0XCNutiY63kuaxUlmXHJ22"
 },
 "followers": {
 "href": null,
 "total": 52
 },
 "genres": [],
 "href": "https://api.spotify.com/v1/artists/0XCNutiY63kuaxUlmXHJ22",
 "id": "0XCNutiY63kuaxUlmXHJ22",
 "images": [],
 "name": "Damian Taylor",
 "popularity": 37,
 "type": "artist",
 "uri": "spotify:artist:0XCNutiY63kuaxUlmXHJ22"
 },
 {
 "external_urls": {
 "spotify": "https://open.spotify.com/artist/32lVGr0fSRGT6okLKHiP68"
 },
 "followers": {
 "href": null,
 "total": 105938
 },
 "genres": [
 "dance pop",
 "dance rock",
 "disco",
 "freestyle",
 "mellow gold",
 "new romantic",
 "new wave pop",
 "soft rock"
 ],
 "href": "https://api.spotify.com/v1/artists/32lVGr0fSRGT6okLKHiP68",
 "id": "32lVGr0fSRGT6okLKHiP68",
 "images": [
 {
 "height": 1091,
 "url": "https://i.scdn.co/image/c6a26a85816c1d0c025d7a12f2337e4cd6367eeb",
 "width": 960
 },
 {
 "height": 727,
 "url": "https://i.scdn.co/image/34618a6605f0bb291a30021ac4b859c4d00a5db4",
 "width": 640
 },
 {
 "height": 227,
 "url": "https://i.scdn.co/image/21d3b74f3c8749080a6d3ce7b2344d8df482b063",
 "width": 200
 },
 {
 "height": 73,
 "url": "https://i.scdn.co/image/d14f646c4646251ec929df5fb6e7f09de0339660",
 "width": 64
 }
 ],
 "name": "Taylor Dayne",
 "popularity": 57,
 "type": "artist",
 "uri": "spotify:artist:32lVGr0fSRGT6okLKHiP68"
 },
 {
 "external_urls": {
 "spotify": "https://open.spotify.com/artist/4eQKo2fvEqEbdopHhSjlug"
 },
 "followers": {
 "href": null,
 "total": 3478
 },
 "genres": [],
 "href": "https://api.spotify.com/v1/artists/4eQKo2fvEqEbdopHhSjlug",
 "id": "4eQKo2fvEqEbdopHhSjlug",
 "images": [
 {
 "height": 640,
 "url": "https://i.scdn.co/image/fd55d4eddd879f6d6b796512a8cb602ba8ad8b9a",
 "width": 640
 },
 {
 "height": 320,
 "url": "https://i.scdn.co/image/b71ae4be864fbf96b95b87b2513bd537e7de6244",
 "width": 320
 },
 {
 "height": 160,
 "url": "https://i.scdn.co/image/fa9f25fb35e2a793da28177a9da7646df5475f22",
 "width": 160
 }
 ],
 "name": "Kaleem Taylor",
 "popularity": 53,
 "type": "artist",
 "uri": "spotify:artist:4eQKo2fvEqEbdopHhSjlug"
 },
 {
 "external_urls": {
 "spotify": "https://open.spotify.com/artist/0j0HBDnIuT6rsn840ec18A"
 },
 "followers": {
 "href": null,
 "total": 5190
 },
 "genres": [],
 "href": "https://api.spotify.com/v1/artists/0j0HBDnIuT6rsn840ec18A",
 "id": "0j0HBDnIuT6rsn840ec18A",
 "images": [
 {
 "height": 640,
 "url": "https://i.scdn.co/image/4950bd69c81c750f315131cd4fa511d96ab5f880",
 "width": 640
 },
 {
 "height": 320,
 "url": "https://i.scdn.co/image/4c459b77cb0894eef0106f69f1fc539cf74a5d97",
 "width": 320
 },
 {
 "height": 160,
 "url": "https://i.scdn.co/image/3b113286e4ae3aa42086777d38ee410e86c552ac",
 "width": 160
 }
 ],
 "name": "Lafa Taylor",
 "popularity": 53,
 "type": "artist",
 "uri": "spotify:artist:0j0HBDnIuT6rsn840ec18A"
 },
 {
 "external_urls": {
 "spotify": "https://open.spotify.com/artist/1evO4fwLsEkkPGq32dCix7"
 },
 "followers": {
 "href": null,
 "total": 7361
 },
 "genres": [
 "indie r&b"
 ],
 "href": "https://api.spotify.com/v1/artists/1evO4fwLsEkkPGq32dCix7",
 "id": "1evO4fwLsEkkPGq32dCix7",
 "images": [
 {
 "height": 640,
 "url": "https://i.scdn.co/image/a56072789a5424cc1b0415dccd3503ccce128e7e",
 "width": 640
 },
 {
 "height": 320,
 "url": "https://i.scdn.co/image/d3a201ad4dec7151b6d1a57336031fc0ae12029e",
 "width": 320
 },
 {
 "height": 160,
 "url": "https://i.scdn.co/image/3db1fda86d920986e77a5dc67c6a435d161288b8",
 "width": 160
 }
 ],
 "name": "Aaron Taylor",
 "popularity": 48,
 "type": "artist",
 "uri": "spotify:artist:1evO4fwLsEkkPGq32dCix7"
 },
 {
 "external_urls": {
 "spotify": "https://open.spotify.com/artist/1nJGBgldGa0dhIGEUHdwWZ"
 },
 "followers": {
 "href": null,
 "total": 18
 },
 "genres": [],
 "href": "https://api.spotify.com/v1/artists/1nJGBgldGa0dhIGEUHdwWZ",
 "id": "1nJGBgldGa0dhIGEUHdwWZ",
 "images": [],
 "name": "Clyde Taylor",
 "popularity": 35,
 "type": "artist",
 "uri": "spotify:artist:1nJGBgldGa0dhIGEUHdwWZ"
 },
 {
 "external_urls": {
 "spotify": "https://open.spotify.com/artist/0nhDd1RWjZ6SDV1Vg1Ku2Q"
 },
 "followers": {
 "href": null,
 "total": 56146
 },
 "genres": [
 "alternative metal"
 ],
 "href": "https://api.spotify.com/v1/artists/0nhDd1RWjZ6SDV1Vg1Ku2Q",
 "id": "0nhDd1RWjZ6SDV1Vg1Ku2Q",
 "images": [
 {
 "height": 640,
 "url": "https://i.scdn.co/image/8f2da714df9ecc57c549e931570a79f7b8816bde",
 "width": 640
 },
 {
 "height": 320,
 "url": "https://i.scdn.co/image/d1f32ed194f3baba98185f8ec038ea107ae17130",
 "width": 320
 },
 {
 "height": 160,
 "url": "https://i.scdn.co/image/ebf83ae29d64ed698623179b499fb0738caec3bd",
 "width": 160
 }
 ],
 "name": "Corey Taylor",
 "popularity": 49,
 "type": "artist",
 "uri": "spotify:artist:0nhDd1RWjZ6SDV1Vg1Ku2Q"
 },
 {
 "external_urls": {
 "spotify": "https://open.spotify.com/artist/2WxjxdeF7GGdcCK276qViY"
 },
 "followers": {
 "href": null,
 "total": 14152
 },
 "genres": [],
 "href": "https://api.spotify.com/v1/artists/2WxjxdeF7GGdcCK276qViY",
 "id": "2WxjxdeF7GGdcCK276qViY",
 "images": [
 {
 "height": 640,
 "url": "https://i.scdn.co/image/09499cca62ea5505904f4e82800ed929ba80d2b1",
 "width": 640
 },
 {
 "height": 300,
 "url": "https://i.scdn.co/image/fb9d43e2ed9758b7900ec5b7268cda7241bd25c5",
 "width": 300
 },
 {
 "height": 64,
 "url": "https://i.scdn.co/image/009333e8209e5e4c51bcd976c5caebbe3da631e2",
 "width": 64
 }
 ],
 "name": "Natalie Taylor",
 "popularity": 49,
 "type": "artist",
 "uri": "spotify:artist:2WxjxdeF7GGdcCK276qViY"
 },
 {
 "external_urls": {
 "spotify": "https://open.spotify.com/artist/40eCNuH12cyxEcIVObqFrG"
 },
 "followers": {
 "href": null,
 "total": 1714
 },
 "genres": [],
 "href": "https://api.spotify.com/v1/artists/40eCNuH12cyxEcIVObqFrG",
 "id": "40eCNuH12cyxEcIVObqFrG",
 "images": [
 {
 "height": 640,
 "url": "https://i.scdn.co/image/59af72e50a69f5a52eabbec98f0e27f3caa54282",
 "width": 640
 },
 {
 "height": 300,
 "url": "https://i.scdn.co/image/f8cfb5004529ed15a913635b6c9b18dae8b01e9e",
 "width": 300
 },
 {
 "height": 64,
 "url": "https://i.scdn.co/image/e7bca9f43f8540e2b2514251cd7b0f77c173baec",
 "width": 64
 }
 ],
 "name": "Nicki Taylor",
 "popularity": 45,
 "type": "artist",
 "uri": "spotify:artist:40eCNuH12cyxEcIVObqFrG"
 },
 {
 "external_urls": {
 "spotify": "https://open.spotify.com/artist/6vxZqaVbMaaKOS3jL4IqV1"
 },
 "followers": {
 "href": null,
 "total": 206
 },
 "genres": [],
 "href": "https://api.spotify.com/v1/artists/6vxZqaVbMaaKOS3jL4IqV1",
 "id": "6vxZqaVbMaaKOS3jL4IqV1",
 "images": [
 {
 "height": 640,
 "url": "https://i.scdn.co/image/7f504f5759d70fe44c8d0764e1c4ebd76454f1a4",
 "width": 640
 },
 {
 "height": 300,
 "url": "https://i.scdn.co/image/6afc792d9944bfe082c2ce8e46960f3ca5250479",
 "width": 300
 },
 {
 "height": 64,
 "url": "https://i.scdn.co/image/184d8cab6a3b1aae3845e9dcfdbaba6fbe60271d",
 "width": 64
 }
 ],
 "name": "Taylor Leigh",
 "popularity": 44,
 "type": "artist",
 "uri": "spotify:artist:6vxZqaVbMaaKOS3jL4IqV1"
 },
 {
 "external_urls": {
 "spotify": "https://open.spotify.com/artist/5Y1mtkFXBCx0dyL93Wt54T"
 },
 "followers": {
 "href": null,
 "total": 24834
 },
 "genres": [
 "acoustic blues",
 "country blues"
 ],
 "href": "https://api.spotify.com/v1/artists/5Y1mtkFXBCx0dyL93Wt54T",
 "id": "5Y1mtkFXBCx0dyL93Wt54T",
 "images": [
 {
 "height": 1254,
 "url": "https://i.scdn.co/image/74972ade4795d0a9a6a614245c8ea8b06edb0256",
 "width": 1000
 },
 {
 "height": 803,
 "url": "https://i.scdn.co/image/e58f5660a92118404d1d09d0d9e3d4c38a9b103b",
 "width": 640
 },
 {
 "height": 251,
 "url": "https://i.scdn.co/image/343078ead39e78f4e9ec2d66550eb6ac26a72202",
 "width": 200
 },
 {
 "height": 80,
 "url": "https://i.scdn.co/image/20db28ce3214756f8ef103e47b32d19604944b84",
 "width": 64
 }
 ],
 "name": "Otis Taylor",
 "popularity": 41,
 "type": "artist",
 "uri": "spotify:artist:5Y1mtkFXBCx0dyL93Wt54T"
 },
 {
 "external_urls": {
 "spotify": "https://open.spotify.com/artist/2kVeHodElMzmD3aZlog2cM"
 },
 "followers": {
 "href": null,
 "total": 9
 },
 "genres": [],
 "href": "https://api.spotify.com/v1/artists/2kVeHodElMzmD3aZlog2cM",
 "id": "2kVeHodElMzmD3aZlog2cM",
 "images": [],
 "name": "Taylor Hogan",
 "popularity": 33,
 "type": "artist",
 "uri": "spotify:artist:2kVeHodElMzmD3aZlog2cM"
 }
 ],
 "limit": 20,
 "next": "https://api.spotify.com/v1/search?query=taylor&type=artist&market=AT&offset=20&limit=20",
 "offset": 0,
 "previous": null,
 "total": 3596
 }
 }
 */


