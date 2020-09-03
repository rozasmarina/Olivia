import mapboxgl, { Popup } from 'mapbox-gl';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';

const mapElement = document.getElementById('map');

const buildMap = () => {
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
    map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 3000 });
};

const initMapbox = () => {
    if (mapElement) {
        const map = buildMap();
        const markers = JSON.parse(mapElement.dataset.markers);
        const resultMarkers = JSON.parse(mapElement.dataset.markers);
        addMarkersToMap(map, markers);
        fitMapToMarkers(map, markers);
        map.addControl(new MapboxGeocoder({
            accessToken: mapboxgl.accessToken,
            countries: 'br',
            mapboxgl: mapboxgl,
            marker: {
                color: 'pink',
            }
        }));
        const nav = new mapboxgl.NavigationControl();
        const position = new mapboxgl.GeolocateControl({
            positionOptions: {
                enableHighAccuracy: true
            },
            trackUserLocation: true
        })
        map.addControl(position, 'bottom-right');
        map.addControl(nav, 'bottom-right');

    }
};

export { initMapbox };