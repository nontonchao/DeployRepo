<script setup>
import { ref, onBeforeMount } from "vue";
import CategoryList from "../components/CategoryList.vue";
import { useEventCategory } from "../stores/eventCategory.js";
import Footer from "../components/Footer.vue";

const eventCateStore = useEventCategory();
</script>

<template>
  <CategoryList :cateList="eventCateStore.eventCategoryList" />
  <Footer />
</template>
<style></style>
