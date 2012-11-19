<?php

/*
	form_query_ICON.php
	added 2012-11-19 to support user tasks:
		-search for all issues of all publications for a given DATE
		-search for all issues of all publications for a given CITY
		-search for all issues of all publications for a given COUNTRY
		-search for all issues of all publications for a given REPOSITORY
		-cross-reference searches of DATE, CITY, COUNTRY, REPOSITORY
		-search ISSN, LCCN, OCLC

*/
?>


	<div id="content_wrapper" style="visibility: visible">
		<!--Hidden pagination controls-->
		<input type='hidden' id='current_page' />
    <input type='hidden' id='show_per_page' />
		<div id="left_navbar">
			<div id="selection_control_wrapper">
				<div id="loading-calendar" class="loading-calendar-visible">
					<p>

				<form name="form_query_ICON" id="form_query_ICON" method="POST" action="index.php">

					<!--trigger response to form-->
					<input name="ICONquery" id="ICONquery" type="hidden" value="ICONquery">


					<div id="query_ICON_dates">
						Year: <input name="query_ICON_year" id="query_ICON_year" type="text" value="1900" size="4" maxlength="4" />

						Month: <select name="query_ICON_month" id="query_ICON_month" size="1">
							<option class="label" value="01">January</option>
							<option class="label" value="02">February</option>
							<option class="label" value="03">March</option>
							<option class="label" value="04">April</option>
							<option class="label" value="05">May</option>
							<option class="label" value="06">June</option>
							<option class="label" value="07">July</option>
							<option class="label" value="08">August</option>
							<option class="label" value="09">September</option>
							<option class="label" value="10">October</option>
							<option class="label" value="11">November</option>
							<option class="label" value="12">December</option>
						</select>

						Day: <select name="query_ICON_day" id="query_ICON_day" size="1">
							<option class="label" value="01">01</option>
							<option class="label" value="02">02</option>
							<option class="label" value="03">03</option>
							<option class="label" value="04">04</option>
							<option class="label" value="05">05</option>
							<option class="label" value="06">06</option>
							<option class="label" value="07">07</option>
							<option class="label" value="08">08</option>
							<option class="label" value="09">09</option>
							<option class="label" value="10">10</option>
							<option class="label" value="11">11</option>
							<option class="label" value="12">12</option>
							<option class="label" value="12">...add more...</option>
						</select>
					</div><!--#query_ICON_dates-->


					<div id="query_ICON_location">
						Published in city: <input name="pub_city" id="pub_city" type="text" value="Boston" size="25" maxlength="75" />
						Published in country: <input name="country_id" id="country_id" type="text" value="mau" size="3" maxlength="3" />
						Held in repository: <input name="query_ICON_repos" id="query_ICON_repos" type="text" value="BPL" size="3" maxlength="3" />
					</div><!--# query_ICON_location-->


					<input type="submit" name="submit_query_ICON" id="submit_query_ICON" class="label" value="query ICON" />

				</form>



					</p>
				</div>
				<div id="inner_selection_control_wrapper">
					<select id="year_option" name="year_option" >
					</select>
					<label class="select_year_label">Select year from dropdown or by clicking on a bar below:</label><br /><br />
					<ul class="timeline">
						<!--timeline container-->
						<li id="li_1690s">
							<span class="label"><a>1690s</a></span>
							<ul>
							</ul>
						</li>
						<li>
							<span class="label"><a>1700s</a></span>
							<ul>
							</ul>
						</li>
						<li>
							<span class="label"><a>1710s</a></span>
							<ul>
							</ul>
						</li>
						<li>
							<span class="label"><a>1720s</a></span>
							<ul>
							</ul>
						</li>
						<li>
							<span class="label"><a>1730s</a></span>
							<ul>
							</ul>
						</li>
						<li>
							<span class="label"><a>1740s</a></span>
							<ul>
							</ul>
						</li>
						<li>
							<span class="label"><a>1750s</a></span>
							<ul>
							</ul>
						</li>
						<li>
							<span class="label"><a>1760s</a></span>
							<ul>
							</ul>
						</li>
						<li>
							<span class="label"><a>1770s</a></span>
							<ul>
							</ul>
						</li>
						<li>
							<span class="label"><a>1780s</a></span>
							<ul>
							</ul>
						</li>
						<li>
							<span class="label"><a>1790s</a></span>
							<ul>
							</ul>
						</li>
						<li id="li_post_1790s">
							<span class="label"></span>
							<ul>
							</ul>
						</li>
						<li>
							<span class="label"></span>
							<ul>
							</ul>
						</li>
						<li>
							<span class="label"><a>1800s</a></span>
							<ul>
							</ul>
						</li>
						<li>
							<span class="label"><a>1810s</a></span>
							<ul>
							</ul>
						</li>
						<li>
							<span class="label"><a>1820s</a></span>
							<ul>
							</ul>
						</li>
						<li>
							<span class="label"><a>1830s</a></span>
							<ul>
							</ul>
						</li>
						<li>
							<span class="label"><a>1840s</a></span>
							<ul>
							</ul>
						</li>
						<li>
							<span class="label"><a>1850s</a></span>
							<ul>
							</ul>
						</li>
						<li>
							<span class="label"><a>1860s</a></span>
							<ul>
							</ul>
						</li>
						<li>
							<span class="label"><a>1870s</a></span>
							<ul>
							</ul>
						</li>
						<li>
							<span class="label"><a>1880s</a></span>
							<ul>
							</ul>
						</li>
						<li>
							<span class="label" ><a>1890s</a></span>
							<ul>
							</ul>
						</li>
						<li>
							<span class="label" ></span>
							<ul>
							</ul>
						</li>
						<li>
							<span class="label" ></span>
							<ul>
							</ul>
						</li>
						<li>
							<span class="label"><a>1900s</a></span>
							<ul>
							</ul>
						</li>
						<li>
							<span class="label"><a>1910s</a></span>
							<ul>
							</ul>
						</li>
						<li>
							<span class="label"><a>1920s</a></span>
							<ul>
							</ul>
						</li>
						<li>
							<span class="label"><a>1930s</a></span>
							<ul>
							</ul>
						</li>
						<li>
							<span class="label"><a>1940s</a></span>
							<ul>
							</ul>
						</li>
						<li>
							<span class="label"><a>1950s</a></span>
							<ul>
							</ul>
						</li>
						<li>
							<span class="label"><a>1960s</a></span>
							<ul>
							</ul>
						</li>
						<li>
							<span class="label"><a>1970s</a></span>
							<ul>
							</ul>
						</li>
						<li>
							<span class="label"><a>1980s</a></span>
							<ul>
							</ul>
						</li>
						<li>
							<span class="label"><a>1990s</a></span>
							<ul>
							</ul>
						</li>
						<li>
							<span class="label"><a>2000s</a></span>
							<ul>
							</ul>
						</li>
						<li>
							<span class="label"><a>2010s</a></span>
							<ul>
							</ul>
						</li>
					</ul>
					<div id="month_year_container">FORM
						<label class="select_month_label">Select month by clicking on a box below:</label>
						<div id="month_control_wrapper">
							<div class="month_box" id="jan">JAN</div>
							<div class="month_box" id="feb">FEB</div>
							<div class="month_box" id="mar">MAR</div>
							<div class="month_box" id="apr">APR</div>
							<div class="month_box" id="may">MAY</div>
							<div class="month_box" id="jun">JUN</div>
							<div class="month_box" id="jul">JUL</div>
							<!--<div class="month_box" id="aug">AUG</div><br />-->
							<div class="month_box" id="aug">AUG</div>
							<div class="month_box" id="sep">SEP</div>
							<div class="month_box" id="oct">OCT</div>
							<div class="month_box" id="nov">NOV</div>
							<div class="month_box" id="dec">DEC</div>
						</div>
					</div>
					<label class="select_day_label">Select day by clicking on a calendar link:</label>
					<div type="text" id="datepicker_container">
					</div>
				</div>
			</div>
			<div id="result">
					<div id="newspaper_info">
						<div id="title_date_display">
							<div id="issue_date_display"></div>
						</div>
						<div id="issue_info_display">
							<div id="loading-issue-info" class="loading-issue-info-invisible">
								<p>Loading issues&nbsp; . . . &nbsp;&nbsp;<img src="images/loading-issue-info.gif" /></p>
							</div>
							<div id="inner_issue_info_display">
							</div>
						</div>
					</div>
				</div>
		</div>
	</div>
