package com.spring.ft.qna;

public class PageVO {
		private int nowPage = 1; //현재페이지
		private int nowBlock = 1; //현재블록(페이지담는단위)
		
		private int numPerPage = 5; //하나의 페이지에 표시할 게시글 수
	    private int pagePerBlock = 5; //블록당 표시하는 페이지 갯수
	    
	    private int totalRecord =0; //총 게시물 갯수(원본 게시글 수)
	    private int totalPage = 0; //전체 페이지 갯수
	    private int totalBlock = 0; //전체 블록 갯수
	    
	    private int begin = 0; //현재 페이지상 시작 번호
	    private int end = 0; //현재 페이지상 마지막 번호
	    
	    private int beginPage = 0; //현재 블록의 시작 페이지 번호
	    private int endPage = 0; //현제 블록 마지막 번호

	    public void setNowPage(int nowPage) {
	        this.nowPage = nowPage;
	        setTotalPage();
	        setTotalBlock();
	        setNowBlock();
	        setBegin();
	        setEnd();
	        setBeginPage();
	        setEndPage();
	    }
	    
		public int getNowBlock() {
			return nowBlock;
		}

		public void setNowBlock() {
			nowBlock = (int) Math.ceil((double) nowPage / pagePerBlock);
		}

		public int getNumPerPage() {
			return numPerPage;
		}

		public void setNumPerPage(int numPerPage) {
			this.numPerPage = numPerPage;
		}

		public int getPagePerBlock() {
			return pagePerBlock;
		}

		public void setPagePerBlock(int pagePerBlock) {
			this.pagePerBlock = pagePerBlock;
		}

		public int getTotalRecord() {
			return totalRecord;
		}

		public void setTotalRecord(int totalRecord) {
			this.totalRecord = totalRecord;
			setTotalPage();
		}

		public int getTotalPage() {
			return totalPage;
		}

		public void setTotalPage() {
			 totalPage = totalRecord / numPerPage;
		     if (totalRecord % numPerPage > 0) totalPage++;
		}

		public int getTotalBlock() {
			return totalBlock;
		}

		public void setTotalBlock() {
			 totalBlock = (int) Math.ceil((double) totalPage / pagePerBlock);
		}

		public int getBegin() {
			return begin;
		}

		public void setBegin() {
			begin = (nowPage - 1) * numPerPage + 1;
		}

		public int getEnd() {
			return end;
		}

		public void setEnd() {
			end = begin + numPerPage - 1;
	        if (end > totalRecord) {
	            end = totalRecord;
	        }
		}

		public int getBeginPage() {
			return beginPage;
		}

		public void setBeginPage() {
			beginPage = (nowBlock - 1) * pagePerBlock + 1;
		}

		public int getEndPage() {
			return endPage;
		}

		public void setEndPage() {
			endPage = beginPage + pagePerBlock - 1;
	        if (endPage > totalPage) {
	            endPage = totalPage;
	        }
		}

		public int getNowPage() {
			return nowPage;
		}

		@Override
		public String toString() {
			return "PageVO [nowPage=" + nowPage + ", nowBlock=" + nowBlock + ", numPerPage=" + numPerPage
					+ ", pagePerBlock=" + pagePerBlock + ", totalRecord=" + totalRecord + ", totalPage=" + totalPage
					+ ", totalBlock=" + totalBlock + ", begin=" + begin + ", end=" + end + ", beginPage=" + beginPage
					+ ", endPage=" + endPage + "]";
		}
	    
	    
	}
	
