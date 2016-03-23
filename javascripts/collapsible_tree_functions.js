var margin = width = height = null;

var i = 0,
    duration = 750,
    root,
    tree,
    diagonal,
    svg;

var parentCount = 0;

function displayGenealogyVisualization(obj,newwin) {
	var displayElementString = null;
	if (newwin == false) {
		//Called from calendar.php
		displayElement = "#genealogyTab";
	} else {
		//Called from genealogy.php
		displayElement = "#genealogy_container";
	}
	root = JSON.parse(obj);
	parentCount = countLevels(root);
	margin = {top: 20, right: root.title.length > 30 ? 210 : root.title.length * 5 + 20, bottom: 20, left: root.title.length > 30 ? 210 : root.title.length * 5 + 20};
  //width = parentCount == 1 ? 600 : (parentCount * 220) - margin.right - margin.left;
  //width = (parentCount * 220);
 	width = (parentCount * 240) - margin.right - margin.left,
  //Height will need to be adjusted based on total number of sibling nodes
  height = 200 - margin.top - margin.bottom;

	tree = d3.layout.tree()
  				 .size([height, width]);

	diagonal = d3.svg.diagonal()
  						 .projection(function(d) { return [d.y, d.x]; });

	//svg = d3.select("#genealogyTab")
	svg = d3.select(displayElement)
					.append("svg")
  				.attr("width", width + margin.right + margin.left)
  				.attr("height", height + margin.top + margin.bottom)
					.append("g")
  				.attr("transform", "translate(" + margin.left + "," + margin.top + ")");

  root.x0 = 0;
  root.y0 = 0;

  function collapse(d) {
    if (d.children) {
      d._children = d.children;
      d._children.forEach(collapse);
      d.children = null;
    }
  }

  //Adding a 'firstNode' property to top object in JSON data and setting it equal to "true"
	//positions its title to the left of its node circle, whether or not its child nodes are collapsed
  root.firstNode = "true";

  update(root);

}

//d3.select(self.frameElement).style("height", "80px");

