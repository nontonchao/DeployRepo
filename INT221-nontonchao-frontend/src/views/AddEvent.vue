<script setup>
import { onBeforeMount, ref } from "vue";
import AddEventList from "../components/AddEventList.vue";
import { useEvents } from "../stores/events.js";
import { useEventCategory } from "../stores/eventCategory.js";

const eventCateList = ref({});
const eventStore = useEvents();
const eventCateStore = useEventCategory();

onBeforeMount(async () => {
  await eventStore.fetchEvents(0);
  eventCateList.value = eventCateStore.eventCategoryList;
});
</script>

<template>
  <div>
    <h1 class="pt-10 text-center text-4xl font-bold">จองนัดหมาย</h1>
    <AddEventList :cliniclist="eventCateList" />

  </div>
</template>

<style></style>
