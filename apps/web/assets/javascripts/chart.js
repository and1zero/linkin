var ctx = document.getElementById('chart_canvas').getContext('2d');
var error = document.getElementById('error');

// Get the data from our API
fetch(`//${window.location.host}/api${window.location.pathname}`).
  then(function(res) { return res.json(); }).
  then(function(data) {
    if (data.clicks) {
      // let's render the chart
      let clickData = [];

      // We need to populate the data for the last 30 minutes
      // for demo purposes - minute aggregation is too granular,
      // but we don't want to wait for hours for the graph to render
      const clicks = data.clicks.map(function(click) {
        return moment(click.timestamp);
      });
      let timestamp = moment().add(1, 'm');
      let count = 0;
      while (clickData.length < 30) {
        count = 0;
        timestamp = timestamp.clone().subtract(1, 'm');
        // check if there is any clicks in this timestamp
        clicks.forEach(function(click) {
          if (click.isSame(timestamp, 'minute')) {
            count += 1;
          }
        });

        clickData.push({
          t: timestamp,
          y: count
        });
      }

      var chart = new Chart(ctx, {
        responsive: true,
        // The type of chart we want to create
        type: 'line',
        data: {
          datasets: [{
            label: 'Clicks',
            data: clickData
          }]
        },
        options: {
          scales: {
            xAxes: [{
              type: 'time',
              time: {
                unit: 'minute'
              },
              ticks: {
                source: 'labels'
              }
            }],
            yAxes: [{
              scaleLabel: {
                display: true,
                labelString: 'Clicks'
              },
              ticks: {
                beginAtZero: true
              }
            }]
          }
        }
      });

      return chart;
    } else {
      throw 'No clicks data found';
    }
  }).
  catch(function(error) {
    console.error(error);
    error.innerHTML = `<div class="notification is-error">${error}</div>`;
  });
