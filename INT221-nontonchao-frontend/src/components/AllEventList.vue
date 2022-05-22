<script setup>
import { ref, onBeforeMount } from "vue";
import { useEvents } from "../stores/events.js";

defineEmits(["delete", "edit"]);
const props = defineProps({
  eventList: {
    type: Object,
    require: true,
    default: {},
  },
  status: {
    type: String,
    require: true,
    default: "ทั้งหมด",
  },
});

const eventStore = useEvents();

let tmp = {
  eventNotes: "dummy notes",
  eventCategoryName: "dummy event"
};

onBeforeMount(() => {
  if (props.eventList.length > 0) {
    tmp.value = props.eventList[0];
  } else {
    tmp.value = {
      eventCategory: {
        eventCategoryName: "dummy event",
      },
    };
  }
});

const numberFormat = function (number, width) {
  return new Array(+width + 1 - (number + "").length).join("0") + number;
};

const isConfirm = ref(false);
const toggleConfirm = () => {
  isConfirm.value = !isConfirm.value;
  eventStore.addCode = 0;
  console.log(isConfirm.value);
};

const getCurrDate = () => {
  const today = new Date();
  return `${today.getFullYear()}-${numberFormat(
    new Date(today.toString()).getMonth() + 1,
    2
  )}-${numberFormat(new Date(today.toString()).getDate(), 2)}T${today
    .toLocaleTimeString("it-IT")
    .substring(0, 5)}`;
};

const timeErr = ref(0);
const ValidateTime = (time) => {
  return time == "" ? (timeErr.value = 0) : (timeErr.value = 1);
};

const is400 = ref(false);
const isDel = ref(false);
const toggleDel = () => {
  isDel.value = !isDel.value;
};

const isEdit = ref(false);
const toggleEdit = () => {
  isEdit.value = !isEdit.value;
  eventStore.editCode = 0;
};

let tmpdt = ref("");

function showTime(DateTime, add) {
  let ret = new Date(DateTime);
  ret.setMinutes(ret.getMinutes() + add);
  return ret.toLocaleTimeString();
}

const gen_color = (id) => {
  switch (id) {
    case 1:
      return "bg-yellow-100 hover:bg-yellow-300";
    case 2:
      return "bg-green-300 hover:bg-green-500";
    case 3:
      return "bg-purple-200 hover:bg-purple-400";
    case 4:
      return "bg-blue-300 hover:bg-blue-500";
    case 5:
      return "bg-gray-300 hover:bg-gray-400";
  }
};

</script>

<template>
  <div
    class="drop-shadow-2xl flex-col p-4 w-full max-w-xs md:w-full px-6 overflow-auto container md:container md:mx-auto sm:block sm:mx-auto">
    <div v-if="eventList.length <= 0">
      <h1 v-if="props.status == 'ที่ผ่านมา'" class="p-16 text-5xl text-center text-yellow-300">
        No Past Events
      </h1>
      <h1 v-else-if="props.status == 'กำลังจะมาถึง'" class="p-16 text-5xl text-center text-yellow-300">
        No Upcoming Events
      </h1>
      <h1 v-else-if="props.status == 'กำลังดำเนินอยู่'" class="p-16 text-5xl text-center text-yellow-300">
        No Ongoing Events
      </h1>
      <h1 v-else class="p-16 text-5xl text-center text-yellow-300">
        No Scheduled Events
      </h1>
    </div>
    <div v-else>
      <div
        class="w-full mx-auto px-6 mb-8 md:mb-10 md:flex md:justify-around leading-8 pb-12 flex-wrap justify-center grid lg:grid-cols-4 gap-8">
        <div v-for="(result, index) in eventList" :key="index">
          <div :class="
            'shadow-lg w-full w-max-w-xs h-auto pt-8  rounded-t-3xl text-center my-10 p-15 leading-8 rounded-lg rounded-b-3xl transition ease-in-out  hover:-translate-y-1 hover:scale-110 duration-300 ' +
            gen_color(result.eventCategoryId)
          ">
            <div class="">
              <p class="font-bold py-8 text-xl text-center">
                {{ result.eventCategoryName }}
              </p>
              <div class="flex justify-around">
                <div class="md:flex-shrink-0 flex justify-start pl-12 pb-5">
                  <img src="/icon/user-icon.jpg" style="height: 120px" class="max-w-full h-auto rounded-full" />
                  <div class="flex justify-end">
                    <div class="text-right pt-16 pl-10 m-4 text-xs font-bold mt-4 md:mt-0 md:ml-6">
                      <p>SY1</p>
                      <p>Nontonchao</p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="bg-white rounded-b-3xl pt-8 max-w-xs">
              <div class="flex justify-around text-sm pb-16">
                <div class="text-left">
                  <p>หมายเลขนัดหมาย</p>
                  <p class="font-bold">{{ result.id }}</p>
                </div>
                <div class="text-right">
                  <p>วันที่</p>
                  <p class="font-bold">
                    {{ `${new Date(result.eventStartTime).toDateString()}` }}
                  </p>
                </div>
              </div>

              <div class="flex justify-around text-sm pb-8">
                <div class="text-left">
                  <p>ตั้งแต่</p>
                  <p class="font-bold">
                    {{ new Date(result.eventStartTime).toLocaleTimeString() }}
                  </p>
                </div>
                <div class="text-center">
                  <p>ถึง</p>
                  <p class="font-bold">
                    {{ showTime(result.eventStartTime, result.eventDuration) }}
                  </p>
                </div>
                <div class="text-right">
                  <p>ระยะเวลา</p>
                  <p class="font-bold">{{ result.eventDuration }} นาที</p>
                </div>
              </div>
              <hr />
              <div class="text-left pl-8 text-sm p-8 leading-7">
                <p>ผู้นัดหมาย</p>
                <p class="font-bold" v-if="result.bookingName.length > 30">
                  {{ result.bookingName.substring(0, 30) }}
                  ....
                </p>
                <p v-else class="font-bold">{{ result.bookingName }}</p>
              </div>
              <div>
                <button :class="
                  'w-full rounded-lg rounded-b-3xl ' +
                  gen_color(result.eventCategoryId)
                " @click="
  tmp = result;
