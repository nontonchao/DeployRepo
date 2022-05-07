<script setup>
import Footer from '../components/Footer.vue';
import FeatureCard from '../components/FeatureCard.vue';

const features = [
    {
        imgPath: '/icon/booking-icon.png',
        title: 'จองการนัดหมาย',
        desc: 'สามารถจองการนัดหมายได้อย่างสะดวก และง่ายดาย เพียงไม่กี่คลิกก็สามารถจองนัดหมายได้แล้ว'
    },
    {
        imgPath: '/icon/s.png',
        title: 'ตรวจสอบการนัดหมาย',
        desc: 'สามารถตรวจสอบการนัดหมายได้ ไม่ว่าจะเป็นการตรวจสอบทั้งหมด การตรวจสอบ / ค้นหาจาก Email'
    },
    {
        imgPath: '/icon/edit-icon.png',
        title: 'แก้ไขการนัดหมาย',
        desc: 'หากต้องการแก้ไขการนัดหมายก็สามารถทำได้เองโดยไม่ต้องยุ่งยาก'
    },
    {
        imgPath: '/icon/canc.png',
        title: 'ยกเลิกนัดหมาย',
        desc: 'หากนัดหมายไปแล้วไม่สะดวก หรือต้องการยกเลิกนัดหมายก็สามารถทำได้เลย'
    },
    {
        imgPath: '/icon/realtime-icon.png',
        title: 'RealTime',
        desc: 'อัพเดทข้อมูลเรียลไทม์ตลอด หลีกเลี่ยงปัญหาการจองซ้อนทับกัน'
    },
]

</script>
 <template>
    <div class="py-32 px-32">
        <div class="flex overflow-hidden w-full ">
            <div class="mb-4 lg:mb-20">
                <h1 class="text-left text-2xl lg:text-5xl font-bold text-gray tracking-1px pb-6"><strong>Online
                        Appointment
                    </strong>
                </h1>
                <h1 class="text-left text-2xl lg:text-5xl font-bold text-gray tracking-1px  pb-6"><strong>
                        Scheduling System for </strong>
                </h1>
                <h1 class="text-left text-2xl lg:text-5xl font-bold text-gray tracking-1px  pb-6"><strong>
                        Integrated Project Clinics (OASIP-SY1)</strong>
                </h1>

                <div class="flex right-0 py-10 pb-72 w-full md:w-full justify-center leading-8 ">
                    <router-link
                        class="bg-white border-4 border-main  text-black rounded-full font-bold flex p-5 mx-10 hover:text-white drop-shadow-2xl transform  transition ease-in-out delay-150  hover:-translate-y-1  hover:bg-main duration-300 ... "
                        :to="{ name: 'AddEvent' }">จองนัดหมาย

                    </router-link>
                    <router-link
                        class="bg-white border-4 border-green-700 text-black rounded-full font-bold flex p-5 mx-10 hover:text-white drop-shadow-2xl transform  transition ease-in-out delay-150  hover:-translate-y-1  hover:bg-green-700 duration-300 ... "
                        :to="{ name: 'CheckEvent' }">
                        ตรวจสอบนัดหมาย</router-link>
                </div>



            </div>
            <div class="animate-bounce w-700 h-20">
                <img src="/img/home-icon.png" style="width:700px">
            </div>
        </div>

        <div class="mb-4 lg:mb-20 pb-24">
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

        <h1 class="text-center text-2xl mt-8 lg:text-5xl font-bold text-gray tracking-1px pb-16">
            Features
        </h1>

        <div class="flex flex-wrap justify-center">
            <FeatureCard v-for="(card, index) in features" :key="index" :data="card" />
        </div>
    </div>
    <Footer class="bottom-0" />


</template>


<style>
</style>