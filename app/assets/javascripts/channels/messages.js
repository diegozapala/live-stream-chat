/* App.cable.subscriptions.create('MessagesChannel', {
  alert('teste')
  received: function(data) {
    var list      = $('.numbers');
    var thread    = $('.thread');
    var number    = thread.data('number');
    var latest    = $('.message[data-number="'+data.number+'"]');

    // prepend to message thread
    if (thread.length &&
        data.number == number) thread.prepend(data.html);

    // prepend to list of ongoing threads
    if (list.length) {
      latest.remove();
      list.prop(data.html);
    }

    $('.message:first').transition('flash');
  }
}); #/
