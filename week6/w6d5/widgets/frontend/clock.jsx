import React from 'react';

class Clock extends React.Component {
  constructor() {
    super();
    this.state = {
      time: new Date()
    };
  }

  componentDidMount() {
    this.handle = setInterval(this.tick.bind(this) ,1000);
  }

  componentWillUnmount() {
    clearInterval(this.handle);
    this.handle = 0;
  }

  displayTime() {
    return `${this.state.time.getHours()}:${this.state.time.getMinutes()}:${this.state.time.getSeconds()}`;
  }

  displayDate() {
    var monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "June",
      "July", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];

    var weekday=new Array(7);
    weekday[1]="Mon";
    weekday[2]="Tue";
    weekday[3]="Wed";
    weekday[4]="Thur";
    weekday[5]="Fri";
    weekday[6]="Sat";
    weekday[0]="Sun";

    return `${weekday[this.state.time.getDay()]} ${monthNames[this.state.time.getMonth()]} ${this.state.time.getDate()} ${this.state.time.getFullYear()}`
  }

  render() {
    return (
      <h1>
        Clock
        <div className="clock">
        Time: {this.displayTime()}
        <br />
        Date: {this.displayDate()}
        </div>
      </h1>
    );
  }

  tick() {
    this.setState({time: new Date()});
  }
}

// module.exports = Clock;
export default Clock;
