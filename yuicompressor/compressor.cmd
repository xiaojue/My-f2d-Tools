@echo off
REM =====================================
REM    YUI Compressor CMD Script
REM
REM     - by yubo@taobao.com
REM     - 2009-02-12
REM =====================================
SETLOCAL ENABLEEXTENSIONS

echo.
echo YUI Compressor v2.4.2

REM 过滤文件后缀，只压缩 js 和 css
if "%~x1" NEQ ".js" (
    if "%~x1" NEQ ".css" (
        echo.
        echo **** 请选择 CSS 或 JS 文件
        echo.
        goto End
    )
)

REM 检查 Java 环境
if "%JAVA_HOME%" == "" goto NoJavaHome
if not exist "%JAVA_HOME%\bin\java.exe" goto NoJavaHome
if not exist "%JAVA_HOME%\bin\native2ascii.exe" goto NoJavaHome

REM 生成压缩后的文件名，规则为：
REM 1. 文件名有 .source 时: filename.source.js -> filename.js
REM 2. 其它情况：filename.js -> filename-min.js
set RESULT_FILE=%~n1-min%~x1
dir /b "%~f1" | find ".source." > nul
if %ERRORLEVEL% == 0 (
    for %%a in ("%~n1") do (
        set RESULT_FILE=%%~na%~x1
    )
)

REM 调用 yuicompressor 压缩文件
"%JAVA_HOME%\bin\java.exe" -jar "%~dp0yuicompressor.jar" --charset utf-8 "%~nx1" -o "%RESULT_FILE%"

REM 下面解决编码问题：当 js 文件的编码与页面编码不一致时，非 ascii 字符会导致乱码，处理办法是：
REM 1. 对于 js 文件，需要调用 native2ascii.exe 将非 ascii 字符用 \uxxxx 表示
REM 2. 对于 css 文件，需要将非 ascii 字符转换为\uxxxx, 然后将 u 去掉（css 只认识\xxxx）
REM 3. 目前只处理了 js 文件
REM 4. 对于 css 文件，只有 font-family 和 :after 等情况可能有非 ascii 字符，情况很少，手工处理
if "%~x1" == ".js" (
    copy /y "%RESULT_FILE%" "%RESULT_FILE%.tmp" > nul
    del /q "%RESULT_FILE%.tmp"
)

REM 显示压缩结果
if %ERRORLEVEL% == 0 (
    echo.
    echo 压缩文件 %~nx1 到 %RESULT_FILE%
    for %%a in ("%RESULT_FILE%") do (
        echo 文件大小从 %~z1 bytes 压缩到 %%~za bytes
    )
    echo.
) else (
    echo.
    echo **** 文件 %~nx1 中有写法错误，请仔细检查
    echo.
	goto End
)
goto End

:NoJavaHome
echo.
echo **** 请先安装 JDK 并设置 JAVA_HOME 环境变量
echo.

:End
ENDLOCAL
pause
