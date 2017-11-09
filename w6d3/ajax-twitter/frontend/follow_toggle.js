const APIUtil = require("./api_util.js");

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
