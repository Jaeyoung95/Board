package com.company.vo;

public class ReplyBoard2VO {
	private int boardseq;
	private int seq;
	private int rseq;
	private String nickname;
	private String regdate;
	private String content;
	private String userid; // 인증을 위한 userid 추가.
	
	public void setRseq(int rseq) {
		this.rseq = rseq;
	}
	
	public int getRseq() {
		return rseq;
	}
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public int getBoardseq() {
		return boardseq;
	}
	public void setBoardseq(int boardseq) {
		this.boardseq = boardseq;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	
}
