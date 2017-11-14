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
