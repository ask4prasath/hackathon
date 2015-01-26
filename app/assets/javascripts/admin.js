//
//= require jquery_ujs
//= require_tree ./admin_theme

$(function() {
    "use strict";

    var socket = $.atmosphere;
    var subSocket;

    var request = {
        url: "http://54.69.164.109:8090/rheaSocketApi/v1/6a9a98405e270132e43b0a5f603a4ac0::ask4prasath",
        contentType: "application/json",
        logLevel: 'debug',
        transport: 'websocket',
        fallbackTransport: 'long-polling'
    };

    request.onOpen = function(response) {
        console.log("connected")
        subSocket.push("6a9a98405e270132e43b0a5f603a4ac0::ask4prasath");
    };

    request.onMessage = function(rs) {
        console.log(rs)
        var serverStats = jQuery.parseJSON(rs.responseBody)
        networkRealtimeChartTick(serverStats.totalPerSec,  serverStats.successPerSec, serverStats.failurePerSec);
        networkRealtimeGaugeTick(serverStats.guage);

        if(serverStats.alert.length > 0) {
            $(".badge-yellow").text(parseInt($(".badge-yellow").text()) + 1)
            $(".user-timeline-stories").prepend('<article class="timeline-story"><header><p><i class="fa-bell-slash-o" style="color: indianred;"></i>  &nbsp; '  + serverStats.alert +   '</p></header></article>');

            $(".rulesOld").html("<a>" + $(".rulesNew").text() + "</a>");
            $(".rulesNew").html("<a>" + serverStats.alert + "</a>");

            var articles = $(".user-timeline-stories article")
            if(articles.size() > 10) {
                articles.last().remove()
            }

            $.post("/alerts", {"rule": {"source_id": "1", "value":  serverStats.alert }})
        }

        if(serverStats.rule.length > 0) {
            $(".badge-danger").text(parseInt($(".badge-danger").text()) + 1)
            $(".user-timeline-stories").prepend('<article class="timeline-story"><header><p><i class="fa-exclamation-circle" style="color: indianred;"></i>  &nbsp; '  + serverStats.rule +   '</p></header></article>')

            $(".alertOld").html("<a>" + $(".alertNew").text() + "</a>");
            $(".alertNew").html("<a>" + serverStats.rule + "</a>");

            var articles = $(".user-timeline-stories article")
            if(articles.size() > 10) {
                articles.last().remove()
            }

            $.post("/rules", {"rule": {"source_id": "1", "value":  serverStats.rule }})
        }

        $(".totalPerSec").text(serverStats.totalPerSec);
        $(".totalCount").text(serverStats.totalCount);
        $(".successCount").text(serverStats.successCount);
        $(".failureCount").text(serverStats.failureCount);
//        networkRealtimeMBupdate()
    }

    subSocket = socket.subscribe(request);
});