tmpdt = `${new Date(
  tmp.eventStartTime
).getFullYear()}-${numberFormat(
  new Date(tmp.eventStartTime).getMonth() + 1,
  2
)}-${numberFormat(
  new Date(tmp.eventStartTime).getDate(),
  2
)}T${new Date(tmp.eventStartTime).toLocaleTimeString(
  'it-IT'
)}`;
toggleEdit();
">
                  รายละเอียดเพิ่มเติม
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- modal div -->
  <div>
    <!-- delete modal -->
    <div v-show="isDel" id="defaultModal" tabindex="-1" aria-hidden="true"
      class="overflow-x-hidden overflow-y-auto fixed inset-0 z-50 outline-none focus:outline-none justify-center items-center flex backdrop bg-black/50">
      <div class="relative p-4 w-full max-w-md h-full md:h-auto">
        <!-- Modal content -->
        <div class="relative bg-white rounded-lg shadow dark:bg-gray-700">
          <!-- Modal header -->
          <div class="flex justify-center items-center rounded-t dark:border-gray-600 content-center p-8">
            <button @click="
  toggleDel();
toggleEdit();
            " type="button"
              class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm ml-auto inline-flex items-center dark:hover:bg-gray-600 dark:hover:text-white"
              data-modal-toggle="defaultModal">
              <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                <path fill-rule="evenodd"
                  d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                  clip-rule="evenodd"></path>
              </svg>
            </button>
          </div>
          <!-- Modal body -->
          <div class="text-center p-5 flex-auto justify-center">
            <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4 -m-1 flex items-center text-red-500 mx-auto"
              fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
            </svg>
            <svg xmlns="http://www.w3.org/2000/svg" class="w-16 h-16 flex items-center text-red-500 mx-auto"
              viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd"
                d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z"
                clip-rule="evenodd" />
            </svg>
            <h2 class="text-xl font-bold py-4">
              <strong> คุณต้องการยกเลิกนัด </strong>
            </h2>
            <p class="text-sm text-gray-500 px-8">
              {{ tmp.eventCategoryName }}<br />
              ของคุณ {{ tmp.bookingName }} ใช่หรือไม่ ?
            </p>
            <p class="text-sm text-gray-400 px-8">
              คุณจะไม่สามารถกู้คืนข้อมูลได้
            </p>
          </div>
          <!-- Modal footer -->
          <div class="flex items-center justify-end space-x-2 rounded-b border-gray-200 dark:border-gray-600 p-3">
            <button data-modal-toggle="defaultModal" type="button" @click="
  $emit('delete', tmp.id);
