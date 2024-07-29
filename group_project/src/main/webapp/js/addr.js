/**
 * 
 */
const addrBtn = document.querySelector("#addrBtn");
addrBtn.addEventListener("click", () => {
    new daum.Postcode({
        oncomplete: function(data) {
			/* 우편 번호 */
			document.querySelector("#zipcode").value = data.zonecode;
			/* 도로명 주소 */
			document.querySelector("#road").value = data.roadAddress;
        }
    }).open();
});