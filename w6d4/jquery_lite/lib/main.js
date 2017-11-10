const DOMNodeCollection = require('./dom_node_collection.js');

window.$l = function $l(selector) {
  if (typeof selector === "string") {
    const query = document.querySelectorAll(selector);
    return Array.from(query);
  } else if (selector instanceof HTMLElement) {
    const htmlEl = [selector];
    return new DOMNodeCollection(htmlEl);
  }
};

const $l = window.$l;
