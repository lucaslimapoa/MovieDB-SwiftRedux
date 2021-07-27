//
//  FakeMovies.swift
//  FakeMovies
//
//  Created by Lucas Lima on 21.07.21.
//

import Foundation

extension Collection where Element == Content {
    static var fakeMovies: [Content] {
        try! JSONDecoder.tmdbJsonDecoder.decode([Content].self, from: moviesJson)
    }
}

private let moviesJson =
"""
[
    {
      "adult": false,
      "backdrop_path": "/dq18nCTTLpy9PmtzZI6Y2yAgdw5.jpg",
      "genre_ids": [
        28,
        12,
        53,
        878
      ],
      "id": 497698,
      "original_language": "en",
      "original_title": "Black Widow",
      "overview": "Natasha Romanoff, also known as Black Widow, confronts the darker parts of her ledger when a dangerous conspiracy with ties to her past arises. Pursued by a force that will stop at nothing to bring her down, Natasha must deal with her history as a spy and the broken relationships left in her wake long before she became an Avenger.",
      "popularity": 9353.289,
      "poster_path": "/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg",
      "release_date": "2021-07-07",
      "title": "Black Widow",
      "video": false,
      "vote_average": 8,
      "vote_count": 2830
    },
    {
      "adult": false,
      "backdrop_path": "/8s4h9friP6Ci3adRGahHARVd76E.jpg",
      "genre_ids": [
        16,
        35,
        10751,
        878
      ],
      "id": 379686,
      "original_language": "en",
      "original_title": "Space Jam: A New Legacy",
      "overview": "When LeBron and his young son Dom are trapped in a digital space by a rogue A.I., LeBron must get them home safe by leading Bugs, Lola Bunny and the whole gang of notoriously undisciplined Looney Tunes to victory over the A.I.'s digitized champions on the court. It's Tunes versus Goons in the highest-stakes challenge of his life.",
      "popularity": 5648.593,
      "poster_path": "/5bFK5d3mVTAvBCXi5NPWH0tYjKl.jpg",
      "release_date": "2021-07-08",
      "title": "Space Jam: A New Legacy",
      "video": false,
      "vote_average": 7.9,
      "vote_count": 791
    },
    {
      "adult": false,
      "backdrop_path": "/gX5UrH1TLVVBwI7WxplW43BD6Z1.jpg",
      "genre_ids": [
        16,
        35,
        12,
        10751
      ],
      "id": 459151,
      "original_language": "en",
      "original_title": "The Boss Baby: Family Business",
      "overview": "The Templeton brothers — Tim and his Boss Baby little bro Ted — have become adults and drifted away from each other. But a new boss baby with a cutting-edge approach and a can-do attitude is about to bring them together again … and inspire a new family business.",
      "popularity": 4823.585,
      "poster_path": "/5dExO5G2iaaTxYnLIFKLWofDzyI.jpg",
      "release_date": "2021-07-01",
      "title": "The Boss Baby: Family Business",
      "video": false,
      "vote_average": 7.9,
      "vote_count": 728
    },
    {
      "adult": false,
      "backdrop_path": "/yizL4cEKsVvl17Wc1mGEIrQtM2F.jpg",
      "genre_ids": [
        28,
        878
      ],
      "id": 588228,
      "original_language": "en",
      "original_title": "The Tomorrow War",
      "overview": "The world is stunned when a group of time travelers arrive from the year 2051 to deliver an urgent message: Thirty years in the future, mankind is losing a global war against a deadly alien species. The only hope for survival is for soldiers and civilians from the present to be transported to the future and join the fight. Among those recruited is high school teacher and family man Dan Forester. Determined to save the world for his young daughter, Dan teams up with a brilliant scientist and his estranged father in a desperate quest to rewrite the fate of the planet.",
      "popularity": 4403.036,
      "poster_path": "/34nDCQZwaEvsy4CFO5hkGRFDCVU.jpg",
      "release_date": "2021-06-30",
      "title": "The Tomorrow War",
      "video": false,
      "vote_average": 8.3,
      "vote_count": 2621
    },
    {
      "adult": false,
      "backdrop_path": "/620hnMVLu6RSZW6a5rwO8gqpt0t.jpg",
      "genre_ids": [
        16,
        35,
        10751,
        14
      ],
      "id": 508943,
      "original_language": "en",
      "original_title": "Luca",
      "overview": "Luca and his best friend Alberto experience an unforgettable summer on the Italian Riviera. But all the fun is threatened by a deeply-held secret: they are sea monsters from another world just below the water’s surface.",
      "popularity": 3761.234,
      "poster_path": "/jTswp6KyDYKtvC52GbHagrZbGvD.jpg",
      "release_date": "2021-06-17",
      "title": "Luca",
      "video": false,
      "vote_average": 8.1,
      "vote_count": 2960
    },
    {
      "adult": false,
      "backdrop_path": "/tehpKMsls621GT9WUQie2Ft6LmP.jpg",
      "genre_ids": [
        12,
        53,
        28,
        27,
        37
      ],
      "id": 602223,
      "original_language": "en",
      "original_title": "The Forever Purge",
      "overview": "All the rules are broken as a sect of lawless marauders decides that the annual Purge does not stop at daybreak and instead should never end as they chase a group of immigrants who they want to punish because of their harsh historical past.",
      "popularity": 3596.075,
      "poster_path": "/uHA5COgDzcxjpYSHHulrKVl6ByL.jpg",
      "release_date": "2021-06-30",
      "title": "The Forever Purge",
      "video": false,
      "vote_average": 7.8,
      "vote_count": 251
    },
    {
      "adult": false,
      "backdrop_path": "/wjQXZTlFM3PVEUmKf1sUajjygqT.jpg",
      "genre_ids": [
        878,
        28,
        53
      ],
      "id": 581726,
      "original_language": "en",
      "original_title": "Infinite",
      "overview": "Evan McCauley has skills he never learned and memories of places he has never visited. Self-medicated and on the brink of a mental breakdown, a secret group that call themselves “Infinites” come to his rescue, revealing that his memories are real.",
      "popularity": 2612.049,
      "poster_path": "/niw2AKHz6XmwiRMLWaoyAOAti0G.jpg",
      "release_date": "2021-06-10",
      "title": "Infinite",
      "video": false,
      "vote_average": 7.3,
      "vote_count": 517
    },
    {
      "adult": false,
      "backdrop_path": "/70AV2Xx5FQYj20labp0EGdbjI6E.jpg",
      "genre_ids": [
        80,
        28,
        53
      ],
      "id": 637649,
      "original_language": "en",
      "original_title": "Wrath of Man",
      "overview": "A cold and mysterious new security guard for a Los Angeles cash truck company surprises his co-workers when he unleashes precision skills during a heist. The crew is left wondering who he is and where he came from. Soon, the marksman's ultimate motive becomes clear as he takes dramatic and irrevocable steps to settle a score.",
      "popularity": 2464.406,
      "poster_path": "/M7SUK85sKjaStg4TKhlAVyGlz3.jpg",
      "release_date": "2021-04-22",
      "title": "Wrath of Man",
      "video": false,
      "vote_average": 7.8,
      "vote_count": 1409
    }
]
"""
.data(using: .utf8)!
