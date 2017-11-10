class DOMNodeCollection {
  constructor(htmlEls) {
    this.htmlEls = htmlEls;
    this.registeredEvents = [];
  }

  html(string) {
    if (string) {
      this.htmlEls.forEach(function(el) {
        el.innerHTML = string;
      });
    } else {
      return this.htmlEls[0].innerHTML;
    }
  }

  empty() {
    this.htmlEls.forEach(function(el) {
      el.innerHTML = "";
    });
  }

  append(appendMe) {
    if (appendMe instanceof Array) {
      console.log('Array branch');
      appendMe.forEach( (appendObj) => {
        this.htmlEls.forEach( (el) => {
          el.innerHTML += appendObj.outerHTML;
        });
      });
    } else if (appendMe instanceof HTMLElement) {
      console.log('HTMLElement branch');
      this.htmlEls.forEach( (el) => {
        el.innerHTML += appendMe.outerHTML;
      });
    } else if (typeof appendMe === 'string') {
      console.log('string branch');
      this.htmlEls.forEach( (el) => {
        el.innerHTML += appendMe;
      });
    }
  }

  attr(name, value) {
    if (value === undefined) {
      for (let i = 0; i < this.htmlEls.length; i++) {
        return this.htmlEls[i].getAttribute(name);
      }
    } else {
      this.htmlEls.forEach( (el) => {
        console.log(el);
        el.setAttribute(name, value);
      });
    }
  }

  addClass(addMe) {
    this.htmlEls.forEach( el => {
      const currentClass = el.getAttribute("class");
      el.classList.add(addMe);
      // if (currentClass) {
      //   if (currentClass.includes(addMe)) return;
      //   el.setAttribute("class", currentClass + addMe);
      // } else {
      //   el.setAttribute("class", addMe);
      // }
    });
  }

  removeClass(removeMe) {
    this.htmlEls.forEach( el => {
      const currentClass = el.getAttribute("class");
      el.classList.remove(removeMe);
    });
  }

  children() {
    const childrenArray = [];
    this.htmlEls.forEach( el => {
      const kiddos = el.children;
      for (let i = 0; i < kiddos.length; i++) {
        childrenArray.push(kiddos[i]);
      }
    });
    return new DOMNodeCollection(childrenArray);
  }

  parent() {
    const parentArray = [];
    this.htmlEls.forEach( el => {
      parentArray.push(el.parentNode);
    });
    return new DOMNodeCollection(parentArray);
  }

  find(target) {
    const selectedArray = [];
    this.htmlEls.forEach ( el => {
      el.querySelectorAll(target).forEach((foundTarget) => {
        selectedArray.push(foundTarget);
      });
    });
    return new DOMNodeCollection(selectedArray);
  }

  remove() {
    this.htmlEls.forEach( (el) => {
      el.outerHTML = "";
    });
    this.htmlEls = [];
  }

  stringifyCallbacks() {
    return this.registeredEvents.map((el) => el.toString());
  }

  on(eventName, callback) {
    // if (this.stringifyCallbacks().includes(callback.toString())) {
    //   return; // escape instead of re-registering same callback
    // }
    this.registeredEvents.push(callback);
    this.htmlEls.forEach( (el) => {
      el.addEventListener(eventName, callback);
    });
  }

  off(eventName, callback) {
    // console.log(string);
    let originalCallbackIdx = this.stringifyCallbacks().indexOf( callback.toString() );
    console.log(originalCallbackIdx);
    let originalCallback = this.registeredEvents[originalCallbackIdx];
    console.log(originalCallback);
    this.htmlEls.forEach( (el) => {
      el.removeEventListener(eventName, originalCallback);
    });
  }
}


module.exports = DOMNodeCollection;
