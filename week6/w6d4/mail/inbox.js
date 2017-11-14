const MessageStore = require('./message_store.js');

const Inbox = {
  render: () => {
    let ul = document.createElement('ul');

    ul.className = 'messages';
    MessageStore.getInboxMessages.forEach( (msg) => {
      ul.appendChild(Inbox.renderMessage(msg));
    });
    // ul.innerHTML = 'An Inbox Message';
    return ul;
  },

  renderMessage: (msg) => {
    const li = document.createElement('li');
    li.className = "message";
    li.innerHTML = `
    <span class="from">${msg.from}</span>
    <span class="subject">${msg.subject}</span>
    <span class="body">${msg.body}</span>
    `;
    return li;
  }
};


module.exports = Inbox;

// {from: "grandma@mail.com", subject: "Fwd: Fwd: Fwd: Check this out",
// body: "Stay at home mom discovers cure for leg cramps. Doctors hate her"}
