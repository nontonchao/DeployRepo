<script setup>
import { ref, onBeforeMount } from "vue";
import AllEventList from "../components/AllEventList.vue";
import { useEvents } from "../stores/events.js";
import { useEventCategory } from "../stores/eventCategory.js";
import Footer from '../components/Footer.vue';

const eventCateStore = useEventCategory();
const eventStore = useEvents();

const eventList = ref({});
const filter_list = ref({});
const selectDate = ref("");
const search = ref("");
const selectedClinic = ref("ทั้งหมด");
const status = ref("ทั้งหมด");
const eventCateList = ref([]);
const fStatus = ref("ทั้งหมด");

const editEvent = async (editEvent) => {
  await eventStore.editEvent(editEvent, filter_list.value);
};

const deleteEventFromId = async (id) => {
  await eventStore.removeEvent(id, filter_list.value);
};

onBeforeMount(async () => {
  eventList.value = await eventStore.fetchEvents();
  filter_list.value = eventList.value;
  eventCateList.value = eventCateStore.eventCategoryList;
});

const filterEvent = async (search) => {
  eventList.value = await eventStore.fetchEvents();
  if (status.value != "ทั้งหมด") {
    selectDate.value = "";
  }
  filter_list.value = eventList.value.filter(
    (x) =>
      (x.bookingName.includes(search) || x.bookingEmail == search) &&
      x.eventCategory.eventCategoryName.includes(
        selectedClinic.value == "ทั้งหมด" ? "" : selectedClinic.value
      ) &&
      (status.value == "ทั้งหมด" && selectDate.value == ""
        ? x
        : status.value == "ทั้งหมด" && selectDate.value != ""
          ? new Date(x.eventStartTime).toDateString() == new Date(selectDate.value).toDateString()
          : status.value == "กำลังจะมาถึง"
            ? new Date(x.eventStartTime) >= new Date()
            : new Date(x.eventStartTime) < new Date())
  );
  fStatus.value = status.value;
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
          </div>
          <div class="flex items-center justify-center pl-2">
            <button @click="filterEvent(search)"
              class="flex items-center justify-center appearance-none border rounded-md w-auto py-2 px-3">
              <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
                <path
                  d="M21.172 24l-7.387-7.387c-1.388.874-3.024 1.387-4.785 1.387-4.971 0-9-4.029-9-9s4.029-9 9-9 9 4.029 9 9c0 1.761-.514 3.398-1.387 4.785l7.387 7.387-2.828 2.828zm-12.172-8c3.859 0 7-3.14 7-7s-3.141-7-7-7-7 3.14-7 7 3.141 7 7 7z" />
              </svg>
            </button>
            <button @click="
              (selectDate = ''),
              (search = ''),
              (selectedClinic = 'ทั้งหมด'),
              (status = 'ทั้งหมด'),
              filterEvent(search)
            " class="flex items-center justify-center appearance-none border rounded-md w-auto py-2 px-3">
              <svg width="24" height="24" xmlns="http://www.w3.org/2000/svg" fill-rule="evenodd" clip-rule="evenodd">
                <path
                  d="M13.818 16.646c-1.273.797-2.726 1.256-4.202 1.354l-.537-1.983c2.083-.019 4.132-.951 5.49-2.724 2.135-2.79 1.824-6.69-.575-9.138l-1.772 2.314-1.77-6.469h6.645l-1.877 2.553c3.075 2.941 3.681 7.659 1.423 11.262l7.357 7.357-2.828 2.828-7.354-7.354zm-11.024-1.124c-1.831-1.745-2.788-4.126-2.794-6.522-.005-1.908.592-3.822 1.84-5.452 1.637-2.138 4.051-3.366 6.549-3.529l.544 1.981c-2.087.015-4.142.989-5.502 2.766-2.139 2.795-1.822 6.705.589 9.154l1.774-2.317 1.778 6.397h-6.639l1.861-2.478z" />
              </svg>
            </button>
          </div>
        </div>
      </div>
    </div>
    <!-- filter Nav -->
  </div>
  <div v-show="eventStore.editCode == 400" id="defaultModal" tabindex="-1" aria-hidden="true"
    class="overflow-x-hidden overflow-y-auto fixed inset-0 z-50 outline-none focus:outline-none justify-center items-center flex backdrop bg-black/50 transform">
    <div class="relative p-4 w-full max-w-2xl h-full md:h-auto">
      <!-- Modal content -->
      <div class="relative bg-white rounded-lg shadow">
        <!-- Modal header 400 -->
        <div class="flex justify-between items-start p-5 rounded-t border-b">
          <h3 class="text-xl font-semibold text-red-500 lg:text-2xl">
            เกิดข้อผิดพลาด
          </h3>
          <button @click="eventStore.editCode = 0" type="button"
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

  <AllEventList :status="fStatus" :eventList="filter_list" @delete="deleteEventFromId" @edit="editEvent" />
  <Footer />
</template>

<style>
</style>
