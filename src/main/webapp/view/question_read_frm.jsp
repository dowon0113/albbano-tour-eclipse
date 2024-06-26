<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@page import="org.eclipse.jdt.internal.compiler.IDebugRequestor"%>
<%@page import="vo.QnaVO" %>
<%@ page import="dao.QnaDAO" %>
<%@page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html lang="ko">
<head>
    <title>질문답변 글쓰기 | 알빠노관광</title>

    <%@ include file="common_head.jsp" %>
</head>

<body>
<jsp:useBean id="qVO" class="vo.QnaVO" scope="page"/>
<jsp:setProperty property="*" name="qVO"/>
<% request.setCharacterEncoding("UTF-8"); %>

<%@ include file="common_m_header.jsp" %>
<%@ include file="common_desktop_header.jsp" %>

<script type="text/javascript">

	$(function(){
		
		$("#btnNoreadonly").click(function(){
			alert("수정할까요?") 
			$("input[name='ASK_TITLE']").prop("readonly", false);
	            $("textarea[name='ASK_CONTENTS']").prop("readonly", false);
		})
		
		
		$("#btnUpdate").click(function(){
			if(confirm("글이 수정되었습니다")){
				$("#questionForm")[0].action="question_update_process.jsp";
				$("#questionForm").submit();

		}
		})
		
		$(".btnDelete").click(function(){
			if(confirm("글을 삭제하시겠습니까?")){
				$("#questionForm")[0].action="question_delete_process.jsp";
				$("#questionForm").submit();
			}
		})
		
		 $("#btnNoreadonly").click(function() {
		        $("#btnUpdate").show();
		        $("#btnNoreadonly").hide();
		    });
		
		
	})//ready
</script>

<%
// ASK_DOC_NO 파라미터 받기
String ASK_DOC_NO = request.getParameter("ASK_DOC_NO");

// ASK_DOC_NO가 비어 있거나 null인 경우 예외 처리
if (ASK_DOC_NO == null || ASK_DOC_NO.isEmpty()) {
    out.println("게시글 번호가 올바르지 않습니다.");
    return; // 예외 처리 후 페이지 종료
}

// 게시글 조회
QnaVO qVo = null;
try {
    QnaDAO qDao = QnaDAO.getInstance(); // DAO 인스턴스 생성
    qVo = qDao.selectDetailqna(ASK_DOC_NO); // 해당 게시글 정보 조회
} catch (SQLException se) {
    se.printStackTrace();
    out.println("게시글 조회 중 오류가 발생했습니다.");
    return; // 예외 처리 후 페이지 종료
}

// 조회된 게시글 정보를 화면에 출력

%>

<section id="sub_visual">
    <div class="backgroundimg">
        <div class="visual_area"
             style="background:url('https://cmtour.co.kr/theme/cmtour/html/image/sub_visual05.jpg') no-repeat top center;"></div>
    </div>
</section>


<section id="sub_wrapper">
    <div id="sub_menu">
        <div class="sub_location">
            <div>
                <div class="cen"><a href="index_user.jsp"><i class="fa fa-home" aria-hidden="true"></i></a>
                </div>
                <ul class="">
                    <li>
                        <span>고객센터</span>
                        <ul>
                           <li><a href="list_spot.jsp" target="_self">관광지</a></li>
                            <li><a href="list_restaurant.jsp" target="_self">맛집</a></li>
                            <li><a href="booking.jsp" target="_self">투어예약</a></li>
                            <li><a href="main_notice.jsp" target="_self">고객센터</a></li>

                        </ul>
                    </li>
                </ul>
                <ul class="dep2">
                    <li>
                        <span>질문답변</span>
                        <ul>
                            <li><a href="main_notice.jsp" target="_self">공지사항</a></li>
                            <li><a href="faq.jsp" target="_self">자주 묻는 질문</a></li>
                            <li><a href="qna.jsp" target="_self">질문답변</a></li>
                            <li><a href="question.jsp" target="_self">1:1문의</a></li>
                        </ul>
                    </li>
                </ul>

            </div>
        </div>
    </div>

    <div id="sub_tit">
        <div class="path">
            <li><a href="index_user.jsp"><span class="ic-home"><i></i></span></a></li>
            <li>고객센터</li>
            <li></li>
            <li>질문답변</li>
        </div>
        <div class="title">고객센터</div>
        <p class="normal_txt"></p>
    </div>
    <div class="scontents">
        <div class="bg_vline"></div>
        <p class="eng"><em></em> 질문답변</p>
        <p class="stitle"></p>
        <!-- skin : theme/daon_basic -->
        <section id="bo_w">
            <h2 class="sound_only">질문답변</h2>
            <!-- 게시물 작성/수정 시작 { -->
          <form name="questionForm" id="questionForm" method="post">
          
                <input type="hidden" name="ASK_DOC_NO" value="${ qVO.ASK_DOC_NO }"/>
                
	<div class="write_div">
    <label for="wr_subject" class="sound_only">제목 <strong>필수</strong></label>
    <div id="autosave_wrapper write_div">
        <input type="text" name="ASK_TITLE" maxlength="20" readonly required class="frm_input full_input required" value="<%= qVo != null ? qVo.getASK_TITLE() : "" %>">
    </div>
</div>
<div class="write_div">
    <label for="wr_content" class="sound_only">내용<strong>필수</strong></label>
    <div class="wr_content smarteditor2">
        <textarea id="ASK_CONTENTS" name="ASK_CONTENTS" style="width:100%;height:300px" readonly>
            <%= qVo != null ? qVo.getASK_CONTENTS() : "" %>
        </textarea>
    </div>
</div>
                <div class="btn_confirm write_div" style="text-align:center;">
                <input type="button" value="수정하기" class="btn btn-info btn-sm" id="btnNoreadonly" />
                <input type="button" value="수정완료" class="btn btn-info btn-sm" id="btnUpdate" style="display: none;" />
                 <input type="button" value="글삭제" class="btn btn-success btn-sm btnDelete" style="float: right;"/>   
                    <a href="qna.jsp" class="btn_cancel btn">취소</a>
                    
</div>
            </form>
        </section>
        <!-- } 게시물 작성/수정 끝 -->
    </div>
</section>
<%--footer_jsp_적용_시작--%>
<footer>
    <%@ include file="common_footer.jsp" %>
</footer>
<%--footer_jsp_적용_끝--%>

<%@ include file="common_m_footer.jsp" %>
<%@ include file="common_sidebar.jsp" %>
<%@ include file="common_lower_container.jsp" %>

<%--스크롤_애니메이션_리셋--%>
<script src="http://127.0.0.1/front_util/js/wow.min.js"></script>
<script> new WOW().init(); </script>

</body>
</html>