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
    $("#event_start_time").change(function() {
        var val = $("#event_start_time").val();
        if (val) {
            val = new Date(Date.parse(val));
            var hrs = val.getHours();
            if (hrs > 12) {
                hrs -= 12;
            }
            var mins = val.getMinutes();
            if (mins < 10) {
                mins = "0" + mins;
            }
            $(".box-date").text("Today at " + hrs + ":" + mins + (hrs == val.getHours() ? 'am' : 'pm'));
        }
        else {
            $(".box-date").text("Today at 7:20pm");
        }
    });
    $("#events tbody tr").click(function(e) {
        e.preventDefault();
        if (!$(e.target).hasClass('btn-danger')) {
            Turbolinks.visit($(this).attr("data-link"));
        }
    });
    $("#events tbody tr .btn-success").click(function(e) {
        e.stopPropagation();
    });
    if ($("#event_start_time").length) {
        var start_time = flatpickr("#event_start_time", {
            enableTime: true,
            dateFormat: 'Y-m-d H:i:S'
        });
        start_time.changeMonth(3, false);
    }
    var end_time = flatpickr("#event_end_time", {
        enableTime: true,
        dateFormat: 'Y-m-d H:i:S'
    });

    if ($("#event_end_time").val()) {
        var diff = (Date.parse($("#event_end_time").val()) - Date.parse($("#event_start_time").val())) / 1000;
        var selected_button = $("#quick-buttons .btn[data-value='" + diff + "']");
        if (selected_button.length) {
            selected_button.addClass("btn-primary").removeClass("btn-light");
        }
        else {
            $("#end-time-wrapper").show();
            $("#duration-wrapper").hide();
        }
    }

    $("#quick-buttons .btn").click(function(e) {
        e.preventDefault();
        var raw = $(this).attr("data-value");
        if (raw == "other") {
            $("#duration-wrapper").slideUp();
            $("#end-time-wrapper").slideDown();
            return;
        }
        if (!$("#event_start_time").val()) {
            $("#event_start_time").addClass("is-invalid");
            setTimeout(function() {
                $("#event_start_time").removeClass("is-invalid");
            }, 500);
            return;
        }
        $("#quick-buttons .btn").addClass("btn-light").removeClass("btn-primary");
        $(this).addClass("btn-primary").removeClass("btn-light");
        var time = parseInt(raw);
        var start = Date.parse($("#event_start_time").val());
        var end = new Date(start + time * 1000);
        end_time.setDate(end);
    });
});
