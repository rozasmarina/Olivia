import consumer from "./consumer"

consumer.subscriptions.create({ channel: "UserChannel" }, {
    connected() {
        console.log("Conectado em User!");
    },

    disconnected() {

    },

    received(data) {
        console.log(data);
    }

});