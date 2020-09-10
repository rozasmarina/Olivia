import { Controller } from "stimulus"

export default class extends Controller {
    connect() {
        this.load()

        if (this.data.has("refreshInterval")) {
            this.startRefreshing()
        }
    }

    disconnect() {
        this.stopRefreshing()
    }

    load() {
        navigator.geolocation.getCurrentPosition((pos) => {
            let position = pos.coords;
            $.post('/users/update_position', {
                lat: position.latitude,
                lng: position.longitude
            });
        }, () => {
            console.log("Position unavailable.")
        })
    }

    startRefreshing() {
        this.refreshTimer = setInterval(() => {
            this.load()
        }, this.data.get("refreshInterval"))
    }

    stopRefreshing() {
        if (this.refreshTimer) {
            clearInterval(this.refreshTimer)
        }
    }
}