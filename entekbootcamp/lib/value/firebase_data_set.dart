import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'dart:async';

// Fake data in JSON format
const String fakeDataJson = '''

{
  "users": [
    {
      "username": "user1",
      "name": "Suzanne",
      "surname": "Davis",
      "job": "Corporate investment banker",
      "birthday": "2002-06-27",
      "bio": "Away policy I rise who thus sometimes.",
      "follows": [
        "user5",
        "user4",
        "user7",
        "user8"
      ]
    },
    {
      "username": "user2",
      "name": "John",
      "surname": "Romero",
      "job": "Bonds trader",
      "birthday": "1979-11-06",
      "bio": "Then travel serve social rate our check push reach.",
      "follows": [
        "user6",
        "user3",
        "user10",
        "user10",
        "user10"
      ]
    },
    {
      "username": "user3",
      "name": "Alexis",
      "surname": "Woods",
      "job": "Holiday representative",
      "birthday": "2006-01-20",
      "bio": "Home he forget hospital question war whatever.",
      "follows": [
        "user4",
        "user2",
        "user8",
        "user6"
      ]
    },
    {
      "username": "user4",
      "name": "Anthony",
      "surname": "White",
      "job": "Air broker",
      "birthday": "1977-08-01",
      "bio": "Station trouble fact walk middle dog wonder value care.",
      "follows": [
        "user1"
      ]
    },
    {
      "username": "user5",
      "name": "Anthony",
      "surname": "Barr",
      "job": "Commercial art gallery manager",
      "birthday": "1996-01-26",
      "bio": "Baby sport war wall smile not way behavior down field vote fear think.",
      "follows": [
        "user3",
        "user8",
        "user6",
        "user8",
        "user3",
        "user2"
      ]
    },
    {
      "username": "user6",
      "name": "James",
      "surname": "Mora",
      "job": "Structural engineer",
      "birthday": "1963-12-28",
      "bio": "Hot physical skill deep law degree have today wonder each respond.",
      "follows": [
        "user7",
        "user5",
        "user4",
        "user7",
        "user3",
        "user8",
        "user8"
      ]
    },
    {
      "username": "user7",
      "name": "Jenny",
      "surname": "Reeves",
      "job": "Teacher, special educational needs",
      "birthday": "1972-09-17",
      "bio": "Officer decision list mind TV position recent tell.",
      "follows": [
        "user6",
        "user6",
        "user5"
      ]
    },
    {
      "username": "user8",
      "name": "Matthew",
      "surname": "Williams",
      "job": "Marketing executive",
      "birthday": "1975-08-24",
      "bio": "Organization tree center level alone last unit material wonder see some tell.",
      "follows": [
        "user10",
        "user2",
        "user1",
        "user5",
        "user3",
        "user4",
        "user5"
      ]
    },
    {
      "username": "user9",
      "name": "Jennifer",
      "surname": "Mclaughlin",
      "job": "Chiropractor",
      "birthday": "1983-05-10",
      "bio": "Way early water color hear until well bed suggest activity billion require.",
      "follows": [
        "user8",
        "user5",
        "user3",
        "user3"
      ]
    },
    {
      "username": "user10",
      "name": "Benjamin",
      "surname": "Sanchez",
      "job": "Social researcher",
      "birthday": "1980-12-06",
      "bio": "Idea record truth home spring hand hot myself wonder write leave.",
      "follows": [
        "user8",
        "user9",
        "user1"
      ]
    }
  ],
  "posts": [
    {
      "username": "user7",
      "image_link": "https://placekitten.com/375/275",
      "description": "Assume compare produce along second first it live.",
      "like_number": 782,
      "time": "2024-04-16T06:57:36.787753",
      "comments": [
        {
          "time": "2023-12-13T06:57:36.787766",
          "user_id": "user1",
          "text": "These difficult also do available week him kid carry."
        },
        {
          "time": "2024-04-27T06:57:36.787785",
          "user_id": "user7",
          "text": "Happen hair walk lawyer campaign she."
        },
        {
          "time": "2023-11-17T06:57:36.787800",
          "user_id": "user3",
          "text": "Medical star pretty discuss raise general discuss company poor."
        },
        {
          "time": "2024-01-03T06:57:36.787822",
          "user_id": "user1",
          "text": "Entire model share ever time military great front pass above."
        }
      ]
    },
    {
      "username": "user7",
      "image_link": "https://placeimg.com/648/81/any",
      "description": "Successful ability season.",
      "like_number": 287,
      "time": "2024-06-16T06:57:36.787872",
      "comments": [
        {
          "time": "2024-04-02T06:57:36.787882",
          "user_id": "user8",
          "text": "Seven career billion each outside former tonight discuss shoulder."
        },
        {
          "time": "2024-06-05T06:57:36.787904",
          "user_id": "user4",
          "text": "Us various interview should job general tree news."
        },
        {
          "time": "2024-06-15T06:57:36.787928",
          "user_id": "user1",
          "text": "Trouble pattern statement measure interesting place."
        }
      ]
    },
    {
      "username": "user10",
      "image_link": "https://placeimg.com/435/499/any",
      "description": "Put decide economy step wide.",
      "like_number": 435,
      "time": "2024-01-15T06:57:36.787978",
      "comments": [
        {
          "time": "2024-06-25T06:57:36.787988",
          "user_id": "user2",
          "text": "Pm treatment player drive stand."
        },
        {
          "time": "2024-05-06T06:57:36.788005",
          "user_id": "user5",
          "text": "Strong ok little indeed arm enter."
        }
      ]
    },
    {
      "username": "user10",
      "image_link": "https://placeimg.com/602/319/any",
      "description": "Realize doctor current college form.",
      "like_number": 684,
      "time": "2024-03-05T06:57:36.788040",
      "comments": [
        {
          "time": "2024-08-31T06:57:36.788045",
          "user_id": "user3",
          "text": "Listen treatment beautiful voice fact strong trouble me yes."
        },
        {
          "time": "2024-09-20T06:57:36.788061",
          "user_id": "user3",
          "text": "Hour people manager single situation three civil peace."
        }
      ]
    },
    {
      "username": "user4",
      "image_link": "https://www.lorempixel.com/581/317",
      "description": "Town represent technology technology brother note.",
      "like_number": 299,
      "time": "2024-06-19T06:57:36.788112",
      "comments": [
        {
          "time": "2024-01-21T06:57:36.788121",
          "user_id": "user8",
          "text": "Live other bad hope discuss individual."
        },
        {
          "time": "2024-05-18T06:57:36.788141",
          "user_id": "user1",
          "text": "Room air situation challenge better recent policy dinner a effort."
        },
        {
          "time": "2024-01-17T06:57:36.788163",
          "user_id": "user10",
          "text": "Whole suddenly traditional listen listen bring."
        },
        {
          "time": "2024-09-17T06:57:36.788183",
          "user_id": "user8",
          "text": "Happen bring wrong hard natural too compare soldier structure garden."
        },
        {
          "time": "2024-01-25T06:57:36.788207",
          "user_id": "user1",
          "text": "Put per view too all concern suffer move paper."
        }
      ]
    },
    {
      "username": "user3",
      "image_link": "https://dummyimage.com/220x678",
      "description": "Activity whole cut whether.",
      "like_number": 535,
      "time": "2024-04-03T06:57:36.788262",
      "comments": [
        {
          "time": "2023-12-14T06:57:36.788271",
          "user_id": "user3",
          "text": "Point become artist no month condition for Democrat realize bar."
        },
        {
          "time": "2024-05-16T06:57:36.788293",
          "user_id": "user4",
          "text": "Represent they stay together fly center operation part manage."
        }
      ]
    },
    {
      "username": "user5",
      "image_link": "https://placeimg.com/586/939/any",
      "description": "Staff laugh public physical manage whatever.",
      "like_number": 941,
      "time": "2023-10-28T06:57:36.788336",
      "comments": [
        {
          "time": "2024-01-06T06:57:36.788341",
          "user_id": "user2",
          "text": "Paper hand send agree region."
        },
        {
          "time": "2024-06-29T06:57:36.788353",
          "user_id": "user10",
          "text": "Break itself yard represent major."
        },
        {
          "time": "2024-10-03T06:57:36.788368",
          "user_id": "user2",
          "text": "Hair certain stock issue."
        },
        {
          "time": "2024-06-18T06:57:36.788386",
          "user_id": "user8",
          "text": "Relationship moment four back Mr move now lay former four."
        }
      ]
    },
    {
      "username": "user3",
      "image_link": "https://placeimg.com/83/343/any",
      "description": "Mother partner science seek security fill compare.",
      "like_number": 993,
      "time": "2024-10-13T06:57:36.788423",
      "comments": [
        {
          "time": "2024-10-25T06:57:36.788428",
          "user_id": "user7",
          "text": "Machine against particularly these yet pass dog white yes."
        },
        {
          "time": "2023-12-14T06:57:36.788441",
          "user_id": "user6",
          "text": "Too industry establish tonight main story hotel."
        }
      ]
    },
    {
      "username": "user1",
      "image_link": "https://placekitten.com/247/362",
      "description": "Write case strategy benefit region card.",
      "like_number": 622,
      "time": "2023-11-26T06:57:36.788470",
      "comments": [
        {
          "time": "2024-10-25T06:57:36.788475",
          "user_id": "user10",
          "text": "And pressure individual use happen against economic civil public."
        },
        {
          "time": "2024-08-18T06:57:36.788489",
          "user_id": "user1",
          "text": "Yes adult place thank history blood mean about year."
        },
        {
          "time": "2024-04-14T06:57:36.788509",
          "user_id": "user4",
          "text": "Movie woman clear then sense on scientist term."
        },
        {
          "time": "2024-07-23T06:57:36.788525",
          "user_id": "user4",
          "text": "Stock throughout moment culture provide professor case loss whose several."
        }
      ]
    },
    {
      "username": "user10",
      "image_link": "https://www.lorempixel.com/652/225",
      "description": "Make tell identify.",
      "like_number": 369,
      "time": "2024-05-13T06:57:36.788567",
      "comments": [
        {
          "time": "2024-01-20T06:57:36.788575",
          "user_id": "user3",
          "text": "Ever great age group those its together former."
        },
        {
          "time": "2024-01-29T06:57:36.788592",
          "user_id": "user9",
          "text": "Management guy detail few pressure surface."
        },
        {
          "time": "2024-09-28T06:57:36.788612",
          "user_id": "user2",
          "text": "Government top near again program hair."
        },
        {
          "time": "2024-01-12T06:57:36.788630",
          "user_id": "user5",
          "text": "Member sit Democrat attack sure else campaign itself less agree."
        },
        {
          "time": "2024-08-18T06:57:36.788651",
          "user_id": "user9",
          "text": "Film ready first class movement and must base if community."
        }
      ]
    },
    {
      "username": "user1",
      "image_link": "https://www.lorempixel.com/76/400",
      "description": "Part care along Democrat.",
      "like_number": 924,
      "time": "2024-02-07T06:57:36.788699",
      "comments": [
        {
          "time": "2024-01-03T06:57:36.788708",
          "user_id": "user4",
          "text": "Sometimes card thus rock woman lay choice property film."
        },
        {
          "time": "2024-01-04T06:57:36.788722",
          "user_id": "user1",
          "text": "Second occur cell candidate measure than get speech protect spring."
        },
        {
          "time": "2024-02-10T06:57:36.788737",
          "user_id": "user3",
          "text": "Sense many represent crime strategy."
        },
        {
          "time": "2023-11-06T06:57:36.788748",
          "user_id": "user5",
          "text": "During sport summer another our."
        }
      ]
    },
    {
      "username": "user10",
      "image_link": "https://www.lorempixel.com/788/297",
      "description": "Party friend win fly really figure next.",
      "like_number": 206,
      "time": "2024-04-28T06:57:36.788775",
      "comments": [
        {
          "time": "2024-04-23T06:57:36.788780",
          "user_id": "user3",
          "text": "Reality we serious morning find discuss hospital."
        },
        {
          "time": "2024-03-27T06:57:36.788804",
          "user_id": "user2",
          "text": "Three reach read human huge visit father stand."
        },
        {
          "time": "2024-01-24T06:57:36.788824",
          "user_id": "user5",
          "text": "Away state agency or two."
        },
        {
          "time": "2024-01-21T06:57:36.788842",
          "user_id": "user2",
          "text": "Claim help particular nation support decade."
        },
        {
          "time": "2023-11-20T06:57:36.788862",
          "user_id": "user1",
          "text": "Scientist hold follow its talk imagine term serve."
        }
      ]
    },
    {
      "username": "user4",
      "image_link": "https://dummyimage.com/126x135",
      "description": "System official we result gas production course.",
      "like_number": 285,
      "time": "2024-01-07T06:57:36.788915",
      "comments": [
        {
          "time": "2024-03-09T06:57:36.788924",
          "user_id": "user4",
          "text": "There avoid science treatment listen job."
        },
        {
          "time": "2023-10-31T06:57:36.788944",
          "user_id": "user4",
          "text": "Successful lose research memory agree always might behavior fear check analysis."
        },
        {
          "time": "2024-03-08T06:57:36.788968",
          "user_id": "user3",
          "text": "Understand country wait over sister own clear."
        },
        {
          "time": "2024-10-11T06:57:36.788989",
          "user_id": "user7",
          "text": "Future course oil stand join throughout tough movement."
        },
        {
          "time": "2023-12-17T06:57:36.789005",
          "user_id": "user7",
          "text": "Board agree middle event those care other suffer vote."
        }
      ]
    },
    {
      "username": "user7",
      "image_link": "https://placeimg.com/753/269/any",
      "description": "Card threat chair system south series.",
      "like_number": 989,
      "time": "2024-09-25T06:57:36.789035",
      "comments": [
        {
          "time": "2024-07-03T06:57:36.789039",
          "user_id": "user6",
          "text": "Grow successful more sound parent lose experience prevent discuss ahead time."
        },
        {
          "time": "2024-06-18T06:57:36.789053",
          "user_id": "user7",
          "text": "Throughout take toward leader race population."
        },
        {
          "time": "2024-04-02T06:57:36.789072",
          "user_id": "user8",
          "text": "Until television air to free heavy laugh."
        },
        {
          "time": "2024-08-08T06:57:36.789088",
          "user_id": "user2",
          "text": "Eye involve age increase place upon kitchen nice knowledge must."
        }
      ]
    },
    {
      "username": "user1",
      "image_link": "https://dummyimage.com/692x951",
      "description": "Involve dream pick piece.",
      "like_number": 127,
      "time": "2024-05-03T06:57:36.789116",
      "comments": [
        {
          "time": "2023-12-11T06:57:36.789121",
          "user_id": "user1",
          "text": "Great probably call individual land not go writer possible worker."
        },
        {
          "time": "2024-03-04T06:57:36.789135",
          "user_id": "user3",
          "text": "Training beyond I occur research."
        },
        {
          "time": "2024-08-31T06:57:36.789145",
          "user_id": "user8",
          "text": "Yeah bag respond program green."
        },
        {
          "time": "2024-05-02T06:57:36.789157",
          "user_id": "user6",
          "text": "Firm sport begin sing hair."
        }
      ]
    }
  ]
}
''';

// final val1 = "sadas \n dfsdfds \nadsdas";
// final val = '''
// asdasd

// sadasdas
// das
// d
// asd

// ''';

Future<void> addFakeDataToFirestore() async {
  final firestore = FirebaseFirestore.instance;
  final Map<String, dynamic> fakeData = jsonDecode(fakeDataJson);
  inspect(fakeData);
  // Adding users to Firestore
  List<dynamic> users = fakeData['users'];
  for (var user in users) {
    await firestore.collection('users').doc(user['username']).set(user);
  }

  List<dynamic> posts = fakeData['posts'];
  for (var post in posts) {
    String username = post['username'];
    await firestore
        .collection('users')
        .doc(username)
        .collection('posts')
        .add(post);
  }

  print("Fake data has been added to Firestore successfully.");
}
