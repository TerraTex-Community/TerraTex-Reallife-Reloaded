/**
 * Created by geramy on 06.07.2016.
 */

$(document).ready(function(){
    $("html").on(".kickFromFaction", "click", function(){
        var nickname = $(this).parent().parent().parent().attr("data-nickname");
        $.ajax("http://mta/local/ajax_faction_management_execute_member_function.html?func=kick&nickname=" + nickname);
    });

    $("html").on(".giveRank", "click", function(){
        var nickname = $(this).parent().parent().parent().parent().parent().attr("data-nickname");
        var rank = $(this).attr("data-rank");
        $.ajax("http://mta/local/ajax_faction_management_execute_member_function.html?func=giverank&nickname=" + nickname + "&rank=" + rank);
    });
});