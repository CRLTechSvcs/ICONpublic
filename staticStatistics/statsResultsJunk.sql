Mon Sep 21-2015 13:12 [aelliott@localhost:/var/www/html/ICON/staticStatistics $] 

mysql> source /var/www/html/ICON/staticStatistics/pubsCountriesQueries_USAtotal.sql;
Database changed
+---------------------------------------------------+------------+------------+-----------------------------+-------------------+
| numIssues                                         | minDate    | maxDate    | numPublicationsWholeCountry | numStateProvinces |
+---------------------------------------------------+------------+------------+-----------------------------+-------------------+
| All USA for countryInfo[issue_dates]: 36255851    | 1690-09-25 | 2015-03-31 |                       69000 |                52 |
| All USA for countryInfo[country_issues]: 36862302 | 0000-00-00 | 2015-03-31 |                      142128 |                52 |
| All USA for countryInfo[country_pubs]: ...        | 0000-00-00 | 0000-00-00 |                      146123 |                52 |
+---------------------------------------------------+------------+------------+-----------------------------+-------------------+


mysql> source /var/www/html/ICON/staticStatistics/pubsCountriesQueries_UKtotal.sql;
Database changed
+------------------------------------------------+------------+------------+-----------------------------+-------------------+
| numIssues                                      | minDate    | maxDate    | numPublicationsWholeCountry | numStateProvinces |
+------------------------------------------------+------------+------------+-----------------------------+-------------------+
| All UK for countryInfo[issue_dates]: 662564    | 1665-11-07 | 2012-04-23 |                         506 |                 5 |
| All UK for countryInfo[country_issues]: 663239 | 0000-00-00 | 2012-04-23 |                         561 |                 5 |
| All UK for countryInfo[country_pubs]: ...      | 0000-00-00 | 0000-00-00 |                        1446 |                 5 |
+------------------------------------------------+------------+------------+-----------------------------+-------------------+


mysql> source /var/www/html/ICON/staticStatistics/pubsCountriesQueries_CanadaTotal.sql;
Database changed
+----------------------------------------------------+------------+------------+-----------------------------+-------------------+
| numIssues                                          | minDate    | maxDate    | numPublicationsWholeCountry | numStateProvinces |
+----------------------------------------------------+------------+------------+-----------------------------+-------------------+
| All Canada for countryInfo[issue_dates]: 202687    | 1806-11-22 | 2011-12-31 |                         178 |                10 |
| All Canada for countryInfo[country_issues]: 202970 | 0000-00-00 | 2011-12-31 |                         257 |                12 |
| All Canada for countryInfo[country_pubs]: ...      | 0000-00-00 | 0000-00-00 |                        2911 |                14 |
+----------------------------------------------------+------------+------------+-----------------------------+-------------------+

mysql> source /var/www/html/ICON/staticStatistics/pubsCountriesQueries_AustraliaTotal.sql;
Database changed
+-------------------------------------------------------+------------+------------+-----------------------------+-------------------+
| numIssues                                             | minDate    | maxDate    | numPublicationsWholeCountry | numStateProvinces |
+-------------------------------------------------------+------------+------------+-----------------------------+-------------------+
| All Australia for countryInfo[issue_dates]: 100743    | 1803-03-01 | 2009-08-15 |                          33 |                 4 |
| All Australia for countryInfo[country_issues]: 100782 | 0000-00-00 | 2009-08-15 |                          37 |                 4 |
| All Australia for countryInfo[country_pubs]: ...      | 0000-00-00 | 0000-00-00 |                         181 |                 7 |
+-------------------------------------------------------+------------+------------+-----------------------------+-------------------+


