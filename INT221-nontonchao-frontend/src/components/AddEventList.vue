<script setup>
import { ref } from "vue";

const props = defineProps({
  cliniclist: {
    type: Object,
    require: true,
    default: {},
  },
});

const name = ref("");
const email = ref("");
const clinicX = ref("Project Management Clinic");
const note = ref("");
const startTime = ref("");
const msgNoti = ref("");
const toSend = ref("");
const is400 = ref(false);

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

  console.log(
    "DATE SEND: " +
      new Date(startTime.value).toISOString().replace(".000Z", "Z")
  );
  // const res = await fetch("http://localhost:8080/api/events", {
  // const res = await fetch(`http://10.4.56.118:8080/api/events`, {
  const res = await fetch(`${import.meta.env.BASE_URL}api/events`, {
    method: "POST",
    headers: {
      "content-type": "application/json",
    },
    body: JSON.stringify(toSend.value),
  });

  if (res.status == 200) {
    console.log("event added :)");
    toggleQue();
  } else if (res.status == 400) {
    is400.value = true
    console.log("error while adding || error: " + (await res.text()));
  } else {
    console.log("error while adding || error: " + (await res.text()));
  }
};

const isQue = ref(false);
const toggleQue = () => {
  isQue.value = !isQue.value;
  is400.value = false;
};

const isFullfill = () => {
  if (
    name.value === "" ||
    email.value === "" || emailErr.value == 2 ||
    startTime.value === "" || currDate.value >  startTime.value
  ) {
    return true;
  } else {
    return false;
  }
};
const resetModal = () => {
  name.value = "";
  email.value = "";
  clinicX.value = "Project Management Clinic";
  note.value = "";
  startTime.value = "";
  emailErr.value = 0;
};

const numberFormat = function (number, width) {
  return new Array(+width + 1 - (number + "").length).join("0") + number;
};

