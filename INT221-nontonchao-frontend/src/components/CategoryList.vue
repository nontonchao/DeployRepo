<script setup>
import { ref, computed } from "vue";
import { useEventCategory } from "../stores/eventCategory.js"

// defineEmits(["edit"]);
const props = defineProps({
  cateList: {
    type: Object,
    require: true,
    default: {},
  },
});

const EventCateStore = useEventCategory()

const tmp = ref({
  eventCategoryDescription: "",
});

const isEdit = ref(false);
const toggleEdit = () => {
  isEdit.value = !isEdit.value;
};
</script>

<template>
  <div class="overflow-x-auto">
    <div
      class="min-w-screen min-h-screen  flex items-center justify-center bg-gray-100 font-sans overflow-hidden"
    >
      <div class="w-full lg:w-5/6">
        <div class="bg-white shadow-md rounded my-6">
          <table class="min-w-max w-full font-mitr table-auto">
            <thead>
              <tr
                class="bg-gray-200 text-gray-600 uppercase text-sm leading-10"
              >
                <th class="py-3 px-6 text-base text-left">ชื่อหมวดหมู่</th>
                <th class="py-3 px-6 text-base text-left">ระยะเวลา</th>
                <th class="py-3 px-6 text-base text-center">
                  อาจารย์ที่ปรึกษา
                </th>
              
                <th class="py-3 px-6 text-base text-center">แก้ไข</th>
              </tr>
            </thead>
            <tbody class="text-gray-600 text-sm font-light">
              <tr
                v-for="(cate, index) in cateList"
                :key="index"
                class="border-b border-gray-200 hover:bg-gray-100 leading-10"
              >
                <td class="py-3 px-6 text-left whitespace-nowrap">
                  <div class="flex items-center">
                    <div class="mr-2">
                      <img
                        class="w-10 h-10 rounded-full"
                        src="/icon/client-icon.jpg"
                      />
                    </div>
                    <span class="font-medium">{{
                      cate.eventCategoryName
                    }}</span>
                  </div>
                </td>
                <td class="py-3 px-6 text-left">
                  <div class="flex items-center">
                    <span>{{ cate.eventDuration }} นาที</span>
                  </div>
                </td>
                <td class="py-3 px-6 text-center">
                  <div class="flex items-center justify-center">
                    <img
                      class="w-10 h-10 rounded-full border-gray-200 border transform hover:scale-125"
                      src="/Adviser/adviser-icon.jpg"
                    />
                  </div>
                </td>
           
                <td
                  @click="
                    tmp = cate;
                    toggleEdit();
                  "
                  class="py-3 px-6 text-center"
                >
                  <div class="flex item-center justify-center">
                    <button>
                      <div
                        class="w-4 mr-2 transform hover:text-purple-500 hover:scale-110"
                      >
                        <svg
                          xmlns="http://www.w3.org/2000/svg"
                          fill="none"
                          viewBox="0 0 24 24"
                          stroke="currentColor"
                        >
                          <path
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            stroke-width="2"
                            d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z"
                          />
                        </svg>
                      </div>
                    </button>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>

  <!-- Modal Edit header -->
  <div
    v-show="isEdit"
    id="defaultModal"
    tabindex="-1"
    aria-hidden="true"
    class="overflow-x-hidden overflow-y-auto fixed inset-0 z-50 outline-none focus:outline-none justify-center items-center flex backdrop bg-black/50"
  >
    <div class="relative p-4 w-full max-w-lg h-full md:h-auto">
      <div class="relative bg-white rounded-lg shadow dark:bg-gray-700">
        <!-- Modal header -->
        <div
          class="flex justify-center items-center rounded-t dark:border-gray-600 content-center p-8"
        >
          <p>แก้ไขหมวดหมู่ (Clinic)</p>
          <button
            @click="toggleEdit()"
            type="button"
            class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm ml-auto inline-flex items-center dark:hover:bg-gray-600 dark:hover:text-white"
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
        <!-- Edit Modal body-->
        <div class="text-left leading-8 p-5 flex-auto justify-center pb-12">
          <div class="w-full md:w-full px-3 mb-6 md:mb-0">
            <label class="flex">
              <p>ชื่อหมวดหมู่ :</p>
              <input
                type="text"
                v-model="tmp.eventCategoryName"
                class="form-control block mx-4 w-3/5 px-2 py-1.5 text-sm font-normal text-gray-700 bg-white bg-clip-padding border border-solid border-gray-300 rounded transition ease-in-out m-0 focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none"
              />
            </label>
            <p class="py-3">
              อาจารย์ที่ปรึกษา : {{ tmp.eventCategoryName }} Advisor
            </p>
            <div class="w-full md:w-full mb-6 md:mb-0 flex flex-row">
              <p>ระยะเวลา :</p>
              <input
                type="number"
                min="1"
                max="480"
                v-model="tmp.eventDuration"
                class="form-control block mx-4 w-1/5 px-2 py-1.5 text-sm font-normal text-gray-700 bg-white bg-clip-padding border border-solid border-gray-300 rounded transition ease-in-out m-0 focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none"
              />
              <p>นาที</p>
            </div>

            <div class="w-full md:w-full px-3 mb-6 md:mb-0">
              <label
                class="block uppercase tracking-wide text-gray-700 text-sm font-bold mb-2 m-3"
                >คำอธิบาย :
              </label>
              <textarea
                type="text"
                v-model="tmp.eventCategoryDescription"
                class="shadow appearance-none border rounded w-full py-5 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                placeholder="รายละเอียด"
              ></textarea>
              <p class="text-gray-500 text-sm text-right pl-2">
                {{ tmp.eventCategoryDescription.length }}/500
              </p>
            </div>
          </div>
        </div>
        <!-- Edit Modal footer -->
        <p class="p-4 text-sm text-red-600 rounded-b border-t">
          * คุณสามารถแก้ไขระยะเวลาการนัดหมายได้ไม่เกิน 480 นาที
        </p>
        <div
          class="flex items-center justify-end space-x-2 rounded-b border-gray-200 dark:border-gray-600 p-3"
        >
          <button
            data-modal-toggle="defaultModal"
            type="button"
            @click="
              EventCateStore.editEventCategory(tmp);
              toggleEdit();
            "
            class="mb-2 md:mb-0 bg-green-500 border border-green-500 px-5 py-2 text-sm shadow-sm font-medium tracking-wider text-white rounded-full hover:shadow-lg hover:bg-green-600"
          >
            ยืนยัน
          </button>
        </div>
      </div>
    </div>
  </div>

  <!-- modal successful -->
  <div
    v-show="EventCateStore.isEdit200"
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
            การแก้ไขของคุณสำเร็จแล้ว
          </h3>
          <div class="mt-2 px-7 py-3">
            <p class="text-sm text-gray-500">สามารถดูรายละเอียดได้</p>
            <router-link
              class="text-base font-bold py-2 px-4 rounded-3xl underline decoration-blue-600 hover:text-blue-700 drop-shadow-2xl transform text-blue-500 delay-50 hover:-translate-y-1 duration-300"
              :to="{ name: 'EventCategoryList' }"
              >ที่นี่</router-link
            >
          </div>
          <div class="items-center px-4 py-3">
            <button
              @click="EventCateStore.isEdit200 = !EventCateStore.isEdit200"
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

  <div
    v-show="EventCateStore.isEdit400"
    id="defaultModal"
    tabindex="-1"
    aria-hidden="true"
    class="overflow-x-hidden overflow-y-auto fixed inset-0 z-50 outline-none focus:outline-none justify-center items-center flex backdrop bg-black/50 transform"
  >
    <div class="relative p-4 w-full max-w-lg h-full md:h-auto">
      <!-- Modal content -->
      <div class="relative bg-white rounded-lg shadow">
        <!-- Modal header 400 -->
        <div class="flex justify-between items-start p-5 rounded-t border-b">
          <h3 class="text-xl font-semibold text-red-500 lg:text-2xl">
            เกิดข้อผิดพลาด
          </h3>
          <button
            @click="EventCateStore.isEdit400 = !EventCateStore.isEdit400"
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
          <h3 class="text-lg font-bold text-red-500">
            ไม่สามารถแก้ไขระยะเวลานี้ได้         
          </h3>
              <h2 class=" text-sm font-normal text-gray-500">
         คุณสามารถแก้ไขระยะเวลาการนัดหมายได้ไม่เกิน 480 นาที           
          </h2>
        </div>
      </div>
    </div>
  </div>
</template>

<style></style>
