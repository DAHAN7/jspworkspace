document.addEventListener("DOMContentLoaded", function() {
    // 카테고리 드롭다운 토글 기능
    document.querySelectorAll(".category-title").forEach(function(categoryTitle) {
        categoryTitle.addEventListener("click", function() {
            const categoryId = categoryTitle.getAttribute("data-category");
            const subcategoryList = document.getElementById(categoryId);
            if (subcategoryList) {
                subcategoryList.classList.toggle("show");
            } else {
                console.error(`ID가 "${categoryId}"인 요소를 찾을 수 없습니다.`);
            }
        });
    });
    // 도서 정보 가져오기
    function fetchBookInfo(query) {
        fetch(`/group_project/api/books?query=${encodeURIComponent(query)}`, {
            method: "GET",
        })
        .then(response => {
            if (!response.ok) {
                throw new Error("서버 응답이 좋지 않습니다.");
            }
            return response.json();
        })
        .then(data => {
			console.log(data);
            if (data && data.books) {
                displayBookInfo(data.books);
            } else {
                alert("도서 정보를 찾을 수 없습니다.");
            }
        })
        .catch(error => {
            console.error("도서 정보 가져오기 오류:", error);
            alert("도서 정보를 가져오는 중 오류가 발생하였습니다.");
        });
    }

    // 도서 정보 표시
    function displayBookInfo(book) {
		console.log(book);
        const titleElement = document.getElementById("book-title");
        const authorElement = document.getElementById("book-author");
        const priceElement = document.getElementById("book-price");
        const conditionElement = document.getElementById("book-condition");
        const descriptionElement = document.getElementById("book-description");
        const coverImageElement = document.getElementById("book-cover");

        // 요소 존재 여부 확인
        if (titleElement && authorElement && priceElement && conditionElement && descriptionElement && coverImageElement) {
            titleElement.value = book.title || "";
            authorElement.value = book.author || "";
            priceElement.value = book.price || "";
            conditionElement.value = book.condition || "good"; // 기본값 설정
            descriptionElement.value = book.description || "";
            coverImageElement.src = book.image || "https://via.placeholder.com/150"; // 기본 이미지
            document.getElementById("book-info").style.display = "block";
        } else {
            console.error("필수 DOM 요소가 존재하지 않습니다.");
        }
    }

    // 판매 등록 폼 제출 이벤트
    const usedBookForm = document.getElementById("used-book-form");
    if (usedBookForm) {
        usedBookForm.addEventListener("submit", function(event) {
            event.preventDefault();

            const formData = new FormData(usedBookForm);

            fetch("/UploadBookServlet", {  // 서버의 서블릿 URL로 수정
                method: "POST",
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert("도서 판매 등록이 완료되었습니다.");
                    usedBookForm.reset();
                    document.getElementById("book-info").style.display = "none";
                } else {
                    alert("도서 판매 등록에 실패하였습니다. 다시 시도해주세요.");
                }
            })
            .catch(error => {
                console.error("도서 판매 등록 중 오류가 발생하였습니다:", error);
                alert("도서 판매 등록 중 오류가 발생하였습니다. 다시 시도해주세요.");
            });
        });
    }

    // 판매 등록 버튼 클릭 이벤트
    const submitBtn = document.getElementById('submitBtn');
    if (submitBtn) {
        submitBtn.addEventListener('click', function(event) {
            if (confirm('중고책을 등록하시겠습니까?')) {
                const usedBookForm = document.getElementById("used-book-form");
                if (usedBookForm) {
                    usedBookForm.submit();
                } else {
                    console.error("등록 폼을 찾을 수 없습니다.");
                }
            }
        });
    }
});
