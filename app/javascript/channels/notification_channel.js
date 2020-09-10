import consumer from "./consumer"

consumer.subscriptions.create({ channel: "NotificationChannel" }, {
    connected() {
        console.log("Conectado em Notification!");

    },

    disconnected() {

    },

    received(data) {
        console.log(data)
        Notification.requestPermission().then(function(result) {
            if (Notification.permission === 'granted') {
                let title = 'Test notification'
                let body = data
                let options = { body: body }
                new Notification(title, options)
            } else {
                console.log('Permission denied')
            }
        });
    }

});