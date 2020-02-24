$(document).ready(function(){
    $("html").on("click", ".kickFromFaction", function(){
        var nickname = $(this).parent().parent().parent().attr("data-nickname");
        $.ajax("http://mta/local/ajax_faction_management_execute_member_function.html?func=kick&nickname=" + nickname);
    });

    $("html").on("click",".giveRank", function(){
        var nickname = $(this).parent().parent().parent().parent().parent().attr("data-nickname");
        var rank = $(this).attr("data-rank");
        $.ajax("http://mta/local/ajax_faction_management_execute_member_function.html?func=giverank&nickname=" + nickname + "&rank=" + rank);
    });
});
