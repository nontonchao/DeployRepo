<script setup>
import { ref, onBeforeMount } from "vue";
import CategoryList from "../components/CategoryList.vue";

const eventCateList = ref({});


const getEventCategoryList = async () => {
  // const res = await fetch("http://localhost:8080/api/events-category", {
  // const res = await fetch("http://10.4.56.118:8080/api/events-category", {
  const res = await fetch(`${import.meta.env.BASE_URL}/api/events-category`, {
    method: "GET",
  });
  if (res.status == 200) {
    eventCateList.value = await res.json();
  } else {
    console.log("error while fetching");
  }
};

// const editEventCategory = async (updatedEventCat) => {
//   const res = await fetch(
//     `http://localhost:8080/api/events-category/${updatedEventCat.id}`,
//     {
//       //const res = await fetch("http://10.4.56.118:8080/api/events-category", {
//       // const res = await fetch(`${import.meta.env.BASE_URL}/api/events-category`, {
//       method: "PUT",
//       headers: {
//         "content-type": "application/json",
//       },
//       body: JSON.stringify(updatedEventCat),
//     }
//   );
//   if (res.status == 200) {
//     console.log(`${updatedEventCat.id} edit แล้ว`);
//     is200.value = true;
//   } else if (res.status == 400) {
//     is400.value = true;
//     console.log("error while editing || error: " + (await res.text()));
//   } else {
//     console.log("error while editing || error: " + (await res.text()));
//   }
// };


onBeforeMount(async () => {
  await getEventCategoryList();
});


</script>

<template>
  <button @click="is400 = !is400">test</button>
  <CategoryList :cateList="eventCateList"  />
</template>
<!-- @edit="editEventCategory" -->
<style></style>
