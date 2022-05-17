<script setup>
import { ref, onBeforeMount } from "vue";
import CategoryList from "../components/CategoryList.vue";

const eventCateList = ref({});

const getEventCategoryList = async () => {
  // const res = await fetch("http://localhost:8080/api/events-category", {
    //const res = await fetch("http://10.4.56.118:8080/api/events-category", {
  const res = await fetch(`${import.meta.env.BASE_URL}/api/events-category`, {
    method: "GET",
  });
  if (res.status == 200) {
    eventCateList.value = await res.json();
  } else {
    console.log("error while fetching");
  }
};

const editEventCategory = async (updatedEventCat) => {
  // const res = await fetch(`http://localhost:8080/api/events-category/${updatedEventCat.id}`, {
    //const res = await fetch(`http://10.4.56.118:8080/api/events-category${updatedEventCat.id}`, {
  const res = await fetch(`${import.meta.env.BASE_URL}/api/events-category${updatedEventCat.id}`, {
    method: "PUT",
    headers: {
      "content-type": "application/json",
    },
    body: JSON.stringify(updatedEventCat),
  });
  if (res.status == 200) {
    console.log(`${updatedEventCat.id} edit แล้ว`)
  }
}


onBeforeMount(async () => {
  await getEventCategoryList();
});

</script>

<template>
  <CategoryList :cateList="eventCateList" @edit="editEventCategory" />
</template>

<style>
</style>
