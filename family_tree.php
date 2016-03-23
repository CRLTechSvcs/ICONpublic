<?php
	/*
		family_tree.php
		v.1: AJE: 2013-06-13 14:40:20
		- first version of minimal_get_genealogy_info.php works with NON-numeric pub_ids (sn92060570)
			(generates arrays for JSON object, represents root, child, grandhild objects for family tree display in ICON system)

		- if publications.pub_id or bib_relationships.relationship_[to/from]_pub_id ARE NUMERIC (2003260225)
			then this will fail:
				- up to now all the family_tree properties are stored in multidimensional arrays
				- with string keys
				- which are converted to int keys at every step of the way now matter how many casts to string are done
				- http://us.php.net/language.types.array.php
					"Strings containing valid integers will be cast to the integer type. E.g. the key "8" will actually be stored under 8. On the other hand "08" will not be cast, as it isn't a valid decimal integer."
					http://stackoverflow.com/questions/4100488/a-numeric-string-as-array-key-in-php

		- so we will define an object and use that

	*/


$family_tree = array(); //each of the publication objects will be added to family_tree; it also gets worked on in the calling page

class publication
{

		//values from database
	public $pub_id;
	public $relationship_from_pub_id;
	public $rel_type_id;
	public $rel_type_description;
	public $relationship_to_pub_id;
	public $pub_title;
	public $title; //copy of pub_title for CJ's D3/JSON
	public $control_num;
	public $ISSN;
	public $pub_city;
	public $country_id;
	public $pub_bgnDate;
	public $pub_endDate;
		//end values from database
	public $siblings;
	public $children; //will be another whole publication
	public $grandchildren; //will be another whole publication

	public function __construct(){
		global $family_tree;
		array_push($family_tree, $this);
		//$strDebug = '<p>construct...family_tree has '. count($family_tree) . ' elements.</p>';
	}//end construct

		/*
			baby is learning: double underscore in front of functions means that when we do, for ex.
				$requestedTitle->pub_id = $pub_id;
				$instanceOfClass->property = $value;
			the member function is implicitly called.  This is better than: $requestedTitle->set_pub_id($pub_id); //with no underscores
		*/
	public function __set_pub_id($input){ $this->pub_id = (string)$input; }
	public function __set_pub_title($input){ $this->pub_title = (string)$input; }
	public function __set_title($input){ $this->title = (string)$input; }
	public function __set_control_num($input){ $this->control_num = (string)$input; }
	public function __set_ISSN($input){ $this->ISSN = (string)$input; }
	public function __set_pub_city($input){ $this->pub_city = (string)$input; }
	public function __set_country_id($input){ $this->country_id = (string)$input; }
	public function __set_pub_bgnDate($input){ $this->pub_bgnDate = (string)$input; }
	public function __set_pub_endDate($input){ $this->pub_endDate = (string)$input; }
	public function __set_relationship_from_pub_id($input){ $this->relationship_from_pub_id = (string)$input; }
	public function __set_rel_type_id($input){ $this->rel_type_id = (string)$input; }
	public function __set_rel_type_description($input){ $this->rel_type_description = (string)$input; }
	public function __set_relationship_to_pub_id($input){ $this->relationship_to_pub_id = (string)$input; }
  public function __set_children($input){ //different from other setters: gets array of other publication objects
  	$this->children = $input;
  }

	public function __get_pub_id(){ return $this->pub_id; }
	public function __get_pub_title(){ return $this->pub_title; }
	public function __get_control_num(){ return $this->control_num; }
	public function __get_ISSN(){ return $this->ISSN; }
	public function __get_pub_city(){ return $this->pub_city; }
	public function __get_country_id(){ return $this->country_id; }
	public function __get_pub_bgnDate(){ return $this->pub_bgnDate; }
	public function __get_pub_endDate(){ return $this->pub_endDate; }
	public function __get_relationship_from_pub_id(){ return $this->relationship_from_pub_id; }
	public function __get_rel_type_id(){ return $this->rel_type_id; }
	public function __get_rel_type_description(){ return $this->rel_type_description; }
	public function __get_relationship_to_pub_id(){ return $this->relationship_to_pub_id; }


}//end publication definition



?>