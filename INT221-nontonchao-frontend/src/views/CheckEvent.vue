<script setup>
import { ref, onBeforeMount } from "vue";
import AllEventList from "../components/AllEventList.vue";

const eventList = ref({});
const filter_list = ref({});
const selectDate = ref("");
const search = ref("");
const selectedClinic = ref("ทั้งหมด");
const status = ref("ทั้งหมด");
const is400 = ref(false);
const tPage = ref(0);

const numberFormat = function (number, width) {
  return new Array(+width + 1 - (number + "").length).join("0") + number;
};
const currentdate = new Date();
const datetime = `${currentdate.getFullYear()}-${numberFormat(
  new Date(currentdate.toString()).getMonth() + 1,
  2
)}-${numberFormat(new Date(currentdate.toString()).getDate(), 2)}T${currentdate
  .toLocaleTimeString("it-IT")
  .substring(0, 5)}`;

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

const getAllEventList = async (page) => {
  let ret = {};
  // const res = await fetch(`http://localhost:8080/api/events?page=${page}`, {
    //const res = await fetch("http://10.4.56.118:8080/api/events", {
  const res = await fetch(`${import.meta.env.BASE_URL}/api/events`, {
    method: "GET",
  });
  if (res.status == 200) {
    ret = await res.json();
    tPage.value = ret.totalPages;
    eventList.value = ret.content;
    filter_list.value = eventList.value;
  } else {
    console.log("error while fetching");
  }
  return ret;
};

const editDateTime = async (updateEvent) => {
  // const res = await fetch(`http://localhost:8080/api/events/edit/`, {
    //const res = await fetch(`http://10.4.56.118:8080/api/events/edit/`, {
  const res = await fetch(`${import.meta.env.BASE_URL}/api/events/edit/`, {
    method: "PUT",
    headers: {
      "content-type": "application/json",
    },
    body: JSON.stringify(updateEvent),
  });
  if (res.status == 200) {
    console.log("edited");
  } else {
    eventList.value = await getAllEventList(0);
    is400.value = true;
    filter_list.value = eventList.value;
  }
};

const deleteEventFromId = async (id) => {
  // const res = await fetch(`http://localhost:8080/api/events/delete/${id}`, {
    // const res = await fetch(`http://10.4.56.118:8080/api/events/delete/${id}`, {
  const res = await fetch(`${import.meta.env.BASE_URL}/api/events/delete/${id}`, {
    method: "DELETE",
  });
  if (res.status == 200) {
    eventList.value = eventList.value.filter((event) => event.id !== id);
    filter_list.value = filter_list.value.filter((event) => event.id !== id);
  } else {
    console.log("error while fetching || error :" + (await res.text()));
  }
};

onBeforeMount(async () => {
  await getAllEventList(0);
  await getEventCategoryList();
});

const filterEvent = (search) => {
  filter_list.value = eventList.value.filter(
    (x) =>
      (x.bookingName.includes(search) || x.bookingEmail == search) &&
      x.eventCategory.eventCategoryName.includes(
        selectedClinic.value == "ทั้งหมด" ? "" : selectedClinic.value
      ) &&
      (status.value == "ทั้งหมด"
        ? x
        : status.value == "กำลังจะมาถึง"
          ? x.eventStartTime >= datetime
          : x.eventStartTime < datetime)
  );
};
</script>

<template>
  <div class="w-full md:w-3/5 px-6 mb-8 md:mb-0 container mx-auto content-center leading-8">
    <h1 class="text-center text-4xl font-bold m-10">ตรวจสอบนัดหมาย</h1>
    <!-- filter Nav -->
    <div
      class="mx-auto container content-center leading-8 w-full md:w-full px-6 mb-8 md:mb-auto flex space-x-5 justify-center pb-12">
      <div class="w-auto mx-auto">
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
        <input type="date" v-model="selectDate" :disabled="status != 'ทั้งหมด'" required
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
  <div v-show="is400" id="defaultModal" tabindex="-1" aria-hidden="true"
    class="overflow-x-hidden overflow-y-auto fixed inset-0 z-50 outline-none focus:outline-none justify-center items-center flex backdrop bg-black/50 transform">
    <div class="relative p-4 w-full max-w-2xl h-full md:h-auto">
      <!-- Modal content -->
      <div class="relative bg-white rounded-lg shadow">
        <!-- Modal header 400 -->
        <div class="flex justify-between items-start p-5 rounded-t border-b">
          <h3 class="text-xl font-semibold text-red-500 lg:text-2xl">
            เกิดข้อผิดพลาด
          </h3>
          <button @click="is400 = false" type="button"
            class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center"
            data-modal-toggle="defaultModal">
            <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
              <path fill-rule="evenodd"
                d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                clip-rule="evenodd"></path>
            </svg>
          </button>
        </div>
        <!-- Modal body 400 -->
        <div class="p-6 space-y-6 text-center">
          <svg class="mx-auto mb-4 w-14 h-14 text-yellow-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"
            xmlns="http://www.w3.org/2000/svg">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
              d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
          </svg>
          <h3 class="mb-5 text-lg font-normal text-gray-500">
            ไม่สามารถจองช่วงเวลานี้ได้ กรุณาตรวจสอบและเลือกวันเวลาใหม่ ได้
            <router-link
              class="text-base font-bold py-2 px-4 rounded-3xl underline decoration-blue-600 hover:text-blue-700 drop-shadow-2xl transform text-blue-500 delay-50 hover:-translate-y-1 duration-300"
              :to="{ name: 'CheckEvent' }">ที่นี่</router-link>
          </h3>
        </div>
      </div>
    </div>
  </div>

  <AllEventList :eventList="filter_list" @delete="deleteEventFromId" @edit="editDateTime" />

  <div v-show="filter_list.length" class="content-center flex justify-center bg-main">
    <div class="bg-main p-4 flex items-center flex-wrap content-center leading-8">
      <nav aria-label="Page navigation">
        <ul class="inline-flex space-x-2">
          <li>
            <button
              class="flex items-center justify-center w-10 h-10 text-green-600 transition-colors duration-150 rounded-full focus:shadow-outline hover:bg-green-100">
              <svg class="w-4 h-4 fill-current" viewBox="0 0 20 20">
                <path
                  d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z"
                  clip-rule="evenodd" fill-rule="evenodd"></path>
              </svg>
            </button>
          </li>
          <li v-for="i in tPage">
            <button
              class="w-10 h-10 text-black transition-colors duration-150 bg-acqua border border-r-0 border-acqua rounded-full focus:shadow-outline"
              @click="getAllEventList(i - 1)">
              {{ i }}
            </button>
          </li>
          <li>
            <button
              class="flex items-center justify-center w-10 h-10 text-green-600 transition-colors duration-150  rounded-full focus:shadow-outline hover:bg-green-100">
              <svg class="w-4 h-4 fill-current" viewBox="0 0 20 20">
                <path
                  d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z"
                  clip-rule="evenodd" fill-rule="evenodd"></path>
              </svg>
            </button>
          </li>
        </ul>
      </nav>
    </div>
  </div>
</template>

<style>
</style>
