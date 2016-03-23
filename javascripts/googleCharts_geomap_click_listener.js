
/*
  2014-09-24 test interactive map:
    just like ex. from: https://developers.google.com/chart/interactive/docs/basic_interactivity
    where they put the function in the other function, even though I hate that */
        function selectHandler() {
          //alert('welcome to geomap selectHandler: it is ' + regionClick.region);
          var shDebug = 'blort esr';
          //var selectedItem = chart.getSelection()[0];
          var selectedItem = geomap.getSelection()[0];


         // shDebug += '\nthere are ' + selectedItem.length + ' elements in ' + selectedItem;
//console.log(shDebug);

          if (selectedItem) {
            //var topping = data.getValue(selectedItem.row, 0);
            //var topping = googleChartData.getValue(selectedItem.row, 0);
            var region = googleChartData.getValue(selectedItem.row, 0);
            shDebug += '\nThe user selected ' + region;
          }
          else {
            shDebug += '\nsorry, no selection was sensed for selectedItem = ' +selectedItem;
          }
//console.log(shDebug);
        }//end selectHandler

        google.visualization.events.addListener(geomap, 'regionClick', selectHandler);
        //alert('there is a handler in Gilead');
// end interactive test