<script setup>
import ProfileCard from '../components/ProfileCard.vue'
import Footer from '../components/Footer.vue';

const members = [
    {
        name: 'Siam Yamsaengsung (Khun)',
        imagePath: '/members/PO.jpg',
        desc: 'our cute mentor.',
        git: 'https://github.com/siam-yam',
        fb: 'https://www.facebook.com/siamyam',
        ig: ''
    },
    {
        name: 'Chokjaroen Tanjaroenrat (Ny)',
        imagePath: '/members/dev024.jpg',
        desc: 'our cute backend.',
        git: 'https://github.com/itsmeny',
        fb: 'https://www.facebook.com/cjrtp',
        ig: 'https://www.instagram.com/breaklby/'
    },
    {
        name: 'Nattakan Thaweewatthanaprayun (Mint)',
        imagePath: '/members/dev031.jpg',
        desc: 'our cute leader.',
        git: 'https://github.com/dknxsmph',
        fb: 'https://www.facebook.com/dknsxmph',
        ig: 'https://www.instagram.com/dknxsmph/'
    },
    {
        name: 'Nitipoom Suttachai (Poom)',
        imagePath: '/members/dev071.jpg',
        desc: 'our cute boiler.',
        git: 'https://github.com/Nitipoom1456',
        fb: 'https://www.facebook.com/Nitipoom.Sutachai',
        ig: 'https://www.instagram.com/ntpm_poom/'
    },
]


</script>
 
<template>
    <div class=""  >
        <h1 class="text-center text-4xl font-bold pt-12 pb-12">เกี่ยวกับเรา</h1>
        <div class="w-full max-w-sm md:w-full px-6 mb-8 container mx-auto content-center leading-8">
            <ProfileCard :person="members[0]" />
        </div>
        <p class="text-center font-bold text-3xl  pt-12 pb-12"> Team Nontonchao</p>
        <div
            class="w-full md:w-full px-6 mb-8 md:mb-10 flex md:justify-around leading-8  pt-12 pb-12 flex-wrap justify-center">
            <ProfileCard :person="members[1]" />
            <ProfileCard :person="members[2]" />
            <ProfileCard :person="members[3]" />
        </div>
    </div>
    <Footer />

</template>
 
<style>
</style>