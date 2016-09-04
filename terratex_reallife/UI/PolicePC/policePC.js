/**
 * Created by C5217649 on 12.08.2016.
 */
$(document).ready(function () {
    loadPage("overview");
    $('a[data-toggle="tab"]').click(function (e) {
        loadPage($(this).attr("data-page"));
    });

    $("html").on("click", ".editAkte", function(){
        var who = $(this).parent().parent().attr("data-nickname");
        loadPage("PlayerCrimeList", who);
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

    //Filterfunctions
    $("html").on("click", "#filterCategoryEntryList a", function(){
        var category = $(this).attr("data-value");
        var categoryText = $(this).html();

        $("#filterCategory").html(categoryText);
        $("#filterCategory").attr("data-value", category);

        if (category == -1) {
            $("table#crimeList thead, table#crimeList tbody").show();
        } else {
            $("table#crimeList thead, table#crimeList tbody").hide();
            $("table#crimeList thead[data-category='" + category + "'], table#crimeList tbody[data-category='" + category + "'] ").show();
        }
        $("thead#head").show();
    });

    $(document).on("keyup", "#filterCrimes", function(){
        var text = $(this).val();
        $("#crimeList tbody tr").each(function(){
            var title = $(this).attr("data-crime-name");
            if (title.indexOf(text) === -1) {
                $(this).hide();
            } else {
                $(this).show();
            }
        });
    });

    $(document).on("click", "table#crimeList .selectCrime", function(){
        var crimeId = $(this).attr("data-crime-id");
        $("#crimeID").val(crimeId);
        $('#searchPopUp').modal('hide');
    });
});

function loadPage(id, optionalNickname) {
    toggleContentLoader(true);
    $("#content").html("");
    if (!optionalNickname) {
        $.ajax("http://mta/local/ajax_policePC_load_page.html?id=" + id);
    } else {
        $.ajax("http://mta/local/ajax_policePC_load_page.html?id=" + id + "&nickname=" + optionalNickname);
    }
}

function setContent(content) {
    $("#content").html(content);
    toggleContentLoader(false);
}

function toggleContentLoader(bool) {
    $("#page-loading").toggleClass("hidden-xs-up", !bool);
}

function setCar(id, html, newTop, newLeft) {
    if ($("#map div[data-car-id='" + id + "']").length > 0) {
        $("#map div[data-car-id='" + id + "']").css("top", newTop + "%");
        $("#map div[data-car-id='" + id + "']").css("left", newLeft + "%");
    } else {
        $("#map").append(html);
    }

    $("#map div[data-car-id='" + id + "']").tooltip({
        trigger: 'hover'
    });
}

function removeCar(id) {
    if ($("#map div[data-car-id='" + id + "']").length > 0) {
        $("#map div[data-car-id='" + id + "']").tooltip('hide');
        $("#map div[data-car-id='" + id + "']").remove();
    }
}

function setBlitzer(id, html, newTop, newLeft) {
    if ($("#map div[data-blitzer-id='" + id + "']").length > 0) {
        $("#map div[data-blitzer-id='" + id + "']").css("top", newTop + "%");
        $("#map div[data-blitzer-id='" + id + "']").css("left", newLeft + "%");
    } else {
        $("#map").append(html);
    }

    $("#map div[data-blitzer-id='" + id + "']").tooltip({
        trigger: 'hover'
    });
}

function removeBlitzer(id) {
    if ($("#map div[data-blitzer-id='" + id + "']").length > 0) {
        $("#map div[data-blitzer-id='" + id + "']").tooltip('hide');
        $("#map div[data-blitzer-id='" + id + "']").remove();
    }
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
    if ($("#suspectlist tr[data-nickname='" + userName + "']").length > 0) {
        var row = $("tr[data-nickname='" + userName + "']");
        row.find("td:nth-child(2)").html(userName);
        row.find("td:nth-child(3)").html(crimeState);
        row.find("td:nth-child(4)").html(StVO);
    } else {
        var editButton = "<i class='fa fa-edit edit editAkte' title='Akte bearbeiten'></i>";
        var html = "<tr data-nickname='" + userName + "'><td>" + editButton + "</td><td>" + userName + "</td><td>" + crimeState +"</td>" + "</td><td>" + StVO + "</td></tr>";
        $("#suspectlist tbody").append(html);
    }
}
function removeSuspect(userName) {
    $("#supspectlist tr[data-nickname='" + userName + "']").remove();
}

function setSuspectAlka(userName) {
    $("#suspectlist tr[data-nickname='" + userName + "']").addClass("bg-danger");
    var html = $("#suspectlist tr[data-nickname='" + userName + "'] td:nth-child(3)").html();
    $("#suspectlist tr[data-nickname='" + userName + "'] td:nth-child(3)").html(html + " (muss Alkatraz)");
}

function createCategory(ID, name) {
    var categorieHtml = "<thead class='thead-default' data-sort='" + ID + ".1' data-name='" + name + "' data-category='" + ID + "'>";
    categorieHtml += "<tr><th colspan='3'>" + name + "</th></tr>";
    categorieHtml += "</thead>";

    $("table#crimeList").append(categorieHtml);

    var createBodyHtml = "<tbody data-sort='" + ID + ".2' data-category='" + ID + "'></tbody>";
    $("table#crimeList").append(createBodyHtml);

    var addFilterOptionHtml = "<a class='dropdown-item' data-value='" + ID + "' href='#'>" + name + "</a>";
    $("#filterCategoryEntryList").append(addFilterOptionHtml);

    sortCrimeTable();
    sortCrimeCategoryFilter();
}

function createCrime(ID, categoryID, name, insertMode) {

    var crimeHtml = "<tr data-sort='" + ID + "' data-category='" + categoryID + "' data-crime-name='" + name + "'>";
    crimeHtml += "<td>" + ID + "</td><td>" + name + "</td>";
    if (insertMode) {
        crimeHtml += "<td><button type='submit' class='btn btn-success selectCrime' data-crime-id='" + ID + "'>Auswählen</button></td>";
    } else {
        crimeHtml += "<td></td>";
    }
    crimeHtml += "</tr>";

    $("table#crimeList tbody[data-category='" + categoryID + "']").append(crimeHtml);

    sortCrimeTBodys();
}

function sortCrimeTable() {
    $('table > *').sort(function (a, b) {
        var contentA = parseFloat($(a).attr('data-sort'));
        var contentB = parseFloat($(b).attr('data-sort'));
        return (contentA < contentB) ? -1 : (contentA > contentB) ? 1 : 0;
    }).each(function(){ $("table#crimeList").append($(this)); });
}

function sortCrimeCategoryFilter() {
    $('#filterCategory option').sort(function (a, b) {
        var contentA = parseFloat($(a).attr('value'));
        var contentB = parseFloat($(b).attr('value'));
        return (contentA < contentB) ? -1 : (contentA > contentB) ? 1 : 0;
    }).each(function(){ $("#filterCategory").append($(this)); });
}

function sortCrimeTBodys() {
    $('table#crimeList tbody').each(function(){
        var body = $(this);
        $(this).find("tr").sort(function (a, b) {
            var contentA = parseFloat($(a).attr('data-sort'));
            var contentB = parseFloat($(b).attr('data-sort'));
            return (contentA < contentB) ? -1 : (contentA > contentB) ? 1 : 0;
        }).each(function(){ body.append($(this)); });
    });
}
