import { defineStore, acceptHMRUpdate } from "pinia";
import { ref } from "vue";

export const useEvents = defineStore("events", () => {
    const events = ref([]);

    const addEvent = async(event) => {
        // const res = await fetch(`http://10.4.56.118:8080/api/events`, {
        const res = await fetch(`${import.meta.env.BASE_URL}api/events`, {
            method: "POST",
            headers: {
                "content-type": "application/json",
            },
            body: JSON.stringify(event),
        });
        if (res.status === 201) {
            await fetchEvents();
        }
    };

    const removeEvent = async(eventId) => {
        // const res = await fetch(`http://10.4.56.118:8080/api/events/delete/${eventId}`, {
        const res = await fetch(`${import.meta.env.BASE_URL}api/events/delete/${eventId}`, {
                method: "DELETE",
            }
        );
        if (res.status === 200) {
            const eventIndex = events.value.findIndex(
                (event) => event.id === eventId
            );
            events.value.splice(eventIndex, 1);
        } else {
            console.log("error while delete || error :" + (await res.text()));
        }
    };

    const fetchEvents = async() => {
        try {
            // const res = await fetch(`http://10.4.56.118:8080/api/events`, {
            const res = await fetch(`${import.meta.env.BASE_URL}api/events`, {
                method: "GET",
            });
            events.value = await res.json();
            return events.value;
        } catch (err) {
            console.log(err);
        }
    };

    return { events, fetchEvents, removeEvent, addEvent };
});

if (
    import.meta.hot) {
    import.meta.hot.accept(acceptHMRUpdate(useEvents,
        import.meta.hot));
}