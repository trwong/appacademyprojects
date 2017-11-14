import React from 'react';

class Tab extends React.Component {
  constructor(args) {
    super();
    this.state = {
      title: args[0],
      content: args[1],
      index: 0
    };
  }

  changeClass(idx) {
    console.log(idx);
    document.querySelector(`.content-0`).classList.add('hide');
    document.querySelector(`.content-1`).classList.add('hide');
    document.querySelector(`.content-2`).classList.add('hide');
    document.querySelector(`.content-${idx}`).classList.remove('hide');

    document.querySelector(`.title-0`).classList.remove('selected');
    document.querySelector(`.title-1`).classList.remove('selected');
    document.querySelector(`.title-2`).classList.remove('selected');
    document.querySelector(`.title-${idx}`).classList.add('selected');
  }

  render() {
    return (
      <ul className="tabs-container">
        <div className="tabs-header">
          {
            this.props.array.map((el, idx) => (
            <h1 key={`title-${idx}`}
              onClick={() => this.changeClass(idx)}
              className={`title-${idx}`}>{el.title}</h1>
            ))
          }
        </div>
        <div className="tabs-body">
          {
            this.props.array.map((el, idx) => (
              <article key={`content-${idx}`} className={`content-${idx}`}>{el.content}</article>
            ))
          }
        </div>
      </ul>
    );
  }
}

export default Tab;
