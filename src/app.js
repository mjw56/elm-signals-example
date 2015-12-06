import Elm from './Main.elm';

function App() {
	let req = 0;
	let messages = [`hello world ${req}`];
	
	function init() {
	  const root = document.getElementById('root');
	  const app = Elm.embed(Elm.Main, root, { newMessages: [] });

	  app.ports.newMessages.send(messages);

	  app.ports.updateRequests.subscribe(function (value) {
	    messages.push(`hello world ${req += 1}`);
	    app.ports.newMessages.send(messages);
	  });
	}

	return {
		init: init
	}
}

const app = App();
app.init();