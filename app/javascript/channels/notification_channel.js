import consumer from "./consumer"

const initNotificationChannel = () => {
    consumer.subscriptions.create({ channel: "NotificationChannel" }, {
        connected() {
            console.log("Conectado em Notification!");

        },

        disconnected() {

        },

        received(data) {
            console.log(data);
        }

    });
}

export { initNotificationChannel }