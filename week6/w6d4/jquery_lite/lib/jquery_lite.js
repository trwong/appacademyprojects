/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

const DOMNodeCollection = __webpack_require__(1);

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


/***/ }),
/* 1 */
/***/ (function(module, exports) {

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


/***/ })
/******/ ]);