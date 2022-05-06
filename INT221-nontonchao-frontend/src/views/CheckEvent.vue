<script setup>
import { onBeforeMount, ref } from 'vue';
import AllEventList from '../components/AllEventList.vue';

const eventList = ref({});
const init = ref(0)
const result = ref('');
const email = ref('');

const getAllEventList = async () => {
    let ret = {};
    //const res = await fetch("http://localhost:8080/api/events", {
    const res = await fetch("http://10.4.56.118:8081/api/events", {
        method: 'GET'
    });
    if (res.status == 200) {
        ret = await res.json();
        eventList.value = ret;
    } else {
        console.log('error while fetching');
    }
    return ret;
}

const editDateTime = async (updateEvent) => {
    //const res = await fetch(`http://localhost:8080/api/events/edit/`, {
    const res = await fetch(`http://10.4.56.118:8081/api/events/edit/`, {
        method: 'PUT',
        headers: {
            'content-type': 'application/json'
        },
        body: JSON.stringify(updateEvent)
    });
    if (res.status == 200) {
        console.log('edited');
    } else {
        eventList.value = await getAllEventList();
        result.value = await FindEventByEmail();
    }
}

const FindEventByEmail = async () => {
    let ret = {};
    //const res = await fetch(`http://localhost:8080/api/events/find/${email.value}`, {
    const res = await fetch(`http://10.4.56.118:8081/api/events/find/${email.value}`, {
        method: 'GET'
    });
    if (res.status == 200) {
        ret = await res.json();
        result.value = ret;
        //email.value = '';
    } else {
        console.log('error while fetching');
    }
    return ret;
}

const deleteEventFromId = async (id) => {
    //const res = await fetch(`http://localhost:8080/api/events/delete/${id}`, {
    const res = await fetch(`http://10.4.56.118:8081/api/events/delete/${id}`, {
        method: 'DELETE'
    });
    if (res.status == 200) {
        eventList.value = await getAllEventList();
        result.value = await FindEventByEmail();
    } else {
        console.log('error while fetching');
    }
}

onBeforeMount(async () => {
    eventList.value = await getAllEventList();
})

</script>

<template>
    <div class="w-full md:w-3/5 px-6 mb-8 md:mb-0 container mx-auto content-center leading-8">
        <h1 class="text-center text-4xl font-bold m-10">ตรวจสอบนัดหมาย</h1>
        <div class="w-full md:w-full px-6 mb-8 md:mb-auto flex space-x-5 justify-center ">
            <button @click="init = 1;"
                class="font-bold py-2 px-4 rounded-3xl hover:text-white drop-shadow-2xl transform bg-blue-500 hover:bg-blue-700 text-white   delay-50 hover:-translate-y-1  duration-300 ...">
                ดูทั้งหมด
            </button>
            <button @click="init = 2"
                class="font-bold py-2 px-4 rounded-3xl hover:text-white drop-shadow-2xl transform bg-blue-500 hover:bg-blue-700 text-white   delay-50 hover:-translate-y-1  duration-300 ...">
                ตรวจสอบจากอีเมล
            </button>
        </div>
    </div>
    <AllEventList v-if="init == 1" :eventList="eventList" @delete="deleteEventFromId" @edit="editDateTime" />
    <div v-else-if="init == 2">
        <div class="w-full max-w-2xl md:w-3/5 px-6 mb-8 md:mb-8 container mx-auto content-center leading-8 py-8">
            <div class="md:flex md:items-center mb-6">
                <label class="block text-gray-500 font-bold md:text-right mb-1 md:mb-0 pr-4">Email:
                </label>
                <input type="email" v-model="email"
                    class="appearance-none block w-full bg-gray-200 text-gray-300 border rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white justify-center"
                    id="grid-findbyemail" placeholder="E-mail" />
            </div>
            <div class="w-full md:w-full px-6 mb-8 md:mb-auto flex justify-center leading-8 transform">
                <button
                    class="text-white bg-gray-400 hover:bg-gray-800 text-sm text-center font-bold py-2 px-4 rounded-full m-1 "
                    @click="FindEventByEmail">
                    ค้นหา
                </button>
            </div>
        </div>
        <br />
        <AllEventList :eventList="result || {}" @delete="deleteEventFromId" @edit="editDateTime" />
    </div>
    <div v-else></div>
</template>

<style>
</style>
