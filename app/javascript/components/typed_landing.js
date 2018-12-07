import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  new Typed('#typed_text', {
    strings: ["en quelques clics", "en ligne avec tous vos investisseurs"],
    typeSpeed: 50,
    loop: true
  });
};

export { loadDynamicBannerText };
