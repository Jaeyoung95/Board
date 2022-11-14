package com.company.paging;

public class Paging {

	public static void main(String[] args) {
		// 전체 게시물의 개수
		int totalCount = 1000;

		// 현재 페이지
		int pg = 0;

		// 한 페이지에 출력될 게시물 수(10개를 기준으로 잡음)
		int countList = 10;

		// 한 화면에 출력될 페이지 수(통상적으로 10개 페이지를 나오게 함)
		int countPage = 10;

		// totalPage는 전체 페이지 수(전체 게시물/한 페이지에 출력될 게시물 수)
		int totalPage = totalCount / countList;

		if (totalCount % countList > 0) {
			// totalCount를 countList로 나눈 나머지 값이 존재한다는 것은 한 페이지가 더 있다는 의미이다.
			totalPage++;
		}

		if (totalPage < pg) {
			// 현재 페이지가 전체 페이지보다 크다면 이는 출력될 페이지 범위를 벗어난 현제 페이지를 의미
			// 따라서 현재페이지를 가장 끝 페이지인 totalPage로 이동시킨다.
			pg = totalPage;
		}

		int startPage = ((pg - 1) / countList) * countPage + 1;
//		현재 페이지를 기준으로 한 화면에서 시작 페이지 값을 보여준다.
//		pg-1을 한 이유는 10단위일 경우 예를 들어 10페이지면 0-10까지 보정하기 위해 -1을 한다.
//		-1을 지우고 실행하면 알 수 있음.

		int endPage = startPage + countPage - 1;
//		현재 페이지를 기준으로 한 화면에서 끝 페이지 값을 보여준다.
//	    시작 값은 현재 페이지 값을 기준으로 10으로 나누어 0페이지부터 시작되는 것을 보정하기 위해
//		+1을 한다.
//		끝 값은 시작페이지에서 카운트페이지를 더한 후 1을 빼면 끝 페이지가 나온다.
		System.out.println("시작 페이지 :" + startPage);
		System.out.println("끝 페이지 :" + endPage);
//		시작 페이지와 끝 페이지의 값을 정확히 확인하기 위해서는 전체 게시물의 개수가
//		1000이상의 값으로 설정해놓고 테스트(1000으로 설정하면 100개의 전체페이지가 생성되며
//		페이지 수가 충분히 생성이 되어야 시작페이지와 끝 페이지를 확인할 수 있다.
		
		if(startPage>1) {
			System.out.print("<a href='xxx?page=1'>처음</a>");
		}
		
//		이전 페이지 리스트 이동(차후에 만들기)
		
		
		if(pg>1) {
			System.out.print("<a href='xxx?page="+(pg-1)+"'>이전</a>");
		}

		for (int iCount = startPage; iCount <= endPage; iCount++) {
			if (iCount == pg) {
				System.out.print("<b>" + iCount + "</b>");
			} else {
				System.out.print(" " + iCount + " ");
			}
		}
//		페이지번호를 반복문을 이용해서 리스트를 표시하고 현재 보이는 페이지번호를 
//		강조하기 위해 b태그 사용.
		
		if(pg<totalPage) {
			System.out.print("<a href='xxx?page=>"+(pg+1)+"다음</a>");
		}
		
//		다음 페이지 리스트 이동(차후에 만들기)
		if(endPage<totalPage) {
			System.out.print("<a href='xxx?page="+totalPage+"'>끝</a>");
		}
	}

}
