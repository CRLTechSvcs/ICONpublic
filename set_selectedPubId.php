	<script>
			//Strip spaces out of the pub_id passed in from bib rec: PHP writes out the JS values
			<?php
				if (ISSET( $_REQUEST['pub_id']) ) {
					$selectedPubIdWithoutSpace = str_replace("%20", "", $_REQUEST['pub_id']);
					$selectedPubId = $_REQUEST['pub_id'];
				} else { //no pub_id
					$selectedPubIdWithoutSpace = 'no_pub_id';
					$selectedPubId = $selectedPubIdWithoutSpace;
				}
				if (ISSET( $_REQUEST['new_win']) ) {
					$newWin = $_REQUEST['new_win'];
					echo 'newWin = "' . $newWin . '";';
				}
				echo 'selectedPubIdWithoutSpace = "' . $selectedPubIdWithoutSpace .  '";';
				echo 'selectedPubId = "' . $selectedPubId .  '";';
			?>
			//alert(selectedPubId);
	</script>

