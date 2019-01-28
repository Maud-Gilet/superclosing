import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  new Typed('#typed_text', {
    strings: ["gérée en ligne", "avec tous vos investisseurs", "rendue possible en quelques clics"],
    typeSpeed: 40,
    loop: true
  });
};

export { loadDynamicBannerText };
