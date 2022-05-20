<script setup>
import { ref } from "vue";

const isOpen = ref(false);
const toggleMenu = () => {
  isOpen.value = !isOpen.value;
};
</script>

<template>
  <nav class="bg-main border-gray-200 px-4 sm:px-4 py-2.5 rounded mx-auto">
    <div class="container flex flex-wrap justify-between items-center mx-auto">
      <div class="flex flex-wrap justify-start ">
        <div class="relative flex flex-wrap ">
          <router-link :to="{ name: 'Home' }">
            <div class="w-16 h-16">
              <img src="/img/logo.png" alt="logo" width="60" height="60" />
            </div>
          </router-link>
          <div
            class="absolute top-0 right-0 -mr-1 -mt-0 w-4 h-4 rounded-full bg-green-400 animate-ping"
          ></div>
          <div
            class="absolute top-0 right-0 -mr-1 -mt-0 w-4 h-4 rounded-full bg-green-400"
          ></div>
        </div>
        <div class="relative ">
          <router-link :to="{ name: 'Home' }">
            <p class="text-black font-bold p-3 text-2xl mx-auto text-right">
              OASIP-SY1 by NTC
            </p>
          </router-link>
        </div>
      </div>
      <div class="relative  flex flex-wrap justify-end">
        <button
          data-collapse-toggle="mobile-menu"
          type="button"
          @click="toggleMenu()"
          class="inline-flex items-center p-2 text-sm text-gray-500 rounded-lg md:hidden hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-200 dark:text-gray-400"
          aria-controls="mobile-menu"
          aria-expanded="false"
        >
          <span class="sr-only">Open main menu</span>
          <svg
            class="w-6 h-6"
            fill="currentColor"
            viewBox="0 0 20 20"
            xmlns="http://www.w3.org/2000/svg"
          >
            <path
              fill-rule="evenodd"
              d="M3 5a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 10a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 15a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z"
              clip-rule="evenodd"
            ></path>
          </svg>
          <svg
            class="hidden w-6 h-6"
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

        <div
          class="w-full md:block md:w-auto"
          :class="[isOpen ? '' : 'hidden']"
          id="mobile-menu"
        >
          <ul
            class="flex flex-col mt-4 md:flex-row md:space-x-4 md:mt-0 md:text-sm md:font-medium"
          >
            <li>
              <router-link
                class="text-lg font-bold py-2 px-4 rounded-3xl hover:text-white drop-shadow-2xl transform text-black delay-50 hover:-translate-y-1 duration-300"
                :to="{ name: 'Home' }"
                @click="toggleMenu()"
                >หน้าหลัก</router-link
              >
            </li>
            <li>
              <router-link
                class="text-lg font-bold py-2 px-4 rounded-3xl hover:text-white drop-shadow-2xl transform text-black delay-50 hover:-translate-y-1 duration-300"
                :to="{ name: 'AddEvent' }"
                @click="toggleMenu()"
                >จองนัดหมาย</router-link
              >
            </li>
            <li>
              <router-link
                class="text-lg font-bold py-2 px-4 rounded-3xl hover:text-white drop-shadow-2xl transform text-black delay-50 hover:-translate-y-1 duration-300"
                :to="{ name: 'CheckEvent' }"
                @click="toggleMenu()"
                >ตรวจสอบนัดหมาย</router-link
              >
            </li>
            <li>
              <router-link
                class="text-lg font-bold py-2 px-4 rounded-3xl hover:text-white drop-shadow-2xl transform text-black delay-50 hover:-translate-y-1 duration-300"
                :to="{ name: 'EventCategoryList' }"
                @click="toggleMenu()"
                >หมวดหมู่</router-link
              >
            </li>
            <li>
              <router-link
                class="text-lg font-bold py-2 px-4 rounded-3xl hover:text-white drop-shadow-2xl transform text-black delay-50 hover:-translate-y-1 duration-300"
                :to="{ name: 'AboutUs' }"
                @click="toggleMenu()"
                >เกี่ยวกับเรา</router-link
              >
            </li>
          </ul>
        </div>
      </div>
    </div>
  </nav>
</template>

<style></style>
