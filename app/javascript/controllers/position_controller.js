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
            const csrfToken = document.querySelector('meta[name="csrf-token"]').content

            fetch("/users/update_position", {
                method: "POST",
                headers: { 'X-CSRF-Token': csrfToken },
                body: JSON.stringify({
                    lat: position.latitude,
                    lng: position.longitude
                })
            })
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