// Keep the application light and dependencies small
// We could make the frontend stack as overkill as we want
// if we have complicated business requirements

const displayError = (message) => {
  var notification = document.getElementById('notification_placeholder');
  notification.removeChild();
  notification.insertAdjacentHTML(
    'beforeend',
    `<div class="notification is-danger">${message}</div>`
  )
}

const processForm = function(event) {
  event.preventDefault && event.preventDefault();
  // run manual validation first
  if (this.url.value === "") {
    displayError("URL can't be empty");
  }

  // Submit the URL through our API
  // We are already using input[type=url] to use HTML5 built-in validation
  return fetch('/api/shorten', {
    headers: new Headers({
      Accept: 'application/json',
      'Content-Type': 'application/json'
    }),
    method: 'POST',
    body: JSON.stringify({ url: '' })
  }).then(res => res.json()).
    then(data => {
      if (data.errors) {
        throw data.errors;
      } else {
        debugger
      }
    });
}

window.onload = function() {
  var form = document.getElementById('shorten_url');
  if (form.attachEvent) {
    form.attachEvent('submit', processForm);
  } else {
    form.addEventListener('submit', processForm);
  }
}
