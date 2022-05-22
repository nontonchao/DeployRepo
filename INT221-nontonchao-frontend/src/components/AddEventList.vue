<script setup>
import { ref } from "vue";
import { useEvents } from "../stores/events.js";

const props = defineProps({
  cliniclist: {
    type: Object,
    require: true,
    default: {},
  },
});

const eventStore = useEvents();
const name = ref("");
const email = ref("");
const clinicX = ref("");
const note = ref("");
const startTime = ref("");
const toSend = ref("");
const selectClinic = ref({});

const getCurrDate = () => {
  const today = new Date();
  return `${today.getFullYear()}-${numberFormat(
    new Date(today.toString()).getMonth() + 1,
    2
  )}-${numberFormat(new Date(today.toString()).getDate(), 2)}T${today
    .toLocaleTimeString("it-IT")
    .substring(0, 5)}`;
};

const getClinic = (clinicName) => {
  selectClinic.value = props.cliniclist.filter(
    (x) => x.eventCategoryName == clinicName
  )[0];
};

const addEventList = async () => {
  toSend.value = {
    bookingName: name.value,
    bookingEmail: email.value,
    eventStartTime: new Date(startTime.value)
      .toISOString()
      .replace(".000Z", "Z"),
    eventDuration: JSON.stringify(
      props.cliniclist.filter((x) => x.eventCategoryName === clinicX.value)[0]
        .eventDuration
    ),
    eventNotes: note.value,
    eventCategory: {
      id: JSON.stringify(
        props.cliniclist.filter((x) => x.eventCategoryName === clinicX.value)[0]
          .id
      ),
    },
  };
  eventStore.addEvent(toSend.value);
  if (eventStore.statusCode == 200) {
    console.log("event added :)");
    toggleQue();
  }
};

const isQue = ref(false);
const toggleQue = () => {
  isQue.value = !isQue.value;
  eventStore.addCode = 0;
};

const isNotFullfill = () => {
  if (
    clinicX.value === "" ||
    name.value === "" ||
    email.value === "" ||
    emailErr.value == 2 ||
    startTime.value === "" ||
    getCurrDate() >= startTime.value
  ) {
    return true;
  } else {
    return false;
  }
};
const resetModal = () => {
  name.value = "";
  email.value = "";
  note.value = "";
  startTime.value = "";
  emailErr.value = 0;
};

const numberFormat = function (number, width) {
  return new Array(+width + 1 - (number + "").length).join("0") + number;
};

const emailErr = ref(0);
const ValidateEmail = (mail) => {
  return mail == ""
    ? (emailErr.value = 0)
    : /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,24}))$/.test(
        mail
      )
    ? (emailErr.value = 1)
    : (emailErr.value = 2);
};

const timeErr = ref(0);
const ValidateTime = (time) => {
  return time == "" ? (timeErr.value = 0) : (timeErr.value = 1);
};
</script>

