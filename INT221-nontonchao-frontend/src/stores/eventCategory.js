import { defineStore, acceptHMRUpdate } from "pinia";
import { ref } from "vue";

export const useEventCategory = defineStore("eventCategory", () => {
    const isEdit200 = ref(false);
    const isEdit400 = ref(false);
    const getEventCategoryList = async() => {
        // const res = await fetch("http://localhost:8080/api/events-category", {
        // const res = await fetch("http://10.4.56.118:8080/api/events-category", {
        const res = await fetch(`${import.meta.env.BASE_URL}api/events-category`, {
            method: "GET",
        });
        if (res.status == 200) {
            const eventCategoryList = await res.json();
            return eventCategoryList;
        } else {
            console.log("error while fetching");
        }
    };
    const editEventCategory = async(updatedEventCat) => {
        // const res = await fetch(`http://localhost:8080/api/events-category/${updatedEventCat.id}`, {
        // const res = await fetch(`http://10.4.56.118:8080/api/events-category/${updatedEventCat.id}`, {
        const res = await fetch(`${import.meta.env.BASE_URL}api/events-category${updatedEventCat.id}`, {
            method: "PUT",
            headers: {
                "content-type": "application/json",
            },
            body: JSON.stringify(updatedEventCat),
        });
        if (res.status == 200) {
            console.log(`${updatedEventCat.id} edit แล้ว`);
            isEdit200.value = true;
            return getEventCategoryList();
        } else if (res.status == 400) {
            isEdit400.value = true;
            console.log("error while editing || error: " + (await res.text()));
        } else {
            console.log("error while editing || error: " + (await res.text()));
        }
    };
    return { getEventCategoryList, editEventCategory, isEdit200, isEdit400 };
});

if (
    import.meta.hot) {
    import.meta.hot.accept(acceptHMRUpdate(useEventCategory,
        import.meta.hot));
}