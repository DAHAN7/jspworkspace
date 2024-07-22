document.addEventListener('DOMContentLoaded', () => {
    // DOM 요소들
    const bookSearchInput = document.getElementById('book-search');
    const searchButton = document.getElementById('search-button');
    const bookInfo = document.getElementById('book-info');
    const bookCover = document.getElementById('book-cover');
    const bookTitleInput = document.getElementById('book-title');
    const bookAuthorInput = document.getElementById('book-author');
    const bookIsbnInput = document.getElementById('book-isbn');
    const bookPriceInput = document.getElementById('book-price');
    const bookConditionSelect = document.getElementById('book-condition');
    const bookDescriptionInput = document.getElementById('book-description');
    const bookImagesInput = document.getElementById('book-images');
    const bookImagePreview = document.querySelector('.book-image');
    const usedBookForm = document.getElementById('used-book-form');
    const categoryButtons = document.querySelectorAll('.category-title');

    // 카테고리 드롭다운 토글 함수
    function toggleDropdown(id) {
        const dropdown = document.getElementById(id);
        if (dropdown) {
            dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
        }
    }

    // 카테고리 버튼 이벤트 리스너 추가
    categoryButtons.forEach(button => {
        button.addEventListener('click', () => {
            const id = button.getAttribute('onclick').match(/'([^']+)'/)[1];
            toggleDropdown(id);
        });
    });

    // 도서 검색 버튼 클릭 이벤트 핸들러
    searchButton.addEventListener('click', async () => {
        const query = bookSearchInput.value.trim();
        if (!query) {
            alert('도서명 또는 ISBN을 입력해주세요.');
            return;
        }

        try {
            const response = await fetch(`/searchBooks?query=${encodeURIComponent(query)}`);
            if (!response.ok) throw new Error('Network response was not ok.');

            const data = await response.json();
            if (data) {
                bookCover.src = data.coverImage || 'default-cover.jpg';
                bookTitleInput.value = data.title || '';
                bookAuthorInput.value = data.author || '';
                bookIsbnInput.value = data.isbn || '';
                bookInfo.style.display = 'block';
            } else {
                alert('도서를 찾을 수 없습니다.');
            }
        } catch (error) {
            console.error('Error fetching book information:', error);
            alert('도서 정보를 가져오는 중 오류가 발생했습니다.');
        }
    });

    // 도서 등록 폼 제출 이벤트 핸들러
    usedBookForm.addEventListener('submit', async (event) => {
        event.preventDefault();

        const bookTitle = bookTitleInput.value.trim();
        const bookAuthor = bookAuthorInput.value.trim();
        const bookIsbn = bookIsbnInput.value.trim();
        const bookPrice = parseFloat(bookPriceInput.value);
        const bookCondition = bookConditionSelect.value;
        const bookDescription = bookDescriptionInput.value;
        const bookImages = bookImagesInput.files;

        if (!bookTitle || !bookAuthor || !bookIsbn) {
            alert('도서 제목, 저자, ISBN을 입력해주세요.');
            return;
        }

        if (isNaN(bookPrice) || bookPrice <= 0) {
            alert('판매 가격은 0보다 큰 숫자여야 합니다.');
            return;
        }

        if (bookImages.length === 0) {
            alert('최소 하나의 이미지를 업로드해야 합니다.');
            return;
        }

        const formData = new FormData();
        formData.append('book-title', bookTitle);
        formData.append('book-author', bookAuthor);
        formData.append('book-isbn', bookIsbn);
        formData.append('book-price', bookPrice);
        formData.append('book-condition', bookCondition);
        formData.append('book-description', bookDescription);

        for (let i = 0; i < bookImages.length; i++) {
            formData.append(`book-images-${i}`, bookImages[i]);
        }

        try {
            const response = await fetch('/uploadBook', {
                method: 'POST',
                body: formData
            });

            const result = await response.json();
            if (result.success) {
                alert('도서 등록이 완료되었습니다.');
                usedBookForm.reset();
                bookImagePreview.innerHTML = '';
            } else {
                alert('도서 등록에 실패하였습니다.');
            }
        } catch (error) {
            console.error('Error uploading book:', error);
            alert('도서 등록 중 오류가 발생했습니다.');
        }
    });

    // 이미지 미리보기 기능
    bookImagesInput.addEventListener('change', () => {
        const files = bookImagesInput.files;
        bookImagePreview.innerHTML = '';

        Array.from(files).forEach(file => {
            const reader = new FileReader();
            reader.onload = (e) => {
                const img = document.createElement('img');
                img.src = e.target.result;
                img.style.maxWidth = '150px';
                img.style.maxHeight = '150px';
                bookImagePreview.appendChild(img);
            };
            reader.readAsDataURL(file);
        });
    });
});
