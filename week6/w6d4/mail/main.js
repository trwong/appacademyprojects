const Router = require("./router.js");
const Inbox = require("./inbox.js");
const Sent = require("./sent.js");

const routes = {
  inbox: Inbox,
  sent: Sent
};

function registerNavClick(el) {
  window.location.hash = el.innerText.toLowerCase();
}

document.addEventListener("DOMContentLoaded", (event) => {
  // register click events for nav buttons;
  Array.from(document.querySelector('.sidebar-nav').children).forEach( child => {
    child.addEventListener("click", () => registerNavClick(child));
  });

  //
  const content = document.querySelector('.content');
  const router = new Router(content, routes);
  router.start();
});
