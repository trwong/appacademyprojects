class Router {
  constructor(node, routes) {
    this.node = node;
    this.routes = routes;
  }

  start() {
    window.location.hash = "inbox";
    this.render();
    window.addEventListener("hashchange", this.render.bind(this));
  }

  activeRoute() {
    return this.routes[window.location.hash.slice(1)];
  }

  render() {
    this.node.innerHTML = "";
    let component = this.activeRoute();
    if (component) {
      const addMe = component.render();
      this.node.appendChild(addMe);

    }
    // const paragraph = document.createElement('p');
    // paragraph.innerText = this.activeRoute();
  }
}

module.exports = Router;
