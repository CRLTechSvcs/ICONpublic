Wed Dec 16 14:14 [aelliott@localhost:/var/www/html/ICON/staticStatistics $]  mysql -u root -p
[...]

mysql> source /var/www/html/ICON/staticStatistics/pubsCountriesQueries_USAtotal.sql;
Database changed
+---------------------------------------------------+------------+------------+-----------------------------+-------------------+
| numIssues                                         | minDate    | maxDate    | numPublicationsWholeCountry | numStateProvinces |
+---------------------------------------------------+------------+------------+-----------------------------+-------------------+
| All USA for countryInfo[issue_dates]: 36587945    | 1690-09-25 | 2015-03-31 |                       69098 |                52 |
| All USA for countryInfo[country_issues]: 37194396 | 0000-00-00 | 2015-03-31 |                      142175 |                52 |
| All USA for countryInfo[country_pubs]: ...        | 0000-00-00 | 0000-00-00 |                      146154 |                52 |
+---------------------------------------------------+------------+------------+-----------------------------+-------------------+
3 rows in set (20 min 38.51 sec)

mysql> source /var/www/html/ICON/staticStatistics/pubsCountriesQueries_CanadaTotal.sql;
Database changed
+----------------------------------------------------+------------+------------+-----------------------------+-------------------+
| numIssues                                          | minDate    | maxDate    | numPublicationsWholeCountry | numStateProvinces |
+----------------------------------------------------+------------+------------+-----------------------------+-------------------+
| All Canada for countryInfo[issue_dates]: 203502    | 1806-11-22 | 2011-12-31 |                         203 |                10 |
| All Canada for countryInfo[country_issues]: 203785 | 0000-00-00 | 2011-12-31 |                         282 |                12 |
| All Canada for countryInfo[country_pubs]: ...      | 0000-00-00 | 0000-00-00 |                        2939 |                14 |
+----------------------------------------------------+------------+------------+-----------------------------+-------------------+
3 rows in set (5.06 sec)

mysql> source /var/www/html/ICON/staticStatistics/pubsCountriesQueries_UKtotal.sql;
Database changed
+-------------------------------------------------+------------+------------+-----------------------------+-------------------+
| numIssues                                       | minDate    | maxDate    | numPublicationsWholeCountry | numStateProvinces |
+-------------------------------------------------+------------+------------+-----------------------------+-------------------+
| All UK for countryInfo[issue_dates]: 1869235    | 1604-01-14 | 2012-12-31 |                        2268 |                 5 |
| All UK for countryInfo[country_issues]: 1869915 | 0000-00-00 | 2012-12-31 |                        2311 |                 5 |
| All UK for countryInfo[country_pubs]: ...       | 0000-00-00 | 0000-00-00 |                        3081 |                 5 |
+-------------------------------------------------+------------+------------+-----------------------------+-------------------+
3 rows in set (46.61 sec)

mysql> source /var/www/html/ICON/staticStatistics/pubsCountriesQueries_AustraliaTotal.sql;
Database changed
+-------------------------------------------------------+------------+------------+-----------------------------+-------------------+
| numIssues                                             | minDate    | maxDate    | numPublicationsWholeCountry | numStateProvinces |
+-------------------------------------------------------+------------+------------+-----------------------------+-------------------+
| All Australia for countryInfo[issue_dates]: 104864    | 1803-03-01 | 2009-08-15 |                          53 |                 5 |
| All Australia for countryInfo[country_issues]: 104903 | 0000-00-00 | 2009-08-15 |                          57 |                 5 |
| All Australia for countryInfo[country_pubs]: ...      | 0000-00-00 | 0000-00-00 |                         202 |                 7 |
+-------------------------------------------------------+------------+------------+-----------------------------+-------------------+
3 rows in set (2.19 sec)


