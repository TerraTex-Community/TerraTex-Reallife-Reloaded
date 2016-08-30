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
    $("html").on("click", "#dblitzerall", function(){
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
    //@todo -- rework -> set values instead of html
    if ($("#map div[data-car-id='" + id + "']").length > 0) {
        $("#map div[data-car-id='" + id + "']").tooltip('dispose');
        $("#map div[data-car-id='" + id + "']").remove();
    }
    $("#map").append(html);

    //@todo: rework: they are not deleted correctly
    $("#map div[data-car-id='" + id + "']").tooltip({
        trigger: 'click'
    });
}

function setBlitzer(id, html) {
    //@todo -- rework -> set values instead of html
    if ($("#map div[data-blitzer-id='" + id + "']").length > 0) {
        $("#map div[data-blitzer-id='" + id + "']").tooltip('hide');
        $("#map div[data-blitzer-id='" + id + "']").remove();
    }

    $("#map").append(html);
    //@todo: rework: they are not deleted correctly
    $("#map div[data-blitzer-id='" + id + "']").tooltip({
        trigger: 'hover'
    });
}

function setJailPlayer(userName, jail, time, totalTime) {
    if ($("tr[data-nickname='" + userName + "']").length > 0) {
        var row = $("#jaillist tr[data-nickname='" + userName + "']");
        row.find("td:nth-child(1)").html(userName);
        row.find("td:nth-child(2)").html(jail);
        row.find("td:nth-child(3)").html(time);
        row.find("td:nth-child(4)").html(totalTime);
    } else {
        var html = "<tr data-nickname='" + userName + "'><td>" + userName + "</td><td>" + jail +"</td>" + "</td><td>" + time + "</td><td>" + totalTime + "</td></tr>";
        $("#jaillist tbody").append(html);
    }
}

function removeJailPlayer(userName) {
    $("#jaillist tr[data-nickname='" + userName + "']").remove();
}

function setJailPlayerAlka(userName) {
    $("#jaillist tr[data-nickname='" + userName + "']").addClass("bg-danger");
    var html = $("#jaillist tr[data-nickname='" + userName + "'] td:nth-child(2)").html();
    $("#jaillist tr[data-nickname='" + userName + "'] td:nth-child(2)").html(html + " (muss Alkatraz)");
}

function setSuspect(userName, crimeState, StVO) {
    if ($("#supspectlist tr[data-nickname='" + userName + "']").length > 0) {
        var row = $("tr[data-nickname='" + userName + "']");
        row.find("td:nth-child(2)").html(userName);
        row.find("td:nth-child(3)").html(crimeState);
        row.find("td:nth-child(4)").html(StVO);
    } else {
        var editButton = "<i class='fa fa-edit edit' title='Akte bearbeiten'></i>";
        var html = "<tr data-nickname='" + userName + "'><td>" + editButton + "</td><td>" + userName + "</td><td>" + crimeState +"</td>" + "</td><td>" + StVO + "</td></tr>";
        $("#supspectlist tbody").append(html);
    }
}
function removeSuspect(userName) {
    $("#supspectlist tr[data-nickname='" + userName + "']").remove();
}

function setSuspectAlka(userName) {
    $("#supspectlist tr[data-nickname='" + userName + "']").addClass("bg-danger");
    var html = $("#supspectlist tr[data-nickname='" + userName + "'] td:nth-child(3)").html();
    $("#supspectlist tr[data-nickname='" + userName + "'] td:nth-child(3)").html(html + " (muss Alkatraz)");
}