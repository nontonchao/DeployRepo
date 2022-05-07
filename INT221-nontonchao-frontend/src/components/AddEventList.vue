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

const toSend = ref("");

const currentdate = new Date();
const datetime = currentdate.toISOString().substring(0, 11) + currentdate.getHours() + `:` +currentdate.getMinutes();

const addEventList = async () => {
  toSend.value = {
    bookingName: name.value,
    bookingEmail: email.value,
    eventStartTime: startTime.value + ":00Z",
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

  //const res = await fetch('http://localhost:8080/api/events', {
  const res = await fetch(`${import.meta.env.BASE_URL}/api/events`, {
    method: "POST",
    headers: {
      "content-type": "application/json",
    },
    body: JSON.stringify(toSend.value),
  });

  if (res.status == 200) {
    console.log("event added :)");
    toggleQue();
  } else {
    console.log("error while adding");
  }
};

const isQue = ref(false);
const toggleQue = () => {
  isQue.value = !isQue.value;
};

const isFullfill = () => {
  if (name.value === "" || email.value === "" || startTime.value === "") {
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
};
</script>
<template>
  <div
    class="w-full max-w-lg md:w-3/5 px-6 mb-8 container mx-auto content-center leading-8"
  >
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
        <input
          type="text"
          v-model="name"
          required
          class="appearance-none block w-full bg-gray-200 text-gray-700 border rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white"
          id="grid-name"
          placeholder="ชื่อ"
        />
      </div>
      <div class="w-full md:w-full px-3 mb-6 md:mb-0">
        <label
          class="block uppercase tracking-wide text-gray-700 text-sm font-bold mb-2 m-3"
          for="grid-email"
          >Email:
        </label>
        <input
          type="email"
          v-model="email"
          required
          class="appearance-none block w-full bg-gray-200 text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-300"
          placeholder="อีเมล"
        />
      </div>
      <div class="w-full md:w-full px-3 mb-6 md:mb-0">
        <label
          class="block uppercase tracking-wide text-gray-700 text-sm font-bold mb-2 m-3"
          >รายละเอียด :
        </label>
        <textarea
          type="text"
          v-model="note"
          class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
          placeholder="รายละเอียด"
        ></textarea>
      </div>
      <div class="w-full md:w-full px-3 mb-6 md:mb-0">
        <label
          class="block uppercase tracking-wide text-gray-700 text-sm font-bold mb-2 m-3"
          >วันเวลา :
        </label>
        <input
          type="datetime-local"
          v-model="startTime"
          required
          :min="datetime"
          class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
        />
      </div>
    </div>
    <div class="w-full m-5 md:w-full px-3 mb-8 md:mb-0">
      <button
        @click="toggleQue()"
        :disabled="isFullfill()"
        class="bg-main p-5 hover:text-black hover:bg-acqua text-white font-bold py-2 px-4 rounded-full"
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
    class="overflow-x-hidden overflow-y-auto fixed inset-0 z-50 outline-none focus:outline-none justify-center items-center flex"
  >
    <div class="relative p-4 w-full max-w-2xl h-full md:h-auto">
      <!-- Modal content -->
      <div class="relative bg-white rounded-lg shadow dark:bg-gray-700">
        <!-- Modal header -->
        <div
          class="flex justify-between items-start p-5 rounded-t border-b dark:border-gray-600"
        >
          <h3
            class="text-xl font-semibold text-gray-900 lg:text-2xl dark:text-white"
          >
            ยืนยันการจอง
          </h3>
          <button
            @click="toggleQue()"
            type="button"
            class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center dark:hover:bg-gray-600 dark:hover:text-white"
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
        <!-- Modal body -->
        <div class="p-6 space-y-6">
          <h3
            class="text-base leading-relaxed text-yellow-300 dark:text-gray-400"
          >
            <strong>{{ clinicX }}</strong>
          </h3>
          <p class="text-base leading-relaxed text-gray-500 dark:text-gray-400">
            วันที่ : {{ startTime.substring(0, 10) }}
          </p>
          <p class="text-base leading-relaxed text-gray-500 dark:text-gray-400">
            เวลา : {{ startTime.substring(11, 16) }}
          </p>
        </div>
        <!-- Modal footer -->
        <div
          class="flex items-center p-6 space-x-2 rounded-b border-t border-gray-200 dark:border-gray-600"
        >
          <button
            data-modal-toggle="defaultModal"
            type="button"
            @click="
              addEventList();
              resetModal();
            "
            class="text-white bg-green-400 hover:bg-green-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800"
          >
            ยืนยันการนัดหมาย
          </button>
          <button
            data-modal-toggle="defaultModal"
            type="button"
            @click="toggleQue()"
            class="text-gray-500 bg-white hover:bg-gray-100 focus:ring-4 focus:outline-none focus:ring-blue-300 rounded-lg border border-gray-200 text-sm font-medium px-5 py-2.5 hover:text-gray-900 focus:z-10 dark:bg-gray-700 dark:text-gray-300 dark:border-gray-500 dark:hover:text-white dark:hover:bg-gray-600 dark:focus:ring-gray-600"
          >
            แก้ไข
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<style></style>