function update(source) {

  // Compute the new tree layout.
  var nodes = tree.nodes(root).reverse(),
      links = tree.links(nodes);

  // Normalize for fixed-depth.
  nodes.forEach(function(d) {
  	//console.log(d.title);
  	d.y = d.depth * 180;
  });

  // Update the nodes…
  var node = svg.selectAll("g.node")
      .data(nodes, function(d) {
      	//console.log(d3.max(d.title.length));
      	return d.id || (d.id = ++i);
      });

  // Enter any new nodes at the parent's previous position.
  var nodeEnter = node.enter().append("g")
      .attr("class", "node")
      .attr("transform", function(d) { return "translate(" + source.y0 + "," + source.x0 + ")"; })
      .on("click", circle_click);

  nodeEnter.append("circle")
      .attr("r", 1e-6)
      .style("fill", function(d) { return d._children ? "#675F7F" : "#fff"; });

   nodeEnter.append("text")
			.attr("x", 0)
      .attr("dy", "20px")
      .attr("text-anchor", function(d,i) {
      	if (d.firstNode == "true") {
      		//Topmost data object, hence leftmost node - so position title to the left
      		return "end";
      	} else if (!d.children && !d._children) {
      		//Nested non-parent node, so position title to the right
      		return "start";
      	} else {
      		//Nested parent node, so position title directly under circle
      		return "middle";
      	}
      })
      .text(function(d,i) {
        //AJE 2013-11-20 if this section executes, truncates pub_title
      	if (d.title.length > 30) {
          return d.title.substr(0,30); //original CJ
      	} else {
      		return d.title;
      	}
    	})
      .style("fill-opacity", 1e-6)
      .attr("title", function(d) {
      	if (d.title.length > 30) {
      		return d.title;
      	}
      })
      //Add 'show more' text in case title exceeds 30 characters
      .append('tspan')
      .text('more...')
      .attr('class','show_more')
      .attr('font-style','italic')
      .attr('font-size','10px') // ORIG
      .attr('fill','#6F6F6F')
      .attr('display','none')
      .attr('dx','5px')
      .attr('dy','0px');

/*
//AJE 2013-11-20 added this after:
http://stackoverflow.com/questions/14951392/add-hyperlink-to-node-text-on-a-collapsible-tree
http://bl.ocks.org/serra/5012770
/
nodeEnter
    .append("a")
        // AJE: note d.id attribute in next line appears to show order items added to tree?
       //.attr("xlink:href", function (d) { return "calendar.php?pub_id=my_pub_id" + d.id; })
       .attr("xlink:href", function (d) { return "calendar.php?pub_id=" + d.relationship_to_pub_id; })
    .append("rect")
        .attr("class", "clickable")

        //.attr("y", -6)
        //.attr("x", function (d) { return d.children || d._children ? -60 : 10; })
        .attr("y", 12)
        .attr("x", function (d) { return d.children || d._children ? -30 : -10; })

        //.attr("width", 50) //2*4.5) //ORIG
        //.attr("height", 12) //ORIG
        //.attr("width", function (d) { return d.title.length * 2; }) //AJE: works a little
        .attr("width", function (d) { return d.title.length * 6; }) //AJE: works a little
        //.attr("width", function (d) { return d.parent.width; }) //AJE:  d.parent is undefined
        //.attr("width", function (d) { return d.parentNode.width; }) //AJE:  d.parentNode is undefined
        //.attr("width", function (d) { return d.children.width; }) //AJE:  d.children is null
        //.attr("width", function (d) { return d._parent.width; }) //AJE:  d._parent is undefined
        //.attr("width", function (d) { return node.parent.width; }) //AJE: node.parent is undefined
        .attr("height", 12)

        .style("fill", "lightsteelblue")
        .style("fill-opacity", .3)        // set to 1e-6 to hide
        ;
////////////////////////////////////////////////////// end AJE 2013-11-20 */





  // Transition nodes to their new position.
  var nodeUpdate = node.transition()
      .duration(duration)
      .attr("transform", function(d) { return "translate(" + d.y + "," + d.x + ")"; });

  nodeUpdate.select("circle")
      .attr("r", 4.5)
      .style("fill", function(d) { return d._children ? "#675F7F" : "#fff"; });

  nodeUpdate.select("text")
      .style("fill-opacity", 1);

  nodeUpdate.select(".show_more")
  		//Display 'show more' text if necessary
      .attr("display", function(d) {
      	if (d.title.length > 30) {
      		return "block";
      	} else {
      		return "none";
      	}
      });

  // Transition exiting nodes to the parent's new position.
  var nodeExit = node.exit().transition()
      .duration(duration)
      .attr("transform", function(d) { return "translate(" + source.y + "," + source.x + ")"; })
      .remove();

  nodeExit.select("circle")
      .attr("r", 1e-6);

  nodeExit.select("text")
      .style("fill-opacity", 1e-6);

  // Update the links…
  var link = svg.selectAll("path.genealogy_link")
      .data(links, function(d) { return d.target.id; });

  // Enter any new links at the parent's previous position.
  link.enter()
  		.insert("path", "g")
      .attr("class", "genealogy_link")
      //.attr("marker-end", "url(#arrowhead)")
      .attr("d", function(d) {
        var o = {x: source.x0, y: source.y0};
        return diagonal({source: o, target: o});
      });

   /*
   //Display relationship type near links
   var relationshipLabels = svg.selectAll("g.link")
    .data(links, function(d) { return d.target.id; })
    .enter().append("g")
    .attr("class", "relationship_label");

		relationshipLabels.append("path")
    .attr("class", "relationship_label")
    .attr("d", diagonal);

		relationshipLabels.append("text")
    .attr("x", function(d) { return (d.source.x + d.target.x) / 2; })
    .attr("y", function(d) { return (d.source.y + d.target.y) / 2; })
    .attr("dy", "-20px")
    .attr("text-anchor", "middle")
    .text(function(d) {
        return d.target.rel_type_description;
    });
		*/

  // Transition links to their new position.
  link.transition()
      .duration(duration)
      .attr("d", diagonal);

  // Transition exiting nodes to the parent's new position.
  link.exit()
  		.transition()
      .duration(duration)
      .attr("d", function(d) {
        var o = {x: source.x, y: source.y};
        return diagonal({source: o, target: o});
      })
      .attr("marker-end", null)
      .remove();

  // Stash the old positions for transition.
  nodes.forEach(function(d) {
    d.x0 = d.x;
    d.y0 = d.y;
  });
}

// Toggle genealogy children on click.
function circle_click(d) {
  if (d.children) {
    d._children = d.children;
    d.children = null;
  } else {
    d.children = d._children;
    d._children = null;
  }
  update(d);
}
function countLevels(obj) {
 	//Return number of nested levels in JSON relationships data
 	//Use this number to set width of D3 tree layout
 	//From: http://stackoverflow.com/questions/11922383/access-process-nested-objects-arrays-or-json
  var result = [];
  for (var prop in obj) {
  		if (prop == 'title') {
  			parentCount++;
  		}
      var value = obj[prop];
      if (typeof value === 'object') {
          result.push(countLevels(value)); // <- recursive call
      }
      else {
          result.push(value);
      }
  }
  return parentCount;
}

