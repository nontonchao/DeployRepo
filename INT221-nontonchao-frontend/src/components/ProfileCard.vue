<script setup>

defineProps({
    person: {
        type: Object,
        require: true,
        default: {}
    },
})
</script>
 
<template>
    <div
        class="max-w-sm bg-white rounded-lg border border-gray-200  transition ease-in-out delay-150 hover:scale-110 shadow-md">
        <img class="rounded-t-lg" :src="person.imagePath" alt="" width="600" height="800" />
        <div class="p-5">
            <h5 class="mb-2 text-2xl font-bold tracking-tight text-gray-900 ">{{ person.name }}</h5>
            <p class="mb-3 font-normal text-gray-700">{{ person.desc }}</p>
        </div>
        <div class="flex justify-center">
            <div class="flex leading-8 m-5 space-x-3 shadow-lg">
                <a :href="person.git" target="_blank"><img class="duration-500 hover:scale-125" src="/icon/github.png"
                        alt="" width="30" height="30"></a>
            </div>
            <div class="flex leading-8 m-5 space-x-3"> <a :href="person.fb" target="_blank"><img
                        class="  duration-500 hover:scale-125" src="/icon/facebook-logo.png" alt="" width="30"
                        height="30"></a> </div>
            <div class="flex leading-8 m-5 space-x-3"><a :href="person.ig"><img class="duration-500 hover:scale-125"
                        src="/icon/instagram.png" alt="" width="30" height="30"></a>
            </div>
        </div>
    </div>
</template>
 
<style>
</style>