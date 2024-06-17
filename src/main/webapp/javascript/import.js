// import.js
const scripts = [
    "https://www.gstatic.com/recaptcha/releases/TqxSU0dsOd2Q9IbI7CpFnJLD/recaptcha__ko.js",
    "https://www.googletagmanager.com/gtag/js?id=G-V2S2YMEQHE&amp;l=dataLayer&amp;cx=c",
    "https://www.gstatic.com/recaptcha/releases/TqxSU0dsOd2Q9IbI7CpFnJLD/recaptcha__ko.js",
    "//www.googletagmanager.com/gtm.js?id=GTM-5VQ9FNP",
    "https://widget.freshworks.com/widgets/69000001641.js",
    "https://themewagon.com/wp-content/plugins/woocommerce-products-filter/ext/by_text/assets/js/husky.js?ver=1.3.5.3",
    "https://themewagon.com/wp-includes/js/jquery/jquery.min.js?ver=3.7.1",
    "https://themewagon.com/wp-content/plugins/woo-custom-related-products/public/js/woo-custom-related-products-public.js",
    "https://themewagon.com/wp-content/plugins/woocommerce/assets/js/frontend/single-product.min.js?ver=8.7.0",
    "https://themewagon.com/wp-content/plugins/woocommerce/assets/js/jquery-blockui/jquery.blockUI.min.js?ver=2.7.0-wc.8.7.0",
    "https://themewagon.com/wp-content/plugins/woocommerce/assets/js/js-cookie/js.cookie.min.js?ver=2.1.4-wc.8.7.0",
    "https://themewagon.com/wp-content/plugins/woocommerce/assets/js/frontend/woocommerce.min.js?ver=8.7.0",
    "https://themewagon.com/wp-content/plugins/woodiscuz-woocommerce-comments/files/js/validator.js?ver=1.0.0",
    "https://themewagon.com/wp-content/plugins/woodiscuz-woocommerce-comments/files/js/wpc-ajax.js?ver=2.3.0",
    "https://themewagon.com/wp-content/plugins/woodiscuz-woocommerce-comments/files/js/jquery.cookie.js?ver=1.4.1",
    "https://themewagon.com/wp-content/plugins/woodiscuz-woocommerce-comments/files/third-party/tooltipster/js/jquery.tooltipster.min.js?ver=1.2",
    "https://themewagon.com/wp-content/plugins/woodiscuz-woocommerce-comments/files/js/jquery.autogrowtextarea.min.js?ver=3.0",
    "https://themewagon.com/wp-content/plugins/woocommerce/assets/js/frontend/tokenization-form.min.js?ver=8.7.0"
];

scripts.forEach(src => {
    const script = document.createElement('script');
    script.src = src;
    script.async = true;
    document.head.appendChild(script);
});
