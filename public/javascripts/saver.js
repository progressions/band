var Saver = {
  init: function() {
    Saver.scanner = new PeriodicalExecuter(Saver.update, 5);
  },
  
  update: function() {
    $('new_blog').request({
      onComplete: function() {
        // console.log("saved");
      }
    });
  }
};


document.observe("dom:loaded", function() {
  Saver.init();
});