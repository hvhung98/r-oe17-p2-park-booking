$(document).ready(function() {
  $("#livesearch_input").hsearchbox({
    url: $("#livesearch_form").attr("action"),
    param: "search",
    dom_id: "#livesearch_dom",
    loading_css: "#livesearch_loading",
    onInitSearch: function() {
      console.log("search init:" + this.url);
    },
    onStartSearch: function() {
      console.log("search start");
    },
    onFinishSearch: function() {
      console.log("search finish");
    }
  });
  $("#livesearch_parking_input").hsearchbox({
    url: $("#livesearch_parking_form").attr("action"),
    param: "search",
    dom_id: "#livesearch_parking_dom",
    loading_css: "#livesearch_parking_loading",
    onInitSearch: function() {
      console.log("parking init:" + this.url);
    },
    onStartSearch: function() {
      console.log("parking start");
    },
    onFinishSearch: function() {
      console.log("parking finish");
    }
  });

});
