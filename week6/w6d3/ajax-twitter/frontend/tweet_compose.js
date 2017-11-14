const APIUtil = require("./api_util.js");

class TweetCompose{
  constructor(){
    $(".tweet-compose").on("submit", (data) => APIUtil.createTweet(data));
  }

  // submit(){
  //   .serializeJSON
  // }
}

module.exports = TweetCompose;
