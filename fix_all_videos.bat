@echo off
cd /d "%~dp0"

echo ========================================================
echo FIX LOI VIDEO V3 - FINAL (BAT TEN FILE CHINH XAC)
echo ========================================================

:: Quét từng folder
for /f "delims=" %%D in ('dir /b /ad') do (
    echo.
    echo Dang xu ly folder: "%%D"
    
    cd "%%D"
    
    :: 1. Dọn dẹp file lỗi cũ
    if exist index.m3u8 del /q index.m3u8
    if exist *.ts del /q *.ts
    
    :: 2. Tìm chính xác tên file MP4 trong folder này để xử lý
    :: Lưu ý: Dùng vòng lặp con để lấy tên file %%F
    for %%F in (*.mp4) do (
        echo ...Tim thay file: "%%F"
        echo ...Dang convert...
        
        ffmpeg -v error -stats -i "%%F" -c:v libx264 -c:a aac -preset ultrafast -start_number 0 -hls_time 6 -hls_list_size 0 -f hls index.m3u8
    )
    
    cd ..
)

echo.
echo ========================================================
echo XONG. KIEM TRA LAI FOLDER XEM CO FILE .M3U8 CHUA NHE!
echo ========================================================
pause