package usedlist;


public class Criteria {
    private int page = 1; // 현재 페이지 번호
    private int perPageNum = 10; // 페이지당 항목 수

    // 페이지 번호와 페이지당 항목 수 설정
    public void setPage(int page) {
        if (page <= 0) {
            this.page = 1;
        } else {
            this.page = page;
        }
    }

    public void setPerPageNum(int perPageNum) {
        if (perPageNum <= 0 || perPageNum > 100) {
            this.perPageNum = 10;
        } else {
            this.perPageNum = perPageNum;
        }
    }

    // 페이지의 시작 행 계산
    public int getStartRow() {
        return (this.page - 1) * this.perPageNum;
    }

    public int getPerPageNum() {
        return this.perPageNum;
    }

    public int getPage() {
        return this.page;
    }
}
