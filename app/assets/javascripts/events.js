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
                $(".img-wrapper img").attr("src", e.target.result);
            };
            reader.readAsDataURL(this.files[0]);
        }
    });
});
