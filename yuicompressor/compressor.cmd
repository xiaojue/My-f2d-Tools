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

REM �����ļ���׺��ֻѹ�� js �� css
if "%~x1" NEQ ".js" (
    if "%~x1" NEQ ".css" (
        echo.
        echo **** ��ѡ�� CSS �� JS �ļ�
        echo.
        goto End
    )
)

REM ��� Java ����
if "%JAVA_HOME%" == "" goto NoJavaHome
if not exist "%JAVA_HOME%\bin\java.exe" goto NoJavaHome
if not exist "%JAVA_HOME%\bin\native2ascii.exe" goto NoJavaHome

REM ����ѹ������ļ���������Ϊ��
REM 1. �ļ����� .source ʱ: filename.source.js -> filename.js
REM 2. ���������filename.js -> filename-min.js
set RESULT_FILE=%~n1-min%~x1
dir /b "%~f1" | find ".source." > nul
if %ERRORLEVEL% == 0 (
    for %%a in ("%~n1") do (
        set RESULT_FILE=%%~na%~x1
    )
)

REM ���� yuicompressor ѹ���ļ�
"%JAVA_HOME%\bin\java.exe" -jar "%~dp0yuicompressor.jar" --charset utf-8 "%~nx1" -o "%RESULT_FILE%"

REM �������������⣺�� js �ļ��ı�����ҳ����벻һ��ʱ���� ascii �ַ��ᵼ�����룬����취�ǣ�
REM 1. ���� js �ļ�����Ҫ���� native2ascii.exe ���� ascii �ַ��� \uxxxx ��ʾ
REM 2. ���� css �ļ�����Ҫ���� ascii �ַ�ת��Ϊ\uxxxx, Ȼ�� u ȥ����css ֻ��ʶ\xxxx��
REM 3. Ŀǰֻ������ js �ļ�
REM 4. ���� css �ļ���ֻ�� font-family �� :after ����������з� ascii �ַ���������٣��ֹ�����
if "%~x1" == ".js" (
    copy /y "%RESULT_FILE%" "%RESULT_FILE%.tmp" > nul
    del /q "%RESULT_FILE%.tmp"
)

REM ��ʾѹ�����
if %ERRORLEVEL% == 0 (
    echo.
    echo ѹ���ļ� %~nx1 �� %RESULT_FILE%
    for %%a in ("%RESULT_FILE%") do (
        echo �ļ���С�� %~z1 bytes ѹ���� %%~za bytes
    )
    echo.
) else (
    echo.
    echo **** �ļ� %~nx1 ����д����������ϸ���
    echo.
	goto End
)
goto End

:NoJavaHome
echo.
echo **** ���Ȱ�װ JDK ������ JAVA_HOME ��������
echo.

:End
ENDLOCAL
pause
