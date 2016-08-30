/**
 * Created by C5217649 on 12.08.2016.
 */
$(document).ready(function () {
    loadPage("overview");
    $('a[data-toggle="tab"]').click(function (e) {
        loadPage($(this).attr("data-page"));
    });

    $("html").on("click", "#dblitzer", function(){
        if ($("#dblitzer_id").val() == "" || $("#dblitzer_id").val() < 1) {
            $("#dblitzer_id").toggleClass("bg-danger", true);
        } else {
            $("#dblitzer_id").toggleClass("bg-danger", false);
            $.ajax("http://mta/local/ajax_policePC_dBlitzer.html?id=" + $("#dblitzer_id").val());
        }
    });
    $("html").on("click", "#dblitzer_all", function(){
        $("#dblitzer_id").toggleClass("bg-danger", false);
        $.ajax("http://mta/local/ajax_policePC_dBlitzer.html?id=all");
    });

});

function loadPage(id) {
    toggleContentLoader(true);
    $("#content").html("");
    $.ajax("http://mta/local/ajax_policePC_load_page.html?id=" + id);
}

function setContent(content) {
    $("#content").html(content);
    toggleContentLoader(false);
}

function toggleContentLoader(bool) {
    $("#page-loading").toggleClass("hidden-xs-up", !bool);
}

function setCar(id, html) {
    if ($("#map div[data-car-id='" + id + "']").length > 0) {
        $("#map div[data-car-id='" + id + "']").remove();
    }
    $("#map").append(html);
    $("#map div[data-car-id='" + id + "']").tooltip({
        container: 'body',
        trigger: 'click'
    });
}

function setBlitzer(id, html) {
    if ($("#map div[data-blitzer-id='" + id + "']").length > 0) {
        $("#map div[data-blitzer-id='" + id + "']").remove();
    }

    $("#map").append(html);
    $("#map div[data-blitzer-id='" + id + "']").tooltip({
        container: 'body',
        trigger: 'click'
    });
}

function setJailPlayer(userName, jail, time, totalTime) {
    if ($("tr[data-nickname='" + userName + "']").length > 0) {
        var row = $("tr[data-nickname='" + userName + "']");
        row.find("td:nth-child(1)").html(userName);
        row.find("td:nth-child(2)").html(jail);
        row.find("td:nth-child(3)").html(time);
        row.find("td:nth-child(4)").html(totalTime);
    } else {
        var html = "<tr data-nickname='" + userName + "'><td>" + userName + "</td><td>" + jail +"</td>" + "</td><td>" + time + "</td><td>" + totalTime + "</td></tr>";
        $("tbody").append(html);
    }
}

function removeJailPlayer(userName) {
    $("tr[data-nickname='" + userName + "']").remove();
}

function setJailPlayerAlka(userName) {
    $("tr[data-nickname='" + userName + "']").addClass("bg-danger");
}