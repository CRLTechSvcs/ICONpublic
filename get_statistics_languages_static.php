<?php

  /* 2013-09-26 hardcoded JSON for statistics.php : 2 levels of array so same javascript can work on both */

	$languageInfo = array();
	$languagesArray = array();
/***************************************************************
to get the data for this set of statistics, run:
  get_statistics_languages.php
in a COMMAND WINDOW, on AWS so numbers are live, like this:

  Thu Jan 30 21:22 [aelliott@ip-10-165-44-177:/var/www/ICON $]  php get_statistics_languages.php > /home/aelliott/got_statistics_languages.json

download it, open it, paste the results after the comment block.

Then perform the replacements below to create a good JSON file for the static statistics set.

//RETAIN THIS EXAMPLE WHEN PASTING NEW UPDATED STATS

$languageInfo = array("language_id"=>"1","language_name"=>"unspecified/unknown","format_note"=>"default","publications"=>21009,"issues"=>673420);
array_push($languagesArray, $languageInfo);

UEStudio replacement, not as regex:
},{
with
);^parray_push($languagesArray, $languageInfo);^p$languageInfo = array(

AND
":"
with
"=>"

AND then catch the numeric stuff:
":
with
"=>

***************************************************************/
$languageInfo = array("language_id"=>"afr","language_family"=>"Indo-European","language_name"=>"Afrikaans","native_name"=>"Afrikaans","ISO639_1"=>"af","ISO639_2B"=>"afr","ISO639_3"=>"afr","language_note"=>"","language_pubs"=>38,"language_issues"=>"12214","issue_dates"=>"1803-04-09 to 1987-06-30");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"alb","language_family"=>"Indo-European","language_name"=>"Albanian","native_name"=>"Shqip","ISO639_1"=>"sq","ISO639_2B"=>"alb","ISO639_3"=>"sqi","language_note"=>"macrolanguage, 'Albanian Phylozone' in 639-6","language_pubs"=>20,"language_issues"=>"15087","issue_dates"=>"1945-04-21 to 2003-12-30");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"tut","language_family"=>null,"language_name"=>"Altaic (Other)","native_name"=>null,"ISO639_1"=>null,"ISO639_2B"=>null,"ISO639_3"=>null,"language_note"=>"","language_pubs"=>1,"language_issues"=>"0","issue_dates"=>null);
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"ara","language_family"=>"Afro-Asiatic","language_name"=>"Arabic","native_name"=>"\u0627\u0644\u0639\u0631\u0628\u064a\u0629","ISO639_1"=>"ar","ISO639_2B"=>"ara","ISO639_3"=>"ara","language_note"=>"macrolanguage, Standard Arabic is [arb]","language_pubs"=>398,"language_issues"=>"154626","issue_dates"=>"1880-01-01 to 2011-12-31");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"arm","language_family"=>"Indo-European","language_name"=>"Armenian","native_name"=>"\u0540\u0561\u0575\u0565\u0580\u0565\u0576","ISO639_1"=>"hy","ISO639_2B"=>"arm","ISO639_3"=>"hye","language_note"=>"","language_pubs"=>23,"language_issues"=>"5852","issue_dates"=>"1917-12-07 to 1958-07-27");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"aze","language_family"=>"Turkic","language_name"=>"Azerbaijani","native_name"=>"az\u0259rbaycan dili","ISO639_1"=>"az","ISO639_2B"=>"aze","ISO639_3"=>"aze","language_note"=>"macrolanguage","language_pubs"=>11,"language_issues"=>"18","issue_dates"=>"1992-01-01 to 1995-12-31");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"bak","language_family"=>"Turkic","language_name"=>"Bashkir","native_name"=>"\u0431\u0430\u0448\u04a1\u043e\u0440\u0442 \u0442\u0435\u043b\u0435","ISO639_1"=>"ba","ISO639_2B"=>"bak","ISO639_3"=>"bak","language_note"=>"","language_pubs"=>1,"language_issues"=>"0","issue_dates"=>null);
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"baq","language_family"=>"Language isolate","language_name"=>"Basque","native_name"=>"euskara, euskera","ISO639_1"=>"eu","ISO639_2B"=>"baq","ISO639_3"=>"eus","language_note"=>"","language_pubs"=>1,"language_issues"=>"1","issue_dates"=>"1894-03-24 to 1894-03-24");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"bel","language_family"=>"Indo-European","language_name"=>"Belarusian","native_name"=>"\u0431\u0435\u043b\u0430\u0440\u0443\u0441\u043a\u0430\u044f \u043c\u043e\u0432\u0430","ISO639_1"=>"be","ISO639_2B"=>"bel","ISO639_3"=>"bel","language_note"=>"","language_pubs"=>18,"language_issues"=>"1666","issue_dates"=>"1985-01-01 to 2007-01-01");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"ben","language_family"=>"Indo-European","language_name"=>"Bengali, Bangla","native_name"=>"\u09ac\u09be\u0982\u09b2\u09be","ISO639_1"=>"bn","ISO639_2B"=>"ben","ISO639_3"=>"ben","language_note"=>"","language_pubs"=>3,"language_issues"=>"2","issue_dates"=>"2003-05-30 to 2004-03-02");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"bos","language_family"=>"Indo-European","language_name"=>"Bosnian","native_name"=>"bosanski jezik","ISO639_1"=>"bs","ISO639_2B"=>"bos","ISO639_3"=>"bos","language_note"=>"","language_pubs"=>1,"language_issues"=>"108","issue_dates"=>"1994-01-06 to 1996-01-25");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"bul","language_family"=>"Indo-European","language_name"=>"Bulgarian","native_name"=>"\u0431\u044a\u043b\u0433\u0430\u0440\u0441\u043a\u0438 \u0435\u0437\u0438\u043a","ISO639_1"=>"bg","ISO639_2B"=>"bul","ISO639_3"=>"bul","language_note"=>"","language_pubs"=>135,"language_issues"=>"9321","issue_dates"=>"1913-07-09 to 1999-12-31");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"bur","language_family"=>"Sino-Tibetan","language_name"=>"Burmese","native_name"=>null,"ISO639_1"=>"my","ISO639_2B"=>"bur","ISO639_3"=>"mya","language_note"=>"","language_pubs"=>6,"language_issues"=>"1750","issue_dates"=>"1968-08-13 to 1973-07-24");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"cat","language_family"=>"Indo-European","language_name"=>"Catalan","native_name"=>"catal\u00e0","ISO639_1"=>"ca","ISO639_2B"=>"cat","ISO639_3"=>"cat","language_note"=>"","language_pubs"=>4,"language_issues"=>"0","issue_dates"=>null);
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"chi","language_family"=>"Sino-Tibetan","language_name"=>"Chinese","native_name"=>"\u4e2d\u6587 (Zh\u014dngw\u00e9n), \u6c49\u8bed, \u6f22\u8a9e","ISO639_1"=>"zh","ISO639_2B"=>"chi","ISO639_3"=>"zho","language_note"=>"macrolanguage","language_pubs"=>779,"language_issues"=>"233662","issue_dates"=>"1872-04-30 to 2003-02-25");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"chv","language_family"=>"Turkic","language_name"=>"Chuvash","native_name"=>"\u0447\u04d1\u0432\u0430\u0448 \u0447\u04d7\u043b\u0445\u0438","ISO639_1"=>"cv","ISO639_2B"=>"chv","ISO639_3"=>"chv","language_note"=>"","language_pubs"=>2,"language_issues"=>"0","issue_dates"=>null);
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"hrv","language_family"=>"Indo-European","language_name"=>"Croatian","native_name"=>"hrvatski jezik","ISO639_1"=>"hr","ISO639_2B"=>"hrv","ISO639_3"=>"hrv","language_note"=>"","language_pubs"=>28,"language_issues"=>"15534","issue_dates"=>"1896-11-14 to 2003-12-31");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"cze","language_family"=>"Indo-European","language_name"=>"Czech","native_name"=>"\u010de\u0161tina, \u010desk\u00fd jazyk","ISO639_1"=>"cs","ISO639_2B"=>"cze","ISO639_3"=>"ces","language_note"=>"","language_pubs"=>144,"language_issues"=>"40182","issue_dates"=>"1868-06-26 to 2008-04-30");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"dan","language_family"=>"Indo-European","language_name"=>"Danish","native_name"=>"dansk","ISO639_1"=>"da","ISO639_2B"=>"dan","ISO639_3"=>"dan","language_note"=>"","language_pubs"=>54,"language_issues"=>"82975","issue_dates"=>"1869-01-01 to 1995-06-30");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"dut","language_family"=>"Indo-European","language_name"=>"Dutch","native_name"=>"Nederlands, Vlaams","ISO639_1"=>"nl","ISO639_2B"=>"dut","ISO639_3"=>"nld","language_note"=>"","language_pubs"=>175,"language_issues"=>"52485","issue_dates"=>"1681-01-16 to 2010-12-31");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"eng","language_family"=>"Indo-European","language_name"=>"English","native_name"=>"English","ISO639_1"=>"en","ISO639_2B"=>"eng","ISO639_3"=>"eng","language_note"=>"","language_pubs"=>142461,"language_issues"=>"39031200","issue_dates"=>"1604-01-14 to 2015-03-31");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"est","language_family"=>"Uralic","language_name"=>"Estonian","native_name"=>"eesti, eesti keel","ISO639_1"=>"et","ISO639_2B"=>"est","ISO639_3"=>"est","language_note"=>"macrolanguage","language_pubs"=>9,"language_issues"=>"0","issue_dates"=>null);
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"fin","language_family"=>"Uralic","language_name"=>"Finnish","native_name"=>"suomi, suomen kieli","ISO639_1"=>"fi","ISO639_2B"=>"fin","ISO639_3"=>"fin","language_note"=>"","language_pubs"=>69,"language_issues"=>"21711","issue_dates"=>"1891-01-27 to 2007-06-13");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"fre","language_family"=>"Indo-European","language_name"=>"French","native_name"=>"fran\u00e7ais, langue fran\u00e7aise","ISO639_1"=>"fr","ISO639_2B"=>"fre","ISO639_3"=>"fra","language_note"=>"","language_pubs"=>2703,"language_issues"=>"929118","issue_dates"=>"1649-01-01 to 2011-12-31");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"ger","language_family"=>"Indo-European","language_name"=>"German","native_name"=>"Deutsch","ISO639_1"=>"de","ISO639_2B"=>"ger","ISO639_3"=>"deu","language_note"=>"","language_pubs"=>3350,"language_issues"=>"1722526","issue_dates"=>"1703-08-08 to 2011-12-31");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"gem","language_family"=>null,"language_name"=>"Germanic (Other)","native_name"=>null,"ISO639_1"=>null,"ISO639_2B"=>null,"ISO639_3"=>null,"language_note"=>"","language_pubs"=>1,"language_issues"=>"290","issue_dates"=>"1871-05-02 to 1871-11-25");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"gre","language_family"=>"Indo-European","language_name"=>"Greek (modern)","native_name"=>"\u03b5\u03bb\u03bb\u03b7\u03bd\u03b9\u03ba\u03ac","ISO639_1"=>"el","ISO639_2B"=>"gre","ISO639_3"=>"ell","language_note"=>"","language_pubs"=>24,"language_issues"=>"8","issue_dates"=>"1908-04-07 to 2002-01-05");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"guj","language_family"=>"Indo-European","language_name"=>"Gujarati","native_name"=>"\u0a97\u0ac1\u0a9c\u0ab0\u0abe\u0aa4\u0ac0","ISO639_1"=>"gu","ISO639_2B"=>"guj","ISO639_3"=>"guj","language_note"=>"","language_pubs"=>2,"language_issues"=>"1","issue_dates"=>"2000-09-16 to 2000-09-16");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"hau","language_family"=>"Afro-Asiatic","language_name"=>"Hausa","native_name"=>"(Hausa) \u0647\u064e\u0648\u064f\u0633\u064e","ISO639_1"=>"ha","ISO639_2B"=>"hau","ISO639_3"=>"hau","language_note"=>"","language_pubs"=>1,"language_issues"=>"0","issue_dates"=>null);
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"haw","language_family"=>null,"language_name"=>"Hawaiian","native_name"=>null,"ISO639_1"=>null,"ISO639_2B"=>null,"ISO639_3"=>null,"language_note"=>"","language_pubs"=>60,"language_issues"=>"645","issue_dates"=>"1834-11-26 to 1940-06-29");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"heb","language_family"=>"Afro-Asiatic","language_name"=>"Hebrew (modern)","native_name"=>"\u05e2\u05d1\u05e8\u05d9\u05ea","ISO639_1"=>"he","ISO639_2B"=>"heb","ISO639_3"=>"heb","language_note"=>"","language_pubs"=>16,"language_issues"=>"9929","issue_dates"=>"1941-05-30 to 1988-12-30");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"hun","language_family"=>"Uralic","language_name"=>"Hungarian","native_name"=>"magyar","ISO639_1"=>"hu","ISO639_2B"=>"hun","ISO639_3"=>"hun","language_note"=>"","language_pubs"=>180,"language_issues"=>"45638","issue_dates"=>"1841-01-01 to 2003-09-30");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"ice","language_family"=>"Indo-European","language_name"=>"Icelandic","native_name"=>"\u00cdslenska","ISO639_1"=>"is","ISO639_2B"=>"ice","ISO639_3"=>"isl","language_note"=>"","language_pubs"=>5,"language_issues"=>"13399","issue_dates"=>"1956-01-01 to 2002-06-15");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"ind","language_family"=>"Austronesian","language_name"=>"Indonesian","native_name"=>"Bahasa Indonesia","ISO639_1"=>"id","ISO639_2B"=>"ind","ISO639_3"=>"ind","language_note"=>"Covered by macrolanguage [ms\/msa]","language_pubs"=>1,"language_issues"=>"358","issue_dates"=>"1975-03-09 to 1981-12-31");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"ita","language_family"=>"Indo-European","language_name"=>"Italian","native_name"=>"italiano","ISO639_1"=>"it","ISO639_2B"=>"ita","ISO639_3"=>"ita","language_note"=>"","language_pubs"=>504,"language_issues"=>"292692","issue_dates"=>"1729-01-02 to 2008-12-31");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"jpn","language_family"=>"Japonic","language_name"=>"Japanese","native_name"=>"\u65e5\u672c\u8a9e (\u306b\u307b\u3093\u3054)","ISO639_1"=>"ja","ISO639_2B"=>"jpn","ISO639_3"=>"jpn","language_note"=>"","language_pubs"=>103,"language_issues"=>"74608","issue_dates"=>"1888-07-10 to 2010-02-10");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"kbd","language_family"=>null,"language_name"=>"Kabardian","native_name"=>null,"ISO639_1"=>null,"ISO639_2B"=>null,"ISO639_3"=>null,"language_note"=>"","language_pubs"=>1,"language_issues"=>"0","issue_dates"=>null);
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"kal","language_family"=>"Eskimo\u2013Aleut","language_name"=>"Kalaallisut, Greenlandic","native_name"=>"kalaallisut, kalaallit oqaasii","ISO639_1"=>"kl","ISO639_2B"=>"kal","ISO639_3"=>"kal","language_note"=>"","language_pubs"=>1,"language_issues"=>"237","issue_dates"=>"1861-01-01 to 1950-08-31");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"kha","language_family"=>null,"language_name"=>"Khasi","native_name"=>null,"ISO639_1"=>null,"ISO639_2B"=>null,"ISO639_3"=>null,"language_note"=>"","language_pubs"=>1,"language_issues"=>"360","issue_dates"=>"1962-02-08 to 1968-12-25");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"khm","language_family"=>"Austroasiatic","language_name"=>"Khmer","native_name"=>"\u1781\u17d2\u1798\u17c2\u179a, \u1781\u17c1\u1798\u179a\u1797\u17b6\u179f\u17b6, \u1797\u17b6\u179f\u17b6\u1781\u17d2\u1798\u17c2\u179a","ISO639_1"=>"km","ISO639_2B"=>"khm","ISO639_3"=>"khm","language_note"=>"a.k.a. Cambodian","language_pubs"=>2,"language_issues"=>"28","issue_dates"=>"1974-09-02 to 1975-01-31");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"kor","language_family"=>"Koreanic","language_name"=>"Korean","native_name"=>"\ud55c\uad6d\uc5b4, \uc870\uc120\uc5b4","ISO639_1"=>"ko","ISO639_2B"=>"kor","ISO639_3"=>"kor","language_note"=>"","language_pubs"=>15,"language_issues"=>"5","issue_dates"=>"1919-08-21 to 1945-04-19");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"kur","language_family"=>"Indo-European","language_name"=>"Kurdish","native_name"=>"Kurd\u00ee, \u0643\u0648\u0631\u062f\u06cc\u200e","ISO639_1"=>"ku","ISO639_2B"=>"kur","ISO639_3"=>"kur","language_note"=>"macrolanguage","language_pubs"=>6,"language_issues"=>"0","issue_dates"=>null);
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"lad","language_family"=>null,"language_name"=>"Ladino","native_name"=>null,"ISO639_1"=>null,"ISO639_2B"=>null,"ISO639_3"=>null,"language_note"=>"","language_pubs"=>6,"language_issues"=>"6","issue_dates"=>"1919-12-02 to 1919-12-26");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"lao","language_family"=>"Tai\u2013Kadai","language_name"=>"Lao","native_name"=>"\u0e9e\u0eb2\u0eaa\u0eb2\u0ea5\u0eb2\u0ea7","ISO639_1"=>"lo","ISO639_2B"=>"lao","ISO639_3"=>"lao","language_note"=>"","language_pubs"=>1,"language_issues"=>"17","issue_dates"=>"1965-04-12 to 1966-08-12");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"lav","language_family"=>"Indo-European","language_name"=>"Latvian","native_name"=>"latvie\u0161u valoda","ISO639_1"=>"lv","ISO639_2B"=>"lav","ISO639_3"=>"lav","language_note"=>"macrolanguage","language_pubs"=>20,"language_issues"=>"179","issue_dates"=>"1946-01-10 to 1947-06-28");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"lit","language_family"=>"Indo-European","language_name"=>"Lithuanian","native_name"=>"lietuvi\u0173 kalba","ISO639_1"=>"lt","ISO639_2B"=>"lit","ISO639_3"=>"lit","language_note"=>"","language_pubs"=>35,"language_issues"=>"5884","issue_dates"=>"1920-07-09 to 1991-12-31");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"nds","language_family"=>null,"language_name"=>"Low German","native_name"=>null,"ISO639_1"=>null,"ISO639_2B"=>null,"ISO639_3"=>null,"language_note"=>"","language_pubs"=>2,"language_issues"=>"0","issue_dates"=>null);
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"mac","language_family"=>"Indo-European","language_name"=>"Macedonian","native_name"=>"\u043c\u0430\u043a\u0435\u0434\u043e\u043d\u0441\u043a\u0438 \u0458\u0430\u0437\u0438\u043a","ISO639_1"=>"mk","ISO639_2B"=>"mac","ISO639_3"=>"mkd","language_note"=>"","language_pubs"=>6,"language_issues"=>"6429","issue_dates"=>"1962-01-01 to 1999-08-25");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"may","language_family"=>"Austronesian","language_name"=>"Malay","native_name"=>"bahasa Melayu, \u0628\u0647\u0627\u0633 \u0645\u0644\u0627\u064a\u0648\u200e","ISO639_1"=>"ms","ISO639_2B"=>"may","ISO639_3"=>"msa","language_note"=>"macrolanguage, Standard Malay is [zsm], Indonesian is [id\/ind]","language_pubs"=>1,"language_issues"=>"0","issue_dates"=>null);
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"mal","language_family"=>"Dravidian","language_name"=>"Malayalam","native_name"=>"\u0d2e\u0d32\u0d2f\u0d3e\u0d33\u0d02","ISO639_1"=>"ml","ISO639_2B"=>"mal","ISO639_3"=>"mal","language_note"=>"","language_pubs"=>3,"language_issues"=>"0","issue_dates"=>null);
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"mul","language_family"=>null,"language_name"=>"Multiple languages","native_name"=>null,"ISO639_1"=>null,"ISO639_2B"=>null,"ISO639_3"=>null,"language_note"=>"","language_pubs"=>3,"language_issues"=>"0","issue_dates"=>null);
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"nep","language_family"=>"Indo-European","language_name"=>"Nepali","native_name"=>"\u0928\u0947\u092a\u093e\u0932\u0940","ISO639_1"=>"ne","ISO639_2B"=>"nep","ISO639_3"=>"nep","language_note"=>"","language_pubs"=>32,"language_issues"=>"51403","issue_dates"=>"1946-04-19 to 2002-12-31");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"nor","language_family"=>"Indo-European","language_name"=>"Norwegian","native_name"=>"Norsk","ISO639_1"=>"no","ISO639_2B"=>"nor","ISO639_3"=>"nor","language_note"=>"macrolanguage, Bokm\u00e5l is [nb\/nob], Nynorsk is [nn\/nno]","language_pubs"=>73,"language_issues"=>"39430","issue_dates"=>"1866-05-25 to 2008-07-31");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"pan","language_family"=>"Indo-European","language_name"=>"Panjabi, Punjabi","native_name"=>"\u0a2a\u0a70\u0a1c\u0a3e\u0a2c\u0a40, \u067e\u0646\u062c\u0627\u0628\u06cc\u200e","ISO639_1"=>"pa","ISO639_2B"=>"pan","ISO639_3"=>"pan","language_note"=>"","language_pubs"=>2,"language_issues"=>"1","issue_dates"=>"2004-09-03 to 2004-09-03");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"pus","language_family"=>"Indo-European","language_name"=>"Pashto, Pushto","native_name"=>"\u067e\u069a\u062a\u0648","ISO639_1"=>"ps","ISO639_2B"=>"pus","ISO639_3"=>"pus","language_note"=>"macrolanguage","language_pubs"=>1,"language_issues"=>"0","issue_dates"=>null);
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"per","language_family"=>"Indo-European","language_name"=>"Persian (Farsi)","native_name"=>"\u0641\u0627\u0631\u0633\u06cc","ISO639_1"=>"fa","ISO639_2B"=>"per","ISO639_3"=>"fas","language_note"=>"macrolanguage","language_pubs"=>21,"language_issues"=>"1770","issue_dates"=>"1909-01-23 to 2012-03-01");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"pol","language_family"=>"Indo-European","language_name"=>"Polish","native_name"=>"j\u0119zyk polski, polszczyzna","ISO639_1"=>"pl","ISO639_2B"=>"pol","ISO639_3"=>"pol","language_note"=>"","language_pubs"=>260,"language_issues"=>"214832","issue_dates"=>"1833-04-05 to 2006-03-01");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"por","language_family"=>"Indo-European","language_name"=>"Portuguese","native_name"=>"portugu\u00eas","ISO639_1"=>"pt","ISO639_2B"=>"por","ISO639_3"=>"por","language_note"=>"","language_pubs"=>286,"language_issues"=>"198019","issue_dates"=>"1822-09-12 to 2009-12-01");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"rum","language_family"=>"Indo-European","language_name"=>"Romanian","native_name"=>"limba rom\u00e2n\u0103","ISO639_1"=>"ro","ISO639_2B"=>"rum","ISO639_3"=>"ron","language_note"=>"[mo] for Moldavian has been withdrawn, recommending [ro] also for Moldavian","language_pubs"=>96,"language_issues"=>"16866","issue_dates"=>"1911-09-21 to 1999-12-31");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"rus","language_family"=>"Indo-European","language_name"=>"Russian","native_name"=>"\u0440\u0443\u0441\u0441\u043a\u0438\u0439","ISO639_1"=>"ru","ISO639_2B"=>"rus","ISO639_3"=>"rus","language_note"=>"","language_pubs"=>1115,"language_issues"=>"242679","issue_dates"=>"1756-04-26 to 2011-12-31");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"smo","language_family"=>"Austronesian","language_name"=>"Samoan","native_name"=>"gagana fa'a Samoa","ISO639_1"=>"sm","ISO639_2B"=>"smo","ISO639_3"=>"smo","language_note"=>"","language_pubs"=>3,"language_issues"=>"0","issue_dates"=>null);
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"srp","language_family"=>"Indo-European","language_name"=>"Serbian","native_name"=>"\u0441\u0440\u043f\u0441\u043a\u0438 \u0458\u0435\u0437\u0438\u043a","ISO639_1"=>"sr","ISO639_2B"=>"srp","ISO639_3"=>"srp","language_note"=>"The ISO 639-2\/T code srp deprecated the ISO 639-2\/B code scc[1]","language_pubs"=>63,"language_issues"=>"39177","issue_dates"=>"1904-12-01 to 1998-07-31");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"sit","language_family"=>null,"language_name"=>"Sino-Tibetan (Other)","native_name"=>null,"ISO639_1"=>null,"ISO639_2B"=>null,"ISO639_3"=>null,"language_note"=>"","language_pubs"=>1,"language_issues"=>"0","issue_dates"=>null);
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"slo","language_family"=>"Indo-European","language_name"=>"Slovak","native_name"=>"sloven\u010dina, slovensk\u00fd jazyk","ISO639_1"=>"sk","ISO639_2B"=>"slo","ISO639_3"=>"slk","language_note"=>"","language_pubs"=>17,"language_issues"=>"756","issue_dates"=>"1899-05-25 to 1972-12-23");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"slv","language_family"=>"Indo-European","language_name"=>"Slovene","native_name"=>"slovenski jezik, sloven\u0161\u010dina","ISO639_1"=>"sl","ISO639_2B"=>"slv","ISO639_3"=>"slv","language_note"=>"","language_pubs"=>28,"language_issues"=>"13956","issue_dates"=>"1876-03-06 to 1999-12-31");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"som","language_family"=>"Afro-Asiatic","language_name"=>"Somali","native_name"=>"Soomaaliga, af Soomaali","ISO639_1"=>"so","ISO639_2B"=>"som","ISO639_3"=>"som","language_note"=>"","language_pubs"=>1,"language_issues"=>"0","issue_dates"=>null);
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"wen","language_family"=>null,"language_name"=>"Sorbian (Other)","native_name"=>null,"ISO639_1"=>null,"ISO639_2B"=>null,"ISO639_3"=>null,"language_note"=>"","language_pubs"=>1,"language_issues"=>"1","issue_dates"=>"1945-04-20 to 1945-04-20");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"spa","language_family"=>"Indo-European","language_name"=>"Spanish","native_name"=>"espa\u00f1ol","ISO639_1"=>"es","ISO639_2B"=>"spa","ISO639_3"=>"spa","language_note"=>"","language_pubs"=>4287,"language_issues"=>"1187743","issue_dates"=>"1805-10-01 to 2013-08-31");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"swe","language_family"=>"Indo-European","language_name"=>"Swedish","native_name"=>"svenska","ISO639_1"=>"sv","ISO639_2B"=>"swe","ISO639_3"=>"swe","language_note"=>"","language_pubs"=>164,"language_issues"=>"80591","issue_dates"=>"1845-04-19 to 2010-06-20");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"tgl","language_family"=>"Austronesian","language_name"=>"Tagalog","native_name"=>"Wikang Tagalog","ISO639_1"=>"tl","ISO639_2B"=>"tgl","ISO639_3"=>"tgl","language_note"=>"Note: Filipino (Pilipino) has the code [fil]","language_pubs"=>12,"language_issues"=>"4415","issue_dates"=>"1898-11-01 to 1973-01-30");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"tgk","language_family"=>"Indo-European","language_name"=>"Tajik","native_name"=>"\u0442\u043e\u04b7\u0438\u043a\u04e3, to\u00e7ik\u012b, \u062a\u0627\u062c\u06cc\u06a9\u06cc\u200e","ISO639_1"=>"tg","ISO639_2B"=>"tgk","ISO639_3"=>"tgk","language_note"=>"","language_pubs"=>2,"language_issues"=>"30","issue_dates"=>"1996-09-07 to 1997-05-31");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"tam","language_family"=>"Dravidian","language_name"=>"Tamil","native_name"=>"\u0ba4\u0bae\u0bbf\u0bb4\u0bcd","ISO639_1"=>"ta","ISO639_2B"=>"tam","ISO639_3"=>"tam","language_note"=>"","language_pubs"=>1,"language_issues"=>"58","issue_dates"=>"1916-12-01 to 1918-12-31");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"tat","language_family"=>"Turkic","language_name"=>"Tatar","native_name"=>"\u0442\u0430\u0442\u0430\u0440 \u0442\u0435\u043b\u0435, tatar tele","ISO639_1"=>"tt","ISO639_2B"=>"tat","ISO639_3"=>"tat","language_note"=>"","language_pubs"=>14,"language_issues"=>"0","issue_dates"=>null);
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"tha","language_family"=>"Tai\u2013Kadai","language_name"=>"Thai","native_name"=>"\u0e44\u0e17\u0e22","ISO639_1"=>"th","ISO639_2B"=>"tha","ISO639_3"=>"tha","language_note"=>"","language_pubs"=>3,"language_issues"=>"66","issue_dates"=>"1978-01-05 to 1983-11-16");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"tib","language_family"=>"Sino-Tibetan","language_name"=>"Tibetan Standard, Tibetan, Central","native_name"=>"\u0f56\u0f7c\u0f51\u0f0b\u0f61\u0f72\u0f42","ISO639_1"=>"bo","ISO639_2B"=>"tib","ISO639_3"=>"bod","language_note"=>"","language_pubs"=>5,"language_issues"=>"1808","issue_dates"=>"1969-10-01 to 1992-09-18");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"tog","language_family"=>null,"language_name"=>"Tonga (Nyasa)","native_name"=>null,"ISO639_1"=>null,"ISO639_2B"=>null,"ISO639_3"=>null,"language_note"=>"","language_pubs"=>1,"language_issues"=>"0","issue_dates"=>null);
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"tur","language_family"=>"Turkic","language_name"=>"Turkish","native_name"=>"T\u00fcrk\u00e7e","ISO639_1"=>"tr","ISO639_2B"=>"tur","ISO639_3"=>"tur","language_note"=>"","language_pubs"=>630,"language_issues"=>"139168","issue_dates"=>"1850-08-02 to 2008-12-26");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"ota","language_family"=>null,"language_name"=>"Turkish, Ottoman","native_name"=>null,"ISO639_1"=>null,"ISO639_2B"=>null,"ISO639_3"=>null,"language_note"=>"","language_pubs"=>4,"language_issues"=>"0","issue_dates"=>null);
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"tuk","language_family"=>"Turkic","language_name"=>"Turkmen","native_name"=>"T\u00fcrkmen, \u0422\u04af\u0440\u043a\u043c\u0435\u043d","ISO639_1"=>"tk","ISO639_2B"=>"tuk","ISO639_3"=>"tuk","language_note"=>"","language_pubs"=>1,"language_issues"=>"0","issue_dates"=>null);
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"ukr","language_family"=>"Indo-European","language_name"=>"Ukrainian","native_name"=>"\u0443\u043a\u0440\u0430\u0457\u043d\u0441\u044c\u043a\u0430 \u043c\u043e\u0432\u0430","ISO639_1"=>"uk","ISO639_2B"=>"ukr","ISO639_3"=>"ukr","language_note"=>"","language_pubs"=>124,"language_issues"=>"16276","issue_dates"=>"1919-02-25 to 2009-06-30");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"und","language_family"=>null,"language_name"=>"Undetermined","native_name"=>null,"ISO639_1"=>null,"ISO639_2B"=>null,"ISO639_3"=>null,"language_note"=>"","language_pubs"=>12675,"language_issues"=>"2037383","issue_dates"=>"1623-10-11 to 2013-12-31");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"urd","language_family"=>"Indo-European","language_name"=>"Urdu","native_name"=>"\u0627\u0631\u062f\u0648","ISO639_1"=>"ur","ISO639_2B"=>"urd","ISO639_3"=>"urd","language_note"=>"","language_pubs"=>5,"language_issues"=>"6","issue_dates"=>"2004-04-29 to 2004-05-05");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"uig","language_family"=>"Turkic","language_name"=>"Uyghur","native_name"=>"\u0626\u06c7\u064a\u063a\u06c7\u0631\u0686\u06d5\u200e, Uyghurche","ISO639_1"=>"ug","ISO639_2B"=>"uig","ISO639_3"=>"uig","language_note"=>"","language_pubs"=>1,"language_issues"=>"0","issue_dates"=>null);
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"vie","language_family"=>"Austroasiatic","language_name"=>"Vietnamese","native_name"=>"Vi\u1ec7t Nam","ISO639_1"=>"vi","ISO639_2B"=>"vie","ISO639_3"=>"vie","language_note"=>"","language_pubs"=>23,"language_issues"=>"4947","issue_dates"=>"1865-07-01 to 1970-08-11");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"wel","language_family"=>"Indo-European","language_name"=>"Welsh","native_name"=>"Cymraeg","ISO639_1"=>"cy","ISO639_2B"=>"wel","ISO639_3"=>"cym","language_note"=>"","language_pubs"=>8,"language_issues"=>"2563","issue_dates"=>"1857-03-04 to 1900-12-26");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"fry","language_family"=>"Indo-European","language_name"=>"Western Frisian","native_name"=>"Frysk","ISO639_1"=>"fy","ISO639_2B"=>"fry","ISO639_3"=>"fry","language_note"=>"","language_pubs"=>1,"language_issues"=>"53","issue_dates"=>"1946-01-04 to 1946-12-31");
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"sah","language_family"=>null,"language_name"=>"Yakut","native_name"=>null,"ISO639_1"=>null,"ISO639_2B"=>null,"ISO639_3"=>null,"language_note"=>"","language_pubs"=>1,"language_issues"=>"0","issue_dates"=>null);
array_push($languagesArray, $languageInfo);
$languageInfo = array("language_id"=>"yid","language_family"=>"Indo-European","language_name"=>"Yiddish","native_name"=>"\u05d9\u05d9\u05b4\u05d3\u05d9\u05e9","ISO639_1"=>"yi","ISO639_2B"=>"yid","ISO639_3"=>"yid","language_note"=>"macrolanguage","language_pubs"=>110,"language_issues"=>"31934","issue_dates"=>"1876-09-15 to 1980-01-01");
array_push($languagesArray, $languageInfo);

/***************************************************************/

// Sort the multidimensional array: solution from nick ([AT]) nickyost ([DOT]) com in the PHP manual
usort($languagesArray, "custom_sort");
// Define the custom sort function
function custom_sort($a,$b) {
     return $a['language_name']>$b['language_name'];
}

$encoded = json_encode($languagesArray);
die($encoded);

?>
