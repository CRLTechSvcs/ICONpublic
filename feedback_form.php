<!--AJE 2014-04-07 begin feedback_form.php; included in feedback.php-->
<div id="feedback_form_div" title="Send feedback to ICON team">
  <form action="<?php echo $_SERVER['REQUEST_URI']; ?>" method="post"  id="feedback_form" name="feedback_form" class="window" enctype="application/x-www-form-urlencoded">

    <!--hidden fields here-->
    <input name="to_email" type="hidden" value="<?php echo $to_email; ?>" />
    <input name="subject_email" type="hidden" value="<?php echo $subject_email; ?>" />
    <input name="about_page" type="hidden" value="<?php echo $HTTP_REFERER; ?>" />

    <div class="six columns float left">
      <input type="text" name="from_name" id="from_name" title="<?php echo $from_name; ?>" placeholder="<?php echo $from_name; ?>"  class="text ui-widget-content ui-corner-all" />
    </div>
    <div class="six columns float right">
      <input name="from_email" type="text" title="<?php echo $from_email; ?>" placeholder="<?php echo $from_email; ?>"  class="text ui-widget-content ui-corner-all" />
    </div>

    <div class="twelve columns">
	    <textarea name="body_email" cols="50" rows="2" wrap="virtual"></textarea>
    </div>
  </form>

<div class="six columns">
  <div id="submit_feedback_button" class="feedback_button">Send ICON feedback</div>
</div>

<div class="six columns">
  <div href="#" id="cancel_feedback_button" class="feedback_button">Cancel, close window</div>
</div>


</div>
<!--end feedback_form.php-->
