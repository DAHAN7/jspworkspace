document.addEventListener("DOMContentLoaded", function() {
    // 카테고리 드롭다운 토글 기능
    document.querySelectorAll(".category-title").forEach(function(categoryTitle) {
        categoryTitle.addEventListener("click", function() {
            const subcategoryList = document.getElementById(categoryTitle.dataset.category);
            subcategoryList.classList.toggle("show");
        });
    });

    // 도서 검색 버튼 클릭 이벤트
    const searchButton = document.getElementById("search-button");
    searchButton.addEventListener("click", function() {
        const searchQuery = document.getElementById("book-search").value.trim();
        if (searchQuery) {
            fetchBookInfo(searchQuery);
        } else {
            alert("도서명 또는 ISBN을 입력해주세요.");
        }
    });

    // 도서 정보 가져오기
    function fetchBookInfo(query) {
        // 실제 도서 검색 API를 호출하는 부분입니다. 
        // 여기서는 예시로 고정된 데이터를 사용합니다.
        const exampleBook = {
            title: "예제 도서 제목",
            author: "예제 저자",
            isbn: "1234567890",
            coverImage: "example-cover.jpg"
        };

        // 도서 정보 표시
        displayBookInfo(exampleBook);
    }

    // 도서 정보 표시
    function displayBookInfo(book) {
        document.getElementById("book-title").value = book.title;
        document.getElementById("book-author").value = book.author;
        document.getElementById("book-isbn").value = book.isbn;
        document.getElementById("book-cover").src = book.coverImage;
        document.getElementById("book-info").style.display = "block";
    }

    // 판매 등록 폼 제출 이벤트
    const usedBookForm = document.getElementById("used-book-form");
    usedBookForm.addEventListener("submit", function(event) {
        event.preventDefault();

        const formData = new FormData(usedBookForm);

        // 도서 판매 등록 API 호출
        fetch("/usedbooks", {
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
            console.error("Error:", error);
            alert("도서 판매 등록 중 오류가 발생하였습니다. 다시 시도해주세요.");
        });
    });
});
