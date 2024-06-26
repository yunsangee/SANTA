<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<!DOCTYPE html>
<html>

<!--  ////////////////////////////////////////////// main ///////////////////////////////////////////////// -->

<head>
    <meta charset="UTF-8">
    <title>비밀번호 변경</title>

    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script>

<!--  ////////////////////////////////////////////// style ///////////////////////////////////////////////// -->

    <style>
        body {
            display: flex;
            flex-direction: column;
          /*   justify-content: space-between; */
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
        }

        header {
            width: 100%;
        }

        main {
        	flex: 1;
            margin-top: 280px; /* Adjust this value as needed to avoid overlap */
         /*    margin-bottom: 215px; */
            padding: 20px;
            text-align: center;
            justify-content: center;
            align-items: center;
            /* width: 90%;
            max-width: 500px; */
        }

        .container h2 {
            color: #333;
            margin-top: 5px;
            margin-bottom: 30px;
           /*  text-align: center; */
        }

        .container p {
            color: #999999;
            font-size: 13px;
            margin-bottom: 30px;
            /* text-align: center; */
        }

        .passwordNew  {
            width: 30%; 
           /*  width: 21.8% */;
            padding: 10px;
            margin-bottom: 10px;
            margin-top: 30px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            align-items: center;
            /* margin-right: 77px; */
        }
        
        .checkPassword {
            width: 30%; 
           /*  width: 21.8% */;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            align-items: center;
            /* margin-right: 77px; */
        }

        .passwordNew:focus,
        .checkPassword:focus {
            border: 1px solid #81C408;
            outline: none;
            box-shadow: 0 0 5px rgba(129, 196, 8, 0.5);
        }

        .submit {
            width: 30%;
            padding: 15px;
            font-size: 16px;
            background-color: #81C408;
            margin-top: 10px;
            margin-bottom: 10px;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            /* margin-left:-70px; */
        }

        .submit:hover {
            background-color: #578906;
        }

        @media (max-width: 768px) {
            .passwordNew,
            .checkPassword,
            .submit {
                width: 100%;
            }
        }

        footer {
            width: 100%;
              margin-bottom:-249px;
        }
    </style>

    <c:import url="../common/header.jsp"/>

<!--  ////////////////////////////////////////////// script ///////////////////////////////////////////////// -->

    <script>
        function submitForm(event) {
            event.preventDefault();

            const passwordNew = document.getElementById("passwordNew").value;
            const checkPassword = document.getElementById("checkPassword").value;
            const userPassword = document.getElementById("userPassword").value;
            const userId = document.getElementById("userId").value;

            if (passwordNew !== checkPassword) {
                alert("비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
                return;
            }

            if (passwordNew === userPassword) {
                alert("기존 비밀번호와 같은 비밀번호입니다.");
                return;
            }
            
            if(userPassword == "kakao"){
            	alert("소셜 로그인 회원은 비밀번호를 변경하실 수 없습니다.");
            	return;
            }

            fetch('rest/setUserPassword', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    userId: userId,
                    userPassword: userPassword,
                    passwordNew: passwordNew,
                    checkPassword: checkPassword
                })
            })
            .then(response => {
                if (!response.ok) {
                    return response.text().then(text => { throw new Error(text) });
                }
                return response.text();
            })
            .then(data => {
                alert("비밀번호가 변경되었습니다.");
                window.location.href = "/user/login.jsp"; // 비밀번호 변경 후 로그인 페이지로 리디렉션
            })
            .catch(error => {
                alert(error.message);
            });
        }
    </script>
</head>

<!--  ////////////////////////////////////////////// body ///////////////////////////////////////////////// -->

<body>

<!--  ////////////////////////////////////////////// header ///////////////////////////////////////////////// -->

<header>
    <c:import url="../common/top.jsp"/>
</header>

<!--  ////////////////////////////////////////////// main ///////////////////////////////////////////////// -->

<main class="container">
    <h2>비밀번호 재설정</h2>
    <p>비밀번호는 영문 대/소문자, 숫자, 특수문자 사용이 가능하며, 10자 이상 입력하셔야 변경 가능합니다.</p>
    <form onsubmit="submitForm(event)">
        
        <div class="form-group">
            <label for="passwordNew"></label>
            <input type="password" class="passwordNew" id="passwordNew" name="passwordNew" placeholder="비밀번호 입력" required>
        </div>
       
        <div class="form-group">
            <label for="checkPassword"></label>
            <input type="password" class="checkPassword" id="checkPassword" name="checkPassword" placeholder="비밀번호 확인" required>
        </div>
        
        <input type="hidden" id="userPassword" name="userPassword" value="<c:out value='${sessionScope.userPassword}'/>">
        <input type="hidden" id="userId" name="userId" value="<c:out value='${sessionScope.userId}'/>">
        
        <button type="submit" class="submit">비밀번호 변경</button>
    </form>
</main>

<!--  ////////////////////////////////////////////// footer ///////////////////////////////////////////////// -->

<footer>
    <c:import url="../common/footer.jsp"/>
</footer>

</body>

</html>
