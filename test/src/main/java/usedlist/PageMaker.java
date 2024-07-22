package usedlist;

public class PageMaker {
    private Criteria cri; // 페이지 설정 객체
    private int totalCount; // 전체 항목 수
    private int displayPageNum = 10; // 페이지 네비게이션에 표시할 페이지 수

    public void setCri(Criteria cri) {
        this.cri = cri;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
    }

    public void setDisplayPageNum(int displayPageNum) {
        this.displayPageNum = displayPageNum;
    }

    public int getStartPage() {
        return ((cri.getPage() - 1) / displayPageNum) * displayPageNum + 1;
    }

    public int getEndPage() {
        int endPage = getStartPage() + displayPageNum - 1;
        return endPage > getMaxPage() ? getMaxPage() : endPage;
    }

    public int getMaxPage() {
        return (int) Math.ceil((double) totalCount / cri.getPerPageNum());
    }

    public boolean getPrev() {
        return getStartPage() > 1;
    }

    public boolean getNext() {
        return getEndPage() < getMaxPage();
    }
}
