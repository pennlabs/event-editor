//= require moment.min.js
//= require jquery-ui.min.js
//= require jquery.timepicker.min.js

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

            var selected_button = $("#quick-buttons .btn.btn-primary");
            if (selected_button.length) {
                selected_button.click();
            }
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

        var date = moment($("#event_end_time").val(), "YYYY-MM-DD HH:mm:SS Z");
        $("#end_time_date").val(date.format("MM/DD/YYYY"));
        $("#end_time_time").val(date.format("h:mma"));
    }

    if ($("#event_start_time").val()) {
        var date = moment($("#event_start_time").val(), "YYYY-MM-DD HH:mm:SS Z");
        $("#start_time_date").val(date.format("MM/DD/YYYY"));
        $("#start_time_time").val(date.format("h:mma"));
    }

    $("#start_time_date, #end_time_date").datepicker();
    $("#start_time_time, #end_time_time").timepicker();

    $("form").submit(function() {
        var start = $("#event_start_time");
        var end = $("#event_end_time");
        if (start.length) {
            var sd = $("#start_time_date").val();
            var st = $("#start_time_time").val();
            if (sd && st) {
                start.val(moment(sd + " " + st + " 00 -0400", "MM/DD/YYYY h:mma ss Z").format("YYYY-MM-DD HH:mm:SS ZZ"));
            }
        }
        if (end.length) {
            var ed = $("#end_time_date").val();
            var et = $("#end_time_time").val();
            if (ed && et) {
                end.val(moment(ed + " " + et + " 00 -0400", "MM/DD/YYYY h:mma ss Z").format("YYYY-MM-DD HH:mm:SS ZZ"));
            }
        }
    });

    $("#quick-buttons .btn").click(function(e) {
        e.preventDefault();
        var raw = $(this).attr("data-value");
        if (raw == "other") {
            $("#quick-buttons .btn").removeClass("btn-primary").addClass("btn-light");
            $("#duration-wrapper").slideUp();
            $("#end-time-wrapper").slideDown();
            return;
        }
        if (!$("#start_time_time").val() || !$("#start_time_date").val()) {
            $("#start_time_time, #start_time_date").addClass("is-invalid");
            setTimeout(function() {
                $("#start_time_time, #start_time_date").removeClass("is-invalid");
            }, 500);
            return;
        }
        $("#quick-buttons .btn").addClass("btn-light").removeClass("btn-primary");
        $(this).addClass("btn-primary").removeClass("btn-light");
        var time = parseInt(raw);
        var start = moment($("#start_time_date").val() + " " + $("#start_time_time").val() + " 00 -0400", "MM/DD/YYYY h:mmA ss Z");
        var end = start.add(time, 'second');
        $("#end_time_date").val(end.format("MM/DD/YYYY"));
        $("#end_time_time").val(end.format("h:mma"));
        $("#event_end_time").val(end.format("YYYY-MM-DD HH:mm:SS ZZ"));
    });
});
