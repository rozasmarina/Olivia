import mapboxgl, { Popup } from 'mapbox-gl';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';

const buildMap = () => {
    const mapElement = document.getElementById('map');
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    return new mapboxgl.Map({
        container: 'map',
        style: 'mapbox://styles/oliviatheapp/cken128nw071i19s0sndd9p0w'
    });
};

const addMarkersToMap = (map, markers) => {
    markers.forEach((marker) => {
        const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);

        const element = document.createElement('div');
        element.className = 'marker';
        element.style.backgroundImage = `url('${marker.image_url}')`;
        element.style.backgroundSize = 'contain';
        element.style.width = '25px';
        element.style.height = '25px';

        new mapboxgl.Marker(element)
            .setLngLat([marker.lng, marker.lat])
            .setPopup(popup)
            .addTo(map);
    });
};

const fitMapToMarkers = (map, markers) => {
    const bounds = new mapboxgl.LngLatBounds();
    markers.forEach(marker => bounds.extend([marker.lng, marker.lat]));
    map.fitBounds(bounds, { padding: 20, maxZoom: 13, duration: 1000 });
};

const initMapbox = () => {
    const mapElement = document.getElementById('map');
    if (mapElement) {
        let crd;
        const map = buildMap();
        const markers = JSON.parse(mapElement.dataset.markers);
        const rmarker = JSON.parse(mapElement.dataset.rmarker);
        addMarkersToMap(map, markers);
        fitMapToMarkers(map, markers)
        const geocoder = new MapboxGeocoder({
            accessToken: mapboxgl.accessToken,
            countries: 'br',
            mapboxgl: mapboxgl,
            marker: false
        });
        document.getElementById('geocoder').appendChild(geocoder.onAdd(map));
        geocoder.on('result', (resultCoord) => {
            const newPlaceMarker = resultCoord.result.center
            const popup = new mapboxgl.Popup().setHTML(rmarker.createPlace);

            const element = document.createElement('div');
            element.className = 'rmarker';
            element.style.backgroundImage = `url('${rmarker.image_url}')`;
            element.style.backgroundSize = 'contain';
            element.style.width = '25px';
            element.style.height = '25px';

            new mapboxgl.Marker(element)
                .setLngLat(newPlaceMarker)
                .setPopup(popup)
                .addTo(map);
        });

        const nav = new mapboxgl.NavigationControl();
        const position = new mapboxgl.GeolocateControl({
            positionOptions: {
                enableHighAccuracy: true
            },
            trackUserLocation: true
        })
        map.addControl(position, 'bottom-right');
        map.addControl(nav, 'bottom-right');
        navigator.geolocation.getCurrentPosition((pos) => {
            crd = pos.coords;
            map.flyTo({
                center: [crd.longitude, crd.latitude],
                zoom: 13
            })
        }, () => {
            fitMapToMarkers(map, markers)
        });
    }
};

export { initMapbox };