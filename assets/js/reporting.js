let moment = require('moment');
let $ = require('jquery');

let reporting = {
    in_how_log(date) {
        return moment(date).fromNow();
    },

    day_of_week(date) {
        return moment(date).format("dddd");
    },

    complete(id, csrf) {
        $.post("/complete", {
            id: id,
            _csrf_token: csrf
        }, function () { window.location.reload(); });
    }
};

export default reporting;