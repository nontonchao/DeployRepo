<script setup>
import { ref, onBeforeMount } from "vue";
import CategoryList from "../components/CategoryList.vue";
import { useEventCategory } from "../stores/eventCategory.js"

const eventCateStore = useEventCategory()
const eventCateList = ref({});

onBeforeMount(async () => {
  eventCateList.value = await eventCateStore.getEventCategoryList();
});


</script>

<template>
  <CategoryList :cateList="eventCateList" />
</template>
<!-- @edit="editEventCategory" -->
<style></style>