toggleDel();
            "
              class="mb-2 md:mb-0 bg-green-500 border border-green-500 px-5 py-2 text-sm shadow-sm font-medium tracking-wider text-white rounded-full hover:shadow-lg hover:bg-green-600">
              ยืนยัน
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Modal Edit -->
    <div v-show="isEdit" id="defaultModal" tabindex="-1" aria-hidden="true"
      class="overflow-x-hidden overflow-y-auto fixed inset-0 z-50 outline-none focus:outline-none justify-center items-center flex backdrop bg-black/50">
      <div class="relative p-4 w-full max-w-xl h-full md:h-auto">
        <!-- Modal content -->
        <div class="relative bg-white rounded-lg shadow">
          <!-- Modal header 200 -->
          <div v-show="is400 == false" class="flex justify-between items-start p-6">
            <h3 class="text-xl font-semibold text-gray-900 lg:text-2xl dark:text-white">
              นัดหมายเลขที่ {{ tmp.id }}
            </h3>
            <button @click="toggleEdit()" type="button"
              class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center"
              data-modal-toggle="defaultModal">
              <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                <path fill-rule="evenodd"
                  d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                  clip-rule="evenodd"></path>
              </svg>
            </button>
          </div>
          <!-- Modal body 200 -->
          <div v-show="is400 == false" class="pt-4 pb-8 space-y-6 max-w-md container mx-auto content-center leading-8">
            <div class="w-full md:w-full px-3 mb-6 md:mb-0">
              <p>ชื่อผู้นัดหมาย : {{ tmp.bookingName }}</p>
              <p>อีเมล : {{ tmp.bookingEmail }}</p>
              <p>คลินิก : {{ tmp.eventCategoryName }}</p>
              <p>ระยะเวลา : {{ tmp.eventDuration }} นาที</p>
              <label class="block uppercase tracking-wide text-gray-700 text-sm font-bold mb-2 m-3" for="">
                วันที่นัดหมาย :
              </label>
              <p class="text-red-600 text-sm font-bold pl-2" v-show="tmpdt == ''">
                * กรุณาเลือกวันและเวลา
              </p>
              <p class="text-red-600 text-sm font-bold pl-2" v-show="getCurrDate() > tmpdt">
                * กรุณาเลือกช่วงเวลาในปัจจุบันหรืออนาคต
              </p>
              <input type="datetime-local" :disabled="getCurrDate() > tmpdt" v-model="tmpdt" required
                :min="getCurrDate()"
                class="block py-3.5 px-0 max-w-xs full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-100 appearance-none focus:outline-none focus:ring-0 focus:border-blue-700" />
            </div>
            <div class="w-full md:w-full px-3 mb-6 md:mb-0">
              <label class="block uppercase tracking-wide text-gray-700 text-sm font-bold mb-2 m-3">รายละเอียด :
              </label>
              <p class="text-red-600 text-sm font-bold pl-2" v-if="tmp.eventNotes.length == 500">
                * รายละเอียดต้องไม่เกิน 500 ตัวอักษร
              </p>
              <textarea type="text" v-model="tmp.eventNotes" :disabled="getCurrDate() > tmpdt"
                class="block py-3.5 px-0 md:w-full h-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-100 appearance-none focus:outline-none focus:ring-0 focus:border-blue-700"
                placeholder="รายละเอียด" maxlength="500"></textarea>
              <p class="text-gray-500 text-sm text-right pl-2">
                {{ tmp.eventNotes.length }}/500
              </p>
            </div>
          </div>

          <!-- Modal footer -->
          <div class="flex items-center justify-end p-6 space-x-2 rounded-b border-gray-200 dark:border-gray-600">
            <button data-modal-toggle="defaultModal" type="button" @click="
  toggleConfirm();
toggleEdit();
            " :disabled="getCurrDate() > tmpdt" :class="
              getCurrDate() > tmpdt
                ? 'hidden '
                : '' +
                'bg-green-500 text-white  shadow-sm hover:bg-green-600 focus:outline-none focus:ring-2 focus:ring-green-300 text-sm text-center font-bold py-2 px-4 rounded-full m-1'
            ">
              ยืนยันการแก้ไข
            </button>
            <button
              class="text-white bg-red-400 hover:bg-red-800 focus:ring-4 focus:outline-none focus:ring-blue-300 text-sm text-center font-bold py-2 px-4 rounded-full m-1"
              @click="
  toggleDel();
