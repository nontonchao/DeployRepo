import { createRouter, createWebHashHistory, createWebHistory } from "vue-router";

import Home from "../views/Home.vue";
import NotFound from "../views/NotFound.vue";
import AddEvent from "../views/AddEvent.vue";
import AllEvent from "../views/AllEvent.vue";
import AboutUs from "../views/AboutUS.vue";
import CheckEvent from "../views/CheckEvent.vue";

const history = createWebHashHistory();
const routes = [

    {
        path: "/",
        name: "Home",
        component: Home,
    },
    {
        path: "/:catchNotMatchPath(.*)",
        name: "NotFound",
        component: NotFound,
    },
    {
        path: "/add-event",
        name: "AddEvent",
        component: AddEvent,
    },
    {
        path: "/all-event",
        name: "AllEvent",
        component: AllEvent,
    },
    {
        path: "/about-us",
        name: "AboutUs",
        component: AboutUs,
    },
    {
        path: "/check-event",
        name: "CheckEvent",
        component: CheckEvent,
    }
];

const router = createRouter({ history, routes });

export default router;