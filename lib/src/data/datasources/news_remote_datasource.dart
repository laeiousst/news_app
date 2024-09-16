import 'package:dio/dio.dart';
import 'package:news_app/src/core/network/dio_client.dart';
import 'package:news_app/src/data/models/response/news_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'news_remote_datasource.g.dart';

abstract class NewsRemoteDataSource {
  Future<List<NewsResponse>> getNewsList(String topic);
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final Dio dio;

  NewsRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<NewsResponse>> getNewsList(String topic) async {
    final response = await dio.get("/$topic?lr=en-US");
    final data = (response.data["items"] as Iterable).where((e) => e != null).map((e) => NewsResponse.fromJson(e));
    // final data = (test2).map((e) => NewsResponse.fromJson(e));
    return data.toList();
  }
}

@riverpod
NewsRemoteDataSource newsRemoteDataSource(NewsRemoteDataSourceRef ref) {
  final dio = ref.read(dioProvider);
  return NewsRemoteDataSourceImpl(dio: dio);
}

// final test2 = [
//   {
//     "title":
//         "How a false rumor about pets in Ohio and Laura Loomer’s presence helped derail Trump’s planned attacks on Harris",
//     "snippet":
//         "Donald Trump wanted to spend this week attacking one of Democratic rival Kamala Harris' biggest political vulnerabilities. Instead, he spent most of the ...",
//     "publisher": "CNN",
//     "timestamp": "1726324980000",
//     "newsUrl": "https://www.cnn.com/2024/09/14/politics/donald-trump-kamala-harris-laura-loomer/index.html",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iL0NnNVhWVWQyVDFWQ1VtcDFZelY2VFJDZkF4ampCU2dLTWdrbEZJcFF5U1NEaFFJ=-w280-h168-p-df-rw",
//       "thumbnailProxied":
//           "https://i.zedtranslate.com/newsimage/CC8iL0NnNVhWVWQyVDFWQ1VtcDFZelY2VFJDZkF4ampCU2dLTWdrbEZJcFF5U1NEaFFJ"
//     },
//     "hasSubnews": true,
//     "subnews": [
//       {
//         "title": "Trump Promises Mass Deportation of Springfield, Ohio Immigrants If Elected",
//         "snippet":
//             "In a campaign event Friday, Donald Trump vowed to oversee the \"largest deportation in the history of our country,\" starting in Springfield, Ohio, ...",
//         "publisher": "National Review",
//         "timestamp": "1726323194000",
//         "newsUrl":
//             "https://www.nationalreview.com/news/trump-promises-mass-deportation-of-springfield-ohio-immigrants-if-elected/",
//         "images": {
//           "thumbnail":
//               "https://news.google.com/api/attachments/CC8iK0NnNU1VRzB3WmpGMlpIRkJlSEZXVFJDbkF4alZCU2dLTWdZVlZwWm9xZ2M=-w280-h168-p-df-rw",
//           "thumbnailProxied":
//               "https://i.zedtranslate.com/newsimage/CC8iK0NnNU1VRzB3WmpGMlpIRkJlSEZXVFJDbkF4alZCU2dLTWdZVlZwWm9xZ2M"
//         }
//       },
//       {
//         "title":
//             "Racial tensions in Springfield have simmered for months. Trump’s rhetoric now has Haitians there in a full-blown ‘panic’",
//         "snippet":
//             "After Republican vice presidential candidate JD Vance helped supercharge a false, racist rumor that Haitian refugees in small-town Ohio were stealing and ...",
//         "publisher": "The Independent",
//         "timestamp": "1726322202000",
//         "newsUrl":
//             "https://www.independent.co.uk/news/world/americas/haitian-immigrants-eating-dogs-springfield-ohio-b2612594.html",
//         "images": {
//           "thumbnail":
//               "https://news.google.com/api/attachments/CC8iK0NnNXJRVVpJVUhwd2JEUnpORTlzVFJERUF4aW1CU2dLTWdZSkFZaEtEZzA=-w280-h168-p-df-rw",
//           "thumbnailProxied":
//               "https://i.zedtranslate.com/newsimage/CC8iK0NnNXJRVVpJVUhwd2JEUnpORTlzVFJERUF4aW1CU2dLTWdZSkFZaEtEZzA"
//         }
//       },
//       {
//         "title": "The Cat Eaters of Ohio",
//         "snippet": "The establishment media called it a racist myth, but is it?",
//         "publisher": "Christopher F. Rufo",
//         "timestamp": "1726315200000",
//         "newsUrl": "https://christopherrufo.com/p/the-cat-eaters-of-ohio",
//         "images": {
//           "thumbnail":
//               "https://news.google.com/api/attachments/CC8iK0NnNXlRMGxxWm1Ka1JEQmlTRzl5VFJDM0FSaVRBaWdCTWdhbHBaRE5PUVk=-w280-h168-p-df-rw",
//           "thumbnailProxied":
//               "https://i.zedtranslate.com/newsimage/CC8iK0NnNXlRMGxxWm1Ka1JEQmlTRzl5VFJDM0FSaVRBaWdCTWdhbHBaRE5PUVk"
//         }
//       },
//       {
//         "title": "Springfield school evacuated, Ohio BMV locations and county offices closed",
//         "snippet":
//             "SPRINGFIELD, Ohio (WDTN) — Multiple locations in Springfield have either evacuated or decided to close on Thursday. School Buildings According to a ...",
//         "publisher": "WDTN.com",
//         "timestamp": "1726158888000",
//         "newsUrl": "https://www.wdtn.com/top-stories/springfield-school-evacuated-ohio-bmv-locations-closed/",
//         "images": {
//           "thumbnail":
//               "https://news.google.com/api/attachments/CC8iK0NnNUdNalZyUW5SMU1GRjRYM0YzVFJERUF4aW5CU2dLTWdhWjBZQnRTUVE=-w280-h168-p-df-rw",
//           "thumbnailProxied":
//               "https://i.zedtranslate.com/newsimage/CC8iK0NnNUdNalZyUW5SMU1GRjRYM0YzVFJERUF4aW5CU2dLTWdhWjBZQnRTUVE"
//         }
//       }
//     ]
//   },
//   {
//     "title": "3 Americans in Congo sentenced to death after coup attempt",
//     "snippet":
//         "Three Americans have been sentenced to death in Congo, along with other foreigners, after being convicted for participating in a failed coup attempt in May.",
//     "publisher": "Fox News",
//     "timestamp": "1726314000000",
//     "newsUrl": "https://www.foxnews.com/world/3-americans-congo-sentenced-death-after-coup-attempt",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iMkNnNTZSbEo0V1Y4MGRWUldiMUJSVFJDZkF4ampCU2dLTWdzQk1KYXVJYWtXYUNyMHFR=-w280-h168-p-df-rw",
//       "thumbnailProxied":
//           "https://i.zedtranslate.com/newsimage/CC8iMkNnNTZSbEo0V1Y4MGRWUldiMUJSVFJDZkF4ampCU2dLTWdzQk1KYXVJYWtXYUNyMHFR"
//     },
//     "hasSubnews": true,
//     "subnews": [
//       {
//         "title": "Briton and Americans among 37 given death sentence over DRC coup attempt",
//         "snippet":
//             "A Briton and three Americans are among 37 people sentenced to death on Friday over an attempt to overthrow the president of the Democratic Republic of the ...",
//         "publisher": "The Guardian",
//         "timestamp": "1726277400000",
//         "newsUrl": "https://www.theguardian.com/world/2024/sep/13/briton-americans-sentenced-to-death-drc-coup-attempt",
//         "images": {
//           "thumbnail":
//               "https://news.google.com/api/attachments/CC8iL0NnNW5lbEpMT0dkVk5sZDJWMWhEVFJDUkF4ajhCU2dLTWdtQk1KempwZWt0cGdJ=-w280-h168-p-df-rw",
//           "thumbnailProxied":
//               "https://i.zedtranslate.com/newsimage/CC8iL0NnNW5lbEpMT0dkVk5sZDJWMWhEVFJDUkF4ajhCU2dLTWdtQk1KempwZWt0cGdJ"
//         }
//       },
//       {
//         "title": "Three Americans Sentenced to Death for Failed Congo Coup",
//         "snippet":
//             "Benjamin Zalman-Polun, Marcel Malanga and Tyler Thompson, American citizens sentenced to death for an attempted coup, waited to hear the final trial verdict ...",
//         "publisher": "The New York Times",
//         "timestamp": "1726259176000",
//         "newsUrl": "https://www.nytimes.com/2024/09/13/world/africa/congo-coup-death-sentence-americans.html",
//         "images": {
//           "thumbnail":
//               "https://news.google.com/api/attachments/CC8iI0NnNHphMlZEUmxOVGNGZFpjMmRqVFJDUEF4allCQ2dLTWdB=-w280-h168-p-df-rw",
//           "thumbnailProxied":
//               "https://i.zedtranslate.com/newsimage/CC8iI0NnNHphMlZEUmxOVGNGZFpjMmRqVFJDUEF4allCQ2dLTWdB"
//         }
//       },
//       {
//         "title": "DR Congo military court sentences 37 to death in coup trial",
//         "snippet":
//             "A military court in the Democratic Republic of the Congo (DRC) has sentenced to death 37 people, including three United States citizens, on charges of ...",
//         "publisher": "Al Jazeera English",
//         "timestamp": "1726255800000",
//         "newsUrl":
//             "https://www.aljazeera.com/news/2024/9/13/dr-congo-military-court-sentences-37-to-death-in-coup-trial",
//         "images": {
//           "thumbnail":
//               "https://news.google.com/api/attachments/CC8iL0NnNVFTMmRETmt4eGRIaHBWa1I1VFJEZ0F4aUFCU2dLTWdrQk1KN2hwU2tlcGdJ=-w280-h168-p-df-rw",
//           "thumbnailProxied":
//               "https://i.zedtranslate.com/newsimage/CC8iL0NnNVFTMmRETmt4eGRIaHBWa1I1VFJEZ0F4aUFCU2dLTWdrQk1KN2hwU2tlcGdJ"
//         }
//       },
//       {
//         "title": "British plumber among 37 people sentenced to death over Congo coup plot",
//         "snippet":
//             "A British plumber and three Americans are among 37 people sentenced to death on charges of taking part in a murky coup plot to overthrow the Congolese ...",
//         "publisher": "The Telegraph",
//         "timestamp": "1726251780000",
//         "newsUrl":
//             "https://www.telegraph.co.uk/world-news/2024/09/13/british-plumber-sentenced-to-death-over-congo-coup-plot/",
//         "images": {
//           "thumbnail":
//               "https://news.google.com/api/attachments/CC8iI0NnNU1Oa1ZZVEZWdWRHMTRSSEpqVFJDcUF4aW9CU2dLTWdB=-w280-h168-p-df-rw",
//           "thumbnailProxied":
//               "https://i.zedtranslate.com/newsimage/CC8iI0NnNU1Oa1ZZVEZWdWRHMTRSSEpqVFJDcUF4aW9CU2dLTWdB"
//         }
//       }
//     ]
//   },
//   {
//     "title": "Southern California Wildfires: Latest updates on Airport, Bridge, Line fires",
//     "snippet":
//         "Three major wildfires burning simultaneously in Southern California have burned homes and stretched resources from multiple agencies across four counties ...",
//     "publisher": "KTLA Los Angeles",
//     "timestamp": "1726234883000",
//     "newsUrl":
//         "https://ktla.com/news/local-news/southern-california-wildfires-latest-updates-on-airport-bridge-line-fires/",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iI0NnNXpkRlEzU1dKeGIybE5Talp1VFJERUF4aW1CU2dLTWdB=-w280-h168-p-df-rw",
//       "thumbnailProxied": "https://i.zedtranslate.com/newsimage/CC8iI0NnNXpkRlEzU1dKeGIybE5Talp1VFJERUF4aW1CU2dLTWdB"
//     },
//     "hasSubnews": true,
//     "subnews": [
//       {
//         "title": "The volatile recipe behind the Southern California summer fire outbreak",
//         "snippet":
//             "The trio of blazes — the Bridge Fire, Line Fire and Airport Fire — burned more than 100000 acres combined in a matter of days.",
//         "publisher": "The Washington Post",
//         "timestamp": "1726326338000",
//         "newsUrl": "https://www.washingtonpost.com/weather/2024/09/14/california-fires-line-bridge-airport-climate/",
//         "images": {
//           "thumbnail":
//               "https://news.google.com/api/attachments/CC8iI0NnNHpiVU5ETjNWQlNGcERVRnB4VFJDZkF4ampCU2dLTWdB=-w280-h168-p-df-rw",
//           "thumbnailProxied":
//               "https://i.zedtranslate.com/newsimage/CC8iI0NnNHpiVU5ETjNWQlNGcERVRnB4VFJDZkF4ampCU2dLTWdB"
//         }
//       },
//       {
//         "title": "Los Angeles wildfires slow, still threaten suburbs",
//         "snippet":
//             "Wildfires that have burned dozens of mountain homes near Los Angeles slowed on Thursday with cooler temperatures but authorities warned the blazes still ...",
//         "publisher": "CNBC",
//         "timestamp": "1726231173000",
//         "newsUrl": "https://www.cnbc.com/2024/09/13/los-angeles-wildfires-slow-still-threaten-suburbs.html",
//         "images": {
//           "thumbnail":
//               "https://news.google.com/api/attachments/CC8iI0NnNDRVblpIWjFsbFVrZG1TMjh0VFJDZkF4ampCU2dLTWdB=-w280-h168-p-df-rw",
//           "thumbnailProxied":
//               "https://i.zedtranslate.com/newsimage/CC8iI0NnNDRVblpIWjFsbFVrZG1TMjh0VFJDZkF4ampCU2dLTWdB"
//         }
//       },
//       {
//         "title": "Firefighters make progress battling Line Fire in San Bernardino County",
//         "snippet":
//             "HIGHLAND, Calif. (KABC) -- Firefighters are making progress in battling the Line Fire in San Bernardino County, which has charred more than 38,000 acres and ...",
//         "publisher": "ABC7 Los Angeles",
//         "timestamp": "1726279323000",
//         "newsUrl":
//             "https://abc7.com/post/line-fire-firefighters-make-progress-battling-blaze-san-bernardino-county/15301138/",
//         "images": {
//           "thumbnail":
//               "https://news.google.com/api/attachments/CC8iI0NnNXRiakpvWWpsZk1YVmtaR05OVFJDZkF4ampCU2dLTWdB=-w280-h168-p-df-rw",
//           "thumbnailProxied":
//               "https://i.zedtranslate.com/newsimage/CC8iI0NnNXRiakpvWWpsZk1YVmtaR05OVFJDZkF4ampCU2dLTWdB"
//         }
//       }
//     ]
//   },
//   {
//     "title": "Harris and Trump place their chips on different states to win White House",
//     "snippet":
//         "A compressed battleground map has given each campaign a defensive electoral college wall, and they overlap in the crucial state of Pennsylvania.",
//     "publisher": "The Washington Post",
//     "timestamp": "1726324475000",
//     "newsUrl":
//         "https://www.washingtonpost.com/politics/2024/09/14/harris-trump-place-their-chips-different-states-win-white-house/",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iK0NnNDNhSE01Y0RCTlMxTXhjbUUzVFJERUF4aW1CU2dLTWdZQjhJU0MwQUk=-w280-h168-p-df-rw",
//       "thumbnailProxied":
//           "https://i.zedtranslate.com/newsimage/CC8iK0NnNDNhSE01Y0RCTlMxTXhjbUUzVFJERUF4aW1CU2dLTWdZQjhJU0MwQUk"
//     },
//     "hasSubnews": true,
//     "subnews": [
//       {
//         "title": "Video Battleground blitz in the race for the White House",
//         "snippet":
//             "Vice President Kamala Harris holds a rally in Pennsylvania, as former President Donald Trump doubles down on immigration in the West.",
//         "publisher": "ABC News",
//         "timestamp": "1726318487000",
//         "newsUrl": "https://abcnews.go.com/GMA/News/video/battleground-blitz-race-white-house-113685600",
//         "images": {
//           "thumbnail":
//               "https://news.google.com/api/attachments/CC8iK0NnNWhSelpMZEVWU01WRnFZbXh0VFJDZkF4ampCU2dLTWdhWlVvNElMUWc=-w280-h168-p-df-rw",
//           "thumbnailProxied":
//               "https://i.zedtranslate.com/newsimage/CC8iK0NnNWhSelpMZEVWU01WRnFZbXh0VFJDZkF4ampCU2dLTWdhWlVvNElMUWc"
//         }
//       },
//       {
//         "title": "Kamala Harris rides debate momentum to North Carolina rallies",
//         "snippet":
//             "Vice President Kamala Harris isn't letting anyone forget about her strong debate performance against former President Trump in Philadelphia on Tuesday.",
//         "publisher": "Axios",
//         "timestamp": "1726182138000",
//         "newsUrl":
//             "https://www.axios.com/local/charlotte/2024/09/12/harris-trump-debate-2024-charlotte-greesboro-rally",
//         "images": {
//           "thumbnail":
//               "https://news.google.com/api/attachments/CC8iK0NnNTNhbDlEV201SlluTTVia0Z0VFJDZkF4ampCU2dLTWdZTkE0ekdBUTA=-w280-h168-p-df-rw",
//           "thumbnailProxied":
//               "https://i.zedtranslate.com/newsimage/CC8iK0NnNTNhbDlEV201SlluTTVia0Z0VFJDZkF4ampCU2dLTWdZTkE0ekdBUTA"
//         }
//       },
//       {
//         "title": "Election Live Updates: Trump and Harris to Rally Supporters as Race Intensifies",
//         "snippet":
//             "Vice President Kamala Harris, campaigning in Pennsylvania, sought to build on her strong showing in Tuesday's debate. Former President Donald J. Trump, ...",
//         "publisher": "The New York Times",
//         "timestamp": "1726285200000",
//         "newsUrl": "https://www.nytimes.com/live/2024/09/13/us/harris-trump-election",
//         "images": {
//           "thumbnail":
//               "https://news.google.com/api/attachments/CC8iI0NnNVVjVWgyV0ZRNFgwRkxObVppVFJDV0F4allCQ2dLTWdB=-w280-h168-p-df-rw",
//           "thumbnailProxied":
//               "https://i.zedtranslate.com/newsimage/CC8iI0NnNVVjVWgyV0ZRNFgwRkxObVppVFJDV0F4allCQ2dLTWdB"
//         }
//       }
//     ]
//   },
//   {
//     "title": "What to know about Laura Loomer, Trump's conspiracy theorist ally",
//     "snippet":
//         "Far-right activist Laura Loomer has been at former President Trump's side this week as he campaigns, though the GOP candidate claimed Friday he's unaware of ...",
//     "publisher": "Axios",
//     "timestamp": "1726308832000",
//     "newsUrl": "https://www.axios.com/2024/09/13/laura-loomer-conspiracy-theories-trump",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iK0NnNVpjMVJEVFhaaWVXTndVV3hyVFJDZkF4ampCU2dLTWdZcFpvN3RKUWc=-w280-h168-p-df-rw",
//       "thumbnailProxied":
//           "https://i.zedtranslate.com/newsimage/CC8iK0NnNVpjMVJEVFhaaWVXTndVV3hyVFJDZkF4ampCU2dLTWdZcFpvN3RKUWc"
//     },
//     "hasSubnews": true,
//     "subnews": [
//       {
//         "title": "Caputo shares reason why Trump keeps Loomer close",
//         "snippet":
//             "CNN's Erin Burnett speaks with Marc Caputo, national reporter for “The Bulwark,” about the growing relationship between former President Donald Trump and ...",
//         "publisher": "CNN",
//         "timestamp": "1726271821000",
//         "newsUrl":
//             "https://www.cnn.com/2024/09/13/politics/video/trump-laura-loomer-relationship-campaign-caputo-ebof-digvid",
//         "images": {
//           "thumbnail":
//               "https://news.google.com/api/attachments/CC8iI0NnNUtXRXBoVlhvMFowbFpNV2hxVFJDZkF4ampCU2dLTWdB=-w280-h168-p-df-rw",
//           "thumbnailProxied":
//               "https://i.zedtranslate.com/newsimage/CC8iI0NnNUtXRXBoVlhvMFowbFpNV2hxVFJDZkF4ampCU2dLTWdB"
//         }
//       },
//       {
//         "title":
//             "'Check your man': Melania Trump warned against hubby Donald's growing closeness with Laura Loomer amid campaign trail",
//         "snippet":
//             "Amidst Donald Trump's growing closeness with Laura Loomer, Melania Trump received a suggestion to become more involved in the ex-President's election ...",
//         "publisher": "Hindustan Times",
//         "timestamp": "1726322967000",
//         "newsUrl":
//             "https://www.hindustantimes.com/world-news/us-news/check-your-man-melania-trump-warned-against-hubby-donalds-growing-closeness-with-laura-loomer-amid-campaign-trail-101726319889572.html",
//         "images": {
//           "thumbnail":
//               "https://news.google.com/api/attachments/CC8iK0NnNVBkV3h0YVRoaVZrVjFRMHBXVFJDb0FSaXJBaWdCTWdhdE5KcXVHUW8=-w280-h168-p-df-rw",
//           "thumbnailProxied":
//               "https://i.zedtranslate.com/newsimage/CC8iK0NnNVBkV3h0YVRoaVZrVjFRMHBXVFJDb0FSaXJBaWdCTWdhdE5KcXVHUW8"
//         }
//       },
//       {
//         "title": "Who Is Laura Loomer, the Far-Right Activist Who Traveled With Trump?",
//         "snippet":
//             "Five years ago Laura Loomer, a far-right activist with a history of expressing bigoted views and a knack for generating publicity, filed an application for ...",
//         "publisher": "The New York Times",
//         "timestamp": "1726277020000",
//         "newsUrl": "https://www.nytimes.com/2024/09/13/us/politics/who-is-laura-loomer.html",
//         "images": {
//           "thumbnail":
//               "https://news.google.com/api/attachments/CC8iK0NnNVFZMWcyTkZRM1pWOUpaMFZqVFJDUUF4allCQ2dLTWdhbEVaak5rUW8=-w280-h168-p-df-rw",
//           "thumbnailProxied":
//               "https://i.zedtranslate.com/newsimage/CC8iK0NnNVFZMWcyTkZRM1pWOUpaMFZqVFJDUUF4allCQ2dLTWdhbEVaak5rUW8"
//         }
//       },
//       {
//         "title": "Opinion | Donald Trump and Loomer Tunes",
//         "snippet":
//             "Donald Trump likes to call his political opponents nuts, as in “crazy Nancy Pelosi,” so then why is he hanging with the 9/11 conspiracist Laura Loomer?",
//         "publisher": "The Wall Street Journal",
//         "timestamp": "1726264200000",
//         "newsUrl": "https://www.wsj.com/opinion/donald-trump-laura-loomer-conspiracist-2024-campaign-54e13cf8",
//         "images": {
//           "thumbnail":
//               "https://news.google.com/api/attachments/CC8iI0NnNHhNVE5GWWpaUFFsSnRhak15VFJERUF4aW1CU2dLTWdB=-w280-h168-p-df-rw",
//           "thumbnailProxied":
//               "https://i.zedtranslate.com/newsimage/CC8iI0NnNHhNVE5GWWpaUFFsSnRhak15VFJERUF4aW1CU2dLTWdB"
//         }
//       },
//       {
//         "title": "Marjorie Taylor Greene publicly condemns Laura Loomer's racist post about Kamala Harris",
//         "snippet":
//             "Rep. Marjorie Taylor Greene, R-Ga., a staunch Donald Trump supporter, called out someone in his entourage for a racist online post about Vice President ...",
//         "publisher": "USA TODAY",
//         "timestamp": "1726260439000",
//         "newsUrl":
//             "https://www.usatoday.com/story/news/politics/elections/2024/09/12/marjorie-taylor-greene-loomer-racist-post-condemnation/75195292007/",
//         "images": {
//           "thumbnail":
//               "https://news.google.com/api/attachments/CC8iK0NnNDBiR2RCUzFGV2VHbFRkSFpMVFJEekFoaVVCU2dLTWdhWlE0aFJIUWs=-w280-h168-p-df-rw",
//           "thumbnailProxied":
//               "https://i.zedtranslate.com/newsimage/CC8iK0NnNDBiR2RCUzFGV2VHbFRkSFpMVFJEekFoaVVCU2dLTWdhWlE0aFJIUWs"
//         }
//       }
//     ]
//   },
//   {
//     "title": "Putin's options for Ukraine missiles response include nuclear test, experts say",
//     "snippet":
//         "LONDON, Sept 13 (Reuters) - Vladimir Putin's options to retaliate if the West lets Ukraine use its long-range missiles to strike Russia could include ...",
//     "publisher": "Reuters",
//     "timestamp": "1726262280000",
//     "newsUrl":
//         "https://www.reuters.com/world/europe/putins-options-ukraine-missiles-response-includes-nuclear-test-experts-say-2024-09-13/",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iI0NnNXRTME13Wkd4NWFFSlJSakJrVFJEQkF4aXJCU2dLTWdB=-w280-h168-p-df-rw",
//       "thumbnailProxied": "https://i.zedtranslate.com/newsimage/CC8iI0NnNXRTME13Wkd4NWFFSlJSakJrVFJEQkF4aXJCU2dLTWdB"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "Wanted Islamic State commander killed by U.S., Iraqi forces, officials say",
//     "snippet":
//         "In an operation last month, Iraqi forces and American troops killed a senior commander with the Islamic State group who was wanted by the United States, ...",
//     "publisher": "CBS News",
//     "timestamp": "1726272659000",
//     "newsUrl": "https://www.cbsnews.com/news/islamic-state-commander-abu-ali-al-tunisi-killed-by-u-s-iraqi-forces/",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iK0NnNXRNblIzYW5kU2JVRXhNM1F6VFJDUkF4ajhCU2dLTWdZQmdJYVdzQVE=-w280-h168-p-df-rw",
//       "thumbnailProxied":
//           "https://i.zedtranslate.com/newsimage/CC8iK0NnNXRNblIzYW5kU2JVRXhNM1F6VFJDUkF4ajhCU2dLTWdZQmdJYVdzQVE"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title":
//         "Authorities were ‘actively looking’ for Georgia shooting suspect after a warning call from his mom the morning of the attack",
//     "snippet":
//         "On the morning of the shooting at a Winder, Georgia high school that left four people dead, authorities were “actively looking” for the teenage suspect ...",
//     "publisher": "CNN",
//     "timestamp": "1726303440000",
//     "newsUrl":
//         "https://www.cnn.com/2024/09/14/us/authorities-actively-looking-georgia-shooting-suspect-warning-call-mom-morning/index.html",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iK0NnNUNhVmxWV0hGbkxUVmFaR1V3VFJDZkF4amlCU2dLTWdZQllJU21KQU0=-w280-h168-p-df-rw",
//       "thumbnailProxied":
//           "https://i.zedtranslate.com/newsimage/CC8iK0NnNUNhVmxWV0hGbkxUVmFaR1V3VFJDZkF4amlCU2dLTWdZQllJU21KQU0"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "Mom selling Taylor Swift tickets she got for daughter’s birthday, citing popstar’s Harris endorsement",
//     "snippet":
//         "A mom is selling Taylor Swift tickets she bought for her daughter's 13th birthday, citing the megastar's endorsement of Dem nominee Kamala Harris while...",
//     "publisher": "New York Post ",
//     "timestamp": "1726288560000",
//     "newsUrl":
//         "https://nypost.com/2024/09/14/entertainment/mom-shaking-off-swift-tickets-for-daughters-birthday-after-harris-endorsement-taylor-you-are-a-billionaire/",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iL0NnNTVhVzVrYkZGSWVrRnZXVlo1VFJETUFSaXlBaWdLTWdrSk1wU0ZJbWs5aGdJ=-w280-h168-p-df-rw",
//       "thumbnailProxied":
//           "https://i.zedtranslate.com/newsimage/CC8iL0NnNTVhVzVrYkZGSWVrRnZXVlo1VFJETUFSaXlBaWdLTWdrSk1wU0ZJbWs5aGdJ"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "An American activist killed by Israeli fire is buried in Turkey as Israel strikes Gaza",
//     "snippet":
//         "Israeli airstrikes hit central and southern Gaza overnight into Saturday, as family members of a Turkish-American activist killed by an Israeli soldier ...",
//     "publisher": "The Associated Press",
//     "timestamp": "1726324080000",
//     "newsUrl":
//         "https://apnews.com/article/israel-hamas-war-palestinians-14-september-2024-816a01b4ca23bfd6b22a1a381e1671bb",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iK0NnNW5hRGRKZUVwS1ZuVjBOV3BWVFJDUEF4alhCQ2dLTWdZQkFJeVd5QU0=-w280-h168-p-df-rw",
//       "thumbnailProxied":
//           "https://i.zedtranslate.com/newsimage/CC8iK0NnNW5hRGRKZUVwS1ZuVjBOV3BWVFJDUEF4alhCQ2dLTWdZQkFJeVd5QU0"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "New poll reveals how voters are viewing Trump and Harris after the debate",
//     "snippet":
//         "CNN senior data reporter Harry Enten analyzes a new national poll indicating that Vice President Kamala Harris is leading former President Donald Trump by ...",
//     "publisher": "CNN",
//     "timestamp": "1726235783000",
//     "newsUrl": "https://www.cnn.com/2024/09/13/politics/video/harris-trump-debate-polling-enten-cnc-digvid",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iI0NnNWZVV2hEVGsxS1VsbG9UV1ZtVFJDZkF4ampCU2dLTWdB=-w280-h168-p-df-rw",
//       "thumbnailProxied": "https://i.zedtranslate.com/newsimage/CC8iI0NnNWZVV2hEVGsxS1VsbG9UV1ZtVFJDZkF4ampCU2dLTWdB"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "Women in France moved by defiance of Gisèle Pelicot in mass rape trial",
//     "snippet":
//         "When she walks into the courthouse in the French city of Avignon, flanked by her children and a team of lawyers, Gisèle Pelicot cuts an unassuming figure.",
//     "publisher": "BBC.com",
//     "timestamp": "1726277795000",
//     "newsUrl": "https://www.bbc.com/news/articles/cvg5g24rr6lo",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iI0NnNDJZVlJrZDFOWE0wcFZWVEZzVFJDZkF4ampCU2dLTWdB=-w280-h168-p-df-rw",
//       "thumbnailProxied": "https://i.zedtranslate.com/newsimage/CC8iI0NnNDJZVlJrZDFOWE0wcFZWVEZzVFJDZkF4ampCU2dLTWdB"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "Meeting With Biden, British Leader Hints at Ukraine Weapon Decision Soon",
//     "snippet":
//         "As the president deliberated with Prime Minister Keir Starmer, the question of whether to let Ukraine use long-range weapons in Russia was a rare point of ...",
//     "publisher": "The New York Times",
//     "timestamp": "1726275531000",
//     "newsUrl": "https://www.nytimes.com/2024/09/13/us/politics/biden-starmer-ukraine-russia-missiles.html",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iL0NnNHdWakZvTFVad09XSjJOa1pLVFJDUUF4allCQ2dLTWdrQlVJeWxOdVUxN1FF=-w280-h168-p-df-rw",
//       "thumbnailProxied":
//           "https://i.zedtranslate.com/newsimage/CC8iL0NnNHdWakZvTFVad09XSjJOa1pLVFJDUUF4allCQ2dLTWdrQlVJeWxOdVUxN1FF"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "D.C.-area forecast: Warm this weekend before rain odds rise early week",
//     "snippet":
//         "We could use some more rain after another recent dry spell. It won't arrive this weekend, but perhaps shortly thereafter.",
//     "publisher": "The Washington Post",
//     "timestamp": "1726326306000",
//     "newsUrl": "https://www.washingtonpost.com/weather/2024/09/14/dc-area-forecast-warm-weekend/",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iI0NnNWhhMnhuU0VsQlJrZElObFJNVFJERUF4aW1CU2dLTWdB=-w280-h168-p-df-rw",
//       "thumbnailProxied": "https://i.zedtranslate.com/newsimage/CC8iI0NnNWhhMnhuU0VsQlJrZElObFJNVFJERUF4aW1CU2dLTWdB"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "WATCH LIVE: Trump appears at campaign rally in Las Vegas",
//     "snippet": "Former President Donald Trump will appear at a campaign rally in Las Vegas, Nevada on Friday.",
//     "publisher": "PBS NewsHour",
//     "timestamp": "1726254169000",
//     "newsUrl": "https://www.pbs.org/newshour/politics/watch-live-trump-appears-at-campaign-rally-in-las-vegas",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iK0NnNW9ZM040VVRoalRrWXpWbXc0VFJDM0FSaVRBaWdCTWdZbEpvcnRsUW8=-w280-h168-p-df-rw",
//       "thumbnailProxied":
//           "https://i.zedtranslate.com/newsimage/CC8iK0NnNW9ZM040VVRoalRrWXpWbXc0VFJDM0FSaVRBaWdCTWdZbEpvcnRsUW8"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "Killing a baby ‘after birth’ is homicide and legal nowhere. What is Trump on about?",
//     "snippet":
//         "The ex-president repeated the rightwing talking point during the debate with Harris, and now even Fox News is validating it.",
//     "publisher": "The Guardian",
//     "timestamp": "1726324861000",
//     "newsUrl": "https://www.theguardian.com/commentisfree/2024/sep/14/baby-homicide-illegal-trump",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iL0NnNTNORWxsWjFGMFdsSlpaVk16VFJDUkF4ajhCU2dLTWdrWlJJQm9vZWxyZWdB=-w280-h168-p-df-rw",
//       "thumbnailProxied":
//           "https://i.zedtranslate.com/newsimage/CC8iL0NnNTNORWxsWjFGMFdsSlpaVk16VFJDUkF4ajhCU2dLTWdrWlJJQm9vZWxyZWdB"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "Police confirm remains found in Wisconsin are Elijah Vue, 3-year-old missing since February",
//     "snippet":
//         "Wisconsin police have confirmed that a set of human bones found on a property in Twin Rivers are the remains of Elijah Vue, a three-year-old who went ...",
//     "publisher": "The Independent",
//     "timestamp": "1726279897000",
//     "newsUrl": "https://www.independent.co.uk/news/world/americas/crime/elijah-vue-body-found-wisconsin-b2612694.html",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iK0NnNTFTVFJHWVVKRFZXUnNSR0ZKVFJERUF4aW5CU2dLTWdhbGRJTE51UU0=-w280-h168-p-df-rw",
//       "thumbnailProxied":
//           "https://i.zedtranslate.com/newsimage/CC8iK0NnNTFTVFJHWVVKRFZXUnNSR0ZKVFJERUF4aW5CU2dLTWdhbGRJTE51UU0"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title":
//         "North Korea releases images of Kim Jong Un visiting a uranium enrichment site, giving rare glimpse inside its nuclear program",
//     "snippet":
//         "New pictures of North Korean leader Kim Jong Un touring what state media said is a uranium enrichment facility have given an extremely rare glimpse inside ...",
//     "publisher": "CNN",
//     "timestamp": "1726277700000",
//     "newsUrl": "https://www.cnn.com/2024/09/12/asia/north-korea-uranium-enrichment-intl-hnk/index.html",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iI0NnNTBhRE5DZDBoUGRHdHNkVmhMVFJDZkF4ampCU2dLTWdB=-w280-h168-p-df-rw",
//       "thumbnailProxied": "https://i.zedtranslate.com/newsimage/CC8iI0NnNTBhRE5DZDBoUGRHdHNkVmhMVFJDZkF4ampCU2dLTWdB"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "Tropical Storm Gordon forms in Atlantic, hurricane forecasters eye track",
//     "snippet":
//         "Gordon, the seventh named storm of the 2024 Atlantic hurricane season, formed far out in the open ocean.",
//     "publisher": "USA TODAY",
//     "timestamp": "1726241574000",
//     "newsUrl":
//         "https://www.usatoday.com/story/news/weather/2024/09/13/tropical-storm-gordon-forms-what-path/75190435007/",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iL0NnNHphWEp1UWtwSWMwOTRWMU14VFJEekFoaVVCU2dLTWdtQkJvNWdCbXQ3Z0FN=-w280-h168-p-df-rw",
//       "thumbnailProxied":
//           "https://i.zedtranslate.com/newsimage/CC8iL0NnNHphWEp1UWtwSWMwOTRWMU14VFJEekFoaVVCU2dLTWdtQkJvNWdCbXQ3Z0FN"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "Pope Francis says both Trump and Harris are \"against life\"",
//     "snippet":
//         "Pope Francis criticized both former President Trump and Vice President Kamala Harris as being \"against life\" given their respective stances on migration and ...",
//     "publisher": "Axios",
//     "timestamp": "1726303381000",
//     "newsUrl": "https://www.axios.com/2024/09/13/pope-francis-trump-harris-2024-election",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iI0NnNVFjRmhZTUVJeWJqQTFSVzFqVFJDZkF4ampCU2dLTWdB=-w280-h168-p-df-rw",
//       "thumbnailProxied": "https://i.zedtranslate.com/newsimage/CC8iI0NnNVFjRmhZTUVJeWJqQTFSVzFqVFJDZkF4ampCU2dLTWdB"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "911 calls overwhelmed operators after shooting at Georgia’s Apalachee High School",
//     "snippet":
//         "Records released Friday show a Georgia county's emergency call center was overwhelmed by calls on Sept. 4 about a school shooting at Apalachee High School.",
//     "publisher": "The Associated Press",
//     "timestamp": "1726273140000",
//     "newsUrl":
//         "https://apnews.com/article/georgia-apalachee-high-school-911-colt-gray-49ca117ff4d4fe4576843fed1e0a907b",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iL0NnNXVRVkZwT1dzd05qaHBSVUUyVFJDUEF4alhCQ2dLTWdrQlFaUkVxZWRMeUFJ=-w280-h168-p-df-rw",
//       "thumbnailProxied":
//           "https://i.zedtranslate.com/newsimage/CC8iL0NnNXVRVkZwT1dzd05qaHBSVUUyVFJDUEF4alhCQ2dLTWdrQlFaUkVxZWRMeUFJ"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "Pennsylvania mail-in ballots with flawed dates on envelopes can be thrown out, court rules",
//     "snippet":
//         "Pennsylvania voters could have their mail-in ballots thrown out if they do not write accurate dates on envelopes they use to return them under a state ...",
//     "publisher": "ABC News",
//     "timestamp": "1726261473000",
//     "newsUrl":
//         "https://abcnews.go.com/US/wireStory/pennsylvania-mail-ballots-flawed-dates-envelopes-thrown-court-113675710",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iI0NnNVlTSGxwTVVVdGNURlNSbXhGVFJDZkF4ampCU2dLTWdB=-w280-h168-p-df-rw",
//       "thumbnailProxied": "https://i.zedtranslate.com/newsimage/CC8iI0NnNVlTSGxwTVVVdGNURlNSbXhGVFJDZkF4ampCU2dLTWdB"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "Being left behind by Starliner craft was hard, say stranded astronauts",
//     "snippet":
//         "Suni Williams and Butch Wilmore say they watched as the malfunctioning Starliner craft departed without them.",
//     "publisher": "BBC.com",
//     "timestamp": "1726306357000",
//     "newsUrl": "https://www.bbc.com/news/articles/ckgn1125ne3o",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iI0NnNWplVEpaZURWVFJFSjJWalJ1VFJDZkF4ampCU2dLTWdB=-w280-h168-p-df-rw",
//       "thumbnailProxied": "https://i.zedtranslate.com/newsimage/CC8iI0NnNWplVEpaZURWVFJFSjJWalJ1VFJDZkF4ampCU2dLTWdB"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "DirecTV, Disney reach deal to end blackout in time for college football",
//     "snippet": "Disney and DirecTV have reached a deal to end a blackout in time for college football this weekend.",
//     "publisher": "CNBC",
//     "timestamp": "1726318446000",
//     "newsUrl": "https://www.cnbc.com/2024/09/14/directv-disney-near-deal-to-end-blackout.html",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iK0NnNDVObFZhU0c1NmFVbEVSM3BoVFJDZkF4ampCU2dLTWdhcGhaVE5OUWM=-w280-h168-p-df-rw",
//       "thumbnailProxied":
//           "https://i.zedtranslate.com/newsimage/CC8iK0NnNDVObFZhU0c1NmFVbEVSM3BoVFJDZkF4ampCU2dLTWdhcGhaVE5OUWM"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "Fani Willis skips a Georgia state Senate hearing while challenging subpoena",
//     "snippet":
//         "A special Georgia state Senate committee that had subpoenaed Fulton County District Attorney Fani Willis with plans to question her Friday about “alleged ...",
//     "publisher": "The Associated Press",
//     "timestamp": "1726259880000",
//     "newsUrl":
//         "https://apnews.com/article/fani-willis-trump-georgia-election-indictment-6ef40406e7d69594164c7a64e142dc8c",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iK0NnNVJhbTEzVlV0UlZ6TlZMVXROVFJEVkFSakFBaWdLTWdheFZJNlBKUWc=-w280-h168-p-df-rw",
//       "thumbnailProxied":
//           "https://i.zedtranslate.com/newsimage/CC8iK0NnNVJhbTEzVlV0UlZ6TlZMVXROVFJEVkFSakFBaWdLTWdheFZJNlBKUWc"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "‘A giant leap’: Why a tech billionaire’s climb outside a spacecraft was so historic",
//     "snippet":
//         "The SpaceX Polaris Dawn mission may wind down this weekend. Here are all the ways its crew of four citizen astronauts has made history so far.",
//     "publisher": "CNN",
//     "timestamp": "1726317000000",
//     "newsUrl": "https://www.cnn.com/2024/09/14/science/spacex-polaris-dawn-spacewalk-historic-milestone/index.html",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iI0NnNDNZbFpQTVZKNVZYSmhSVlJXVFJDZkF4ampCU2dLTWdB=-w280-h168-p-df-rw",
//       "thumbnailProxied": "https://i.zedtranslate.com/newsimage/CC8iI0NnNDNZbFpQTVZKNVZYSmhSVlJXVFJDZkF4ampCU2dLTWdB"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "Francine could cause more flooding as forecasters eye possible Mid-Atlantic storm",
//     "snippet":
//         "It's been almost two days since Francine swept ashore Louisiana's coast, but it is still delivering flooding as its moisture swirls inland.",
//     "publisher": "The Washington Post",
//     "timestamp": "1726268322000",
//     "newsUrl": "https://www.washingtonpost.com/weather/2024/09/13/francine-storm-carolinas-flooding/",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iI0NnNVJibVZVZGkxWGNWOWZYMHR1VFJERUF4aW5CU2dLTWdB=-w280-h168-p-df-rw",
//       "thumbnailProxied": "https://i.zedtranslate.com/newsimage/CC8iI0NnNVJibVZVZGkxWGNWOWZYMHR1VFJERUF4aW5CU2dLTWdB"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "Oregon DMV registered more than 300 non-citizens to vote",
//     "snippet": "Under state and federal laws, non-citizens are prohibited from voting in national or local elections.",
//     "publisher": "OregonLive",
//     "timestamp": "1726269960000",
//     "newsUrl":
//         "https://www.oregonlive.com/politics/2024/09/oregon-dmv-has-registered-more-than-300-non-citizens-as-voters-since-2021.html",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iK0NnNXJUbDlzTjFkT1IyMDBkVTFmVFJDd0FSaWVBaWdCTWdhQllJS3FQUVU=-w280-h168-p-df-rw",
//       "thumbnailProxied":
//           "https://i.zedtranslate.com/newsimage/CC8iK0NnNXJUbDlzTjFkT1IyMDBkVTFmVFJDd0FSaWVBaWdCTWdhQllJS3FQUVU"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "A confrontation at pro-Israeli rally leads to gunfire after a man tackles one of the demonstrators",
//     "snippet":
//         "A suspected gunman and the man he allegedly shot both face charges of assault after a clash at a pro-Israeli demonstration in Newton, Massachusetts, ...",
//     "publisher": "CNN",
//     "timestamp": "1726276800000",
//     "newsUrl": "https://www.cnn.com/2024/09/13/us/confrontation-pro-israeli-rally-shooting-massachusetts/index.html",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iI0NnNWtUMjEyTldrNGJVVklibXhWVFJDZkF4amlCU2dLTWdB=-w280-h168-p-df-rw",
//       "thumbnailProxied": "https://i.zedtranslate.com/newsimage/CC8iI0NnNWtUMjEyTldrNGJVVklibXhWVFJDZkF4amlCU2dLTWdB"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "Brazil lifts bank account freeze on Musk's companies after \$3 million fine",
//     "snippet":
//         "Brazil's top judge lifted restrictions on the bank accounts of Elon Musk's Starlink and X on Friday after more than \$3 million dollars in fines were ...",
//     "publisher": "Axios",
//     "timestamp": "1726259697000",
//     "newsUrl": "https://www.axios.com/2024/09/13/brazil-elon-musk-x-starlink",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iI0NnNVZXbEpoY1VkdWVFMVNXbE15VFJDZkF4ampCU2dLTWdB=-w280-h168-p-df-rw",
//       "thumbnailProxied": "https://i.zedtranslate.com/newsimage/CC8iI0NnNVZXbEpoY1VkdWVFMVNXbE15VFJDZkF4ampCU2dLTWdB"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "Zelensky reveals details of phone call with Trump from two months ago",
//     "snippet":
//         "CNN's Fareed Zakaria sat down for an exclusive interview with Ukrainian President Volodymyr Zelensky to discuss who he will share his peace plan with and ...",
//     "publisher": "CNN",
//     "timestamp": "1726249430000",
//     "newsUrl": "https://www.cnn.com/2024/09/13/politics/video/zelensky-trump-ukraine-war-zakaria-gps-intv-sot-digvid",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iI0NnNVJSekF5UVRWblJFaFNUSGxtVFJDZkF4ampCU2dLTWdB=-w280-h168-p-df-rw",
//       "thumbnailProxied": "https://i.zedtranslate.com/newsimage/CC8iI0NnNVJSekF5UVRWblJFaFNUSGxtVFJDZkF4ampCU2dLTWdB"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "Boeing workers go on strike after overwhelming votes to reject contract offer and walk off the job",
//     "snippet":
//         "Machinists at Boeing have gone on strike, another setback for the aviation giant whose reputation and finances were already being battered.",
//     "publisher": "CBS News",
//     "timestamp": "1726273460000",
//     "newsUrl": "https://www.cbsnews.com/news/boeing-strike-overwhelming-vote/",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iK0NnNVRaRmhSYW1oTFptZHpORWxEVFJDUkF4ajhCU2dLTWdZQllJNXJNQWM=-w280-h168-p-df-rw",
//       "thumbnailProxied":
//           "https://i.zedtranslate.com/newsimage/CC8iK0NnNVRaRmhSYW1oTFptZHpORWxEVFJDUkF4ajhCU2dLTWdZQllJNXJNQWM"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "Javion McGee of Aurora, found dead against tree with rope around neck, not lynched, NC sheriff says",
//     "snippet":
//         "Javion McGee of Aurora was found in Henderson, NC against a tree with a rope around his neck. The Vance County Sheriff said it's \"not a lynching.\"",
//     "publisher": "ABC7 Chicago",
//     "timestamp": "1726271971000",
//     "newsUrl":
//         "https://abc7chicago.com/post/vance-county-north-carolina-investigation-chicago-area-man-javion-magee-not-lynching-despite-reports-hanging-sheriff/15299737/",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iI0NnNXRTWFZGWVRSVFVEUXlaRFpEVFJDZkF4ampCU2dLTWdB=-w280-h168-p-df-rw",
//       "thumbnailProxied": "https://i.zedtranslate.com/newsimage/CC8iI0NnNXRTWFZGWVRSVFVEUXlaRFpEVFJDZkF4ampCU2dLTWdB"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "Paramedic convicted in Elijah McClain's death freed after judge reduces sentence",
//     "snippet":
//         "Peter Cichuniec was found guilty of assault in the second degree for the unlawful administration of drugs and criminally negligent homicide in Elijah ...",
//     "publisher": "ABC News",
//     "timestamp": "1726281480000",
//     "newsUrl":
//         "https://abcnews.go.com/US/paramedic-convicted-elijah-mcclain-death-freed-from-prison/story?id=113678258",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iI0NnNXhORVF3TnpoUU5HdzRWVXRWVFJDZkF4ampCU2dLTWdB=-w280-h168-p-df-rw",
//       "thumbnailProxied": "https://i.zedtranslate.com/newsimage/CC8iI0NnNXhORVF3TnpoUU5HdzRWVXRWVFJDZkF4ampCU2dLTWdB"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "What to know about the Violence Against Women Act as the landmark law turns 30",
//     "snippet":
//         "Thirty years ago, a new law transformed the way the United States recognizes and combats gender-based violence. The Violence Against Women Act, ...",
//     "publisher": "PBS NewsHour",
//     "timestamp": "1726257685000",
//     "newsUrl":
//         "https://www.pbs.org/newshour/politics/what-to-know-about-the-violence-against-women-act-as-the-landmark-law-turns-30",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iI0NnNXJka3d4VTJka1ZGVmhkM2RTVFJERUF4aW1CU2dLTWdB=-w280-h168-p-df-rw",
//       "thumbnailProxied": "https://i.zedtranslate.com/newsimage/CC8iI0NnNXJka3d4VTJka1ZGVmhkM2RTVFJERUF4aW1CU2dLTWdB"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "Competing abortion ballot measures can appear on November ballot, court rules",
//     "snippet":
//         "Nebraska's Supreme Court ruled that rival abortion initiatives can appear on the November ballot after determining neither ballot initiative violates the ...",
//     "publisher": "Nebraska Public Media | News",
//     "timestamp": "1726260937000",
//     "newsUrl":
//         "https://nebraskapublicmedia.org/en/news/news-articles/competing-abortion-ballot-measures-can-appear-on-november-ballot-court-rules/",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iL0NnNVpTSEF6TkhsTlUyaG5SM3BwVFJDMkFSaVZBaWdCTWdrQkFJSnFtYVd4VHdF=-w280-h168-p-df-rw",
//       "thumbnailProxied":
//           "https://i.zedtranslate.com/newsimage/CC8iL0NnNVpTSEF6TkhsTlUyaG5SM3BwVFJDMkFSaVZBaWdCTWdrQkFJSnFtYVd4VHdF"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "Officials ignored warning signs prior to young girl's death at the hands of her father, lawsuit says",
//     "snippet":
//         "MEREDITH, N.H. (AP) — New Hampshire social workers ignored a litany of warning signs that a 5-year-old girl was being physically abused by her father prior ...",
//     "publisher": "The Associated Press",
//     "timestamp": "1726259760000",
//     "newsUrl":
//         "https://apnews.com/article/harmony-montgomery-lawsuit-new-hampshire-father-abuse-9c4c39e52255265921205563eecc4736",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iI0NnNVdUekl5WmxWR1ZVcHdkVVZZVFJDUEF4alhCQ2dLTWdB=-w280-h168-p-df-rw",
//       "thumbnailProxied": "https://i.zedtranslate.com/newsimage/CC8iI0NnNVdUekl5WmxWR1ZVcHdkVVZZVFJDUEF4alhCQ2dLTWdB"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "Harris Visits Red Areas of Pennsylvania, Hoping to Cut Into Trump’s Edge",
//     "snippet":
//         "The vice president, who appeared in Johnstown and Wilkes-Barre, pledged to remove “unnecessary degree requirements” for some federal jobs, aiming to compete ...",
//     "publisher": "The New York Times",
//     "timestamp": "1726272578000",
//     "newsUrl": "https://www.nytimes.com/2024/09/13/us/politics/harris-pennsylvania-rally.html",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iK0NnNDJjbFV3VkhJMVpUSk9RelZrVFJDUUF4allCQ2dLTWdhQlk1UnZLUWc=-w280-h168-p-df-rw",
//       "thumbnailProxied":
//           "https://i.zedtranslate.com/newsimage/CC8iK0NnNDJjbFV3VkhJMVpUSk9RelZrVFJDUUF4allCQ2dLTWdhQlk1UnZLUWc"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "An emotional week for the Dolphins ends with Tua Tagovailoa concussed and his future unclear",
//     "snippet":
//         "Tua Tagovailoa is dealing with his third diagnosed concussion in three years after colliding head-first with defensive back Damar Hamlin and hitting the ...",
//     "publisher": "The Associated Press",
//     "timestamp": "1726321020000",
//     "newsUrl": "https://apnews.com/article/dolphins-tagovailoa-tyreek-hill-mcdaniel-9340880b532285b932d2807dd16b6cb9",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iI0NnNUVPREZTYkd4bWVHcHpkVWRaVFJDUkF4alhCQ2dLTWdB=-w280-h168-p-df-rw",
//       "thumbnailProxied": "https://i.zedtranslate.com/newsimage/CC8iI0NnNUVPREZTYkd4bWVHcHpkVWRaVFJDUkF4alhCQ2dLTWdB"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "In Politically Divided America, Even the Walz Family Has Painful Rifts",
//     "snippet":
//         "On the campaign trail, Tim Walz, the Democratic vice-presidential nominee, has lamented the political divides in American families, recalling a time when ...",
//     "publisher": "The New York Times",
//     "timestamp": "1726304555000",
//     "newsUrl": "https://www.nytimes.com/2024/09/14/us/elections/tim-walz-estranged-brother-jeff.html",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iI0NnNXdRbXB3UzA1cVlYWkZkMjl3VFJDUUF4allCQ2dLTWdB=-w280-h168-p-df-rw",
//       "thumbnailProxied": "https://i.zedtranslate.com/newsimage/CC8iI0NnNXdRbXB3UzA1cVlYWkZkMjl3VFJDUUF4allCQ2dLTWdB"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "Florida sued for using taxpayer money on website promoting GOP spin on abortion initiative",
//     "snippet":
//         "TALLAHASSEE, Fla. (AP) — A political committee behind the campaign to pass a constitutional right to abortion in Florida has filed a lawsuit against a state ...",
//     "publisher": "The Associated Press",
//     "timestamp": "1726244640000",
//     "newsUrl":
//         "https://apnews.com/article/florida-abortion-amendment-4-website-lawsuit-de510053ee9799d6d6da3d4b203052f3",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iK0NnNWxlbDlwVTBGUmFrTlFaVlZ2VFJETkF4alhCQ2dLTWdZTllwSm5JZ1k=-w280-h168-p-df-rw",
//       "thumbnailProxied":
//           "https://i.zedtranslate.com/newsimage/CC8iK0NnNWxlbDlwVTBGUmFrTlFaVlZ2VFJETkF4alhCQ2dLTWdZTllwSm5JZ1k"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "Media reports jump the gun on start of early voting in Pennsylvania",
//     "snippet":
//         "The New York Times and Fox News, among others, have reported that Pennsylvania begins early voting on Sept. 16. That's not correct.",
//     "publisher": "Votebeat",
//     "timestamp": "1726252200000",
//     "newsUrl": "https://www.votebeat.org/pennsylvania/2024/09/13/september-16-early-voting-misinformation/",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iI0NnNUZTbUpPTkRVdFdVbEdTbXAyVFJDM0FSaVRBaWdCTWdB=-w280-h168-p-df-rw",
//       "thumbnailProxied": "https://i.zedtranslate.com/newsimage/CC8iI0NnNUZTbUpPTkRVdFdVbEdTbXAyVFJDM0FSaVRBaWdCTWdB"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "FACT FOCUS: A look at false claims made by Trump in California",
//     "snippet":
//         "Former President Donald Trump, speaking Friday at his Los Angeles-area golf club, unleashed an attack on Vice President Kamala Harris, revisiting many ...",
//     "publisher": "The Associated Press",
//     "timestamp": "1726267560000",
//     "newsUrl":
//         "https://apnews.com/article/fact-check-misinformation-trump-california-news-conference-a02862f23ebb777057842803e37eff80",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iI0NnNUhRMFYzZW1oWWNVdFpVVlpuVFJEVkFSakFBaWdLTWdB=-w280-h168-p-df-rw",
//       "thumbnailProxied": "https://i.zedtranslate.com/newsimage/CC8iI0NnNUhRMFYzZW1oWWNVdFpVVlpuVFJEVkFSakFBaWdLTWdB"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "25 Best Places To Enjoy Your Retirement In 2024: Eugene And Other Top Spots",
//     "snippet":
//         "Find the best places to retire in the United States. The top 25 retirement spots for leisure activities: golf, hiking, boating, theater, music and ...",
//     "publisher": "Forbes",
//     "timestamp": "1726309800000",
//     "newsUrl":
//         "https://www.forbes.com/sites/williampbarrett/2024/09/14/25-best-places-to-enjoy-your-retirement-in-2024-eugene-and-other-top-spots/",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iJ0NnNHlPV0l6WTJodGVsZDJkSFUzVFJDcUJCaXFCQ2dLTWdNOTRCSQ=-w280-h168-p-df-rw",
//       "thumbnailProxied":
//           "https://i.zedtranslate.com/newsimage/CC8iJ0NnNHlPV0l6WTJodGVsZDJkSFUzVFJDcUJCaXFCQ2dLTWdNOTRCSQ"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "Apple’s Johny Srouji confirms all iPhone 16 models have 8GB RAM, more details",
//     "snippet":
//         "On Monday, Apple touted the new iPhone 16 and iPhone 16 Pro as the first iPhones built from the ground up for Apple Intelligence with the A18 and A18 Pro ...",
//     "publisher": "9to5Mac",
//     "timestamp": "1726271520000",
//     "newsUrl": "https://9to5mac.com/2024/09/13/iphone-16-ram-apple-intelligence/",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iK0NnNXVkek5hYlhkQk9HY3Rka1ZSVFJDZkF4ampCU2dLTWdhcGxZek51UVU=-w280-h168-p-df-rw",
//       "thumbnailProxied":
//           "https://i.zedtranslate.com/newsimage/CC8iK0NnNXVkek5hYlhkQk9HY3Rka1ZSVFJDZkF4ampCU2dLTWdhcGxZek51UVU"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "Russia expels 6 British diplomats it accuses of spying. The UK calls it ‘completely baseless’",
//     "snippet":
//         "Russia on Friday accused six British diplomats of spying and said it decided to expel them. The U.K. said the “completely baseless” move came weeks ago and ...",
//     "publisher": "The Associated Press",
//     "timestamp": "1726265880000",
//     "newsUrl": "https://apnews.com/article/russia-uk-spying-7845e3554c753388e8c952733589fb7f",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iI0NnNU1OVVZqWVUxMVVsSndlVjg1VFJDUEF4alhCQ2dLTWdB=-w280-h168-p-df-rw",
//       "thumbnailProxied": "https://i.zedtranslate.com/newsimage/CC8iI0NnNU1OVVZqWVUxMVVsSndlVjg1VFJDUEF4alhCQ2dLTWdB"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "Sources: Texas A&M QB Weigman game-time call",
//     "snippet":
//         "Texas A&M quarterback Conner Weigman's status for Saturday's game at Florida is uncertain, sources told ESPN. A source called Weigman a \"legitimate ...",
//     "publisher": "ESPN",
//     "timestamp": "1726312500000",
//     "newsUrl":
//         "https://www.espn.com/college-football/story/_/id/41254742/sources-texas-qb-conner-weigman-game-decision",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iK0NnNVBORWhZVGpBM0xWYzBTRFI1VFJDb0FSaXNBaWdCTWdZQk5KQ1FxUWM=-w280-h168-p-df-rw",
//       "thumbnailProxied":
//           "https://i.zedtranslate.com/newsimage/CC8iK0NnNVBORWhZVGpBM0xWYzBTRFI1VFJDb0FSaXNBaWdCTWdZQk5KQ1FxUWM"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "What a way to end HR drought! Judge slam keys comeback win",
//     "snippet":
//         "NEW YORK -- Aaron Judge claimed he didn't know about his career-long homer drought, which had sparked conversation in the grandstands and social media.",
//     "publisher": "MLB.com",
//     "timestamp": "1726290225000",
//     "newsUrl": "https://www.mlb.com/news/aaron-judge-hits-grand-slam-to-end-home-run-drought",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iI0NnNDJRemhuYm5RMmJYZFdZbGRSVFJDb0FSaXNBaWdCTWdB=-w280-h168-p-df-rw",
//       "thumbnailProxied": "https://i.zedtranslate.com/newsimage/CC8iI0NnNDJRemhuYm5RMmJYZFdZbGRSVFJDb0FSaXNBaWdCTWdB"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "Mortgage rates reach new low for 2024 before expected Fed cut",
//     "snippet": "They're not expected to fall far immediately after the September Fed meeting.",
//     "publisher": "Axios",
//     "timestamp": "1726311459000",
//     "newsUrl": "https://www.axios.com/2024/09/14/mortgage-rates-low-september",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iK0NnNVhUbVpXV1hFMlRGVnRjSGRXVFJDcUJCaXFCQ2dLTWdhSkFwWUhEZ2c=-w280-h168-p-df-rw",
//       "thumbnailProxied":
//           "https://i.zedtranslate.com/newsimage/CC8iK0NnNVhUbVpXV1hFMlRGVnRjSGRXVFJDcUJCaXFCQ2dLTWdhSkFwWUhEZ2c"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "Donald Trump Issues Warning After Stock Halted",
//     "snippet":
//         "Former President Donald Trump said he may consider moving his media company's stock listing after it was briefly halted on the Nasdaq stock exchange.",
//     "publisher": "Newsweek",
//     "timestamp": "1726286546000",
//     "newsUrl": "https://www.newsweek.com/donald-trump-issues-warning-after-stock-halted-1953811",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iL0NnNWFPWFpzYTNKYVRrRjRXVEpGVFJERUF4aW1CU2dLTWdrcE5ZYXRVYU56eGdJ=-w280-h168-p-df-rw",
//       "thumbnailProxied":
//           "https://i.zedtranslate.com/newsimage/CC8iL0NnNWFPWFpzYTNKYVRrRjRXVEpGVFJERUF4aW1CU2dLTWdrcE5ZYXRVYU56eGdJ"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title":
//         "Teen screamed he was 'going to die' after being shot in face while looking for place to take homecoming pictures",
//     "snippet":
//         "A teenager who was shot in the face while looking for a place to take homecoming photos told deputies he screamed \"I was going to die,\" according to an ...",
//     "publisher": "ABC News",
//     "timestamp": "1726256526000",
//     "newsUrl": "https://abcnews.go.com/US/teen-screamed-die-after-shot-face-place-homecoming/story?id=113669302",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iK0NnNUtlSEZDUW1GbE1saGhjR1JCVFJDZkF4ampCU2dLTWdhcFpZN3RLUWM=-w280-h168-p-df-rw",
//       "thumbnailProxied":
//           "https://i.zedtranslate.com/newsimage/CC8iK0NnNUtlSEZDUW1GbE1saGhjR1JCVFJDZkF4ampCU2dLTWdhcFpZN3RLUWM"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "Indiana Fever’s Caitlin Clark breaks WNBA single-season assists record in loss to Las Vegas Aces",
//     "snippet":
//         "Caitlin Clark added another milestone to her historic rookie campaign, breaking the WNBA single-season assists record in the Indiana Fever's 78-74 loss to ...",
//     "publisher": "CNN",
//     "timestamp": "1726284960000",
//     "newsUrl": "https://www.cnn.com/2024/09/13/sport/caitlin-clark-single-season-assists-record-spt-intl/index.html",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iL0NnNXhka0ZXTFRodlEwdE5WbU42VFJDZkF4amlCU2dLTWdtWk1KQkpGaWxGeXdF=-w280-h168-p-df-rw",
//       "thumbnailProxied":
//           "https://i.zedtranslate.com/newsimage/CC8iL0NnNXhka0ZXTFRodlEwdE5WbU42VFJDZkF4amlCU2dLTWdtWk1KQkpGaWxGeXdF"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "The Fed has the proof it wants that inflation is slowing, but the next move is still up in the air",
//     "snippet": "A week's worth of inflation data showed that price pressures have eased substantially.",
//     "publisher": "CNBC",
//     "timestamp": "1726313927000",
//     "newsUrl":
//         "https://www.cnbc.com/2024/09/14/inflation-is-slowing-but-the-feds-next-move-is-still-up-in-the-air.html",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iI0NnNVRkV1pzZDJ4RVUzQTFXbHBaVFJDZkF4ampCU2dLTWdB=-w280-h168-p-df-rw",
//       "thumbnailProxied": "https://i.zedtranslate.com/newsimage/CC8iI0NnNVRkV1pzZDJ4RVUzQTFXbHBaVFJDZkF4ampCU2dLTWdB"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "Nixon Started the War on Drugs. Privately, He Said Pot Was ‘Not Particularly Dangerous.’",
//     "snippet":
//         "Two years after former President Richard M. Nixon launched a war on drugs in 1971, calling substance use the nation's “public enemy No.",
//     "publisher": "The New York Times",
//     "timestamp": "1726304467000",
//     "newsUrl": "https://www.nytimes.com/2024/09/14/us/nixon-marijuana-tapes.html",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iK0NnNWFPWE4wTVhCVVMxSnZZVnBSVFJDUkF4allCQ2dLTWdZdFZZS3VLUVk=-w280-h168-p-df-rw",
//       "thumbnailProxied":
//           "https://i.zedtranslate.com/newsimage/CC8iK0NnNWFPWE4wTVhCVVMxSnZZVnBSVFJDUkF4allCQ2dLTWdZdFZZS3VLUVk"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "NFL finds no violation in 49ers’ concealment of Christian McCaffrey’s status",
//     "snippet": "League office has no interest in exposing shenanigans that undermine the integrity of wagers.",
//     "publisher": "NBC Sports",
//     "timestamp": "1726269221000",
//     "newsUrl":
//         "https://www.nbcsports.com/nfl/profootballtalk/rumor-mill/news/nfl-finds-no-violation-in-49ers-concealment-of-christian-mccaffreys-status",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iK0NnNVBXRlJrUmxKS2FuQkRNVlJNVFJDb0FSaXNBaWdCTWdhaFpJNnNxUVk=-w280-h168-p-df-rw",
//       "thumbnailProxied":
//           "https://i.zedtranslate.com/newsimage/CC8iK0NnNVBXRlJrUmxKS2FuQkRNVlJNVFJDb0FSaXNBaWdCTWdhaFpJNnNxUVk"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "FDA approves Apple AirPods Pro 2 to be used as hearing aids",
//     "snippet":
//         "Apple AirPods Pro 2 can soon be used as hearing aids, after they received Food and Drug Administration (FDA) clearance, in what experts call a game changer ...",
//     "publisher": "CBS News",
//     "timestamp": "1726234920000",
//     "newsUrl": "https://www.cbsnews.com/news/fda-approves-apple-airpods-2-as-hearing-aids/",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iK0NnNU5Xa1ZIZWpkVVRYWnVXVGcxVFJDUkF4ajhCU2dLTWdZcFJZN05JUWc=-w280-h168-p-df-rw",
//       "thumbnailProxied":
//           "https://i.zedtranslate.com/newsimage/CC8iK0NnNU5Xa1ZIZWpkVVRYWnVXVGcxVFJDUkF4ajhCU2dLTWdZcFJZN05JUWc"
//     },
//     "hasSubnews": false
//   },
//   {
//     "title": "Recap: Flyers Rookies Lose Game One in Shootout",
//     "snippet":
//         "The Philadelphia Flyers Rookies lost to the New York Rangers Rookies via shootout, 4-3 (1-0), at the PPL Center on Friday night.",
//     "publisher": "NHL.com",
//     "timestamp": "1726279862000",
//     "newsUrl": "https://www.nhl.com/flyers/news/recap-flyers-rookies-lose-game-one-in-shootout",
//     "images": {
//       "thumbnail":
//           "https://news.google.com/api/attachments/CC8iI0NnNTZZekl0Y0hwRlZtWlpheTA1VFJDb0FSaXNBaWdCTWdB=-w280-h168-p-df-rw",
//       "thumbnailProxied": "https://i.zedtranslate.com/newsimage/CC8iI0NnNTZZekl0Y0hwRlZtWlpheTA1VFJDb0FSaXNBaWdCTWdB"
//     },
//     "hasSubnews": false
//   }
// ];
