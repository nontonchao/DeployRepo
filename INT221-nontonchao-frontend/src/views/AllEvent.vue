<script setup>
import { onBeforeMount, ref } from "vue";
import AllEventList from "../components/AllEventList.vue";

const eventList = ref({});

const getAllEventList = async () => {
  //const res = await fetch("http://localhost:8080/api/events", {
  const res = await fetch(`${import.meta.env.BASE_URL}/events`, {
    method: "GET",
  });
  if (res.status == 200) {
    eventList.value = await res.json();
  } else {
    console.log("error while fetching");
  }
};

const deleteEventFromId = async (id) => {
  //const res = await fetch(`http://localhost:8080/api/events/delete/${id}`, {
  const res = await fetch(`${import.meta.env.BASE_URL}/events/delete/${id}`, {
    method: "DELETE",
  });
  if (res.status == 200) {
    await getAllEventList();
  } else {
    console.log("error while delete");
  }
};

onBeforeMount(async () => {
  await getAllEventList();
});

const sortByNumAsc = (fieldName) => {
  eventList.value.sort((a, b) => {
    return a[fieldName] - b[fieldName];
  });
};

const sortByStringDesc = (fieldName) => {
  eventList.value.sort((a, b) => {
    if (a[fieldName] > b[fieldName]) {
      return -1;
    }
    if (a[fieldName] < b[fieldName]) {
      return 1;
    }
    return 0;
  });
};

const sortByStringAsc = (fieldName) => {
  eventList.value.sort((a, b) => {
    if (a[fieldName] < b[fieldName]) {
      return -1;
    }
    if (a[fieldName] > b[fieldName]) {
      return 1;
    }
    return 0;
  });
};
</script>

<template>
  <h1 class="m-10 text-center text-4xl font-bold">นัดหมายทั้งหมด</h1>
  <div class="flex space-x-5">
    <button class="rounded bg-orange-800 p-3 text-white" @click="sortByStringDesc('eventStartTime')">
      Sort by StartTime
    </button>
    <button class="rounded bg-orange-800 p-3 text-white" @click="sortByNumAsc('id')">
      Sort by ID
    </button>
    <button class="rounded bg-orange-800 p-3 text-white" @click="sortByStringAsc('bookingName')">
      Sort by Name
    </button>
    <button class="rounded bg-orange-800 p-3 text-white" @click="sortByStringAsc('bookingEmail')">
      Sort by Email
    </button>
  </div>

  <AllEventList :eventList="eventList" @delete="deleteEventFromId" />
</template>

<style>
</style>
