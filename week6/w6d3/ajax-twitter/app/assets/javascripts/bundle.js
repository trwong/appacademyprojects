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

const FollowToggle = __webpack_require__(1);
const UsersSearch = __webpack_require__(3);
const TweetCompose = __webpack_require__(!(function webpackMissingModule() { var e = new Error("Cannot find module \"./tweet-compose.js\""); e.code = 'MODULE_NOT_FOUND'; throw e; }()));

$(() => {
  $('.follow-toggle').each((i,el)=> {
    new FollowToggle(el);
  });

  $('.users-search').each((i,el) => {
    new UsersSearch(el);
  });
});


/***/ }),
/* 1 */
/***/ (function(module, exports, __webpack_require__) {

const APIUtil = __webpack_require__(2);

class FollowToggle{
  constructor(el){
    this.userId = el.dataset["userId"];
    this.followState = el.dataset["initialFollowState"];
    this.$el = $(el);
    this.render();
    this.handleClick();
  }

  render(){
    if (this.followState === "false") {
      this.$el.text("Follow!");
      this.$el.prop("disabled", false);
    }else if(this.followState === "following"){
      this.$el.text("Following....");
      this.$el.prop("disabled", true);
    }else if(this.followState === "unfollowing"){
      this.$el.text("Unfollowing...");
      this.$el.prop("disabled", true);
    }else{
      this.$el.text("Unfollow!");
      this.$el.prop("disabled", false);
    }
  }

  handleClick(){
    this.$el.on("click",(event)=>{
      event.preventDefault();
      let success = () => {
        this.followState = (this.followState === "unfollowing" ? "false" : "true");
        this.render();
      };
      if (this.followState === "true") {
        this.followState = "unfollowing";
        this.render();
        APIUtil.unfollowUser(this.userId).then(success);
      } else {
        this.followState = "following";
        this.render();
        APIUtil.followUser(this.userId).then(success);
      }
    });
  }
}

module.exports = FollowToggle;


/***/ }),
/* 2 */
/***/ (function(module, exports) {

const APIUtil = {
  followUser: id => {
      // console.log(id);
    return $.ajax({
      method: "POST",
      dataType: "json",
      url: `/users/${id}/follow`
    });
  },
  unfollowUser: id => {
    // console.log(id);
    return $.ajax({
      method: "DELETE",
      dataType: "json",
      url: `/users/${id}/follow`
    });
  },

  searchUsers: (queryVal, success) => {
    return $.ajax({
      method: "GET",
      url: "/users/search",
      dataType: "json",
      data: {
        query: queryVal
      },
      success: success
    });
  },

  createTweet: (data) => {
    return $.ajax({
      method:"POST",
      url:"/tweets",
      dataType:"json",
      data: data
    });
  }
};

module.exports = APIUtil;


/***/ }),
/* 3 */
/***/ (function(module, exports, __webpack_require__) {

const APIUtil = __webpack_require__(2);
const FollowToggle = __webpack_require__(1);

class UsersSearch{
  constructor(el){
    this.$el = $(el);
    this.$input = this.$el.children("input");
    this.$ul = this.$el.children("ul");
    this.handleInput();
  }

  handleInput(){
    let search = () => APIUtil.searchUsers(this.$input.val(), (res) => {
      this.renderResults(res);});
    this.$el.on("input", search);
  }

  renderResults(res) {
    this.$ul.empty();
    res.forEach((obj) => {
      let $li = $(`<li><a href="./${obj.id}">${obj.username}</a></li>`);
      this.$ul.append($li);
      let $button = $(`<button type="button"
      class="follow-toggle"
      data-initial-follow-state="${obj.followed}"
      data-user-id ="${obj.id}">
      </button>`);
      $li.append($button);
    });
    $('.follow-toggle').each((i,el)=> {
      new FollowToggle(el);
    });
  }
}

module.exports = UsersSearch;


/***/ })
/******/ ]);
//# sourceMappingURL=bundle.js.map