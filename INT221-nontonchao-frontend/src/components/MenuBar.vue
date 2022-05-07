<script setup>
</script>
 
<template>
    <div class="flex bg-main p-5 font-mitr justify-between w-auto">
        <div class="flex ">
            <router-link :to="{ name: 'Home' }"><img class="ml-12" src="/img/logo.png" alt="logo" width="50"
                    height="50"></router-link>
            <router-link :to="{ name: 'Home' }">
                <p class="text-white font-bold p-3 text-2xl mx-5">OASIP by NTC</p>
            </router-link>
        </div>
        <div class="flex mr-12">
            <router-link
                class="text-2xl font-bold py-2 px-4 rounded-3xl hover:text-white drop-shadow-2xl transform  text-white   delay-50 hover:-translate-y-1  duration-300 ..."
                :to="{ name: 'Home' }">หน้าหลัก</router-link>
            <router-link
                class="text-2xl font-bold py-2 px-4 rounded-3xl hover:text-white drop-shadow-2xl transform  text-white   delay-50 hover:-translate-y-1  duration-300 ..."
                :to="{ name: 'AboutUs' }">เกี่ยวกับเรา</router-link>
        </div>
    </div>
</template>
 
<style>
</style>