<template>
  <div
    class="w-full pt-4 max-w-lg md:w-3/5 px-6 mb-8 container mx-auto content-center leading-8"
  >
    <div
      v-show="false"
      class="w- full border-solid border border-red-600 font-bold rounded-lg"
    >
      <div class="p-3 w-full bg-red-600 text-white rounded-lg">
        <p>เกิดข้อผิดพลาด</p>
      </div>
      <div class="text-red-700 p-3">
        <p></p>
      </div>
    </div>

    <div>
      <label
        class="block uppercase tracking-wide text-gray-700 text-sm font-bold mb-2 m-5"
        for="grid-clinic "
        >คลินิก :
      </label>
      <p
        class="text-red-600 text-sm font-bold pl-2"
        v-show="clinicX == '' || clinicX == 'กรุณาเลือกคลินิก'"
      >
        * กรุณาเลือกคลินิก
      </p>
      <div class="relative">
        <select
          v-model="clinicX"
          @change="getClinic(clinicX)"
          required
          class="block appearance-none w-full bg-gray-50 border border-gray-200 text-gray-700 py-3 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-main"
          id="grid-clinic"
        >
          <option value="" disabled selected>กรุณาเลือกคลินิก</option>
          <option v-for="(clinic, index) in cliniclist" :key="clinic.id">
            {{ clinic.eventCategoryName }}
          </option>
        </select>

        <div
          class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700"
        >
          <svg
            class="fill-current h-4 w-4"
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 20 20"
          >
            <path
              d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"
            />
          </svg>
        </div>
      </div>
      <div class="w-full md:w-full px-3 mb-6 md:mb-0">
        <label
          v-show="clinicX"
          class="block uppercase tracking-wide text-gray-700 text-sm font-bold mb-2 m-3"
          for="username"
          >ระยะเวลา : {{ selectClinic.eventDuration }} นาที
        </label>
      </div>
      <div class="w-full md:w-full px-3 mb-6 md:mb-0">
        <label
          class="block uppercase tracking-wide text-gray-700 text-sm font-bold mb-2 m-3"
          for="username"
          >ชื่อผู้นัดหมาย :
        </label>
        <p class="text-red-600 text-sm font-bold pl-2" v-show="name == ''">
          * กรุณาใส่ชื่อ
        </p>
        <input
          type="text"
          v-model="name"
          required
          class="appearance-none block w-full bg-gray-50 text-gray-700 border rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-main"
          id="grid-name"
          placeholder="ชื่อ"
          minlength="1"
          maxlength="100"
        />
      </div>
      <div class="w-full md:w-full px-3 mb-6 md:mb-0">
        <label
          class="block uppercase tracking-wide text-gray-700 text-sm font-bold mb-2 m-3"
          for="grid-email"
          >อีเมล:
        </label>
        <p class="text-green-400 text-sm font-bold pl-2" v-if="emailErr == 1">
          อีเมลถูกต้อง
        </p>
        <p
          class="text-red-600 text-sm font-bold pl-2"
          v-else-if="emailErr == 2"
        >
          * กรุณาใส่อีเมลให้ถูกต้อง
        </p>
        <p class="text-red-600 text-sm font-bold pl-2" v-else>
          * กรุณาใส่อีเมล
        </p>

        <input
          type="email"
          v-model="email"
          required
          @keyup="ValidateEmail(email)"
          class="appearance-none block w-full bg-gray-50 text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-main"
          placeholder="อีเมล"
        />
      </div>
      <div class="w-full md:w-full px-3 mb-6 md:mb-0">
        <label
          class="block uppercase tracking-wide text-gray-700 text-sm font-bold mb-2 m-3"
          >วันเวลา :
        </label>
        <p class="text-red-600 text-sm font-bold pl-2" v-show="startTime == ''">
          * กรุณาเลือกวันและเวลา
        </p>
        <p
          class="text-red-600 text-sm font-bold pl-2"
          v-show="getCurrDate() >= startTime"
        >
          * กรุณาเลือกช่วงเวลาในปัจจุบันหรืออนาคต
        </p>
        <input
          type="datetime-local"
          v-model="startTime"
          @change="ValidateTime(startTime)"
          required
          class="shadow appearance-none border rounded w-full py-2 px-3 bg-gray-50 text-gray-700 leading-tight focus:outline-none focus:shadow-outline focus:border-main"
          :min="getCurrDate()"
        />
      </div>
    </div>
    <div class="w-full md:w-full px-3 mb-6 md:mb-0">
      <label
        class="block uppercase tracking-wide text-gray-700 text-sm font-bold mb-2 m-3"
        >รายละเอียด :
      </label>
      <p class="text-red-600 text-sm font-bold pl-2" v-if="note.length == 500">
        * รายละเอียดต้องไม่เกิน 500 ตัวอักษร
      </p>
      <textarea
        type="text"
        v-model="note"
        class="shadow appearance-none border rounded w-full py-4 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline focus:border-main"
        placeholder="รายละเอียด"
        maxlength="500"
      ></textarea>
      <p class="text-gray-500 text-sm text-right pl-2">{{ note.length }}/500</p>
    </div>
    <div class="w-full m-5 md:w-full px-3 mb-8 md:mb-0 ">
      <button
        @click="isNotFullfill() ? '' : toggleQue()"
        :disabled="isNotFullfill()"
        class="bg-white border-2 border-main text-black rounded-3xl font-bold flex p-2 hover:text-white drop-shadow-xl hover: hover:bg-main "
        type="button"
      >
        นัดหมาย
      </button>
    </div>
  </div>
  

  <!-- Verify modal -->
  <div
    v-show="isQue"
    id="defaultModal"
    tabindex="-1"
    aria-hidden="true"
    class="overflow-x-hidden overflow-y-auto fixed inset-0 z-50 outline-none focus:outline-none justify-center items-center flex backdrop bg-black/50"
  >
    <div class="relative p-4 w-full max-w-xl h-full md:h-auto">
      <!-- Modal content -->
      <div class="relative bg-white rounded-lg shadow">
        <!-- Modal header normal -->
        <div
          v-show="eventStore.addCode == 0"
          class="flex justify-between items-start p-5"
        >
          <h3 class="text-xl font-semibold text-gray-900 lg:text-2xl">
            ยืนยันการจอง
          </h3>
          <button
            @click="toggleQue()"
            type="button"
            class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center"
            data-modal-toggle="defaultModal"
          >
            <svg
              class="w-5 h-5"
              fill="currentColor"
              viewBox="0 0 20 20"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                fill-rule="evenodd"
                d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                clip-rule="evenodd"
              ></path>
            </svg>
          </button>
        </div>
        <!-- Modal body normal -->
        <div v-show="eventStore.addCode == 0" class="p-6 space-y-3 text-center">
          <h2 class="text-base leading-relaxed text-left">
            <strong>คุณ {{ name }} ได้ทำการนัดหมาย </strong>
          </h2>
          <h3 class="text-base leading-relaxed text-green-500">
            <strong>{{ clinicX }}</strong>
          </h3>
          <p class="text-base leading-relaxed text-gray-500">
            วันที่ : {{ startTime.substring(0, 10) }}
          </p>
          <p class="text-base leading-relaxed text-gray-500">
            เวลา : {{ startTime.substring(11, 16) }}
          </p>
        </div>
        <!-- Modal footer -->
        <div
          v-show="eventStore.addCode == 0"
          class="flex flex-right justify-end items-center p-6 space-x-2 border-gray-200"
        >
          <button
            data-modal-toggle="defaultModal"
            type="button"
            @click="
              toggleQue();
              eventStore.addCode = 0;
              addEventList();
              resetModal();
            "
            class="text-white bg-green-400 hover:bg-green-700 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium text-sm px-5 py-2.5 text-center rounded-full m-1"
          >
            ยืนยันการนัดหมาย
          </button>
          <button
            data-modal-toggle="defaultModal"
            type="button"
            @click="toggleQue()"
            class="text-gray-500 bg-white hover:bg-gray-200 focus:ring-4 focus:outline-none focus:ring-blue-300 rounded-full m-1 border border-gray-200 text-sm font-medium px-5 py-2.5 hover:text-gray-900 focus:z-10"
          >
            แก้ไข
          </button>
        </div>
      </div>
    </div>
  </div>

  <div
    v-show="eventStore.addCode == 400"
    id="defaultModal"
    tabindex="-1"
    aria-hidden="true"
    class="overflow-x-hidden overflow-y-auto fixed inset-0 z-50 outline-none focus:outline-none justify-center items-center flex backdrop bg-black/50"
  >
    <div class="relative p-4 w-full max-w-2xl h-full md:h-auto">
      <div class="relative bg-white rounded-lg shadow">
        <!-- Modal header 400 -->
        <div class="flex justify-between items-start p-5">
          <h3 class="text-xl text-red-500 font-semibold lg:text-2xl">
            เกิดข้อผิดพลาด
          </h3>
          <button
            @click="eventStore.addCode = 0"
            type="button"
            class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center"
            data-modal-toggle="defaultModal"
          >
            <svg
              class="w-5 h-5"
              fill="currentColor"
              viewBox="0 0 20 20"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                fill-rule="evenodd"
                d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                clip-rule="evenodd"
              ></path>
            </svg>
          </button>
        </div>
        <!-- Modal body 400 -->
        <div class="p-6 space-y-6 text-center">
          <svg
            class="mx-auto mb-4 w-14 h-14 text-yellow-400"
            fill="none"
            stroke="currentColor"
            viewBox="0 0 24 24"
            xmlns="http://www.w3.org/2000/svg"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
            ></path>
          </svg>
          <h3 class="mb-5 text-lg font-normal text-gray-500">
            ไม่สามารถจองช่วงเวลานี้ได้ กรุณาตรวจสอบและเลือกวันเวลาใหม่ ได้
            <router-link
              class="text-sm font-bold py-2 px-4 rounded-3xl underline decoration-blue-600 hover:text-blue-700 drop-shadow-2xl transform text-blue-500 delay-50 hover:-translate-y-1 duration-300"
              :to="{ name: 'CheckEvent' }"
              >ที่นี่</router-link
            >
          </h3>
        </div>
      </div>
    </div>
  </div>

  <!-- modal successful -->
  <div
    v-show="eventStore.addCode == 201"
    id="defaultModal"
    tabindex="-1"
    aria-hidden="true"
    class="overflow-x-hidden overflow-y-auto fixed inset-0 z-50 outline-none focus:outline-none justify-center items-center flex backdrop bg-black/50"
  >
    <div class="relative p-4 w-full max-w-lg h-full md:h-auto">
      <!-- Modal content 200-->
      <div
        class="relative top-20 mx-auto p-5 border w-96 shadow-lg rounded-md bg-white"
      >
        <div class="mt-3 text-center">
          <div
            class="mx-auto flex items-center justify-center h-12 w-12 rounded-full bg-green-100"
          >
            <svg
              class="h-6 w-6 text-green-600"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
              xmlnx="http://www.w.org/2000/svg"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M5 13l4 4L19 7"
              ></path>
            </svg>
          </div>
          <h3 class="text-lg leading-6 font-medium text-gray-900">
            การนัดหมายของคุณสำเร็จแล้ว
          </h3>
          <div class="mt-2 px-7 py-3">
            <p class="text-sm text-gray-500">คุณสามารถดูรายละเอียดได้</p>
            <router-link
              class="text-sm font-bold py-2 px-4 rounded-3xl underline decoration-blue-600 hover:text-blue-700 drop-shadow-2xl transform text-blue-500 delay-50 hover:-translate-y-1 duration-300"
              :to="{ name: 'CheckEvent' }"
              >ที่นี่</router-link
            >
          </div>
          <div class="items-center px-4 py-3">
            <button
              @click="eventStore.addCode = 0"
              id="ok-btn"
              class="px-4 py-2 bg-green-500 text-white text-base font-medium rounded-md w-full shadow-sm hover:bg-green-600 focus:outline-none focus:ring-2 focus:ring-green-300"
            >
              ตกลง
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- ----------------------------------------------------------------------- -->
</template>
<style></style>
