const APIUtil = require('./api_util.js');
const FollowToggle = require('./follow_toggle.js');

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
