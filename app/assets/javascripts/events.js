//= require flatpickr.min.js

$(document).on("turbolinks:load", function() {
    $("#event_name").keyup(function() {
        $(".box-title").text($(this).val() || "Your Title");
    });
    $("#event_description").keyup(function() {
        $(".box-desc").text($(this).val() || "Your Description");
    });
    $("#event_image").change(function() {
        if (this.files && this.files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                $(".img-wrapper img").css("background-image", "url(" + e.target.result + ")");
            };
            reader.readAsDataURL(this.files[0]);
        }
    });
    $("#events tbody tr").click(function(e) {
        e.preventDefault();
        Turbolinks.visit($(this).attr("data-link"));
    });
    $("#events tbody tr .btn").click(function(e) {
        e.stopPropagation();
    });
    $("#event_start_time, #event_end_time").flatpickr({
        enableTime: true,
        dateFormat: 'Y-m-d H:i:S'
    });
});