toggleEdit();
              ">
              <span v-if="getCurrDate() > tmpdt">
                ลบนัดหมาย
              </span>
              <span v-else>
                ยกเลิกนัด
              </span>
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- modal confirmation -->
  <div v-show="isConfirm" id="defaultModal" tabindex="-1" aria-hidden="true"
    class="overflow-x-hidden overflow-y-auto fixed inset-0 z-50 outline-none focus:outline-none justify-center items-center flex backdrop bg-black/50">
    <div class="relative p-4 w-full max-w-lg h-full md:h-auto">
      <!-- Modal content 200-->
      <div class="relative top-20 mx-auto p-5 border w-96 shadow-lg rounded-md bg-white">
        <div class="mt-3 text-center">
          <div class="mx-auto flex items-center justify-center h-12 w-12 rounded-full bg-gray-300">
            <svg width="50" height="50" viewBox="0 0 1000 1000" xmlns="http://www.w3.org/2000/svg">
              <path
                d="M 500 0C 224 0 0 224 0 500C 0 776 224 1000 500 1000C 776 1000 1000 776 1000 500C 1000 224 776 0 500 0C 500 0 500 0 500 0 M 501 191C 626 191 690 275 690 375C 690 475 639 483 595 513C 573 525 558 553 559 575C 559 591 554 602 541 601C 541 601 460 601 460 601C 446 601 436 581 436 570C 436 503 441 488 476 454C 512 421 566 408 567 373C 566 344 549 308 495 306C 463 303 445 314 411 361C 400 373 384 382 372 373C 372 373 318 333 318 333C 309 323 303 307 312 293C 362 218 401 191 501 191C 501 191 501 191 501 191M 500 625C 541 625 575 659 575 700C 576 742 540 776 500 775C 457 775 426 739 425 700C 425 659 459 625 500 625C 500 625 500 625 500 625" />
            </svg>
          </div>
          <h3 class="text-lg pt-8 leading-6 font-medium text-gray-900">
            คุณต้องการแก้ไขหรือไม่
          </h3>
          <div class="mt-2 px-7 py-3">
            <p class="text-sm text-gray-500">
              หากแก้ไขแล้วคุณจะไม่สามารถย้อนกลับได้
            </p>
          </div>
          <div class="items-center px-4 py-3 flex flex-row justify-end">
            <button @click="
  $emit('edit', {
    eventId: tmp.id,
    toUpdate: {
      eventStartTime: new Date(tmpdt).toISOString(),
      eventNotes: tmp.eventNotes,
    },
  });
toggleConfirm();
            " id="ok-btn"
              class="px-4 py-2 bg-green-500 text-white text-base font-medium max-w-3xl shadow-sm hover:bg-green-600 focus:outline-none focus:ring-2 focus:ring-green-300 text-center rounded-full m-1">
              ยืนยัน
            </button>
            <button @click="
  toggleConfirm();
toggleEdit();
            " id="ok-btn"
              class="px-4 py-2 bg-gray-500 text-white text-base font-medium max-w-3xl shadow-sm hover:bg-gray-600 focus:outline-none focus:ring-2 focus:ring-gray-300 text-center rounded-full m-1">
              ยกเลิก
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- ----------------------------------------------------------------------- -->
  <!-- modal successful -->
  <div v-show="eventStore.editCode == 200" id="defaultModal" tabindex="-1" aria-hidden="true"
    class="overflow-x-hidden overflow-y-auto fixed inset-0 z-50 outline-none focus:outline-none justify-center items-center flex backdrop bg-black/50">
    <div class="relative p-4 w-full max-w-lg h-full md:h-auto">
      <!-- Modal content 200-->
      <div class="relative top-20 mx-auto p-5 border w-96 shadow-lg rounded-md bg-white">
        <div class="mt-3 text-center">
          <div class="mx-auto flex items-center justify-center h-12 w-12 rounded-full bg-green-100">
            <svg class="h-6 w-6 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24"
              xmlnx="http://www.w.org/2000/svg">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
            </svg>
          </div>
          <h3 class="text-lg leading-6 pt-8 font-medium text-gray-900">
            การแก้ไขนัดหมายของคุณสำเร็จแล้ว
          </h3>
          <div class="mt-2 px-7 py-3">
            <p class="text-sm text-gray-500">
              สามารถดูรายละเอียดนัดหมายใหม่ของคุณได้
            </p>
          </div>
          <div class="items-center px-4 py-3">
            <button @click="eventStore.editCode = !eventStore.editCode" id="ok-btn"
              class="px-4 py-2 bg-green-500 text-white text-base font-medium rounded-md w-full shadow-sm hover:bg-green-600 focus:outline-none focus:ring-2 focus:ring-green-300">
              ตกลง
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<style>
</style>
