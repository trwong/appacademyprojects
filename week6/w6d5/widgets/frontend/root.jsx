import React from 'react';
import Clock from './clock';
import Tab from './tab';
import Weather from './weather';

class Root extends React.Component {


  render() {
    let arr = [{"title": "one", "content": "I am the first"},
    {"title": "two", "content": "I am the second"},
    {"title": "three", "content": "I am the third"}];

    return (
      <div>
        <div><Clock /></div>
        <div><Tab array = {arr}/></div>
        <div><Weather /></div>
      </div>
    );
  }
}

export default Root;
