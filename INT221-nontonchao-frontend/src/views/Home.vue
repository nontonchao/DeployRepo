<script setup>
import Footer from '../components/Footer.vue';
import FeatureCard from '../components/FeatureCard.vue';

const features = [
    {
        imgPath: '/sy1/icon/booking-icon.png',
        title: 'จองการนัดหมาย',
        desc: 'สามารถจองการนัดหมายได้อย่างสะดวก และง่ายดาย เพียงไม่กี่คลิกก็สามารถจองนัดหมายได้แล้ว'
    },
    {
        imgPath: '/sy1/icon/s.png',
        title: 'ตรวจสอบการนัดหมาย',
        desc: 'สามารถตรวจสอบการนัดหมายได้ ไม่ว่าจะเป็นการตรวจสอบทั้งหมด การตรวจสอบ / ค้นหาจาก Email'
    },
    {
        imgPath: '/sy1/icon/edit-icon.png',
        title: 'แก้ไขการนัดหมาย',
        desc: 'หากต้องการแก้ไขการนัดหมายก็สามารถทำได้เองโดยไม่ต้องยุ่งยาก'
    },
    {
        imgPath: '/sy1/icon/canc.png',
        title: 'ยกเลิกนัดหมาย',
        desc: 'หากนัดหมายไปแล้วไม่สะดวก หรือต้องการยกเลิกนัดหมายก็สามารถทำได้เลย'
    },
    {
        imgPath: '/sy1/icon/realtime-icon.png',
        title: 'RealTime',
        desc: 'อัพเดทข้อมูลเรียลไทม์ตลอด หลีกเลี่ยงปัญหาการจองซ้อนทับกัน'
    },
]

</script>
 <template>
    <div class="container mx-auto px-4 pt-16 flex flex-col">
        <div class="flex overflow-hidden w-full flex-shrink text-center justify-between mx-auto">
            <div class="mb-4 lg:mb-20 lg:p-24 sm:p-10 lg:pt-48 sm:pt-14 ">
                <h1 class="text-left text-2xl lg:text-5xl font-bold text-gray tracking-1px pb-6"><strong>Online
                        Appointment
                    </strong>
                </h1>
                <h1 class="text-left text-2xl lg:text-5xl font-bold text-gray tracking-1px pb-6"><strong>
                        Scheduling System for </strong>
                </h1>
                <h1 class="text-left text-2xl lg:text-5xl font-bold text-gray tracking-1px pb-6"><strong>
                        Integrated Project Clinics</strong>
                </h1>
                  <h1 class="text-left text-2xl lg:text-5xl font-bold text-gray tracking-1px pb-6"><strong>
                        (OASIP-SY1)</strong>
                </h1>
                <div class="right-0 py-10 pb-32 justify-center leading-8 flex flex-wrap  ">
                    <div class="pb-8 pr-4">
                        <router-link :to="{ name: 'AddEvent' }">
                            <button
                                class="bg-white border-4 border-main  text-black rounded-full font-bold flex p-3  hover:text-white drop-shadow-2xl transform  transition ease-in-out delay-150  hover:-translate-y-1  hover:bg-main duration-300 ">
                                จองนัดหมาย
                            </button>
                        </router-link>
                    </div>
                    <router-link :to="{ name: 'CheckEvent' }">
                        <button class="bg-white border-4 border-green-700 text-black rounded-full font-bold flex p-3
                            hover:text-white drop-shadow-2xl transform transition ease-in-out delay-150
                            hover:-translate-y-1 hover:bg-green-700 duration-300"> ตรวจสอบนัดหมาย</button>
                    </router-link>
                </div>
            </div>
            <div class="animate-bounce flex-wrap w-700 h-20 md:shrink-0 object-cover w-6/12 pt-20 items-center ">
                <img src="/img/home-icon.png" style="width:400px;height:400px"> 
            </div>
        </div>

        <div class="mb-4 lg:mb-20 lg:p-24 sm:p-10 mx-4 lg:pb-24 ">
            <h1 class="text-center text-2xl lg:text-5xl font-bold text-gray tracking-1px">
                ที่มา
            </h1>
            <h2 class="text-base lg:text-lg text-center text-gray-light mt-5 tracking-wider">
                <p class="text-left mb-8">
                    OASIP-SY1 by NTC (Online Appointment Scheduling System for Integrated Project Clinics by
                    Nontonchao)
                    เป็น Web Application เล็ก ๆ ที่มีการนำเอาความรู้ในรายวิชาต่าง ๆ ที่เรียนมายำรวมกัน
                    กลายเป็นแบบนี้แหละทุกคน ;-;
                </p>
            </h2>
        </div>
        <div class="mb-4 lg:mb-20 lg:p-24 sm:p-10 ">
            <h1 class="text-center text-2xl mt-8 lg:text-5xl font-bold text-gray tracking-1px pb-16">
                Features
            </h1>

            <div class="flex flex-wrap justify-center drop-shadow-xl">
                <FeatureCard v-for="(card, index) in features" :key="index" :data="card" />
            </div>
        </div>
    </div>
    <Footer class="bottom-0" />
</template>


<style>
</style>