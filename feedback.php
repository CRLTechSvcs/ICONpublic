<!DOCTYPE html>
<!--[if IE 8]><html class="no-js lt-ie9" lang="en"><![endif]-->
<!--[if gt IE 8]><!--><html class="no-js" lang="en"><!--<![endif]-->
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width" />

    <meta http-equiv="cache-control" content="max-age=0" />
    <meta http-equiv="cache-control" content="no-cache" />
    <meta http-equiv="expires" content="0" />
    <meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT" />
    <meta http-equiv="pragma" content="no-cache" />

		<title>ICON - International Coalition on Newspapers</title>
		<link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon" />
		<link rel="stylesheet" href="stylesheets/foundation.min.css">
		<link rel="stylesheet" href="stylesheets/app.css">
		<link rel="stylesheet" href="stylesheets/icon.css">


	</head>
	<body>
		<div class="row header" style="margin-top: 20px; margin-bottom: 20px;">
<!-- CRL LOGO -->
			<div class="six columns" style="padding-left: 0px;">
				<a href="http://www.crl.edu"><img src="images/CRL_logo.png" /></a>
			</div>
<!-- ICON TEXT -->
			<div class="six columns" style="padding-right: 0px;">
				<h1 class="iconTitle iconTitleLong">International Coalition on Newspapers</h1>
				<h1 class="iconTitle iconTitleShort">ICON</h1>
			</div>
		</div>
  <div class="row contentArea">
      <div class="twelve columns landing_page_content">
        <div class="row landing_content_text">
          <h1 class="iconTitle iconTitleLong" style="text-align:left;">ICON feedback form</h1>
				  <h1 class="iconTitle iconTitleShort" style="text-align:left;">all form fields are required</h1>
<?php

/*
  AJE 2014-04-04 PHP code to handle form submissions from feedback.php ;
  started from example at http://www.totallyphp.co.uk/form-to-mail
*/

$b_form_submitted = (isset($_POST['to_email'] )) ? 1 : 0; // we have received data after first display of form

$b_empty_fields = 0; // assume all fields have data
$empty_fields_list = '';
$empty_fields_message = "Please enter data for all fields in the form."; // Displayed if all required fields not filled in

$b_spam = 0; // assume not spam; check body_email later to see
$spam_message = '<p>The contents of your email look like spam (may contain html code); mail will not be sent.</p>'; // display message

$success_message = '<h3>Thank you. Your feedback mail message has been sent successfully.</h3>'; // Displayed when email has been sent
$success_message .= '<div href="#" id="cancel_feedback_button" class="feedback_button">Great: close this window</div>';
$failure_message = '<p>There was a problem (status code EMAIL_STATUS_CODE. Your feedback mail message was NOT sent.</p>'; // Displayed when email has been sent
$not_allowed_message = '<p>You do not have permission to use this script from another URL; mail will not be sent.</p>'; // display message


$HTTP_REFERER = getenv("HTTP_REFERER");  //Get referring URL; always present
$this_url = "http://".$_SERVER['HTTP_HOST'].$_SERVER["REQUEST_URI"]; // Get the URL of this page
$referer = $_SERVER['HTTP_REFERER']; // Get the referring URL
//echo '<p>this_url = ' . $this_url . ' ; referer = ' . $referer . '</p>';


$crlf = "\r\n";

// check for values from submitted form data; if not found, set defaults
$to_email = 'icon@crl.edu';
if (isset( $_POST['to_email']) ) {
  $to_email = stripslashes($_POST['to_email']); // where the feedback is sent
}
//echo '<p>to_email = ' . $to_email . '</p>';

$subject_email = '';
$about_page = 'About page: ';
if (isset( $_POST['about_page']) ) {
  $about_page = stripslashes($_POST['about_page']); // shd be the page they first clicked on the feedback link from, hidden in form page
  $subject_email = 'ICON feedback about: <' . $about_page . '>';
} else {
  $b_empty_fields = 1;
  $empty_fields_list = '<li class="empty_field">User came from bad page: submission rejected</li>';
}
//echo '<p>subject_email = ' . $subject_email . '</p>';

$from_name = 'your name';
if (isset( $_POST['from_name']) ) {
  $from_name = stripslashes($_POST['from_name']);
} else {
  $b_empty_fields = 1;
  $empty_fields_list = '<li class="empty_field">Your name</li>';
}
//echo '<p>from_name = ' . $from_name . '</p>';