const today = new Date();
const currDate = `${today.getFullYear()}-${numberFormat(
  new Date(today.toString()).getMonth() + 1,2
)}-${numberFormat(new Date(today.toString()).getDate(), 2)}T${today
  .toLocaleTimeString("it-IT")
  .substring(0, 5)}`;


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
    class="w-full pt-4 max-w-lg md:w-3/5 px-6 mb-8 container mx-auto content-center leading-8 "
  >
    <div
      v-show="false"
      class="w- full border-solid border border-red-600 font-bold rounded-lg "
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
        for="grid-clinic"
        >คลินิก :
      </label>
      <div class="relative">
        <select
          v-model="clinicX"
          required
          class="block appearance-none w-full bg-gray-200 border border-gray-200 text-gray-700 py-3 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-300"
          id="grid-clinic"
        >
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
          class="appearance-none block w-full bg-gray-200 text-gray-700 border rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white"
          id="grid-name"
          placeholder="ชื่อ"
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
          class="appearance-none block w-full bg-gray-200 text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-300"
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
        <p class="text-red-600 text-sm font-bold pl-2 " v-show="currDate > startTime">
          * กรุณาเลือกช่วงเวลาในปัจจุบันหรืออนาคต
        </p>
        <p class="text-green-400 text-sm font-bold pl-2 " v-show="currDate < startTime">
          * อนาคต
        </p>
        <input
          type="datetime-local"
          v-model="startTime"
          @keyup="ValidateTime(startTime)"
          required
          class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
          :min="currDate"
        />
      </div>
    </div>
    <div class="w-full md:w-full px-3 mb-6 md:mb-0">
      <label
        class="block uppercase tracking-wide text-gray-700 text-sm font-bold mb-2 m-3"
        >รายละเอียด :
      </label>
      <p class="text-red-600 text-sm font-bold pl-2" v-if="note.length == 500">
        * รายละเอียดไม่ต้องเกิน 500 ตัวอักษร
      </p>
      <textarea
        type="text"
        v-model="note"
        class="shadow appearance-none border rounded w-full py-4 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
        placeholder="รายละเอียด"
        maxlength="500"
      ></textarea>
      <p class="text-gray-500 text-sm text-right pl-2">{{ note.length }}/500</p>
    </div>
    <div class="w-full m-5 md:w-full px-3 mb-8 md:mb-0">
      <button
        @click="toggleQue()"
        :disabled="isFullfill()"
        class="bg-white border-4 border-main text-black rounded-3xl font-bold flex p-3 hover:text-white drop-shadow-2xl hover:-translate-y-1 hover:bg-main"
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
    <div class="relative p-4 w-full max-w-2xl h-full md:h-auto">
      <!-- Modal content -->
      <div class="relative bg-white rounded-lg shadow">
        <!-- Modal header 200 -->
        <div v-show="is400==false" class="flex justify-between items-start p-5 rounded-t border-b">
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
        <!-- Modal header 400 -->
        <div v-show="is400==true" class="flex justify-between items-start p-5">
          <h3
            class="text-xl text-red-500 font-semibold text-gray-900 lg:text-2xl"
          >
            เกิดข้อผิดพลาด
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

        <!-- Modal body 200 -->
        <div v-show="is400==false" class="p-6 space-y-6">
          <h3 class="text-base leading-relaxed text-yellow-300">
            <strong>{{ clinicX }}</strong>
          </h3>
          <p class="text-base leading-relaxed text-gray-500">
            วันที่ : {{ startTime.substring(0, 10) }}
          </p>
          <p class="text-base leading-relaxed text-gray-500">
            เวลา : {{ startTime.substring(11, 16) }}
          </p>
        </div>
        <!-- Modal body 400 -->
        <div v-show="is400==true" class="p-6 space-y-6 text-center">
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
              class="text-base font-bold py-2 px-4 rounded-3xl underline decoration-blue-600 hover:text-blue-700 drop-shadow-2xl transform text-blue-500 delay-50 hover:-translate-y-1 duration-300"
              :to="{ name: 'CheckEvent' }"
              >ที่นี่</router-link
            >
          </h3>
        </div>

        <!-- Modal footer -->
        <div
          v-show="is400==false" class="flex items-center p-6 space-x-2 rounded-b border-t border-gray-200"
        >
          <button
            data-modal-toggle="defaultModal"
            type="button"
            @click="
              addEventList();
              resetModal();
            "
            class="text-white bg-green-400 hover:bg-green-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center"
          >
            ยืนยันการนัดหมาย
          </button>
          <button
            data-modal-toggle="defaultModal"
            type="button"
            @click="toggleQue()"
            class="text-gray-500 bg-white hover:bg-gray-100 focus:ring-4 focus:outline-none focus:ring-blue-300 rounded-lg border border-gray-200 text-sm font-medium px-5 py-2.5 hover:text-gray-900 focus:z-10"
          >
            แก้ไข
          </button>
        </div>
      </div>
    </div>
  </div>

  <!-- modal successful -->
  <div
    v-show="isQue"
    id="popup-modal"
    tabindex="-1"
    aria-hidden="true"
    class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 md:inset-0 h-modal md:h-full"
  >
    <div class="relative p-4 w-full max-w-md h-full md:h-auto">
      <div class="relative bg-white rounded-lg shadow">
        <div class="p-6 text-center">
          <svg
            class="h-6 w-6 text-green-600"
            fill="none"
            stroke="currentColor"
            viewBox="0 0 24 24"
            xmlns="http://www.w3.org/2000/svg"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M5 13l4 4L19 7"
            ></path>
          </svg>
          <h3 class="mb-5 text-lg font-normal text-gray-500">
            การนัดหมายของคุณสำเร็จแล้ว
          </h3>
          <a>ดูรายละเอียด...</a>
          <button
            data-modal-toggle="popup-modal"
            type="button"
            class="text-white bg-green-600 hover:bg-green-800 focus:ring-4 focus:outline-none focus:ring-green-300 font-medium rounded-lg text-sm inline-flex items-center px-5 py-2.5 text-center mr-2"
          >
            ตกลง
          </button>
        </div>
      </div>
    </div>
  </div>
  <!-- modal successful -->

  <!-- alert noti -->
  <div
    v-if="false"
    class="alert w-full max-w-lg md:w-3/5 px-6 mb-8 container mx-auto content-center leading-8 flex flex-row items-center bg-yellow-200 p-5 rounded border-b-2 border-yellow-300"
  >
    <div
      class="alert-icon flex items-center bg-yellow-100 border-2 border-yellow-500 justify-center h-10 w-10 flex-shrink-0 rounded-full"
    >
      <span class="text-yellow-500">
        <svg fill="currentColor" viewBox="0 0 20 20" class="h-6 w-6">
          <path
            fill-rule="evenodd"
            d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z"
            clip-rule="evenodd"
          ></path>
        </svg>
      </span>
    </div>
    <div class="alert-content ml-4">
      <div class="alert-title font-semibold text-lg text-yellow-800">
        Warning
      </div>
      <div class="alert-description text-sm text-yellow-600">
        {{ msgNoti }}
      </div>
    </div>
  </div>
  <!-- alert noti -->
</template>

<style></style>
