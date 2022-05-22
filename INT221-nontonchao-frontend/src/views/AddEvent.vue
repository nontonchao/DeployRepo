<script setup>
import { onBeforeMount } from "vue";
import AddEventList from "../components/AddEventList.vue";
import { useEvents } from "../stores/events.js";
import { useEventCategory } from "../stores/eventCategory.js";

import Footer from "../components/Footer.vue";

const eventStore = useEvents();
const eventCateStore = useEventCategory();

onBeforeMount(async () => {
  await eventStore.fetchEvents();
});

</script>

<template>
  <div>
    <div class="pb-12">
      <h1 class="pt-10 text-center text-4xl font-bold">จองนัดหมาย</h1>
      <AddEventList :cliniclist="eventCateStore.eventCategoryList" />
    </div>

    <Footer />
  </div>
</template>

<style>
</style>