$from_email = 'your email address';
if (isset( $_POST['from_email']) ) {
  $from_email = stripslashes($_POST['from_email']);
} else {
  $b_empty_fields = 1;
  $empty_fields_list = '<li class="empty_field">Your email</li>';
}
//echo '<p>from_email = ' . $from_email . '</p>';

$body_email = '';
if (isset( $_POST['body_email']) ) {
    $body_email .= $crlf . '[user gave name as: ' . $from_name . ']' ;
    $body_email .= $crlf . '[user gave email as: ' . $from_email . ']' ;
    $body_email .= $crlf . '[user clicked feedback link on page: ' . $about_page . ']';
    $body_email .= $crlf . '[user message follows]' . $crlf  . '----' . $crlf;
    $body_email .= stripslashes($_POST['body_email']);

    $body_email = wordwrap($body_email, 70);

    //look for spam strings
    if (
      strpos($body_email, '<a href') ||
      strpos($body_email, '</a>')
    ) {
      $b_spam = 1; //true
    }


} else {
  $b_empty_fields = 1;
  $empty_fields_list = '<li class="empty_field">Your message</li>';
}
//echo '<p>body_email = ' . $body_email . '</p>';
// end values from submitted form data vs. defaults


//echo 'b_form_submitted = "' . $b_form_submitted . '"; b_empty_fields = "' . $b_empty_fields . '"<br/>';
if ( ! $b_form_submitted ) { // display form 1st time on page, or when some fields not filled in
  include 'feedback_form.php';
} elseif ($b_empty_fields) { // some required fields missing
  $empty_fields_list = '<ul>' . $empty_fields_list . '</ul>';
  $empty_fields_message .= '<p>' . $empty_fields_message . $empty_fields_list . '</p>';
  echo $empty_fields_message; // some required field not filled in
  include 'feedback_form.php';
} else { // looks good, but: Stop the form being used from an external URL
    if ($referer != $this_url) { // referring URL + URL of this page don't match then display a message and don't send the email
        echo $not_allowed_message;
        exit; // don't send email
    } elseif( $b_spam ) { //checked body_email for occurences of strings that indicate use by a robot
        echo $spam_message;
        exit; // don't send email
    } else { // all required fields present and valid human user; do send email
      /*
      echo '<ul>';
      echo '<li>to_email: ' . $to_email . '</li>';
      echo '<li>return_path: ' . $to_email . '</li>';
      echo '<li>subject_email: ' . $subject_email . '</li>';
      echo '<li>body_email: ' . $body_email . '</li>';
      echo '<li>from_name: ' . $from_name . '</li>';
      echo '<li>from_email: ' . $from_email . '</li>';
      echo '</ul>';
      */

      /* bool mail ( string $to , string $subject , string $message [, string $additional_headers [, string $additional_parameters ]] )*/
      //$emailStatus = mail($to_email, $subject_email, $body_email, 'From: ' . $to_email . ', Return-Path: ' . $to_email); // the money line
      $emailStatus = mail('aelliott@crl.edu', $subject_email, $body_email, 'From: aelliott@crl.edu'); // the money line
      if ($emailStatus) echo $success_message;
      else echo str_replace('EMAIL_STATUS_CODE', $emailStatus, $failure_message);

    echo '<p>always sending just to one address during dev</p>'; /* till AWS fixed*/

  }// end else, mail
}//end else all fields presnt

?>

         </div><!--landing_content_text-->

        </div><!--landing_page_content-->

		</div><!--row contentArea-->

<!-- FOOTER -->
<?php include("footerCRL.html"); ?>

<?php include("help_selection_timeline.php"); ?>

<?php include("footer_script_tags.php"); ?>

<script>
$(document).ready(function() {
  $("#submit_feedback_button").click(function() {
    $("#feedback_form").submit();
  });

  $("#cancel_feedback_button").click(function() {
    window.close();
  });

  $("#feedback_link").click(function() {
    alert('new window for feedback');
    var url = 'digitization.php';
    var winTitle = 'feedbackWindow';
    var winOptions = 'toolbar=no,width=200,height=200,left=500,top=200, status=no, scrollbars=no, resize=no';
    window.open(url, winTitle, winOptions);
    /*return false;*/
  });
});//end doc.ready func
</script>

	</body>
</html>