<script setup>
import { onBeforeMount, ref } from "vue";
import AddEventList from "../components/AddEventList.vue";

const eventCateList = ref({});

const getEventCategoryList = async () => {
  //const res = await fetch("http://localhost:8080/api/events-category", {
  const res = await fetch(`${import.meta.env.VITE_BASE_URL}/api/events-category`, {
    method: "GET",
  });
  if (res.status == 200) {
    eventCateList.value = await res.json();
  } else {
    console.log("error while fetching");
  }
};

onBeforeMount(async () => {
  await getEventCategoryList();
});
</script>

<template>
  <h1 class="pt-10 text-center text-4xl font-bold">จองนัดหมาย</h1>
  <AddEventList :cliniclist="eventCateList" />
</template>

<style></style>
