<?php

  /* 2013-09-26 hardcoded JSON for statistics.php : 2 levels of array so same javascript can work on both */

$countryInfo = array();
$countriesArray = array();
/***************************************************************
to get the data for this set of statistics, run:
  get_statistics_countries.php
in a COMMAND WINDOW, on AWS so numbers are live, like this:
  Thu Jan 30 21:22 [aelliott@ip-10-165-44-177:/var/www/ICON $]  php get_statistics_countries.php > /home/aelliott/get_statistics_countriesForStaticPaste.json

download it, open it, paste the results after the comment block.

Then perform the replacements below to create a good JSON file for the static statistics set.

//RETAIN THIS EXAMPLE WHEN PASTING NEW UPDATED STATS
$countryInfo = array("country_id"=>"af","country_name"=>"Afghanistan","country_pubs"=>2,"country_issues"=>4246);
array_push($countriesArray, $countryInfo);

BEFORE PASTING HERE, in the .json file, do:
UEStudio replacement, not as regex:
},{
with
);^parray_push($countriesArray, $countryInfo);^p$countryInfo = array(

AND
":"
with
"=>"

AND then catch the numeric stuff:
":
with
"=>

and you have to fix the beginning and ending arrays by hand, and add the last array_push statement.

FOR COUNTRIES: when you think all is done, search for:
  \u00
which is some kind of Unicode entity; get the real country names and paste them in; known problems in:
    - C\u00f4te d'Ivoire
        should be Côte d'Ivoire
        change to C&ocirc;te ...
    - Cura\u00e7ao
        should be Curaçao
        change to Cura&ccedil;ao
    - Qu\u00e9bec
        should be Québec
        change to Qu&eacute;bec
    - R\u00e9union
        should be Réunion
        change to R&eacute;union
Replace the Unicode with HTML entities:
  &ocirc;
  &ccedil;
  &eacute;

  - googleChartsAPIfunctions.js has a function reformat_exceptional_country_names
  called by google_visualization_map that may need updating;
  these countries may not show the correct data on mouseover or click
  if the name we send is not what Google recognizes as a country


############################################################################################

OH:
AND WHEN YOU THINK ALL IS REALLY DONE: 2014-08-14
  United States is composed of 52 individual country codes;
    - 'xxu' is 'United States' but it means the undetermined 'somewhere in the US'
    - as of 2014, only 3 pubs with that code, makes it look bad on maps
    - 2014-08-14 force it to show all US pubs and issues
    - in ./staticStatistics/pubsCountriesQueries.sql find the one labeled:
        # how many publications and issues in any US jurisdiction? #
        # paste results in here, fudge (paste) the numbers for 'xxu'
        # or use or pubsCountriesQueries_USAtotal.sql by itself; mySQL Workbench times out

NOTE FOR ALL THESE SPECIAL COUNTRY CASES:
  FIRST set of numbers is only for those publications with VALID issues:
  SECOND set includes the ZERO-DATE issues; THIRD is only for PUBLICATIONS
  - FOR EACH special country,
    use the FIRST DATES for countryInfo[issue_dates]
    use the SECOND ISSUES number for countryInfo[country_issues]
    use the THIRD PUBLICATIONS number for countryInfo[country_pubs]

[2014-10-14] mysql> source /var/www/html/ICON/staticStatistics/pubsCountriesQueries_USAtotal.sql;
+---------------------------------------------------+------------+------------+-----------------------------+-------------------+
| numIssues                                         | minDate    | maxDate    | numPublicationsWholeCountry | numStateProvinces |
+---------------------------------------------------+------------+------------+-----------------------------+-------------------+
| All USA for countryInfo[issue_dates]: 30631577    | 1690-09-25 | 2014-03-31 |                       68212 |                52 |
| All USA for countryInfo[country_issues]: 31237986 | 0000-00-00 | 2014-03-31 |                      143012 |                52 |
| All USA for countryInfo[country_pubs]: ...        | 0000-00-00 | 0000-00-00 |                      147284 |                52 |
+---------------------------------------------------+------------+------------+-----------------------------+-------------------+

   - PASTE AND REPLACE THE UNITED STATES NUMBERS INTO A COPY OF THIS SAMPLE ARRAY ELEMENT
$countryInfo = array("country_id"=>"xxu","country_name"=>"United States","country_pubs"=>GET_FROM_QUERY,"country_issues"=>"GET_FROM_QUERY","issue_dates"=>"GET_FROM_QUERY to GET_FROM_QUERY");



BUT WAIT: THIS IS STILL NOT FIXED: MORE WEIRD COUNTRIES
  - Canada is composed of 14 individual country codes:
    Same process as above using: pubsCountriesQueries_CanadaTotal.sql
[2014-10-14] mysql> source /var/www/html/ICON/staticStatistics/pubsCountriesQueries_CanadaTotal.sql;
+----------------------------------------------------+------------+------------+-----------------------------+-------------------+
| numIssues                                          | minDate    | maxDate    | numPublicationsWholeCountry | numStateProvinces |
+----------------------------------------------------+------------+------------+-----------------------------+-------------------+
| All Canada for countryInfo[issue_dates]: 202459    | 1806-11-22 | 2011-12-31 |                         173 |                10 |
| All Canada for countryInfo[country_issues]: 202742 | 0000-00-00 | 2011-12-31 |                         255 |                12 |
| All Canada for countryInfo[country_pubs]: ...      | 0000-00-00 | 0000-00-00 |                        2949 |                14 |
+----------------------------------------------------+------------+------------+-----------------------------+-------------------+

   - PASTE AND REPLACE THE CANADA NUMBERS INTO A COPY OF THIS SAMPLE ARRAY ELEMENT
  $countryInfo = array("country_id"=>"xxc","country_name"=>"Canada","country_pubs"=>GET_FROM_QUERY,"country_issues"=>"GET_FROM_QUERY","issue_dates"=>"GET_FROM_QUERY to GET_FROM_QUERY");


  - UK is composed of 6 individual country codes
    There is no array element from the JSON, because there are no 'xxk' publications in the database
    - Same process as above using: pubsCountriesQueries_UKtotal.sql
[2014-10-14] mysql> source /var/www/html/ICON/staticStatistics/pubsCountriesQueries_UKtotal.sql;
+------------------------------------------------+------------+------------+-----------------------------+-------------------+
| numIssues                                      | minDate    | maxDate    | numPublicationsWholeCountry | numStateProvinces |
+------------------------------------------------+------------+------------+-----------------------------+-------------------+
| All UK for countryInfo[issue_dates]: 662564    | 1665-11-07 | 2012-04-23 |                         519 |                 5 |
| All UK for countryInfo[country_issues]: 663239 | 0000-00-00 | 2012-04-23 |                         583 |                 5 |
| All UK for countryInfo[country_pubs]: ...      | 0000-00-00 | 0000-00-00 |                        1507 |                 5 |
+------------------------------------------------+------------+------------+-----------------------------+-------------------+

  - PASTE AND REPLACE THE UK NUMBERS INTO A COPY OF THIS SAMPLE ARRAY ELEMENT
  $countryInfo = array("country_id"=>"xxk","country_name"=>"United Kingdom","country_pubs"=>GET_FROM_QUERY,"country_issues"=>"GET_FROM_QUERY","issue_dates"=>"GET_FROM_QUERY to GET_FROM_QUERY");
  array_push($countriesArray, $countryInfo);
  - INSERT THE ARRAY ELEMENT IN ITS PLACE (before 'United Kingdom Misc. Islands')

  - Australia is composed of 9 individual country codes
    Same process as above using: pubsCountriesQueries_AustraliaTotal.sql
[2014-10-14] mysql> source /var/www/html/ICON/staticStatistics/pubsCountriesQueries_AustraliaTotal.sql;
+-------------------------------------------------------+------------+------------+-----------------------------+-------------------+
| numIssues                                             | minDate    | maxDate    | numPublicationsWholeCountry | numStateProvinces |
+-------------------------------------------------------+------------+------------+-----------------------------+-------------------+
| All Australia for countryInfo[issue_dates]: 100743    | 1803-03-01 | 2009-08-15 |                          33 |                 4 |
| All Australia for countryInfo[country_issues]: 100782 | 0000-00-00 | 2009-08-15 |                          37 |                 4 |
| All Australia for countryInfo[country_pubs]: ...      | 0000-00-00 | 0000-00-00 |                         191 |                 7 |
+-------------------------------------------------------+------------+------------+-----------------------------+-------------------+

   - PASTE AND REPLACE THE AUSTRALIA NUMBERS INTO A COPY OF THIS SAMPLE ARRAY ELEMENT
$countryInfo = array("country_id"=>"at","country_name"=>"Australia","country_pubs"=>GET_FROM_QUERY,"country_issues"=>"GET_FROM_QUERY","issue_dates"=>"GET_FROM_QUERY to GET_FROM_QUERY");


############################################################################################

// RETAIN THESE COMMENTS
***************************************************************/
$countryInfo = array("country_id"=>"af","country_name"=>"Afghanistan","country_pubs"=>28,"country_issues"=>"2463","issue_dates"=>"1981-01-01 to 1995-05-10");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"alu","country_name"=>"Alabama","country_pubs"=>2395,"country_issues"=>"84414","issue_dates"=>"1803-05-17 to 1986-06-19");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"aku","country_name"=>"Alaska","country_pubs"=>239,"country_issues"=>"6954","issue_dates"=>"1869-11-06 to 1992-06-03");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"aa","country_name"=>"Albania","country_pubs"=>14,"country_issues"=>"15086","issue_dates"=>"1956-01-01 to 2003-12-30");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"abc","country_name"=>"Alberta","country_pubs"=>206,"country_issues"=>"413","issue_dates"=>"1968-04-25 to 1982-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ae","country_name"=>"Algeria","country_pubs"=>102,"country_issues"=>"17851","issue_dates"=>"1919-04-26 to 2000-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"as","country_name"=>"American Samoa","country_pubs"=>14,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ao","country_name"=>"Angola","country_pubs"=>30,"country_issues"=>"381","issue_dates"=>"1908-01-05 to 1919-10-20");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"aq","country_name"=>"Antigua and Barbuda","country_pubs"=>7,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ag","country_name"=>"Argentina","country_pubs"=>324,"country_issues"=>"240696","issue_dates"=>"1821-06-01 to 2013-08-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"azu","country_name"=>"Arizona","country_pubs"=>1868,"country_issues"=>"160772","issue_dates"=>"1856-03-02 to 2002-11-12");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"aru","country_name"=>"Arkansas","country_pubs"=>2051,"country_issues"=>"64691","issue_dates"=>"1819-11-20 to 1998-09-19");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ai","country_name"=>"Armenia (Republic)","country_pubs"=>17,"country_issues"=>"4","issue_dates"=>"1993-01-01 to 2006-01-01");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"aw","country_name"=>"Aruba","country_pubs"=>9,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"at","country_name"=>"Australia","country_pubs"=>191,"country_issues"=>"100782","issue_dates"=>"1803-03-01 to 2009-08-15");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"aca","country_name"=>"Australian Capital Territory","country_pubs"=>2,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"au","country_name"=>"Austria","country_pubs"=>314,"country_issues"=>"244875","issue_dates"=>"1703-08-08 to 1993-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"aj","country_name"=>"Azerbaijan","country_pubs"=>28,"country_issues"=>"17899","issue_dates"=>"1881-01-01 to 1995-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"bf","country_name"=>"Bahamas","country_pubs"=>23,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ba","country_name"=>"Bahrain","country_pubs"=>5,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"bg","country_name"=>"Bangladesh","country_pubs"=>51,"country_issues"=>"59902","issue_dates"=>"1921-10-14 to 2007-09-25");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"bb","country_name"=>"Barbados","country_pubs"=>18,"country_issues"=>"1314","issue_dates"=>"1948-10-15 to 1976-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"bw","country_name"=>"Belarus","country_pubs"=>36,"country_issues"=>"5725","issue_dates"=>"1955-02-01 to 2007-01-01");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"be","country_name"=>"Belgium","country_pubs"=>114,"country_issues"=>"18589","issue_dates"=>"1830-07-01 to 1998-03-02");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"bh","country_name"=>"Belize","country_pubs"=>27,"country_issues"=>"4643","issue_dates"=>"1826-07-01 to 1974-06-15");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"dm","country_name"=>"Benin","country_pubs"=>25,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"bm","country_name"=>"Bermuda Islands","country_pubs"=>40,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"bt","country_name"=>"Bhutan","country_pubs"=>5,"country_issues"=>"603","issue_dates"=>"1975-06-01 to 1990-12-29");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"bo","country_name"=>"Bolivia","country_pubs"=>454,"country_issues"=>"45264","issue_dates"=>"1833-09-08 to 2004-01-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"bn","country_name"=>"Bosnia and Hercegovina","country_pubs"=>15,"country_issues"=>"18811","issue_dates"=>"1947-01-01 to 2008-01-11");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"bs","country_name"=>"Botswana","country_pubs"=>24,"country_issues"=>"3312","issue_dates"=>"1966-10-03 to 1981-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"bl","country_name"=>"Brazil","country_pubs"=>184,"country_issues"=>"185006","issue_dates"=>"1827-08-29 to 2009-12-01");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"bcc","country_name"=>"British Columbia","country_pubs"=>383,"country_issues"=>"18943","issue_dates"=>"1865-06-06 to 2010-09-20");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"vb","country_name"=>"British Virgin Islands","country_pubs"=>4,"country_issues"=>"247","issue_dates"=>"1959-02-28 to 1973-12-22");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"bx","country_name"=>"Brunei","country_pubs"=>8,"country_issues"=>"1747","issue_dates"=>"1966-03-27 to 1971-01-09");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"bu","country_name"=>"Bulgaria","country_pubs"=>144,"country_issues"=>"13745","issue_dates"=>"1921-11-01 to 1999-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"uv","country_name"=>"Burkina Faso","country_pubs"=>4,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"br","country_name"=>"Burma","country_pubs"=>43,"country_issues"=>"20857","issue_dates"=>"1930-06-25 to 1993-04-16");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"bd","country_name"=>"Burundi","country_pubs"=>19,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"cau","country_name"=>"California","country_pubs"=>9383,"country_issues"=>"1323448","issue_dates"=>"1819-08-08 to 2013-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"cb","country_name"=>"Cambodia","country_pubs"=>90,"country_issues"=>"3405","issue_dates"=>"1923-12-01 to 1975-01-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"cm","country_name"=>"Cameroon","country_pubs"=>329,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"xxc","country_name"=>"Canada","country_pubs"=>2949,"country_issues"=>"202742","issue_dates"=>"1806-11-22 to 2011-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"cv","country_name"=>"Cape Verde","country_pubs"=>4,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"cj","country_name"=>"Cayman Islands","country_pubs"=>3,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"cx","country_name"=>"Central African Republic","country_pubs"=>2,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"cd","country_name"=>"Chad","country_pubs"=>1,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"cl","country_name"=>"Chile","country_pubs"=>133,"country_issues"=>"66054","issue_dates"=>"1827-09-12 to 1996-10-21");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"cc","country_name"=>"China","country_pubs"=>945,"country_issues"=>"426772","issue_dates"=>"1822-09-12 to 2010-12-15");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ch","country_name"=>"China (Republic : 1949- )","country_pubs"=>23,"country_issues"=>"39056","issue_dates"=>"1947-10-10 to 2001-12-27");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"xa","country_name"=>"Christmas Island (Indian Ocean)","country_pubs"=>1,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ck","country_name"=>"Colombia","country_pubs"=>85,"country_issues"=>"26515","issue_dates"=>"1840-08-23 to 1987-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"cou","country_name"=>"Colorado","country_pubs"=>2654,"country_issues"=>"408023","issue_dates"=>"1813-01-20 to 1993-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"cq","country_name"=>"Comoros","country_pubs"=>2,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"cf","country_name"=>"Congo (Brazzaville)","country_pubs"=>16,"country_issues"=>"2576","issue_dates"=>"1956-01-03 to 1988-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"cg","country_name"=>"Congo (Democratic Republic)","country_pubs"=>296,"country_issues"=>"9593","issue_dates"=>"1956-12-22 to 2006-08-16");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ctu","country_name"=>"Connecticut","country_pubs"=>2082,"country_issues"=>"677724","issue_dates"=>"1706-01-17 to 2014-03-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"cr","country_name"=>"Costa Rica","country_pubs"=>40,"country_issues"=>"6816","issue_dates"=>"1849-11-10 to 1980-11-28");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"iv","country_name"=>"C&ocirc;te d'Ivoire","country_pubs"=>10,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ci","country_name"=>"Croatia","country_pubs"=>55,"country_issues"=>"24353","issue_dates"=>"1941-10-01 to 1996-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"cu","country_name"=>"Cuba","country_pubs"=>157,"country_issues"=>"93568","issue_dates"=>"1844-09-03 to 1995-12-30");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"co","country_name"=>"Cura&ccedil;ao","country_pubs"=>7,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"cy","country_name"=>"Cyprus","country_pubs"=>17,"country_issues"=>"13293","issue_dates"=>"1949-10-13 to 1993-10-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"xr","country_name"=>"Czech Republic","country_pubs"=>192,"country_issues"=>"40083","issue_dates"=>"1918-10-28 to 2008-04-30");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"deu","country_name"=>"Delaware","country_pubs"=>310,"country_issues"=>"108114","issue_dates"=>"1776-01-10 to 1991-08-28");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"dk","country_name"=>"Denmark","country_pubs"=>45,"country_issues"=>"76522","issue_dates"=>"1869-01-01 to 1995-06-30");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"dcu","country_name"=>"District of Columbia","country_pubs"=>739,"country_issues"=>"744699","issue_dates"=>"1789-04-23 to 2012-03-25");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ft","country_name"=>"Djibouti","country_pubs"=>6,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"dq","country_name"=>"Dominica","country_pubs"=>9,"country_issues"=>"3295","issue_dates"=>"1842-01-01 to 1907-02-14");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"dr","country_name"=>"Dominican Republic","country_pubs"=>31,"country_issues"=>"13509","issue_dates"=>"1909-12-23 to 1987-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"em","country_name"=>"East Timor","country_pubs"=>7,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ec","country_name"=>"Ecuador","country_pubs"=>40,"country_issues"=>"29980","issue_dates"=>"1821-07-28 to 2009-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ua","country_name"=>"Egypt","country_pubs"=>101,"country_issues"=>"130457","issue_dates"=>"1880-01-01 to 2011-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"es","country_name"=>"El Salvador","country_pubs"=>49,"country_issues"=>"26697","issue_dates"=>"1849-06-15 to 2005-04-20");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"enk","country_name"=>"England","country_pubs"=>1371,"country_issues"=>"524629","issue_dates"=>"1665-11-07 to 2012-04-23");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"eg","country_name"=>"Equatorial Guinea","country_pubs"=>1,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ea","country_name"=>"Eritrea","country_pubs"=>29,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"er","country_name"=>"Estonia","country_pubs"=>27,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"et","country_name"=>"Ethiopia","country_pubs"=>359,"country_issues"=>"20531","issue_dates"=>"1941-06-17 to 2009-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"fj","country_name"=>"Fiji","country_pubs"=>9,"country_issues"=>"573","issue_dates"=>"1978-01-02 to 1979-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"fi","country_name"=>"Finland","country_pubs"=>69,"country_issues"=>"26650","issue_dates"=>"1921-02-11 to 2007-06-13");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"flu","country_name"=>"Florida","country_pubs"=>1757,"country_issues"=>"32927","issue_dates"=>"1783-02-22 to 2013-05-26");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"fr","country_name"=>"France","country_pubs"=>1288,"country_issues"=>"715581","issue_dates"=>"1649-01-01 to 2009-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"fg","country_name"=>"French Guiana","country_pubs"=>3,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"go","country_name"=>"Gabon","country_pubs"=>44,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"gm","country_name"=>"Gambia","country_pubs"=>18,"country_issues"=>"460","issue_dates"=>"1947-04-05 to 1962-01-13");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"gz","country_name"=>"Gaza Strip","country_pubs"=>1,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"gau","country_name"=>"Georgia","country_pubs"=>2392,"country_issues"=>"308575","issue_dates"=>"1763-04-07 to 2004-05-27");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"gs","country_name"=>"Georgia (Republic)","country_pubs"=>35,"country_issues"=>"11430","issue_dates"=>"1906-03-10 to 2006-08-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"gw","country_name"=>"Germany","country_pubs"=>1023,"country_issues"=>"600544","issue_dates"=>"1753-01-01 to 2011-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"gh","country_name"=>"Ghana","country_pubs"=>120,"country_issues"=>"17045","issue_dates"=>"1874-03-28 to 2006-04-29");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"gr","country_name"=>"Greece","country_pubs"=>56,"country_issues"=>"21771","issue_dates"=>"1952-05-24 to 2003-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"gl","country_name"=>"Greenland","country_pubs"=>3,"country_issues"=>"823","issue_dates"=>"1861-01-01 to 1974-01-17");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"gd","country_name"=>"Grenada","country_pubs"=>8,"country_issues"=>"135","issue_dates"=>"1980-06-07 to 1983-06-11");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"gp","country_name"=>"Guadeloupe","country_pubs"=>3,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"gu","country_name"=>"Guam","country_pubs"=>12,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"gt","country_name"=>"Guatemala","country_pubs"=>154,"country_issues"=>"44108","issue_dates"=>"1849-06-18 to 1993-10-29");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"gv","country_name"=>"Guinea","country_pubs"=>2,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"pg","country_name"=>"Guinea-Bissau","country_pubs"=>5,"country_issues"=>"23","issue_dates"=>"1922-04-06 to 1922-09-02");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"gy","country_name"=>"Guyana","country_pubs"=>25,"country_issues"=>"16012","issue_dates"=>"1846-01-05 to 1961-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ht","country_name"=>"Haiti","country_pubs"=>82,"country_issues"=>"37291","issue_dates"=>"1843-05-28 to 1990-06-30");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"hiu","country_name"=>"Hawaii","country_pubs"=>424,"country_issues"=>"133506","issue_dates"=>"1834-11-26 to 1988-06-15");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ho","country_name"=>"Honduras","country_pubs"=>57,"country_issues"=>"12515","issue_dates"=>"1849-08-05 to 1978-07-26");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"hu","country_name"=>"Hungary","country_pubs"=>163,"country_issues"=>"35988","issue_dates"=>"1841-01-01 to 2003-09-30");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ic","country_name"=>"Iceland","country_pubs"=>8,"country_issues"=>"13399","issue_dates"=>"1956-01-01 to 2002-06-15");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"idu","country_name"=>"Idaho","country_pubs"=>937,"country_issues"=>"16577","issue_dates"=>"1863-10-13 to 1989-03-22");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ilu","country_name"=>"Illinois","country_pubs"=>8456,"country_issues"=>"1805823","issue_dates"=>"1783-08-27 to 2013-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ii","country_name"=>"India","country_pubs"=>431,"country_issues"=>"1013158","issue_dates"=>"1782-01-01 to 2011-01-01");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"inu","country_name"=>"Indiana","country_pubs"=>4492,"country_issues"=>"482566","issue_dates"=>"1804-08-07 to 2012-08-09");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"io","country_name"=>"Indonesia","country_pubs"=>310,"country_issues"=>"279486","issue_dates"=>"1811-01-04 to 2011-02-28");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"iau","country_name"=>"Iowa","country_pubs"=>3887,"country_issues"=>"483457","issue_dates"=>"1837-06-28 to 1994-09-17");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ir","country_name"=>"Iran","country_pubs"=>94,"country_issues"=>"34472","issue_dates"=>"1907-02-02 to 2008-05-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"iq","country_name"=>"Iraq","country_pubs"=>97,"country_issues"=>"14632","issue_dates"=>"1918-01-01 to 2009-08-20");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ie","country_name"=>"Ireland","country_pubs"=>398,"country_issues"=>"168757","issue_dates"=>"1685-01-16 to 2010-08-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"is","country_name"=>"Israel","country_pubs"=>97,"country_issues"=>"100379","issue_dates"=>"1919-06-01 to 2012-08-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"it","country_name"=>"Italy","country_pubs"=>317,"country_issues"=>"122076","issue_dates"=>"1814-04-14 to 2008-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"jm","country_name"=>"Jamaica","country_pubs"=>77,"country_issues"=>"34822","issue_dates"=>"1834-09-13 to 2007-10-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ja","country_name"=>"Japan","country_pubs"=>168,"country_issues"=>"137966","issue_dates"=>"1836-06-10 to 2010-02-10");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"jo","country_name"=>"Jordan","country_pubs"=>20,"country_issues"=>"12204","issue_dates"=>"1967-03-28 to 2000-08-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ksu","country_name"=>"Kansas","country_pubs"=>6766,"country_issues"=>"412484","issue_dates"=>"1854-09-15 to 1998-09-04");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"kz","country_name"=>"Kazakhstan","country_pubs"=>31,"country_issues"=>"2016","issue_dates"=>"1985-01-01 to 1997-11-30");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"kyu","country_name"=>"Kentucky","country_pubs"=>2176,"country_issues"=>"338684","issue_dates"=>"1787-08-11 to 1992-07-10");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ke","country_name"=>"Kenya","country_pubs"=>124,"country_issues"=>"31388","issue_dates"=>"1903-01-15 to 2011-05-02");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"gb","country_name"=>"Kiribati","country_pubs"=>2,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"kn","country_name"=>"Korea (North)","country_pubs"=>15,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ko","country_name"=>"Korea (South)","country_pubs"=>157,"country_issues"=>"88744","issue_dates"=>"1896-04-07 to 2009-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"kv","country_name"=>"Kosovo","country_pubs"=>2,"country_issues"=>"8895","issue_dates"=>"1945-01-20 to 1985-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ku","country_name"=>"Kuwait","country_pubs"=>14,"country_issues"=>"680","issue_dates"=>"1973-07-01 to 1979-03-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"kg","country_name"=>"Kyrgyzstan","country_pubs"=>19,"country_issues"=>"95","issue_dates"=>"1993-01-01 to 2006-05-01");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ls","country_name"=>"Laos","country_pubs"=>26,"country_issues"=>"3434","issue_dates"=>"1958-06-25 to 1990-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"lv","country_name"=>"Latvia","country_pubs"=>68,"country_issues"=>"16249","issue_dates"=>"1868-11-06 to 2007-02-15");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"le","country_name"=>"Lebanon","country_pubs"=>53,"country_issues"=>"24641","issue_dates"=>"1875-04-20 to 2002-06-30");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"lo","country_name"=>"Lesotho","country_pubs"=>30,"country_issues"=>"1299","issue_dates"=>"1863-11-03 to 1976-12-28");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"lb","country_name"=>"Liberia","country_pubs"=>96,"country_issues"=>"4124","issue_dates"=>"1826-01-16 to 1982-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ly","country_name"=>"Libya","country_pubs"=>15,"country_issues"=>"952","issue_dates"=>"1915-10-14 to 1967-06-11");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"li","country_name"=>"Lithuania","country_pubs"=>56,"country_issues"=>"4996","issue_dates"=>"1925-01-29 to 1977-11-13");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"lau","country_name"=>"Louisiana","country_pubs"=>1938,"country_issues"=>"325841","issue_dates"=>"1794-08-25 to 2014-03-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"lu","country_name"=>"Luxembourg","country_pubs"=>4,"country_issues"=>"7032","issue_dates"=>"1956-07-02 to 1980-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"xn","country_name"=>"Macedonia","country_pubs"=>10,"country_issues"=>"6644","issue_dates"=>"1962-01-01 to 1999-08-25");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"mg","country_name"=>"Madagascar","country_pubs"=>55,"country_issues"=>"1324","issue_dates"=>"1880-10-10 to 1892-12-15");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"meu","country_name"=>"Maine","country_pubs"=>1572,"country_issues"=>"648445","issue_dates"=>"1785-01-01 to 2012-07-06");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"mw","country_name"=>"Malawi","country_pubs"=>151,"country_issues"=>"10670","issue_dates"=>"1899-07-22 to 2002-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"my","country_name"=>"Malaysia","country_pubs"=>76,"country_issues"=>"46753","issue_dates"=>"1892-07-01 to 2010-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"xc","country_name"=>"Maldives","country_pubs"=>4,"country_issues"=>"1","issue_dates"=>"2003-12-07 to 2003-12-07");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ml","country_name"=>"Mali","country_pubs"=>18,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"mm","country_name"=>"Malta","country_pubs"=>4,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"mbc","country_name"=>"Manitoba","country_pubs"=>116,"country_issues"=>"20311","issue_dates"=>"1894-06-16 to 2010-02-07");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"xe","country_name"=>"Marshall Islands","country_pubs"=>1,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"mq","country_name"=>"Martinique","country_pubs"=>2,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"mdu","country_name"=>"Maryland","country_pubs"=>1748,"country_issues"=>"673315","issue_dates"=>"1734-03-08 to 2001-01-13");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"mau","country_name"=>"Massachusetts","country_pubs"=>4606,"country_issues"=>"2332184","issue_dates"=>"1690-09-25 to 2013-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"mu","country_name"=>"Mauritania","country_pubs"=>3,"country_issues"=>"152","issue_dates"=>"1984-07-03 to 1984-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"mf","country_name"=>"Mauritius","country_pubs"=>66,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"mx","country_name"=>"Mexico","country_pubs"=>1436,"country_issues"=>"329276","issue_dates"=>"1805-10-01 to 2003-09-30");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"miu","country_name"=>"Michigan","country_pubs"=>3102,"country_issues"=>"224506","issue_dates"=>"1809-08-31 to 2003-02-20");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"fm","country_name"=>"Micronesia (Federated States)","country_pubs"=>1,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"mnu","country_name"=>"Minnesota","country_pubs"=>3972,"country_issues"=>"256722","issue_dates"=>"1803-11-12 to 1992-02-05");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"msu","country_name"=>"Mississippi","country_pubs"=>1602,"country_issues"=>"237208","issue_dates"=>"1801-03-07 to 1978-06-01");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"mou","country_name"=>"Missouri","country_pubs"=>4696,"country_issues"=>"1138520","issue_dates"=>"1808-07-26 to 2014-03-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"mv","country_name"=>"Moldova","country_pubs"=>23,"country_issues"=>"867","issue_dates"=>"1988-01-01 to 1995-01-01");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"mp","country_name"=>"Mongolia","country_pubs"=>14,"country_issues"=>"524","issue_dates"=>"1961-11-21 to 1982-01-09");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"mtu","country_name"=>"Montana","country_pubs"=>1177,"country_issues"=>"45464","issue_dates"=>"1864-08-27 to 2000-09-20");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"mo","country_name"=>"Montenegro","country_pubs"=>2,"country_issues"=>"5065","issue_dates"=>"1962-01-01 to 1986-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"mj","country_name"=>"Montserrat","country_pubs"=>2,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"mr","country_name"=>"Morocco","country_pubs"=>53,"country_issues"=>"12981","issue_dates"=>"1897-01-02 to 1991-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"mz","country_name"=>"Mozambique","country_pubs"=>33,"country_issues"=>"16984","issue_dates"=>"1898-03-23 to 1988-09-30");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"sx","country_name"=>"Namibia","country_pubs"=>36,"country_issues"=>"12736","issue_dates"=>"1898-10-12 to 1973-11-21");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"nbu","country_name"=>"Nebraska","country_pubs"=>3748,"country_issues"=>"59007","issue_dates"=>"1854-07-15 to 2003-10-05");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"np","country_name"=>"Nepal","country_pubs"=>41,"country_issues"=>"75429","issue_dates"=>"1946-04-19 to 2004-08-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ne","country_name"=>"Netherlands","country_pubs"=>121,"country_issues"=>"51327","issue_dates"=>"1866-04-07 to 2010-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"na","country_name"=>"Netherlands Antilles","country_pubs"=>2,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"nvu","country_name"=>"Nevada","country_pubs"=>652,"country_issues"=>"44059","issue_dates"=>"1862-07-04 to 1999-10-01");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"nkc","country_name"=>"New Brunswick","country_pubs"=>82,"country_issues"=>"1098","issue_dates"=>"1811-05-01 to 1927-02-05");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"nhu","country_name"=>"New Hampshire","country_pubs"=>1374,"country_issues"=>"447860","issue_dates"=>"1756-10-01 to 2000-11-19");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"nju","country_name"=>"New Jersey","country_pubs"=>1954,"country_issues"=>"430673","issue_dates"=>"1765-09-21 to 2013-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"nmu","country_name"=>"New Mexico","country_pubs"=>1315,"country_issues"=>"210452","issue_dates"=>"1844-09-12 to 2013-06-25");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"xna","country_name"=>"New South Wales","country_pubs"=>135,"country_issues"=>"62908","issue_dates"=>"1803-03-01 to 2009-08-15");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"nyu","country_name"=>"New York (State)","country_pubs"=>12259,"country_issues"=>"6159877","issue_dates"=>"1726-03-21 to 2013-12-22");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"nz","country_name"=>"New Zealand","country_pubs"=>33,"country_issues"=>"31061","issue_dates"=>"1863-11-13 to 2006-05-15");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"nfc","country_name"=>"Newfoundland and Labrador","country_pubs"=>45,"country_issues"=>"2557","issue_dates"=>"1864-01-04 to 1884-12-30");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"nq","country_name"=>"Nicaragua","country_pubs"=>48,"country_issues"=>"29019","issue_dates"=>"1848-09-16 to 1997-12-30");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ng","country_name"=>"Niger","country_pubs"=>9,"country_issues"=>"141","issue_dates"=>"1965-05-24 to 1967-06-17");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"nr","country_name"=>"Nigeria","country_pubs"=>175,"country_issues"=>"21868","issue_dates"=>"1882-03-02 to 1997-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"xx","country_name"=>"No place, unknown, or undetermined","country_pubs"=>23,"country_issues"=>"63","issue_dates"=>"1877-02-07 to 1936-09-30");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ncu","country_name"=>"North Carolina","country_pubs"=>2587,"country_issues"=>"187600","issue_dates"=>"1759-10-18 to 2003-09-07");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ndu","country_name"=>"North Dakota","country_pubs"=>1464,"country_issues"=>"43959","issue_dates"=>"1864-07-14 to 2003-12-27");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"nik","country_name"=>"Northern Ireland","country_pubs"=>28,"country_issues"=>"24442","issue_dates"=>"1761-01-01 to 2008-11-29");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"nw","country_name"=>"Northern Mariana Islands","country_pubs"=>3,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ntc","country_name"=>"Northwest Territories","country_pubs"=>26,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"no","country_name"=>"Norway","country_pubs"=>65,"country_issues"=>"55131","issue_dates"=>"1873-05-24 to 2008-07-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"nsc","country_name"=>"Nova Scotia","country_pubs"=>72,"country_issues"=>"1","issue_dates"=>"1965-01-01 to 1965-01-01");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"nuc","country_name"=>"Nunavut","country_pubs"=>2,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ohu","country_name"=>"Ohio","country_pubs"=>6632,"country_issues"=>"1452955","issue_dates"=>"1712-03-01 to 2013-08-02");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"oku","country_name"=>"Oklahoma","country_pubs"=>3692,"country_issues"=>"83072","issue_dates"=>"1833-11-25 to 2003-07-01");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"mk","country_name"=>"Oman","country_pubs"=>7,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"onc","country_name"=>"Ontario","country_pubs"=>1028,"country_issues"=>"85119","issue_dates"=>"1829-07-24 to 2010-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"oru","country_name"=>"Oregon","country_pubs"=>1668,"country_issues"=>"85183","issue_dates"=>"1846-02-05 to 1984-12-26");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"pk","country_name"=>"Pakistan","country_pubs"=>94,"country_issues"=>"139034","issue_dates"=>"1850-01-05 to 2003-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"pw","country_name"=>"Palau","country_pubs"=>2,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"pn","country_name"=>"Panama","country_pubs"=>145,"country_issues"=>"44656","issue_dates"=>"1825-03-27 to 1972-10-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"pp","country_name"=>"Papua New Guinea","country_pubs"=>124,"country_issues"=>"6434","issue_dates"=>"1950-09-26 to 1986-12-30");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"py","country_name"=>"Paraguay","country_pubs"=>51,"country_issues"=>"16723","issue_dates"=>"1894-02-15 to 1996-08-15");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"pau","country_name"=>"Pennsylvania","country_pubs"=>7975,"country_issues"=>"4200681","issue_dates"=>"1719-12-29 to 2013-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"pe","country_name"=>"Peru","country_pubs"=>137,"country_issues"=>"80171","issue_dates"=>"1826-10-07 to 2009-01-01");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ph","country_name"=>"Philippines","country_pubs"=>258,"country_issues"=>"86157","issue_dates"=>"1861-02-26 to 2007-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"pl","country_name"=>"Poland","country_pubs"=>259,"country_issues"=>"194457","issue_dates"=>"1906-01-01 to 2006-03-01");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"po","country_name"=>"Portugal","country_pubs"=>76,"country_issues"=>"15507","issue_dates"=>"1944-10-19 to 2000-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"pic","country_name"=>"Prince Edward Island","country_pubs"=>14,"country_issues"=>"1464","issue_dates"=>"1877-06-04 to 1951-06-27");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"pr","country_name"=>"Puerto Rico","country_pubs"=>574,"country_issues"=>"368","issue_dates"=>"1932-01-01 to 1939-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"qa","country_name"=>"Qatar","country_pubs"=>6,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"quc","country_name"=>"Qu&eacute;bec (Province)","country_pubs"=>881,"country_issues"=>"72479","issue_dates"=>"1806-11-22 to 2011-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"qea","country_name"=>"Queensland","country_pubs"=>4,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"re","country_name"=>"R&eacute;union","country_pubs"=>13,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"riu","country_name"=>"Rhode Island","country_pubs"=>772,"country_issues"=>"194227","issue_dates"=>"1732-10-04 to 1993-06-23");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"rm","country_name"=>"Romania","country_pubs"=>150,"country_issues"=>"21134","issue_dates"=>"1914-05-19 to 1999-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ru","country_name"=>"Russia (Federation)","country_pubs"=>1098,"country_issues"=>"212452","issue_dates"=>"1756-04-26 to 2011-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"rw","country_name"=>"Rwanda","country_pubs"=>32,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"xj","country_name"=>"Saint Helena","country_pubs"=>4,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"xd","country_name"=>"Saint Kitts-Nevis","country_pubs"=>11,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"xk","country_name"=>"Saint Lucia","country_pubs"=>11,"country_issues"=>"4614","issue_dates"=>"1938-01-01 to 1981-09-01");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"xm","country_name"=>"Saint Vincent and the Grenadines","country_pubs"=>8,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ws","country_name"=>"Samoa","country_pubs"=>4,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"sf","country_name"=>"Sao Tome and Principe","country_pubs"=>13,"country_issues"=>"134","issue_dates"=>"1909-03-14 to 1911-08-30");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"snc","country_name"=>"Saskatchewan","country_pubs"=>61,"country_issues"=>"74","issue_dates"=>"1968-09-13 to 1973-06-15");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"su","country_name"=>"Saudi Arabia","country_pubs"=>22,"country_issues"=>"5463","issue_dates"=>"1972-01-01 to 1992-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"stk","country_name"=>"Scotland","country_pubs"=>86,"country_issues"=>"106748","issue_dates"=>"1722-05-01 to 2008-12-16");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"sg","country_name"=>"Senegal","country_pubs"=>50,"country_issues"=>"3926","issue_dates"=>"1947-01-01 to 1981-12-30");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"rb","country_name"=>"Serbia","country_pubs"=>94,"country_issues"=>"43802","issue_dates"=>"1904-12-01 to 1998-07-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"yu","country_name"=>"Serbia and Montenegro","country_pubs"=>4,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"se","country_name"=>"Seychelles","country_pubs"=>11,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"sl","country_name"=>"Sierra Leone","country_pubs"=>53,"country_issues"=>"8143","issue_dates"=>"1855-12-13 to 1951-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"si","country_name"=>"Singapore","country_pubs"=>57,"country_issues"=>"42864","issue_dates"=>"1835-10-08 to 2008-08-08");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"xo","country_name"=>"Slovakia","country_pubs"=>66,"country_issues"=>"4894","issue_dates"=>"1949-03-19 to 1999-03-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"xv","country_name"=>"Slovenia","country_pubs"=>25,"country_issues"=>"13874","issue_dates"=>"1876-03-06 to 1999-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"bp","country_name"=>"Solomon Islands","country_pubs"=>3,"country_issues"=>"280","issue_dates"=>"1974-10-25 to 1980-10-24");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"so","country_name"=>"Somalia","country_pubs"=>105,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"sa","country_name"=>"South Africa","country_pubs"=>335,"country_issues"=>"151712","issue_dates"=>"1800-08-16 to 2009-03-19");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"xra","country_name"=>"South Australia","country_pubs"=>10,"country_issues"=>"65","issue_dates"=>"1948-10-25 to 1973-10-19");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"scu","country_name"=>"South Carolina","country_pubs"=>1334,"country_issues"=>"816575","issue_dates"=>"1737-09-17 to 1994-06-20");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"sdu","country_name"=>"South Dakota","country_pubs"=>1496,"country_issues"=>"30452","issue_dates"=>"1860-01-03 to 2003-10-03");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"sp","country_name"=>"Spain","country_pubs"=>129,"country_issues"=>"82008","issue_dates"=>"1870-01-02 to 2007-08-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ce","country_name"=>"Sri Lanka","country_pubs"=>66,"country_issues"=>"76416","issue_dates"=>"1832-01-07 to 2002-10-27");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"sj","country_name"=>"Sudan","country_pubs"=>88,"country_issues"=>"21751","issue_dates"=>"1960-01-01 to 1995-06-29");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"sr","country_name"=>"Surinam","country_pubs"=>8,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"sq","country_name"=>"Swaziland","country_pubs"=>7,"country_issues"=>"7822","issue_dates"=>"1897-06-05 to 1985-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"sw","country_name"=>"Sweden","country_pubs"=>52,"country_issues"=>"37141","issue_dates"=>"1868-04-17 to 2010-06-20");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"sz","country_name"=>"Switzerland","country_pubs"=>71,"country_issues"=>"78850","issue_dates"=>"1845-01-03 to 2011-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"sy","country_name"=>"Syria","country_pubs"=>19,"country_issues"=>"5146","issue_dates"=>"1973-01-01 to 2010-12-29");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ta","country_name"=>"Tajikistan","country_pubs"=>22,"country_issues"=>"95","issue_dates"=>"1992-01-04 to 1997-05-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"tz","country_name"=>"Tanzania","country_pubs"=>143,"country_issues"=>"8814","issue_dates"=>"1919-11-19 to 2007-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"tma","country_name"=>"Tasmania","country_pubs"=>5,"country_issues"=>"99","issue_dates"=>"1908-02-22 to 1909-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"tnu","country_name"=>"Tennessee","country_pubs"=>2700,"country_issues"=>"285668","issue_dates"=>"1791-11-05 to 2012-11-26");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"fs","country_name"=>"Terres australes et antarctiques fran\u00e7aises","country_pubs"=>2,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"txu","country_name"=>"Texas","country_pubs"=>5629,"country_issues"=>"836064","issue_dates"=>"1813-03-25 to 2013-09-06");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"th","country_name"=>"Thailand","country_pubs"=>81,"country_issues"=>"52321","issue_dates"=>"1844-07-01 to 2008-08-15");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"tg","country_name"=>"Togo","country_pubs"=>13,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"to","country_name"=>"Tonga","country_pubs"=>3,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"tr","country_name"=>"Trinidad and Tobago","country_pubs"=>17,"country_issues"=>"24121","issue_dates"=>"1832-01-04 to 1995-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ti","country_name"=>"Tunisia","country_pubs"=>17,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"tu","country_name"=>"Turkey","country_pubs"=>664,"country_issues"=>"150323","issue_dates"=>"1850-08-02 to 2008-12-26");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"tk","country_name"=>"Turkmenistan","country_pubs"=>16,"country_issues"=>"158","issue_dates"=>"1992-01-01 to 1992-08-01");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"tc","country_name"=>"Turks and Caicos Islands","country_pubs"=>1,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ug","country_name"=>"Uganda","country_pubs"=>129,"country_issues"=>"11238","issue_dates"=>"1912-07-05 to 1955-05-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"un","country_name"=>"Ukraine","country_pubs"=>286,"country_issues"=>"20127","issue_dates"=>"1917-07-22 to 2010-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ts","country_name"=>"United Arab Emirates","country_pubs"=>13,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"xxk","country_name"=>"United Kingdom","country_pubs"=>1507,"country_issues"=>"663239","issue_dates"=>"1665-11-07 to 2012-04-23");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"uik","country_name"=>"United Kingdom Misc. Islands","country_pubs"=>6,"country_issues"=>"1243","issue_dates"=>"1791-01-01 to 1856-08-23");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"xxu","country_name"=>"United States","country_pubs"=>147284,"country_issues"=>"31237986","issue_dates"=>"1690-09-25 to 2014-03-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"uy","country_name"=>"Uruguay","country_pubs"=>49,"country_issues"=>"17000","issue_dates"=>"1910-09-02 to 1991-06-15");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"utu","country_name"=>"Utah","country_pubs"=>698,"country_issues"=>"58735","issue_dates"=>"1850-06-15 to 1973-03-22");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"uz","country_name"=>"Uzbekistan","country_pubs"=>32,"country_issues"=>"585","issue_dates"=>"1900-10-01 to 1994-11-30");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"nn","country_name"=>"Vanuatu","country_pubs"=>3,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"vp","country_name"=>"Various places","country_pubs"=>7,"country_issues"=>"2","issue_dates"=>"1864-03-21 to 1870-04-16");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"vc","country_name"=>"Vatican City","country_pubs"=>7,"country_issues"=>"5034","issue_dates"=>"1849-09-05 to 1984-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ve","country_name"=>"Venezuela","country_pubs"=>155,"country_issues"=>"50854","issue_dates"=>"1822-01-21 to 2009-03-11");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"vtu","country_name"=>"Vermont","country_pubs"=>1114,"country_issues"=>"250391","issue_dates"=>"1781-04-01 to 2013-03-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"vra","country_name"=>"Victoria","country_pubs"=>32,"country_issues"=>"37671","issue_dates"=>"1849-01-02 to 2009-06-10");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"vm","country_name"=>"Vietnam","country_pubs"=>334,"country_issues"=>"150187","issue_dates"=>"1865-07-01 to 1986-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"vi","country_name"=>"Virgin Islands of the United States","country_pubs"=>61,"country_issues"=>"3963","issue_dates"=>"1770-01-01 to 1925-06-10");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"vau","country_name"=>"Virginia","country_pubs"=>2961,"country_issues"=>"643476","issue_dates"=>"1736-09-03 to 2004-06-11");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"wlk","country_name"=>"Wales","country_pubs"=>16,"country_issues"=>"5502","issue_dates"=>"1895-09-02 to 1987-10-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"wau","country_name"=>"Washington (State)","country_pubs"=>2314,"country_issues"=>"99689","issue_dates"=>"1854-02-04 to 2006-12-22");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"wj","country_name"=>"West Bank of the Jordan River","country_pubs"=>3,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"wvu","country_name"=>"West Virginia","country_pubs"=>1228,"country_issues"=>"256828","issue_dates"=>"1790-08-13 to 2002-06-01");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"wea","country_name"=>"Western Australia","country_pubs"=>3,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"wiu","country_name"=>"Wisconsin","country_pubs"=>3575,"country_issues"=>"244690","issue_dates"=>"1833-12-11 to 2001-08-02");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"wyu","country_name"=>"Wyoming","country_pubs"=>719,"country_issues"=>"33760","issue_dates"=>"1818-07-01 to 1992-06-24");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ye","country_name"=>"Yemen","country_pubs"=>36,"country_issues"=>"961","issue_dates"=>"1981-11-01 to 2000-12-19");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"ykc","country_name"=>"Yukon Territory","country_pubs"=>32,"country_issues"=>"0","issue_dates"=>null);
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"za","country_name"=>"Zambia","country_pubs"=>53,"country_issues"=>"12503","issue_dates"=>"1916-01-01 to 1991-12-31");
array_push($countriesArray, $countryInfo);
$countryInfo = array("country_id"=>"rh","country_name"=>"Zimbabwe","country_pubs"=>82,"country_issues"=>"26494","issue_dates"=>"1892-10-29 to 1995-12-30");
array_push($countriesArray, $countryInfo);

/**************************************************************/

// Sort the multidimensional array: solution from nick ([AT]) nickyost ([DOT]) com in the PHP manual
usort($countriesArray, "custom_sort");
// Define the custom sort function
function custom_sort($a,$b) {
     return $a['country_name']>$b['country_name'];
}


$encoded = json_encode($countriesArray);
die($encoded);
?>
