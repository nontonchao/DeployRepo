<script setup>
const props = defineProps({
  cateList: {
    type: Object,
    require: true,
    default: {},
  },
});
</script>

<template>
  <div class="overflow-x-auto">
    <div
      class="min-w-screen min-h-screen bg-gray-100 flex items-center justify-center bg-gray-100 font-sans overflow-hidden"
    >
      <div class="w-full lg:w-5/6">
        <div class="bg-white shadow-md rounded my-6">
          <table class="min-w-max w-full table-auto">
            <thead>
              <tr
                class="bg-gray-200 text-gray-600 uppercase text-sm leading-10"
              >
                <th class="py-3 px-6 text-left">ชื่อหมวดหมู่</th>
                <th class="py-3 px-6 text-left">ระยะเวลา</th>
                <th class="py-3 px-6 text-center">อาจารย์ที่ปรึกษา</th>
                <th class="py-3 px-6 text-center">เพิ่มเติม</th>
                <th class="py-3 px-6 text-center">แก้ไข</th>
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
                        class="w-6 h-6 rounded-full"
                        src="/sy1/icon/client-icon.jpg"
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
                      class="w-6 h-6 rounded-full border-gray-200 border transform hover:scale-125"
                      src="/sy1/Adviser/adviser-icon.jpg"
                    />
                  </div>
                </td>
                <td class="py-3 px-6 text-center">
                  <div class="flex item-center justify-center">
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
                          d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"
                        />
                        <path
                          stroke-linecap="round"
                          stroke-linejoin="round"
                          stroke-width="2"
                          d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"
                        />
                      </svg>
                    </div>
                  </div>
                </td>
                <td class="py-3 px-6 text-center">
                  <div class="flex item-center justify-center">
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
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
  <!-- Modal body -->
  <div
    class="p-6 space-y-6 max-w-md container mx-auto content-center leading-8 bg-gray-500"
  >
    <div class="w-full md:w-full px-3 mb-6 md:mb-0">
      <p>อาจารย์ที่ปรึกษา :</p>
      <div class="w-full md:w-full px-3 mb-6 md:mb-0 flex flex-col">
        <p>ระยะเวลา :</p>
        <input type="nuumber" />
      </div>
      <div class="w-full md:w-full px-3 mb-6 md:mb-0">
        <p>รายละเอียด :</p>
      </div>
    </div>
    <!-- Modal footer -->
    <div
      class="flex items-center justify-end p-6 space-x-2 rounded-b border-t border-gray-200 dark:border-gray-600"
    >
      <button
        data-modal-toggle="defaultModal"
        type="button"
        class="text-white bg-green-400 hover:bg-green-800 focus:ring-4 focus:outline-none focus:ring-blue-300 text-sm text-center font-bold py-2 px-4 rounded-full m-1 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800"
      >
        ยืนยันการแก้ไข
      </button>
    </div>
  </div>
</template>

<style></style>
