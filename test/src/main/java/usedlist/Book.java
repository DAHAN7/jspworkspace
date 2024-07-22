package usedlist;

public class Book {
	private int usedBookId;
	private String description;
	private int price;
	private String status;
	private String image;

	// Getter 및 Setter 메소드
	public int getUsedBookId() {
		return usedBookId;
	}

	public void setUsedBookId(int usedBookId) {
		this.usedBookId = usedBookId;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}
}
