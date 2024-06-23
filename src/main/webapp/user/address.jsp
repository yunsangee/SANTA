<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>주소 검색</title>
<script language="javascript">
function init(){
    var url = location.href;
    var confmKey = "devU01TX0FVVEgyMDI0MDQwODE3Mzk1ODExNDY3MzQ=";//승인키
    var resultType = "4"; // 도로명주소 검색결과 화면 출력유형
    var inputYn = "<%=request.getParameter("inputYn")%>";
    if (inputYn != "Y") {
        document.form.confmKey.value = confmKey;
        document.form.returnUrl.value = url;
        document.form.resultType.value = resultType;
        document.form.action = "https://business.juso.go.kr/addrlink/addrLinkUrl.do"; // 인터넷망
        document.form.submit();
    } else {
        opener.jusoCallBack(
            "<%=request.getParameter("roadFullAddr")%>",
            "<%=request.getParameter("roadAddrPart1")%>",
            "<%=request.getParameter("addrDetail")%>",
            "<%=request.getParameter("roadAddrPart2")%>",
            "<%=request.getParameter("engAddr")%>",
            "<%=request.getParameter("jibunAddr")%>",
            "<%=request.getParameter("zipNo")%>",
            "<%=request.getParameter("admCd")%>",
            "<%=request.getParameter("rnMgtSn")%>",
            "<%=request.getParameter("bdMgtSn")%>",
            "<%=request.getParameter("detBdNmList")%>",
            "<%=request.getParameter("bdNm")%>",
            "<%=request.getParameter("bdKdcd")%>",
            "<%=request.getParameter("siNm")%>",
            "<%=request.getParameter("sggNm")%>",
            "<%=request.getParameter("emdNm")%>",
            "<%=request.getParameter("liNm")%>",
            "<%=request.getParameter("rn")%>",
            "<%=request.getParameter("udrtYn")%>",
            "<%=request.getParameter("buldMnnm")%>",
            "<%=request.getParameter("buldSlno")%>",
            "<%=request.getParameter("mtYn")%>",
            "<%=request.getParameter("lnbrMnnm")%>",
            "<%=request.getParameter("lnbrSlno")%>",
            "<%=request.getParameter("emdNo")%>"
        );
        window.close();
    }
}
</script>
</head>
<body onload="init();">
    <form id="form" name="form" method="post">
        <input type="hidden" id="confmKey" name="confmKey" value=""/>
        <input type="hidden" id="returnUrl" name="returnUrl" value=""/>
        <input type="hidden" id="resultType" name="resultType" value=""/>
    </form>
</body>
</html>
