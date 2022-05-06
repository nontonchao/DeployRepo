<script setup>
defineProps({
    data: {
        type: Object,
        require: true,
        default: {}
    },
})
</script>
 
<template>
<div class="max-w-sm m-4 bg-white rounded-3xl shadow-md py-6 px-6 text-center sm:px-16 sm:text-left ">
    <div class="flex justify-center sm:justify-start">
        <img :src="data.imgPath" width="150" height="150">
    </div>
    <div class="pt-5">
        <h1 class="text-xl lg:text-2xl font-semibold tracking-wider text-gray">{{ data.title }}</h1>
        <p class="mt-4 tracking-wider leading-8 text-base w-11/12 text-gray-light">
            {{ data.desc }}
        </p>
    </div>
</div>
</template>
 
<style>

</style>