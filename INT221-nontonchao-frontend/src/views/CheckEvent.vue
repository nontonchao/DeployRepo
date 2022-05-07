<script setup>
import { ref, onBeforeMount } from "vue";
import AllEventList from "../components/AllEventList.vue";

const eventList = ref({});
const filter_list = ref({});
const selectDate = ref('');
const search = ref('');
const selectedClinic = ref('ทั้งหมด');
const status = ref('ทั้งหมด');

const currentdate = new Date();
const datetime = currentdate.toISOString().substring(0, 11) + currentdate.getHours() + `:` + currentdate.getMinutes()
console.log(datetime);

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

const getAllEventList = async () => {
  let ret = {};
  //const res = await fetch("http://localhost:8080/api/events", {
  const res = await fetch(`${import.meta.env.VITE_BASE_URL}/sy1/api/events`, {
    method: "GET",
  });
  if (res.status == 200) {
    ret = await res.json();
    eventList.value = ret;
  } else {
    console.log("error while fetching");
  }
  return ret;
};

const editDateTime = async (updateEvent) => {
  //const res = await fetch(`http://localhost:8080/api/events/edit/`, {
  const res = await fetch(`${import.meta.env.VITE_BASE_URL}/api/events/edit/`, {
    method: "PUT",
    headers: {
      "content-type": "application/json",
    },
    body: JSON.stringify(updateEvent),
  });
  if (res.status == 200) {
    console.log("edited");
  } else {
    eventList.value = await getAllEventList();
    filter_list.value = eventList.value;
  }
};

const deleteEventFromId = async (id) => {
  //const res = await fetch(`http://localhost:8080/api/events/delete/${id}`, {
  const res = await fetch(`${import.meta.env.VITE_BASE_URL}/api/events/delete/${id}`, {
    method: "DELETE",
  });
  if (res.status == 200) {
    eventList.value = eventList.value.filter((event) => event.id !== id);
    filter_list.value = filter_list.value.filter((event) => event.id !== id);
  } else {
    console.log("error while fetching");
  }
};

onBeforeMount(async () => {
  await getAllEventList();
  await getEventCategoryList();
  filter_list.value = eventList.value;
});

const filterEvent = (search) => {
  filter_list.value = eventList.value.filter(x =>
    (x.bookingName.includes(search) || x.bookingEmail == (search)) && x.eventCategory.eventCategoryName.includes(selectedClinic.value == 'ทั้งหมด' ? '' : selectedClinic.value) &&
    (status.value == 'ทั้งหมด' ? x : (status.value == 'กำลังจะมาถึง' ? x.eventStartTime >= datetime : x.eventStartTime < datetime)));
}
</script>

<template>
  <div class="w-full md:w-3/5 px-6 mb-8 md:mb-0 container mx-auto content-center leading-8">
    <h1 class="text-center text-4xl font-bold m-10">ตรวจสอบนัดหมาย</h1>
    <!-- filter Nav -->
    <div
      class="container mx-auto content-center leading-8 w-full md:w-full px-6 mb-8 md:mb-auto flex space-x-5 justify-center pb-12">
      <div class="w-auto">
        <label class="block uppercase tracking-wide text-gray-700 text-sm font-bold mb-2">สถานะ
        </label>
        <div class="inline-block relative w-52 flex-auto">
          <select v-model="status"
            class="shadow appearance-none border rounded w-full max-w-xs py-2 px-3 text-gray-700 leading-tight transition ease-in-out m-0 focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none">
            <option>ทั้งหมด</option>
            <option>กำลังจะมาถึง</option>
            <option>ที่ผ่านมา</option>
          </select>
          <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
            <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
              <path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z" />
            </svg>
          </div>
        </div>
      </div>
      <div class="w-auto">
        <label class="block uppercase tracking-wide text-gray-700 text-sm font-bold mb-2">วันที่</label>
        <input type="date" v-model="selectDate" required
          class="shadow appearance-none border rounded w-auto py-2 px-3 text-gray-700 leading-tight focus:shadow-outline transition ease-in-out m-0 focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none" />
      </div>
      <div class="w-auto">
        <label class="block uppercase tracking-wide text-gray-700 text-sm font-bold mb-2">คลินิก
        </label>
        <div class="inline-block relative w-64 flex-auto">
          <select v-model="selectedClinic"
            class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:shadow-outline transition ease-in-out m-0 focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none">
            <option>ทั้งหมด</option>
            <option v-for="(a, index) in eventCateList" :key="index">
              {{ a.eventCategoryName }}
            </option>
          </select>
          <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
            <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
              <path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z" />
            </svg>
          </div>
        </div>
      </div>
      <div class="w-auto">
        <label class="block uppercase tracking-wide text-gray-700 text-sm font-bold mb-2">ค้นหา
        </label>
        <div class="flex items-center justify-center">
          <div class="flex rounded">
            <input type="search" v-model="search"
              class="shadow appearance-none border rounded-md w-auto py-2 px-3 text-gray-700 leading-tight focus:shadow-outline transition ease-in-out m-0 focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none"
              placeholder="ชื่อ, อีเมล ... " />
            <button @click="filterEvent(search)"
              class="flex items-center justify-center appearance-none border rounded-md w-auto py-2 px-3">
              <svg class="w-6 h-6 text-gray-600 rounded-2xl" fill="currentColor" xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 24 24">
                <path
                  d="M16.32 14.9l5.39 5.4a1 1 0 0 1-1.42 1.4l-5.38-5.38a8 8 0 1 1 1.41-1.41zM10 16a6 6 0 1 0 0-12 6 6 0 0 0 0 12z" />
              </svg>
            </button>
          </div>
        </div>
      </div>
    </div>
    <!-- filter Nav -->
  </div>
  <AllEventList :eventList="filter_list" @delete="deleteEventFromId" @edit="editDateTime" />
</template>

<style>
</style>
