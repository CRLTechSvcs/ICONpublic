<!--AJE 2014-04-07: footer_script_tags.php: commonly included after footerCRL.php, no need to duplicate -->
		<script src="javascripts/json2.js"></script>
		<script src="javascripts/foundation.min.js"></script>
		<script src="javascripts/app.js"></script>
		<script src="javascripts/jquery-1.7.1.min.js"></script>
		<script src="javascripts/jquery-ui-1.8.9.custom.min.js"></script>

		<script src="javascripts/initialize_variables.js"></script>
		<script src="javascripts/d3.v3.min.js"></script>

		<!--AJE 2015-07-31 new for visualize.php (calendar.php with D3 visualizations)
		  there is a D3 already above, this is what the working version uses:
		  <script src="javascripts/d3.min.js"></script>
		-->
		<script src="javascripts/d3.tip.v0.6.3.js"></script> <!--d3.tip is for tooltips on mouseover-->



<?php
		/*
		2014-July-08
		PXia supplied Google Analytics ICON Site ID: UA-497327-16
		*/
?>
<!-- Google Analytics -->
<script>
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-497327-16', 'auto');
ga('send', 'pageview');

</script>
<!-- End Google Analytics -->