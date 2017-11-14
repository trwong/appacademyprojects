import React from 'react';

const toQueryString = (obj) => {
  let parts = [];
  for (let i in obj) {
      if (obj.hasOwnProperty(i)) {
          parts.push(`${encodeURIComponent(i)}=${encodeURIComponent(obj[i])}`);
      }
  }
  return parts.join('&');
};

class Weather extends React.Component {

  constructor () {
    super();
      this.state = {
        weather: null
      };
      this.currentLocation = this.currentLocation.bind(this);
  }

  componentDidMount() {
    navigator.geolocation.getCurrentPosition(this.currentLocation);
  }

  currentLocation(location) {
    var latitude = location.coords.latitude;
    var longitude = location.coords.longitude;
    var url = 'http://api.openweathermap.org/data/2.5/weather?';
    var params = {
      lat: latitude,
      lon: longitude
    };
    url += toQueryString(params);
    const apiKey = '7b191acdc474a400d2ed1ff8ebdd7d4d';
    url += `&APPID=${apiKey}`;

    var xmlhttp = new XMLHttpRequest ();
    xmlhttp.onreadystatechange = () => {
      if (xmlhttp.readyState === XMLHttpRequest.DONE && xmlhttp.status === 200) {
        const data = JSON.parse(xmlhttp.responseText);
        this.setState({weather: data});
      }
    };
    xmlhttp.open("GET", url, true);
    xmlhttp.send();
  }

  render() {

    let content = <div></div>;

    if (this.state.weather) {
      let weather = this.state.weather;
      let temp = (weather.main.temp - 273.15) * 1.8 + 32;
      content = <div>
                  <p>{weather.name}</p>
                  <p>{temp.toFixed(1)} degrees</p>
                </div>;
    } else {
      content = <div className='loading'>loading weather...</div>;
    }

      return (
      <div>
        <h1>Weather</h1>
        <div className='weather'>
          {content}
        </div>
      </div>
    );
  }
}

export default Weather;
