// Keep the application light and dependencies small
// We could make the frontend stack as overkill as we want
// if we have complicated business requirements

const displayError = (message) => {
  var helpBlock = document.getElementById('help_block');
  helpBlock.innerHTML = message;
  helpBlock.classList.add('is-danger');
  var inputUrl = document.querySelector('[name="url"]');
  inputUrl.classList.add('is-danger');
}

const processForm = function(event) {
  event.preventDefault && event.preventDefault();

  var url = this.url.value;
  // run manual validation first
  if (url === "") {
    displayError("URL can't be empty");
  }

  // Submit the URL through our API
  // We are using input[type=url] to use HTML5 built-in validation
  return fetch('/api/shorten', {
    headers: new Headers({
      Accept: 'application/json',
      'Content-Type': 'application/json'
    }),
    method: 'POST',
    body: JSON.stringify({ url: url })
  }).
    then(res => res.json()).
    then(data => {
      if (data.errors) {
        throw new Error(data.errors.url);
      } else {
        window.location.reload();
      }
    }).
    catch(error => {
      displayError(error.message);
    });
}

window.onload = function() {
  var form = document.getElementById('shorten_url');
  if (form) {
    if (form.attachEvent) {
      form.attachEvent('submit', processForm);
    } else {
      form.addEventListener('submit', processForm);
    }
  }
}
