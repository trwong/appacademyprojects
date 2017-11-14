const MessageStore = require('./message_store.js');

const Sent = {
  render: () => {
    let ul = document.createElement('ul');

    ul.className = 'messages';
    MessageStore.getSentMessages.forEach( (msg) => {
      ul.appendChild(Sent.renderMessage(msg));
    });
    // ul.innerHTML = 'An Inbox Message';
    return ul;
  },

  renderMessage: (msg) => {
    const li = document.createElement('li');
    li.className = "message";
    li.innerHTML = `
    <span class="to">${msg.to}</span>
    <span class="subject">${msg.subject}</span>
    <span class="body">${msg.body}</span>
    `;
    return li;
  }
};


module.exports = Sent;
