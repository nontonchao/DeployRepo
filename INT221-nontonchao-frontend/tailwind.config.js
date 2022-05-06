module.exports = {
    content: ["./index.html", "./src/**/*.{vue,js,ts,jsx,tsx}"],
    theme: {
        extend: {
            fontFamily: {
                "mitr-th": "'Mitr', sans-serif",
                mitr: "'IBM Plex Sans Thai', sans-serif",
            },
            colors: {
                main: "#E6BDB2",
                acqua: "#D3E3D6",
            },
            bgHome: {
                "bg-home": "url('./src/assets/bg/bg-home.png')",
            },
        },
    },
    plugins: [],
};