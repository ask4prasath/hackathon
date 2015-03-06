//
//= require jquery_ujs
//= require_tree ./admin_theme

$(function() {
    "use strict";

    var socket = $.atmosphere;
    var subSocket;

    var request = {
        url: "http://54.68.26.107:8090/rheaSocketApi/v1/6a9a98405e270132e43b0a5f603a4ac0::air_quality",
        contentType: "application/json",
        logLevel: 'debug',
        transport: 'websocket',
        fallbackTransport: 'long-polling'
    };

    request.onOpen = function(response) {
        console.log("connected")
        subSocket.push("6a9a98405e270132e43b0a5f603a4ac0::air_quality");
    };

    request.onMessage = function(rs) {
        var serverStats = jQuery.parseJSON(rs.responseBody)
        networkRealtimeChartTick(serverStats.totalPerSec,  serverStats.successPerSec, serverStats.failurePerSec);
        networkRealtimeGaugeTick(serverStats.guage);

        if(serverStats.alert !=  null) {
            $(".badge-yellow").text(parseInt($(".badge-yellow").text()) + 1)
            $(".user-timeline-stories").prepend('<article class="timeline-story"><header><p><i class="fa-bell-slash-o" style="color: indianred;"></i>  &nbsp; '  + serverStats.alert +   '</p></header></article>');

            $(".alertOld").html("<a>" + $(".alertNew").text() + "</a>");
            $(".alertNew").html("<a>" + serverStats.alert + "</a>");

            var articles = $(".user-timeline-stories article")
            if(articles.size() > 10) {
                articles.last().remove()
            }

            $.post("/alerts", {"alert": {"source_id": "1", "text":  serverStats.alert }})
        }

        if(serverStats.rule !=  null) {

            $(".badge-danger").text(parseInt($(".badge-danger").text()) + 1)
            $(".latest-timeline").removeClass("latest-timeline");
            $(".user-timeline-stories").prepend('<article class="timeline-story latest-timeline"><header><p><i class="fa-exclamation-circle" style="color: indianred;"></i>  &nbsp; '  + serverStats.rule +   '</p></header></article>')
            $(".latest-timeline").fadeTo('slow', 0.5).fadeTo('slow', 1.0)

            $("body").scrollTop( 400 )

            $(".ruleOld").html("<a>" + $(".ruleNew").text() + "</a>");
            $(".ruleNew").html("<a>" + serverStats.rule + "</a>");
            var articles = $(".user-timeline-stories article")
            if(articles.size() > 10) {
                articles.last().remove()
            }
            $.post("/rules", {"rule": {"source_id": "1", "text":  serverStats.rule }})
        }

        $(".totalPerSec").text(serverStats.totalPerSec);
        $(".totalCount").text(serverStats.totalCount);
        $(".successCount").text(serverStats.successCount);
        $(".failureCount").text(serverStats.failureCount);
//        networkRealtimeMBupdate()
    }

    subSocket = socket.subscribe(request);

    $('.user-timeline-stories').jscroll({
        loadingHtml: '<span>Loading..</span>',
        padding: 10,
        nextSelector: 'a'
    });

//    $('.profile-env').jscroll({
//        loadingHtml: '<button class="btn btn-lg btn-warning"><span class="glyphicon glyphicon-refresh glyphicon-refresh-animate"></span> Loading...</button>',
//        padding: 10,
//        nextSelector: 'a'
//    });
});
